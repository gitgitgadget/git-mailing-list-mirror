From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] Documentation: branch: update --merged description
Date: Fri, 09 Oct 2009 17:56:48 -0700
Message-ID: <7vskdsf4mn.fsf@alter.siamese.dyndns.org>
References: <20091009101400.GA16549@progeny.tock>
 <20091009101858.GF16558@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLc-0005GI-1m
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933388AbZJJA5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758881AbZJJA5h
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:57:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199AbZJJA5g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:57:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB97B52C0C;
	Fri,  9 Oct 2009 20:56:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=cHdUBBFPvKs3G8wOtr+2QRLysjo=; b=W7iuSVEL+S/yvUaJc0118TY
	BL3Ovw5LjQvNkFjyFl05z9E7V8v4v231QslHakYVDBFCLimy6UpAyzB0pG/sYEXU
	1+513Ru5cqHN55HMKO/XajLCCz3J9ivh6sCjlaYk0ifU+a36Sryimq4TGfHZXxr4
	BEr5xmQx90ZHWLMg6HSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=vknC58H3lX1QXI0pXNo0l8dI+kQFIKYkWHjSluQ+J76KW5i6k
	ob3UdLN+zxXBviFk/pf2988mLnkkggG9ZpjIxggW0tlzJw9AnZR/5QQiYH14g6Sl
	3p21IijHB9zS1GT0hbnsRHaFGfMAkkSItAeB7VwcURAqL/2Ewqr15SCaQc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CBDD52C0B;
	Fri,  9 Oct 2009 20:56:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00E9852C0A; Fri,  9 Oct
 2009 20:56:49 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CC7B4A28-B537-11DE-846E-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129857>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Update the documentation for --merged and --no-merged to explain
> the meaning of the optional parameter introduced in commit 049716b
> (branch --merged/--no-merged: allow specifying arbitrary commit,
> 2008-07-08).
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

I most often use --no-merged this way:

	$ git branch --no-merged pu

to see topics that are queued but not merged anywhere.  This is not about
"do not list", but "do show the ones that are not merged", so I reworded
the description of the latter in your patch.

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index aad71dc..e8b32a2 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -134,11 +134,13 @@ start-point is either a local or remote branch.
>  --contains <commit>::
>  	Only list branches which contain the specified commit.
>  
> ---merged::
> -	Only list branches which are fully contained by HEAD.
> +--merged [<commit>]::
> +	Only list branches whose tips are reachable from the
> +	specified commit (HEAD if not specified).
>  
> ---no-merged::
> -	Do not list branches which are fully contained by HEAD.
> +--no-merged [<commit>]::
> +	Only list branches whose tips are not reachable from the
> +	specified commit (HEAD if not specified).
>  
>  <branchname>::
>  	The name of the branch to create or delete.
> -- 
> 1.6.5.rc1.199.g596ec
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
