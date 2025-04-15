Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A429E074
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757216; cv=none; b=VCwxL+EF/sIoFR4RnvqZoupo1zeQshvd5wbM1jVMi0/x9wONryfbuZeebQYAwY6nVlSkgCVxk2Sgc8672MwEB5bqYNboOn1qmjY3Zw2yOrvdr9XaobyZjPVpeJOngg/iTFP3YD9QNaO32B5uWXHYmfvSyjOVqVV97tyoZYfqCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757216; c=relaxed/simple;
	bh=T8mpXSgtS40tyZKYuB0imSgPNJtgLW/ctjIJ12/z2hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csM7U/Yi1TJeVg1UwLRYlv4YhxD9pFJEBJLTXbbaUwhZUIlzB8vhA3GoHhSEQ29MVRhKzh49hr0wtEnCtO5ysAYR8XPV6oG6b9g2s8+xp81cowc704iqWb0sQkBS9HKi7IG5aF3UO7bgt3QlY97gdwMD/dmQ3bz8qgASyxcT+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WP3JILCV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WP3JILCV"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476f4e9cf92so45600231cf.3
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744757213; x=1745362013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7sdBfHc+Jxpj0a4C/yrCX1kvhBnvRFcGb8oMLDw5kw=;
        b=WP3JILCVie8ekJtTlwhluWNxfU1b2veUXuWTft9+mRTsCu/uwQntGjK0CVc3pkdgPy
         mqi4q/eKYaYnfYydnbQrfYfeeHk97z0wxUYwlEHVIFMTOTb/KnSlMkN/dJ46uWUUs+91
         aNuT7MgaLucbOekE4+msYWDyZeTSAvB8HR6mdY41Fc7mBeVfdVwUeOftN5he+3L6HdXX
         nH8w1z+0WieAenEBh0UK9UyRmgLUTRlX7wdKvPbBunFUqmLQo4umq017yLUplcKqabxo
         FO6nGl+u5V+1nB++LA56bPr2OChQ1F1L9uFsDXuyRsY7Bw/d1Oi5IQUuTXoIiP9m9rIr
         J8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757213; x=1745362013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7sdBfHc+Jxpj0a4C/yrCX1kvhBnvRFcGb8oMLDw5kw=;
        b=MwnV9gpjRlOYghYAZpVhVxyvZhUr8it8Z2HXHjdALfSfPD3V/dMK67kwT7TXGjYu0d
         j9q0dPwt1367VhBIyGcXwsnTml91xGERJBST3A1sR/t2mnYu9VHwyAkQ5hjqjEwL6CzL
         wWvoY8LVfOH0x5w/3FqLUFujjSnflHNiW2+u4/8/sxWpbuVJwIt6qPCSO59qTafeeuHr
         Vsi+R9hf/A/hAUdA2HSEpWGAjJNCtm1Jlt6KrFbVF2kCAuQOI+STFtdEEpIgfNpLcIu6
         9EE3/OgBIUgrhlOXKn1DJgncPNBqDSnj5p65JKoHOgbScuQfBRyqwcfwV9xTZRtM2AQb
         2COA==
X-Gm-Message-State: AOJu0YwA98L3a9Gu8s3Wx8lHkRtCt7a/APqxinJnG9quGqMxlOtk8B3K
	2d7RMQr3MXacgr9A+Suh5azPpjZIKWXNWDZIUxfQ18hNTvVRh9/+oQdfbGg1h06g139cpx9LZo2
	EOpQ=
X-Gm-Gg: ASbGncsd0V2+Uukjan2kQTaXUQh63A7Vzy8e4TaAo2zSZku8GiJiQixkSO/dWd6+QVe
	alnZxAJn/Ef5Lg64pzlWQNvdtn42IpvgjJtZm92r6JPhrO8f1pvp6aGxv9Q0ul6OODbjFauu20f
	hAmjJFuxN/2OtZaN0YqHbeS8n85xKOWvveeh4L4qIAjH/Qietof1DQMbJLlujttj4pqDsbDrMsy
	VYoakp3OeiVxNnbdlB4FU6MdjLD6ej7ziDA6scuLaRkareWjQHo9vS6nn6DesPWPqDk5fUv+xNA
	cieyRNlUTWqBQMqb1a0GuENtI6ExzuurM9X2ii+ljOnFz+FFN2SwSuFg4syzQxpr3iYkay6RNt6
	aDDopacPRKDd9
X-Google-Smtp-Source: AGHT+IFy8dUkhIBXrFLDWm9U4w3qZi4VmMWWRiMBsfb/yL1u69uCOWpD08TmEzcJnfTBVQ/EKK4qUw==
X-Received: by 2002:a05:622a:1495:b0:477:64b0:6a26 with SMTP id d75a77b69052e-47ad3a1ae6fmr15976191cf.22.1744757212922;
        Tue, 15 Apr 2025 15:46:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796eb2cbf1sm98845721cf.38.2025.04.15.15.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:46:52 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:46:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/9] pack-objects: limit scope in
 'add_object_entry_from_pack()'
Message-ID: <986bef29b5f33d32fd366aa9370d439175a9b605.1744757204.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744757204.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744757204.git.me@ttaylorr.com>

In add_object_entry_from_pack() we declare 'revs' (given to us through
the miscellaneous context argument) earlier in the "if (p)" conditional
than is necessary.  Move it down as far as it can go to reduce its
scope.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 20dd870bbf..4ab695a3aa 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3490,14 +3490,14 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;
 
 	if (p) {
-		struct rev_info *revs = _data;
 		struct object_info oi = OBJECT_INFO_INIT;
-
 		oi.typep = &type;
+
 		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
 			die(_("could not get type of object %s in pack %s"),
 			    oid_to_hex(oid), p->pack_name);
 		} else if (type == OBJ_COMMIT) {
+			struct rev_info *revs = _data;
 			/*
 			 * commits in included packs are used as starting points for the
 			 * subsequent revision walk
-- 
2.49.0.230.ga662d77f78

