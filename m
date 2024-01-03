Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182D1CA8B
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g+kBxYYi"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B8F5418060;
	Wed,  3 Jan 2024 14:23:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=72eBpSQ3FuEe2c8Q6tFUpeqEFuq+d0ADqE8zFF
	rTcN0=; b=g+kBxYYimWSjXTA9O7W6n3YINT2uAeUZT1do6+e4fwiJlljjcZnRU0
	TaaFQo9SF/cXlYodsLI95+T+nOjiw4xiBxAb4dzdVH8+zz/wpJcufl9DNSDVqqqv
	sWP6RXkLpMeA1ZK+htZcgp4RU50Ai8lwH/d1wYj2uZWYQc4A9qqRY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B003C1805F;
	Wed,  3 Jan 2024 14:23:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 574FE1805C;
	Wed,  3 Jan 2024 14:23:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Maarten van der Schrieck via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Maarten van der Schrieck <maarten@thingsconnected.nl>
Subject: Re: [PATCH] Documentation: fix statement about
 rebase.instructionFormat
In-Reply-To: <pull.1629.git.git.1704305663254.gitgitgadget@gmail.com> (Maarten
	van der Schrieck via GitGitGadget's message of "Wed, 03 Jan 2024
	18:14:23 +0000")
References: <pull.1629.git.git.1704305663254.gitgitgadget@gmail.com>
Date: Wed, 03 Jan 2024 11:22:59 -0800
Message-ID: <xmqq1qay9q7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8290B00C-AA6D-11EE-93FE-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Maarten van der Schrieck via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Maarten van der Schrieck <maarten@thingsconnected.nl>
>
> Since commit 62db5247790f2612c0b407a15d1901d88789d35a "rebase -i: generate
> the script via rebase--helper" (Jul 14 2017), the short hash is given in
> rebase-todo. Specifying rebase.instructionFormat does not alter this
> behavior, contrary to what the documentation implies.
>
> Signed-off-by: Maarten van der Schrieck <maarten@thingsconnected.nl>
> ---

Looks good.  Will queue.  Thanks.


>     Documentation: fix statement about rebase.instructionFormat
>     
>     Since commit 62db5247790f2612c0b407a15d1901d88789d35a "rebase -i:
>     generate the script via rebase--helper" (Jul 14 2017), the short hash is
>     given in rebase-todo. Specifying rebase.instructionFormat does not alter
>     this behavior, contrary to what the documentation implies.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1629%2Fthingsconnected%2Fpullreq1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1629/thingsconnected/pullreq1-v1
> Pull-Request: https://github.com/git/git/pull/1629
>
>  Documentation/config/rebase.txt | 2 +-
>  Documentation/git-rebase.txt    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index d59576dbb23..c6187ab28b2 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -40,7 +40,7 @@ rebase.missingCommitsCheck::
>  rebase.instructionFormat::
>  	A format string, as specified in linkgit:git-log[1], to be used for the
>  	todo list during an interactive rebase.  The format will
> -	automatically have the long commit hash prepended to the format.
> +	automatically have the commit hash prepended to the format.
>  
>  rebase.abbreviateCommands::
>  	If set to true, `git rebase` will use abbreviated command names in the
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 1dd6555f66b..25516c45d8b 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -523,7 +523,7 @@ See also INCOMPATIBLE OPTIONS below.
>  +
>  The commit list format can be changed by setting the configuration option
>  rebase.instructionFormat.  A customized instruction format will automatically
> -have the long commit hash prepended to the format.
> +have the commit hash prepended to the format.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>  
>
> base-commit: 055bb6e9969085777b7fab83e3fee0017654f134
