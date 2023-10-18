Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7FC42925
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HtvciLce"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18684D4D
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 14:35:20 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 58E6B1B2230;
	Wed, 18 Oct 2023 17:35:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5ZR2dDmEjagGVQBdVJeEu67g6FelxM6OiuU1ET
	V75E0=; b=HtvciLceNrZGwby5UvXqdX7stLNGIGBux99U3yHsD6wTOX7VNkglwG
	3kHDza1GqcvtNveRhGrzk+xbndEFeTB5sRtby4mvWYxtWQW1U0uCnjRq524UMcZk
	1r944YJKU3LpcgWf7SHK5hFB8avd5g/xuDA9Rya4YwF1tSaAx/TPQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E1041B222E;
	Wed, 18 Oct 2023 17:35:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A643C1B222D;
	Wed, 18 Oct 2023 17:35:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,
    Emily Shaffer <nasamuffin@google.com>
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: Re: [PATCH] Include gettext.h in MyFirstContribution tutorial
In-Reply-To: <20231017041503.3249-1-jacob@initialcommit.io> (Jacob Stopak's
	message of "Mon, 16 Oct 2023 21:15:03 -0700")
References: <20231017041503.3249-1-jacob@initialcommit.io>
Date: Wed, 18 Oct 2023 14:35:17 -0700
Message-ID: <xmqqzg0fpqay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3BC593C8-6DFE-11EE-BC7E-25B3960A682E-77302942!pb-smtp2.pobox.com

Jacob Stopak <jacob@initialcommit.io> writes:

> The tutorial in Documentation/MyFirstContribution.txt has steps to print
> some text using the "_" function. However, this leads to compiler errors
> when running "make" since "gettext.h" is not #included.
>
> Update docs with a note to #include "gettext.h" in "builtin/psuh.c".
>
> Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
> ---
>  Documentation/MyFirstContribution.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Who's the first responder on this document these days?  I think the
"psuh" was Emily's invention, so sending it in her direction.

Thanks.

> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index 62d11a5cd7..7cfed60c2e 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -160,10 +160,11 @@ in order to keep the declarations alphabetically sorted:
>  int cmd_psuh(int argc, const char **argv, const char *prefix);
>  ----
>  
> -Be sure to `#include "builtin.h"` in your `psuh.c`.
> +Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
> +`#include "gettext.h"` to use functions related to printing output text.
>  
> -Go ahead and add some throwaway printf to that function. This is a decent
> -starting point as we can now add build rules and register the command.
> +Go ahead and add some throwaway printf to the `cmd_psuh` function. This is a
> +decent starting point as we can now add build rules and register the command.
>  
>  NOTE: Your throwaway text, as well as much of the text you will be adding over
>  the course of this tutorial, is user-facing. That means it needs to be
