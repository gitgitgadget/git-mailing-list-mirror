From: Junio C Hamano <gitster@pobox.com>
Subject: Re: upgrading GIT from version 1.7.0.4 to 1.7.6.1.
Date: Mon, 19 Sep 2011 14:26:55 -0700
Message-ID: <7vwrd48bq8.fsf@alter.siamese.dyndns.org>
References: <1316435430491-6808156.post@n2.nabble.com>
 <4E773A71.6020905@op5.se> <20110919190023.GC26115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	=?utf-8?Q?Mika=C3=ABl?= <mikael.donini@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 19 23:27:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5lMp-0006aM-PK
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 23:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790Ab1ISV1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 17:27:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932787Ab1ISV05 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 17:26:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47B8052DE;
	Mon, 19 Sep 2011 17:26:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fA9Vfq16AhmKE1X1vinxgN1TggY=; b=ZwWG6f
	qUXM2LjX3IOXy+In7mZTOfMK3QOY4aclcgkxnoLBEPUACS3yHwzIIHvBcVAu/Hy8
	bSsiqK0fwiZYarCNiccHNQbVH/9lbaCvPQ1ZjqarV2SO9zbUbRIhF9vK3/9YPjOM
	Q6wi91gOdHCGu96wxyooi7ib3Gaw48cRB1RNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GgesS4gTuQDQpgt5H1nBO3UcpdXAeN5e
	jpY66xeyhHJph4+jxFSM3C8+UwfB2hDQAXEymMkHEKIURu9+2WxbYnMWUaGBYkaR
	MmbHLVnAvyxlARV5oGzdBXiOu9Uq4I/5DlpNADQFYgy7BX5eNrtyu4zrOgL4z4UH
	7Ld0KNMFn7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F44452DD;
	Mon, 19 Sep 2011 17:26:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB2EF52DC; Mon, 19 Sep 2011
 17:26:56 -0400 (EDT)
In-Reply-To: <20110919190023.GC26115@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Sep 2011 15:00:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A1B8F92-E306-11E0-8083-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181708>

Jeff King <peff@peff.net> writes:

> [2] I suspect a similar thing happened with turning on packed refs
>     (around the v1.4.4 era?), but I didn't dig around for details.

Also when bisecting down to really ancient versions of git, you may get
complaints from the configuration reader. E.g.

    $ rungit v1.0.0 ls-files
    fatal: bad config file line 78 in .git/config
    $ sed -n 78p .git/config
    [remote "git-gui"]
