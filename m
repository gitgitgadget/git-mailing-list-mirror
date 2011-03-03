From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Thu, 03 Mar 2011 15:31:08 -0800
Message-ID: <7vhbbj93yb.fsf@alter.siamese.dyndns.org>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
 <4D700469.7090807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 00:31:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvHzP-0005SU-FP
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 00:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758983Ab1CCXbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 18:31:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758739Ab1CCXbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 18:31:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B5A5949E2;
	Thu,  3 Mar 2011 18:32:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ldLeKO/yAdQQZ8M34AwShr93wtc=; b=ohKKIp
	hglERv1dAQBXWUwr8Mgo9QfhyT+3YMSaTZJ7HGRQLFI14JVau7mo2RidXFGYwprC
	M2JB+R2zw+6eIvI98UuqhRBr2oDhZ8YvkI0OfBtKSxCFYDDvT1X65t4lnXIqx4vW
	7OFFe4/Wqec/OZOExlzg5bdjetRLD/OK/HWsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ni5FZl9/X+4jTv8G92FVujf62KnVhLQc
	IAhhY3eQGKyAakighDjqljKppThJsHtAcu8PV8A7884IV47NhaBQUnvXs7f2XS17
	8kPK2jU86NgpgQtrQ9+ocZRR39figfkcZDaj/5g2/X3lk4FlzeCzxJeBdcflETkg
	PcSVPUKvA2E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 83DBF49DF;
	Thu,  3 Mar 2011 18:32:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C96E49DE; Thu,  3 Mar 2011
 18:32:30 -0500 (EST)
In-Reply-To: <4D700469.7090807@gmail.com> (Piotr Krukowiecki's message of
 "Thu\, 03 Mar 2011 22\:13\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 84E11C3A-45EE-11E0-BEC2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168415>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
> Date: Thu, 3 Mar 2011 21:51:34 +0100
> Subject: [PATCH] Improve error message when gitfile has wrong format
>
> Add information what format of .git file is expected.

Don't do this.  We don't want to _add_ places that needs to be updated
when we need to update our internal implementation.
