Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE0D634F9
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="behi3/l2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3692A1C8F2C;
	Thu, 21 Dec 2023 16:18:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ls2fDQ7AyWoyvhZFykUvZMBj7EAcOx4gOwBbVY
	jf2R8=; b=behi3/l2YPr2ffVbsaBI+l48LzI0P7FUYMSddkl7lgj7YW/VRcNfVK
	PUosP6f9wwJydcfVyXUTJJMPcxRtSvDAQdjgGymDyld+v8qf7GVVpnSqTSD1SKh2
	sh1ajXuqy7vOLKqB8/4EFZ28eTmnDVNUbRwpv+1bgrb9HbSkWJVng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DE861C8F2B;
	Thu, 21 Dec 2023 16:18:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9191C1C8F26;
	Thu, 21 Dec 2023 16:18:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Phillip Wood <phillip.wood123@gmail.com>,  Josh Soref
 <jsoref@gmail.com>
Subject: Re: [PATCH v2 6/9] SubmittingPatches: improve extra tags advice
In-Reply-To: <8f16c7caa7366cab22ad332c402f80823add8224.1703176866.git.gitgitgadget@gmail.com>
	(Josh Soref via GitGitGadget's message of "Thu, 21 Dec 2023 16:41:02
	+0000")
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<8f16c7caa7366cab22ad332c402f80823add8224.1703176866.git.gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 13:18:10 -0800
Message-ID: <xmqqzfy3jlv1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 720540C6-A046-11EE-A81E-25B3960A682E-77302942!pb-smtp2.pobox.com

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Soref <jsoref@gmail.com>
>
> Current statistics show a strong preference to only capitalize the first
> letter in a hyphenated tag, but that some guidance would be helpful:
>
> git log |
>   perl -ne 'next unless /^\s+(?:Signed-[oO]ff|Acked)-[bB]y:/;
>     s/^\s+//;s/:.*/:/;print'|
>   sort|uniq -c|sort -n
>    2 Signed-off-By:
>    4 Signed-Off-by:
>   22 Acked-By:
>   47 Signed-Off-By:
> 2202 Acked-by:
> 95315 Signed-off-by:
>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>  Documentation/SubmittingPatches | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 31878cb70b7..4476b52a50f 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -368,6 +368,9 @@ While you can also create your own trailer if the situation warrants it, we
>  encourage you to instead use one of the common trailers in this project
>  highlighted above.
>  
> +Extra tags should only capitalize the very first letter, i.e. favor
> +"Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".

Drop "Extra", perhaps?  The sentence before already discourages any
extra ones, and what this sentence teaches the contributors is to
avoud spelling variation when to spell the common ones.

>  [[git-tools]]
>  === Generate your patch using Git tools out of your commits.
