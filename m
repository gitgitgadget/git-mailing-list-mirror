From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: trivial cleanup
Date: Sun, 07 Apr 2013 01:16:00 -0700
Message-ID: <7vzjxa7o3j.fsf@alter.siamese.dyndns.org>
References: <1365319139-12362-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 10:16:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOkln-0004GJ-CU
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 10:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161539Ab3DGIQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 04:16:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62646 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932930Ab3DGIQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 04:16:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB8A810ACB;
	Sun,  7 Apr 2013 08:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=plnB1f/yClUqMZIom9BHXniCG8Q=; b=oDwDXW
	5Ob3E98yo6tyEhKgwMb/5/V7SDK97Nf5pn/2DLHeTbOsXNYVOO2goppDFT7vOkYq
	Py06GFUz9IBbashubjg6carqNgTpK3caZuiow7Sfffag91SkNxnj35IWRzgG1EI8
	4tr59kYGh45UHdwJLU7tmWNt1gNDHieKWRt7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jF9y/VOoKI0+MhZAOBODT2TlZw+hjRXF
	I9vAd3S8I9q50wXohOMbW1SOqdVQxBg0Nf83dxiE08wy+iEtxoGh+HZqlmDquubh
	V4c4Gbk3mBbdoMTUWstlJDwKN2BA7rUUziGp86UIBDhtZlG2/NNapvDYp89LseDm
	2SoBmCZQUBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3A9A10ACA;
	Sun,  7 Apr 2013 08:16:02 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41F6D10AC8; Sun,  7 Apr
 2013 08:16:02 +0000 (UTC)
In-Reply-To: <1365319139-12362-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 7 Apr 2013 01:18:59 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62C9C796-9F5B-11E2-BF9F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220295>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> Actually, now that we are on it. After applying my latest patch series, this makes sense.

Yes, this is way easier to read.

>
>  builtin/log.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index fab7998..7cf9277 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1058,12 +1058,10 @@ static char *find_branch_name(struct rev_info *rev)
>  		else
>  			return NULL;
>  	}
> -	if (0 <= positive) {
> -		ref = rev->cmdline.rev[positive].name;
> -		tip_sha1 = rev->cmdline.rev[positive].item->sha1;
> -	} else {
> +	if (positive < 0)
>  		return NULL;
> -	}
> +	ref = rev->cmdline.rev[positive].name;
> +	tip_sha1 = rev->cmdline.rev[positive].item->sha1;
>  	if (dwim_ref(ref, strlen(ref), branch_sha1, &full_ref) &&
>  	    !prefixcmp(full_ref, "refs/heads/") &&
>  	    !hashcmp(tip_sha1, branch_sha1))
