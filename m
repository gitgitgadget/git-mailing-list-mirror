Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185A4AEE5
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387485; cv=none; b=aT6vei4/N8xKFlIXzWLBoGCPq4YTRJ3IfeO+llKj9WtGx0/a/VzrxXt/0uGvKfGD7BnAIAxB96u+qSiZjDkLHcTFgPwiyK9+XeyQr9uPUe3QI9l9uNYWdwwbK+myAVGLLcaFoz0ZGS02BfztbtE0lvzs4CwSLBCA7h0JlVQjlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387485; c=relaxed/simple;
	bh=XtWq6NqD52/Hjkup2Pe4JxxY18W1gaSiSaCHCRauUfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHoEKRStM7HVXloSzF4ENNBB6mHfSw6as3OWMO3nPJP7BvhZXxd6382x9x43Ql4xSZP74vECNgXo6OyNQksCZZ1+od83nP4n7EEFxEQFDxoOWlT22R94grfSF6fZxx9xj4DbVoT5ZkcqGP0tROaWxhs8x8RAD1YIOX9UffO51r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NwRa5hgt; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NwRa5hgt"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78a2093cd44so382116285a.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711387483; x=1711992283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/pBLXp08H8YK1vw5fo90npRZRIsLzp8EivT+tlHGKs=;
        b=NwRa5hgt8cTIrEnS7AzmwaZbQBytcuhTYcWSyX0MUstQntMToUzd5ILgWatgCUupWO
         l5WQBX1xnO9sEdfDIX66r/P3mB1roMR27LBVXDkXMPWA9G7JgWbQ63ib/ThylueYqMnD
         bxswM2oUMOmvOfLwM07HiFTPNEdDy2/Oj8+uBO4fBGJ0tcDmiprich2JlrAju/oU9ZVl
         C8pP8qTMs/ByCaWRfj8PWcP9AtxwvpP95iP52QgpnVnPt98Ggi1z7xdjgqGWlJT7iXQe
         9SrHes3tmkqitKiqqlD16VoE8/1/EtiTz5hgoWmV69kshIAZ7wATFGsrmmgXS8ZRZSeB
         cBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387483; x=1711992283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/pBLXp08H8YK1vw5fo90npRZRIsLzp8EivT+tlHGKs=;
        b=Dw4+irr6wQopEo5F2hX9o3NiM//QDsHGIN+yeNOgG2HJvyWPa69Ui1fdOi+X69ntwy
         QBAZxIKfMvSjFWjmQLmcqceUALEqyyMteFvDt6dKLyKUG9EqRTjbqIcIaoeHls2kNrqy
         5hlsn+X/j6qduHfW8F/cfhbyFT4jL9h2Sbw/KkOsyR7/fuKyY0/6uMxdV5pTDQ33JLeP
         Io1j8Jfz/QUKBsvuZphPoWHS6z2IUPZuBq1rQ9Ekwa6basq086ZYWCxo34CN3CHt45HP
         Xj8/RxgozEedfbd0/bm0UwfAuKE5gzYsyPZmwnm02R7OdYNN6hwueQkO8qRz21AoOS9s
         GiVw==
X-Gm-Message-State: AOJu0Ywv0qxgBOSMymIALP2ukKp9LnBraAlm1/zZliM2cbI8+GlHYw8i
	zE39P9FHQ6TxqYTaOJvFIDjoTWzBIJAeZddGAV2PMlfX9CFtxVS387dT974dGbECKbVVXPOf3d4
	7UJE=
X-Google-Smtp-Source: AGHT+IHj4mqin96IcRX/rEnhA4aoYwUiuS6DGbWyoUSgsrGr50VDuVYwZTPTsxJerrSRh52M3yYdFw==
X-Received: by 2002:a05:6214:20c1:b0:691:3b87:1382 with SMTP id 1-20020a05621420c100b006913b871382mr9166258qve.26.1711387482831;
        Mon, 25 Mar 2024 10:24:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r14-20020a0cf80e000000b0069677500d0bsm2990581qvn.29.2024.03.25.10.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:24:42 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:24:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/11] midx-write.c: avoid directly managed temporary strbuf
Message-ID: <8e32755c492d20eec02c81351d249ce34cc6d7b9.1711387439.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

In midx-write.c::midx_repack(), we construct the command-line arguments
for a pack-objects invocation which will combine objects from the packs
below our `--batch-size` option.

To construct the base name of the output pack, we use a temporary
strbuf, and then push the result of that onto the strvec which holds the
command-line arguments, after which point we release the strbuf.

We could replace this by doing something like:

    struct strbuf buf = STRBUF_INIT;
    strbuf_addf(&buf, "%s/pack/pack", object_dir);
    strvec_push_nodup(&cmd.args, strbuf_detach(&buf));

(combining the two separate `strbuf_addstr()` calls into a single
`strbuf_addf()`). But that is more or less an open-coded version of
strvec_pushf(), which we could use directly instead.

(Note that at the time this code was written back in ce1e4a105b4 (midx:
implement midx_repack(), 2019-06-10), strvec did not yet exist, so the
above example would have replaced the last line with:

    argv_array_push_nodup(&cmd.args, strbuf_detach(&buf));

, but the code is otherwise unchanged).

Avoid directly managing the temporary strbuf used to construct the
base name for pack-object's command-line arguments, and instead use the
purpose-built `strvec_pushf()` instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index c812156cbd..89e325d08e 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1446,7 +1446,6 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	unsigned char *include_pack;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *cmd_in;
-	struct strbuf base_name = STRBUF_INIT;
 	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
 
 	/*
@@ -1473,10 +1472,6 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 
 	strvec_push(&cmd.args, "pack-objects");
 
-	strbuf_addstr(&base_name, object_dir);
-	strbuf_addstr(&base_name, "/pack/pack");
-	strvec_push(&cmd.args, base_name.buf);
-
 	if (delta_base_offset)
 		strvec_push(&cmd.args, "--delta-base-offset");
 	if (use_delta_islands)
@@ -1487,7 +1482,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	else
 		strvec_push(&cmd.args, "-q");
 
-	strbuf_release(&base_name);
+	strvec_pushf(&cmd.args, "%s/pack/pack", object_dir);
 
 	cmd.git_cmd = 1;
 	cmd.in = cmd.out = -1;
-- 
2.44.0.290.g736be63234b

