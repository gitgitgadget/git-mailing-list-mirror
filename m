Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969479;
	b=EZnVkc+veS1HKj12AZxnLVLj+KCIpwPf6Uy1OSbRQXhVUWFhY14NQn39l0v6ZPzfGrXV
	 AqAPJG8yavJhUD+2qtJ8br72cwsl4Tsn2jMQ2TDfMGhpAjcxOIr96JhQjPGqUvwE+vC5c
	 LhW7bvX42uTcIFrTJDIoASMfbEjdByJoR1xN15ssQXsM7Bkce2vqf8UTXQfpk1fpm9pAy
	 ERWDbVKypbQ+lR06mP/X/NbQWAnqUwp2GkKMZo/RdRdWkZrcpyIxcN+dCx29g0uDtfgMk
	 UBZN43M079pJmUlgm1thBOMgqHKVFQ5F1FzZodommmKcjOrQ+BmkXuUbXOFwx/cjl3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=1D2EouQN1l+x3lhp1vH8uEt1RDOW4S6D2DmQ6eysuJQ=;
	b=Fgvt/tSTvo5HuyiefXBctk63ns9mNyMVKydkYd2DWJKNGA0LmGmi4M6MHQuK7eEl+iJO
	 7zaOKuV8qMda+vqxdP3QGpkXvvloX1ZYlrloPEJ/G9HSHHAIFiQs5rl2CW5ArraunyQHC
	 fFJv+5vJo/3WnWULIlTijis/sOXo42M1MfmnJHio3K1Kuj85tqkQjLU3GozrqtG2a6MFL
	 +9tvZfAWG0KF1Hi5ZdGoDozQvEIaRbtr4mGsyyvXApR4JjIPRrN6rIO0baEQYT+KUyDvM
	 j8vcVizX9bxl7IXYMfrGoXQKzVJxSuOjecfI+XoBBeYxaM3UyTIkhW5j0BO5kSmZf+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LIWEPqka;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5E606A331
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 12:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC5E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LIWEPqka
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-945ae2daa68so78585085a.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 04:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969478; x=1794574278; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1D2EouQN1l+x3lhp1vH8uEt1RDOW4S6D2DmQ6eysuJQ=;
        b=LIWEPqkapzu49fAT+5HFHgbJIlaCAul+1VjQicHtdzvSgXipDr5GsltfYj8Wc0dtSU
         HZ/2p4IZMWNjz0fiTUbJYx7L4kF+uyB/hky0tfmsYBx2W679vZMXpHPgl7sJWS/aiKhA
         OuuWmbDEococ6IrvqtaLirXu4RrOnh7FMoQ66hUxfdd0FR0ScK4XKRgCcyuMpd5YybU0
         OuxKWNwYHu3/5QXUbXWCl6SXBknmbvsxFVvYvEbWhP3YOZBAKXSTtaxQxTLmkmc4BWw8
         wIIqtRBgkW2LxPiungePmc7KbnYAvK3d3c9SXhUysEFJupM33hQA+WtVczjZbIxJ4GjX
         I49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969478; x=1794574278;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1D2EouQN1l+x3lhp1vH8uEt1RDOW4S6D2DmQ6eysuJQ=;
        b=mIlPSTB6m65FXwa32U3X6BAdbBREspwsSEBQrWKR/0WYe0XXH7aLaTMlNbFkyeyUqA
         9qwibbjbcqB0Wlhey25O/riSSHZ8+XVgcNqsRRT8S9FYpfsD+iGrB/p8STiMm02tqX16
         FjKW1ItJCVX475hVtPlBJotaL57W8p+1E0Yd33B8h3GsuncNK788E8szq4VIGWoZ3rlk
         z4NwG588viBukbFM9tR/TdZg7yWomhJNsQJyik3hc9264E4iAFcWDe+WqGang2rz+MF1
         TQ2GUEPV41YOYBx/1j9hKeeC6IzTuIafBJG5vqmIc0SUDAuVANFF6C5ZC+bvPPfweoXE
         Cx7g==
X-Gm-Message-State: APuU4Z+ERaOLtU6wjegillIpxBRNrVFP/eDrB0o7X8XF2s3M9RgAAajo
	fs2bVa6hxkYp5RlZ0wPEjEt2calbE9W9Z1GEba5bIN3la0Et2jIDcloTRxqWNPK3
X-Gm-Gg: AYBFou3DOvKltc1zXOa62RnMRkbLx6PiNi+wCTrt0MALPkN+NMjDG+s5o9LeADx3qTi
	fhISiR1epa7vKQbk20Qu82NObq9T+t/JMkiYnKSfA9mrDj9LOybzPlBtyUxZ57qZlFeXAraovI5
	87JaydiURF91ukLTURn8WC7abV/N38IDmULzBoRGoa6FgvjXP+kJAyC6mzzlARvrsYcWYX+93u+
	dpuDM/mNyQLrPFA3nWe29ePFGeGJ4nGk40YUHYgw/lLVrZpeRyhZidsa45bL4LT8N6o4ztQU3eZ
	tvZaKcWNXIT5GQrZqAK5qxnmgi0797IAz10vrfgHj2/CzXKUNLvuviT2GgK+Lw2ZxxxpYNQnL25
	5DLq7I4hngOsFV6oE86Zre59WQ1Wlk2mmAUpdVUyObSSg51RQ6ShfnMaxOajXtuRUgtYt/yGzou
	Zhx05doLbZyltcPRyIAocGSDN7FtBFSxihlC6DOQhCgMkhWjPNrwfHMyFeUgcNfhQGJx2q4i4EY
	+ZIAx4p8DuwWgB4a0M/7VgsSjmDVwuOoMFQGmdl6tUaU+g/GGURL+Yrt+VfITErn78HvOM1jz8V
	WbizCwtPqMe+beg4uc7NlLoatTopMKg=
X-Received: by 2002:a05:620a:2788:b0:943:e872:f521 with SMTP id af79cd13be357-945e16aa3d0mr773861285a.9.1793969478368;
        Fri, 06 Nov 2026 04:51:18 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f58bf0f1sm136951785a.5.2026.11.06.04.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:51:17 -0800 (PST)
Message-Id: <789bb9bca7f4a1c97cfd7a1062d80698cd3e11fc.1793969476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2299.git.1793969476.gitgitgadget@gmail.com>
References: <pull.2299.git.1793969476.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Nov 2026 12:51:15 +0000
Subject: [PATCH 1/2] unpack-objects: pass the size of a streamed blob as
 size_t
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Since f2063855fb (index-pack, unpack-objects: use size_t for object
size, 2026-05-08), unpack_one() decodes the size of an object into a
size_t.  But stream_blob(), which is used for blobs larger than
core.bigFileThreshold, still takes that size as "unsigned long".
Where that type is only 32 bits wide, such as on Windows, the size of
a blob larger than 4GB is truncated, and writing the object fails:

  fatal: write stream object 4294967304 != 8

This was found by the next commit, which makes t5608 actually
exercise the unpack-objects path for a >4GB blob.

Take the size as size_t instead.  The struct odb_stream it is stored
in already uses size_t, as does the rest of the path that writes the
loose object.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/unpack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 351948724a..d2f25bed49 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -386,7 +386,7 @@ static ssize_t zlib_stream_read(struct odb_stream *in_stream,
 	return buf_len - zstream->avail_out;
 }
 
-static void stream_blob(unsigned long size, unsigned nr)
+static void stream_blob(size_t size, unsigned nr)
 {
 	git_zstream zstream = { 0 };
 	struct zlib_stream in_stream = {
-- 
gitgitgadget

