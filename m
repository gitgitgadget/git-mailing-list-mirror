From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Replaced "green" with "#00FF00".
Date: Thu, 27 Dec 2012 09:27:37 -0800
Message-ID: <7v623nmmly.fsf@alter.siamese.dyndns.org>
References: <20121227125916.GC7039@mobiltux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Peter Hofmann <git-dev@uninformativ.de>
X-From: git-owner@vger.kernel.org Thu Dec 27 18:28:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToHFV-0000EB-I4
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 18:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab2L0R1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 12:27:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab2L0R1l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 12:27:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4316FAB73;
	Thu, 27 Dec 2012 12:27:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xJ2Jlpt1Vo0Y0p1lOsfUYMCxP54=; b=Q8Eilh
	xBGUKuAuwb4HqrkDCWYc2rsKr1ZtWj7LOzWVaHyhzxdzPbkGLp/s59W04SvOLGCd
	EntDtTy8cZ6OyDCxVH9ZRewUf0lSW9S6vFlp7Q9CKloSdQJRX48iXDC4TsMkGldm
	N/QvCEKRlQ27ZhmBzFKWFhO+v07EzZDZg8wfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tzixvUqVs1Fum94GXVKMASza89TTA1/2
	BzkMYhA6l/giHuT+/bfJSh1stsRLfL2OViJ361KCQ22oYsr6jxI7LfWPrkbwYLtS
	embst4KYaJEe92c3qXNK5JJtuHutjMmhT1M+bC+8i9MkxUoOFyQcC5tR3cEAAocb
	lnSR618wpFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30231AB72;
	Thu, 27 Dec 2012 12:27:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8739FAB71; Thu, 27 Dec 2012
 12:27:39 -0500 (EST)
In-Reply-To: <20121227125916.GC7039@mobiltux> (Peter Hofmann's message of
 "Thu, 27 Dec 2012 13:59:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B695F63E-504A-11E2-B8DA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212205>

Peter Hofmann <git-dev@uninformativ.de> writes:

> Subject: Re: [PATCH] gitk: Replaced "green" with "#00FF00".

That should be

	Subject: [PATCH] gitk: replace "green" with "#00FF00"

around here.  Instead of reporting what you did in the past tense,
you give an order to somebody to do something to make the codebase
into more desirable shape, without the final full-stop.

> The definition of "green" has changed in Tk 8.6:
>
> - http://wiki.tcl.tk/21276
> - http://www.tcl.tk/cgi-bin/tct/tip/403

Concise reference to the background information is very much
appreciated.  It would have been even nicer if you wrote one line
summary of it, e.g. "This change was to make Tk applications more in
line with Web standard colors."

> gitk looks pretty awkward with Tk 8.6. "green" is simply too dark now
> because it has changed from "#00FF00" to "#008000".

Your observation "awkward" is somewhat subjective and I am hesitant
to recommend this change without a better justification.  Given the
reasoning behind the change Tcl/Tk people made, I wouldn't be
surprised if people coming from webapp world view the "green" color
rendered by updated Tcl/Tk more natural.

Besides, if we are declaring with this patch that we will stick to
X11 colors and will not adopt W3C colors, the patch shouldn't update
only "green", but set all the other colors in stone, no?  "purple",
for example, is also different between X11 and W3C.

> One could also use "lime" instead of "#00FF00" but that would break
> compatibility with older versions of Tk.

A better solution might be to make these colors customizable.

> Signed-off-by: Peter Hofmann <git-dev@uninformativ.de>
> ---
>  gitk-git/gitk | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Please make gitk patches against 

	url = git://ozlabs.org/~paulus/gitk.git

which is my upstream maintained by Paul Mackerras <paulus@samba.org>
(cc'ed) and keep him in the loop.

A patch against Paul's tree would have these lines

> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index d93bd99..d7e922b 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk

without "/gitk-git".

Thanks.
