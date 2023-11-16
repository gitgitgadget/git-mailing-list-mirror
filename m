Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qkGekfkD"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8ABB4
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 20:59:53 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DE9DC1EE2F;
	Wed, 15 Nov 2023 23:59:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fR4XU41UToLCd5bVJFLjczATlHYsRsUTIlf9Vl
	DV2eo=; b=qkGekfkDenxW5/XhhUr+wFxmnWevERYxwbpVFZemKZ/91xK7QrKDTo
	zucwXrD35iphVsTXVJcyXnoylPOij4MbsferLK9KUKL/YKt0TouEm6lBLxzIOf/+
	ZW7fGlHDloSGtwTgUdol6v2DtcTMSTLKCj5U9A+ca+sx+TrTqMPt4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D71861EE2E;
	Wed, 15 Nov 2023 23:59:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 75B231EE2D;
	Wed, 15 Nov 2023 23:59:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?=
 <opohorel@redhat.com>
Subject: Re: [RFC PATCH v2 2/2] send-email: remove stray characters from usage
In-Reply-To: <20231115173952.339303-3-tmz@pobox.com> (Todd Zullinger's message
	of "Wed, 15 Nov 2023 12:39:44 -0500")
References: <20231115173952.339303-1-tmz@pobox.com>
	<20231115173952.339303-3-tmz@pobox.com>
Date: Thu, 16 Nov 2023 13:59:48 +0900
Message-ID: <xmqqzfzes37f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F85F5790-843C-11EE-9857-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Todd Zullinger <tmz@pobox.com> writes:

> A few stray single quotes crept into the usage string in a2ce608244
> (send-email docs: add format-patch options, 2021-10-25).  Remove them.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> This is not scrictly tied to the previous commit.  It just stood out
> while I was reviewing the usage output.

Thanks.  Let's split this out as a docfix patch and handle it
separately.


>
>  git-send-email.perl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 94046e0fb7..cd2f0ae14e 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -28,8 +28,8 @@
>  
>  sub usage {
>  	print <<EOT;
> -git send-email' [<options>] <file|directory>
> -git send-email' [<options>] <format-patch options>
> +git send-email [<options>] <file|directory>
> +git send-email [<options>] <format-patch options>
>  git send-email --dump-aliases
>  
>    Composing:
