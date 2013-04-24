From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/5] git-diff.txt: banish the <commit>..<commit> form
Date: Wed, 24 Apr 2013 11:29:15 -0700
Message-ID: <7vip3bdbpg.fsf@alter.siamese.dyndns.org>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
	<1366822980-21926-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:29:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4RW-0005c8-Qe
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756887Ab3DXS3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:29:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756676Ab3DXS3R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:29:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 605AC19219;
	Wed, 24 Apr 2013 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5sjd5IXzv/leS39oKJF7hdGI3aw=; b=au6UHb
	q/df/gkfEp8WxTLIUSI0XWvLtp5UWSqq1wgta+iOfEXYuQbD52oRjWXVzo6ft+mB
	G5wIffcXRH9k1ar0WxI/mZTPt2p1o6WDRH/QH2m4NZb/4uGb0XsYt2fjN7wocKhY
	6em1tn6mge/AL7Lpm5Vv3arNbuD8QT71C9I+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L0KPqk8y9JoYSRYRAABrw+1vGgqs0HwF
	sF4aQvSIHd6+Wq1Sut4sNT9Zjx+y0g2uSby+qzlWdd3m8Awt/jgMUYBpGuPMD8tO
	4G/AOdE06eCOvYJJLpUVcaUQfcYt4dzyuf+N3ffO27zgbPAoFvMZiCL20gsD+fOO
	cTawyHjxheQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5618A19218;
	Wed, 24 Apr 2013 18:29:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B031F19216;
	Wed, 24 Apr 2013 18:29:16 +0000 (UTC)
In-Reply-To: <1366822980-21926-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 24 Apr 2013 22:33:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF035958-AD0C-11E2-869D-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222288>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The '<commit>..<commit>' and '<commit>...<commit>' forms are confusing
> as they are reminiscent of the corresponding forms in the "SPECIFYING
> RANGES" section of revisions.txt.  We can remove the
> '<commit>..<commit>' form now (hence discouraging its use), since it
> is exactly equivalent to the clearer '<commit> <commit>' form.
> However, we must keep the '<commit>...<commit>' form around until we
> can find a different way to express the same thing.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-diff.txt | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 1f2f681..118b448 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -14,7 +14,6 @@ SYNOPSIS
>  'git diff' [options] --cached [<commit>] [[--] [<path>...]]
>  'git diff' [options] <blob> <blob>
>  'git diff' [options] <commit> <commit> [[--] [<path>...]]
> -'git diff' [options] <commit>..<commit> [[--] [<path>...]]

I agree with the end result not to list .. form in the SYNOPSIS, but
you shouldn't have added it in the first place in the earlier patch.

>  'git diff' [options] <commit>\...<commit> [[--] [<path>...]]
>  
>  DESCRIPTION
> @@ -63,12 +62,6 @@ directories. This behavior can be forced by --no-index.
>  	This is to view the changes between two arbitrary
>  	<commit>.
>  
> -'git diff' [options] <commit>..<commit> [[--] [<path>...]]::
> -
> -	This is synonymous to the previous form.  If <commit> on
> -	one side is omitted, it will have the same effect as
> -	using HEAD instead.

I do not think it is a bad idea to drop this enumerated item, but I
would have expected a sidenote to be added for the description for
"git diff A B" form, so that people who saw "git diff A..B" somewhere
on the web and wonder what it means can look it up.
