Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B11FA4
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ssVEbcAW"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8899B18E
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 16:25:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E82E61A5779;
	Thu,  2 Nov 2023 19:25:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XE13U1rH/L0uLWR1oLAjmPE+pjtE8fgebj9eo0
	/ND2o=; b=ssVEbcAW9N/JrErzCWG+2fLR5Mvp7j6XVzUcCtY3wYskCiX9MWv/0P
	jlxT5ljvmht3CNAA26vat+XDeg+r7wJJMOSvuE3fvpiH8/cD/LSbRGE4rFs5mhZL
	1Ws4KwZ1hNYNwe6K43odE/vNsg4In6YGB0B00gw832LVpTv6S2mDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D7D941A5777;
	Thu,  2 Nov 2023 19:25:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.16.143.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B70A1A575B;
	Thu,  2 Nov 2023 19:25:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jonathan Tan <jonathantanmy@google.com>,  Calvin
 Wan <calvinwan@google.com>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH] strvec: drop unnecessary include of hex.h
In-Reply-To: <pull.1608.git.1698958277454.gitgitgadget@gmail.com> (Linus Arver
	via GitGitGadget's message of "Thu, 02 Nov 2023 20:51:17 +0000")
References: <pull.1608.git.1698958277454.gitgitgadget@gmail.com>
Date: Fri, 03 Nov 2023 08:25:21 +0900
Message-ID: <xmqq7cmzlov2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 188E9AC8-79D7-11EE-87A4-25B3960A682E-77302942!pb-smtp2.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> In 41771fa435 (cache.h: remove dependence on hex.h; make other files
> include it explicitly, 2023-02-24) we added this as part of a larger
> mechanical refactor. But strvec doesn't actually depend on hex.h, so
> remove it.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>     strvec: drop unnecessary include of hex.h
>     
>     In 41771fa435 (cache.h: remove dependence on hex.h; make other files
>     include it explicitly, 2023-02-24) we added this as part of a larger
>     mechanical refactor. But strvec doesn't actually depend on hex.h, so
>     remove it.

This change somehow looks familiar.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1608%2Flistx%2Fstrvec-cleanup-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1608/listx/strvec-cleanup-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1608
>
>  strvec.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/strvec.c b/strvec.c
> index 89dc9e7e753..178f4f37480 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -1,6 +1,5 @@
>  #include "git-compat-util.h"
>  #include "strvec.h"
> -#include "hex.h"
>  #include "strbuf.h"

Makes sense.
Will queue.

Thanks.
