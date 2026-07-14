Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E43ECBD9
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069344; cv=none; b=Fruyxrr40W/YJXzQyna6HVLTa695tvdcDTwXgABAcHoSAQ4/Sq2iI7P5w+2zLKt7UA5sxP9j6dLF5dpNiZA5ubuF4YoBPVvALzDRkObNT9yrAzYPfOdODNGm/gl/Xgo1SJklyX5QrA+osX2foQDWRtPPv+pgT8IORwZwF19Kw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069344; c=relaxed/simple;
	bh=+Muevasa9jPcYd7V1K/wLI+mK/GrFv6eGna0Joyn92g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ji1YcRrI/qZlzmVKRURPIzrGMggJH8x8zx1FU9h8JqeYxbv6pg7+fjDZ8yOV8gwWOqXeE3jH17RlL22cUOmyEvxjRWTFMX26PRKw3Gha881lcnIwgd7A3+QulxAgJJgUkkIce0505TfEWiWskzp3IXmLSbZjgDennilRRZrndzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLBURRVF; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLBURRVF"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6a36a1b5bb5so597488eaf.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069340; x=1784674140; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sNwElakNprIyz8vd0DZzwqm0QIUBxJKxuV/ofs2Zw+8=;
        b=HLBURRVFWM1TroOUzjZvNjAjq8zDe+OYUVN+v9Gi3uf+PjpKG7/FtW2f91w/ED62I1
         LVnLivzCgFjm3ZTKh6X1/AQe9wB0gP378i/kpoKGUMYUa9U15YYPLwzW2iBruEEINtmu
         e8MJuEsOpXg09ilRi1c/VzSzEDukw2vR7OgQnmObwAdkdUReilC2l+RHogekkFXpxwbT
         mFgDdj6k3VM8kvJXXiZvPIf2JICUEUVkkVMLsaAfvAZHmL3DkwExt0hYallqtv0KrMNh
         SAeXaBH5iGHvT9AO8fmKMqbGvsqsjm73LF+/fXwlF1OiaCoQ+x2L6j2MG/D0zcM8+9Ur
         INdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069340; x=1784674140;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNwElakNprIyz8vd0DZzwqm0QIUBxJKxuV/ofs2Zw+8=;
        b=BTi5eESapHIiE6OrIv8F3qWwMYPnE87VB+z5sIF3ucCq6CRa513purA8msGO87HTYN
         xb3kc3vaKrctGikWbbdseLBLL7SasYCsYKvALAJBSVtmLCoL+BoN6zEAm1jJncqGaQVb
         6zNdWEl2CkV08UgkNGSSVQtJuVn3drVhEwUJHQHDxx7ey8qX8Mb9NrSd4x6MzYcbcH7J
         49AkXdRul+omItsNmbO3IcluQ8OvO5viydMxSU2jLBLvbFe/KKyk/feL0b/vGUdtObfK
         xZwKkjhivLLJlASobI3CblWUMEeCmPbGCFVdL/eqeN+g0Mu3ldccd9lyB8GQgdeSUbwd
         h6sg==
X-Gm-Message-State: AOJu0Yw5D/TtOSEDZiL+PXJxN+R67FNdIOZ5ryxcOEfjvqVvYBXBt3PQ
	jAbAApN00g5iCgYYE8Oi/+8QnD8pHO9HKwbw9dRGJGIFLwrufafHfQjAE8iINQ==
X-Gm-Gg: AfdE7clYH9YhqW0SB/LN4VDoYWGysWfmulpxYANw1Alc2uHxYxEkrbMPILWul2Iuc0i
	ubTqedB8J7B6nuPNdcKynvwMBA80C7vzxmNRN9wOByFslrfaW6VfsIt7pKzpQ1MzQ8NU1Q9eZrH
	mTu74dRD3/Ehkr/ED3b1/WoRgvT0Z27kiqR8DSlpNVI1JHVIt50DWkUwtXr5UebHKO/xHcRJUPU
	9hiDaTIQmGpQmmdNFESxUA4FgnaBjQNY/O0uZMll4Xd1zvdpfzTpdJP+BeFAdQandFkJHDo4zal
	vj2Yl5ExnupnXQ1jX6URPbeqz9RjG5/T85KEvJCH2fjVtfCfYoPH/Pub1Os3LAdgx42Cpib1o+U
	Y0BS9n0y7NbEpICkOmfRi8XbGNSMA52KOx2oDkGkfIsDJuE2TTWow9wPRrMsuUgr8thjC0pFYaa
	JbETdv+HEyhY4jgSbC
X-Received: by 2002:a05:6820:2d42:b0:6a3:8a67:1921 with SMTP id 006d021491bc7-6a39a85eafbmr8491125eaf.70.1784069340410;
        Tue, 14 Jul 2026 15:49:00 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-451b64192adsm15199225fac.18.2026.07.14.15.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:48:59 -0700 (PDT)
Message-Id: <1792042098cd50ba164b90e5ce62430037661343.1784069325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:40 +0000
Subject: [PATCH 07/11] transport-helper: check dup() return in get_exporter
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

get_exporter() duplicates helper->in via dup() and stores the
result in fastexport->out. If dup() fails (fd exhaustion), it
returns -1. The child_process machinery interprets out = -1 as
"create a pipe for stdout", which would silently change the
fast-export process's output wiring: instead of sending data
back through the helper's input fd, it would write to a new pipe
that nobody reads from.

Check the return value and report the error before proceeding.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 transport-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 80f90eb7ba..31883b244e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -487,6 +487,8 @@ static int get_exporter(struct transport *transport,
 	/* we need to duplicate helper->in because we want to use it after
 	 * fastexport is done with it. */
 	fastexport->out = dup(helper->in);
+	if (fastexport->out < 0)
+		return error_errno(_("could not dup helper output fd"));
 	strvec_push(&fastexport->args, "fast-export");
 	strvec_push(&fastexport->args, "--use-done-feature");
 	strvec_push(&fastexport->args, data->signed_tags ?
-- 
gitgitgadget

