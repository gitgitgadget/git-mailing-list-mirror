From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH na/strtoimax] Compatibility: declare strtoimax() under
 NO_STRTOUMAX
Date: Sat, 05 Nov 2011 23:10:15 -0700
Message-ID: <7vlirt7pdk.fsf@alter.siamese.dyndns.org>
References: <4EB5583E.2030306@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Alcock <nix@esperi.org.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 07:10:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMvvz-0004Aj-FN
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 07:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973Ab1KFGKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 01:10:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750Ab1KFGKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 01:10:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B23EA42CA;
	Sun,  6 Nov 2011 01:10:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OqKA2ncUvBuKCXmc84mbNliAmr8=; b=a+bvrl
	hL3/U6AU/V403PY/sAM2KGYThbvAtk6IdGYvKCi5CJveRkMD7S3r6hO7q0g8Bxmt
	urchTMOoD+gFMq864fdL2GJ6D1ewwbkh6zCxelq2VGAaSkmOyUdt8Rw0ck4Se/7v
	WfQQftMkiMstc4UDmG6xJLNYZTmhE9gloAWxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dw0wPsQW6hD/A/F/capjjGOE9HiVfHzf
	dOGR9l6mrNmCDLNY/wA1XK/44/a334ASlIwoa959wKA9SV43jwC+M1xOSgH2IFB2
	oTfahHrPv2Z+/RtdhzGNtjP69d2eAUrRnkLH5ljfxt+oQsz8ZmP2mPK3ihacLQlu
	3io+AcsOLCI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA6A742C9;
	Sun,  6 Nov 2011 01:10:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 395A642C8; Sun,  6 Nov 2011
 01:10:17 -0500 (EST)
In-Reply-To: <4EB5583E.2030306@kdbg.org> (Johannes Sixt's message of "Sat, 05
 Nov 2011 16:37:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF9EF7D2-083D-11E1-B4FE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184903>

Johannes Sixt <j6t@kdbg.org> writes:

> Commit f696543d (Add strtoimax() compatibility function) introduced an
> implementation of the function, but forgot to add a declaration.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

Thanks, but I think f696543d is v1.7.6 and not that patch.  I hope you do
not mind if I just squashed this in, instead of leaving it as a separate
patch.

>  git-compat-util.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index feb6f8e..4efef46 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -354,6 +354,8 @@ extern size_t gitstrlcpy(char *, const char *, size_t);
>  #ifdef NO_STRTOUMAX
>  #define strtoumax gitstrtoumax
>  extern uintmax_t gitstrtoumax(const char *, char **, int);
> +#define strtoimax gitstrtoimax
> +extern intmax_t gitstrtoimax(const char *, char **, int);
>  #endif
>  
>  #ifdef NO_STRTOK_R
