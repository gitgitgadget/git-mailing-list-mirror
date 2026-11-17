Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873762;
	b=oTHK/Zq+2aBer4WgGvxFpyhazaC1RYQt30kTD6HmlwU6EnNCFFewE/lQJAw3/lmKB6pq
	 WxOjkOdACB91U3BJSJ4wemht06mSjMu2MKZMEaFNdaALNzfurCueTw2T8ut520ACLFNjU
	 gkVBT1oibgG6SHRfJwFmSC0Uy89B6c/UTJ6nCguFhwbmgtQh6umRQvdsANjxgzLpPVcUj
	 aSjSI4HO6VDq0oYAkkUvDMODZNjCM180jPpgel2TD3Hvg1S8tXyjfR2HiXkwQLEXHFJlg
	 N7HYRCaEMmiHP9R28OkLNnMDmZjbbI0SlCrW2YBh5qTc8QC24xYFXB3U+MHpNN5R49w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873762;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UikmxkMG8oGxqWrUMMtTN3cHdoXLcq3NmFKG7tmJE9E=;
	b=S3WMSjGIhEF+N5Kk0p1ePQUOfk9lRMiZdMfKCosv1ah4rLqORuueimc9DvHuCAmiH5D7
	 PImTEPzLWJH5mOWmu6r0iWFMlRhwmaV1Z+ZBNaVIRrntcgG/+REP/PFR2N7zo6V083VWD
	 TLpYKTjQ88IlRw2Ft2Mpw7gzM30kk1pF183jcV16ie0SdZVrHSPabzbz0hNKuxTAviWw5
	 NvtByeKMKhQkAIcZEOhlpbVtnrFrVszA1f8gPJAaudTR6jZTMVuDju09GUiy13xFS0Wni
	 xSSDUeFOOQtPqqS0MYmjQ9awK45AqvOUHV7NTyCEh1LG420sFSrt8uNLAdIiYKvPZVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=M1IR64we;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nHlTsMCj;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA295606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 00:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA295606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=M1IR64we;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nHlTsMCj
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3929D7A0147
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 19:02:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 19:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794873760; x=1794960160; bh=UikmxkMG8o
	GxqWrUMMtTN3cHdoXLcq3NmFKG7tmJE9E=; b=M1IR64wemk2mryUkbp05tlFRdF
	f0FuEhXM7627+66S2ZZa8BVE6WgS3Q0vXQOPENGsU24az8ABXNHbVoeTpO9wUUMF
	wRu5fcbOnZnKUqaxbDGZcE4TyXFK64nVf2J+5r5Ee93BDN7rT2gRY0ze3hzxjVVn
	FyASwuf/dU5tsWDhMCMhERO/5CaHe36OTpzaJgI1DigfN83RczpFfZXEBOavHeV5
	IhMRgEhHhPsbbMZF0UZLI0qvay9nrEHS4ZoM+Bu3dbCRBMfMmrZNu6Ns9xCbmBje
	vUzn7FZhapFZCnQ/rFEmG8qolp/7A0pDGiXBNjgi0b4Z3Ym4MD9ERfoD+tBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794873760; x=1794960160; bh=UikmxkMG8oGxqWrUMMtTN3cHdoXLcq3NmFK
	G7tmJE9E=; b=nHlTsMCjWXzz2vMHcKivyMdybjDBIid+PfXNlOkzPNO4jGAITZk
	0h7Hbdw5Zq+YIHtbcC+H1f2kqmwdh7hE4kDocOCzcMCkJHNvyJr+H3sS4FGtye47
	xyGyAhAxOPWokXFEctoc4KQ1vadj2ToM/JkCU6OngOAStoCOOY9pxJ2KSZ1pr3ZL
	MbQC96tlJBKxJTRlq4j1zQlB2ES9LBzyWwKQycER8gZeSt8EJ4lclC/zOfnO/rIK
	aGi3BMhLLGk0oC7Yk80Chg9MaqW/BuvFbWpKimVFqsctb0mm2+xK2QjFZTxq3UZb
	iumYUKMhFgR0d7IL9/uCfFgg6qAr1DMEG6Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794873760; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SU8D1iRmKhZzK6kgjvyxszuSD/s7Tc4IZBBW+y7gl/JqEgD
	2X2d5TWEBp4PJx81T3/2e4t9S+5+KU6Pt81WkSeqdajBZOOW5AlDbZidAObSP8lq
	MbwS8CUbHnvyfnY0F5tgbjBPVRI7ujkkNigcM70t3n4J2RxsMvJVSh+odujvyAYd
	3wCZ1S9U3imFwEI0GpxXVW606pCRZNYQRpRCHQBfxFWXtvwXeKz3eIWewyjam5C5
	oZPEr1NftlU7MFLY0tGMrYm6AktrpSC6xiytpSq+xsyLr97NRAHa4GMQQCn5mvDj
	+M1EqSdcWJ8ftRLKQrZgL/K5utufspi1ZlmtZMg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:cA6SMh6a/48s1WoA7XIFsvUBTEC62s5rHccY3EjrKBw=:0xp4PS9yYe7tGSejbMqXYITk7BO5jKcduyjM7gJ65ss=;
X-ME-Sender: <xms:n5n7aifMOhFzwjbR9mcgwIjRZcD_yW9fYlKaa8qU0Egx8cVgsuK_0Q>
    <xme:n5n7ajruOeFdQKaHtD7bJ9T6XqF8R_aiq7uJCoBtbRbeOQDIFcO8u6UxP7G-o2JOI
    nlUIMp156TYkCa58At398QY-Ixz_jMU8WyJHt8nviEcV_YN7Uao5A>
X-ME-Received: <xmr:n5n7ag6TqA9vsoVc26zHnxjh0VKxu8fTnAZ6Ujn-oolXnKpKqR8syTgXBYdiJriE_8NoYEWGPuRaakBGZSOxnC0LAka_WwuuZNRi>
X-ME-Proxy-Cause: dmFkZTEFzgKy9McRvyGMetdtBLTPeq0wOfRn3TirNrkZvwniVkPKNlKpsk7h9w0/6KhmLI
    gGC46wEi7sTMFX1uOJmcp5ARy1tEwZX7/Ho6gpUm9jZAddlFDow/LIME2KDD2s+AUI03Pe
    VwU5eDWgeuLLla9VresBvtDhTezaRTzUSk62KxSeJwn3vzdZX1MKVR4W8RQFkxLwpoXLjw
    EJ4F9HtaVjtBso1FD/BmerLiwOPLaud7WyVxN702RMBI29nykDfH+yOH/QLtGUJawc8l6G
    rvCLmMOURGtB+1yLjJBrTd5CPqE1eTqP8bGh4sirCpVdCz8qF1NawrAKUUbsgKvbw0YVDk
    0MIBCt0PCFsZ7DjIov/bqFUb9mX0Jzd4jSUq8dYPyALG0Kt0adnzqyMJmUdRejl3bR4ACc
    bOnBDIvASxW4CPlaZSVA8ezKaMd4Erwx77XJnbrqdoSgjoZKGpfa1AO0bkNQ7RpGQjLQDW
    JR/Eq45QBG5ra1KPLfybKw1JniFXac3grIYigBox7ew7EWr0I51qFhtWxrt80INwIVB81k
    wGVtO84LJngv4CvTkN9G1K/OpwqErif9Av/ksck/euK0Gv74r+eLhvbN4um+ITSKwTxrdj
    dLEvVeYNlnubF4DEouBpIuMRJ5FRr+qe6HJE9wdtx85v5TXb66u8zOUS2LZw
X-ME-Proxy: <xmx:n5n7apq0l7zSw_mK1-85hv2GKia0uzxuDIleTLtJL4aEvkJkhU9ueA>
    <xmx:n5n7aii9Mw3GzzfiPneiljMqUWnokUKbLtCz12q5ASHsF9NZye149A>
    <xmx:n5n7ajL7ajZZ-WZbw6voYA4xpga9jvfS4hJXpXI3J6fSCcVVWsNMpQ>
    <xmx:n5n7aiDqJqXv3u-El38_dH1WkZe3O3p7mAxhVm5WFqpTbcaeztVIYg>
    <xmx:oJn7avSzx5Upife0eueOLsODX8i4U7cBTjvX8gZR4KO6JOoRRXCnaSzH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 19:02:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] utf8: respect bounds in utf8_strnwidth()
In-Reply-To: <20261116-master-v1-1-dc2a50ce0aa0@gouders.net> (Dirk Gouders's
	message of "Mon, 16 Nov 2026 19:57:00 +0100")
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
	<20261116-master-v1-1-dc2a50ce0aa0@gouders.net>
Date: Mon, 16 Nov 2026 16:02:38 -0800
Message-ID: <xmqqld6siau9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Dirk Gouders <dirk@gouders.net> writes:

> utf8_strnwidth() takes a len argument, but because
> display_mode_esc_sequence_len() works without an explicit boundary,
> there are cases when utf8_strnwidth() operates beyond the given len
> boundary.

The problem is well spotted, but isn't the blame slightly misplaced?
The preimage with missing context looks like this:

    int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
    {
            const char *orig = string;
            size_t width = 0;

            while (string && string < orig + len) {
                    int glyph_width;
                    size_t skip;

                    while (skip_ansi &&
                           (skip = display_mode_esc_sequence_len(string)) != 0)
                            string += skip;

                    glyph_width = utf8_width(&string, NULL);
                    if (glyph_width > 0)
                            width += glyph_width;
            }

Even if display_mode_esc_sequence_len() were updated to take the
remaining number of bytes in string (which I think *is* a good
change, by the way), the loop it is in may cause the entirety of the
string up to the "len" bytes to be skipped.  Because the original
lacks a guard before the call to utf8_width(), however, we end up
calling it even if string points beyond the given region of bytes
orig[0,len).

If you blame the lack of such a guard before utf8_width() (or after
the loop that has display_mode_esc_sequence_len()), it would match
the proposed fix.  But I doubt it is entirely fair to blame the lack
of an explicit boundary in display_mode_esc_sequence_len() for the
breakage you are addressing.

> Fix this by adding a boundary-check after looping with
> display_mode_esc_sequence_len() to ensure we operate strictly within
> the given len.

If the incoming "string" is at the end of an mmapped region (beyond
the end of which nothing is mapped), reading string[len] would give
you SIGBUS, so display_mode_esc_sequence_len() would already have
taken you into trouble.  In other words, even though such a check
before utf8_width() is better than nothing, in a sense it is too
late, no?


> diff --git a/utf8.c b/utf8.c
> index 96460cc414..7e050bb2c4 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -217,9 +217,13 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>  		int glyph_width;
>  		size_t skip;
>  
> -		while (skip_ansi &&
> -		       (skip = display_mode_esc_sequence_len(string)) != 0)
> -			string += skip;
> +		if (skip_ansi) {
> +			while ((skip = display_mode_esc_sequence_len(string)) != 0)
> +				string += skip;
> +
> +			if (string >= orig + len)
> +				break;
> +		}
>  
>  		glyph_width = utf8_width(&string, NULL);
>  		if (glyph_width > 0)
