From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: Clarify "preserve" option wording for git-pull
Date: Thu, 26 Mar 2015 10:37:54 -0700
Message-ID: <xmqqh9t7zmkt.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuMcKAhW+_Ho8X1kzZd3B57ogu2Anb1nuPmKwRQD=OYrZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 18:38:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbBjH-0003Oi-0S
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 18:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbbCZRh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 13:37:58 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751018AbbCZRh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 13:37:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C32CA414C9;
	Thu, 26 Mar 2015 13:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vLbUS21n7z0sGjmUbQb6OHFeDcQ=; b=a5OE/b
	HNwAMg/naJEmLAiUm1ocnjXvcFAMZcGv6YxpMw0JlugjZVB3u36k7Dccx0XyJiZz
	35q+UPDOD9WXzHlKpXSMsaUvFltM62V8Xuy7pUpIzuHCNuuU0wq6PG1Ssgdpg76c
	RfLuhGb6aabtThCIx5yxPMTVP/n4y91x9OGsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cj8EvsZf5HTyy3MuCWbS6WEYcO+FKGUk
	g5Lpo5jijEIcMEEecrs6Ikqu9s848yFoJq/NIJyV4lgBNROXECWC146qyWFVQd0L
	EGXr8WUoElG5+GMv8WQh5xruNcQBgTxVCkZr2dxxuPJblYTpHuorVsbtF/JvAjWP
	CkdceYda+i8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBB78414C7;
	Thu, 26 Mar 2015 13:37:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4256D414C3;
	Thu, 26 Mar 2015 13:37:56 -0400 (EDT)
In-Reply-To: <CAHGBnuMcKAhW+_Ho8X1kzZd3B57ogu2Anb1nuPmKwRQD=OYrZQ@mail.gmail.com>
	(Sebastian Schuberth's message of "Thu, 26 Mar 2015 12:04:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D68003F8-D3DE-11E4-9499-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266339>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Before this path, the "also" sounded as if "preserve" was doing a rebase
> as additional work that "true" would not do. Clarify this by saying
> "still" instead of "also".

I agree that the original "also" is confusing.  I however wonder if
we even want "still", though.  For that matter, I doubt if we even
want "also" in front of "pass".  "When set to preserve, rebase and
pass the extra flag" sounds as clear as, if not clearer than, "When
set to preserve, still rebase and also pass the extra flag", at
least to me.

Thanks.

> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  Documentation/git-pull.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index d3d236c..96829be 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -111,8 +111,8 @@ include::merge-options.txt[]
>      was rebased since last fetched, the rebase uses that information
>      to avoid rebasing non-local changes.
>  +
> -When preserve, also rebase the current branch on top of the upstream
> -branch, but pass `--preserve-merges` along to `git rebase` so that
> +When preserve, still rebase the current branch on top of the upstream
> +branch, but also pass `--preserve-merges` along to `git rebase` so that
>  locally created merge commits will not be flattened.
>  +
>  When false, merge the current branch into the upstream branch.
