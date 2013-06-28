From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [submodule] Add depth to submodule update
Date: Fri, 28 Jun 2013 15:51:41 -0700
Message-ID: <7vr4fllugy.fsf@alter.siamese.dyndns.org>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
	<20130624224925.GC32270@paksenarrion.iveqy.com>
	<20130625221132.GB4161@sandbox-ub>
	<20130626160219.GC9141@paksenarrion.iveqy.com>
	<7vli5wvb3n.fsf@alter.siamese.dyndns.org> <51CC5235.6030908@web.de>
	<20130628065001.GA2783@sandbox-ub>
	<7vk3lenkhh.fsf@alter.siamese.dyndns.org> <51CDF819.9030308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 29 00:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UshW9-0003cE-TO
	for gcvg-git-2@plane.gmane.org; Sat, 29 Jun 2013 00:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab3F1Wvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 18:51:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab3F1Wvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 18:51:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 032A92C8A1;
	Fri, 28 Jun 2013 22:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nteDA3MEPoBIl8ygTG1hTSTuoEU=; b=qKbqx+
	tUb+FrnsogKyHpcMwhGH2OQL5nTTVvjYUNGamClqlWk9FTTFrKUVC4Tt1lhpExRn
	o2BNvdv5ebFieSXAmef314rKtJDBJ+a+n0v0vmGcIVT3N3sCu2H21SfX0i7962V1
	eF/bxOz837kJIRH+FniJ7iayAlnHsK7T9Xydo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ya5agBB7YLTZ5ItMrlm1nPx5B+CzQ6nv
	eHcyIOFYBUCwz73AhrFaG69DRcbgOEKutbDbnx+w+bfrxJkGT7Fu3qGE9u9KzXoy
	S7QQKseOTum/F97RJqwkvtnL1uxng7fLVOMLRN58bdrOLRnLtRxo8HWJsjIjLsJ8
	tTeBouzIhys=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAF1C2C8A0;
	Fri, 28 Jun 2013 22:51:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F9A82C89F;
	Fri, 28 Jun 2013 22:51:43 +0000 (UTC)
In-Reply-To: <51CDF819.9030308@web.de> (Jens Lehmann's message of "Fri, 28 Jun
	2013 22:54:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D92CB9A-E045-11E2-AE70-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229247>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 28.06.2013 20:44, schrieb Junio C Hamano:
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>> ... 
>>> Hmm, but does it have a --depth option for revisions? Maybe we should
>>> call it --clone-depth or --rev-depth to make it clear? --depth and
>>> --max-depth would be completely orthogonal but the name does not allow
>>> to distinguish them properly.
>> 
>> I do not have a strong opinion either way, but as you suggest, it
>> might be a good idea to call this new option --clone-depth to be
>> more specific.
>
> No strong opinion here either, but I'm leaning towards "--depth"
> because on one hand we already have the "--reference" option which
> is passed on to the clone command (and not "--clone-reference")...

OK, then "--depth" it is.

The points in your review on the last version with "--depth" (which
I picked up and parked on 'pu') still need to be addressed, I think?
