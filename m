Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296226;
	b=5WRBns7LIpfIdHHEwK/0QNnS48vBlKytw0U18EVLx7i0Y+lFEFWK75oEB78c/CgHGx1p
	 T+hQkkjZBGx5yFyBsJaPrAqVVEnQgzj4bb4gfHk/CG0bOsOOW5Zt2b5HF3OLnn+J8vqkP
	 38uw11dPZpPhQxcTjNPPpG8+N4+PoSiCWl1ffxZSbOGrRwH7qG4DBhUFq/vc9E4lK61nA
	 LGT1Gl4ghFYpGoBZa9i+GIDZGmzjtLv2R83W1Gcwz2kZK0lwxl+Pn03LWOgKFCnCCuks+
	 gFCeGvZ/tgQmwkBJXbPHFOWOPtYbXE4hvRUV7xIEzj8noYYn7Z7hNBWr26+A40Y0PWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=P993L3pKkA3TOlW1oH6hMlXPi4gc0hyHkMrVyG+TXBo=;
	b=u5/S7Qomd6w4Gq6/5lk19RJZmwiMcLBEk2XPAmiOFBY5X7HQxL6Nz/S/GWwpAaxR9FHY
	 MHoqkPS4vTwTYm/iLwvzaKfDBxNgxZiwetJbcFUOHTzQ+g3UJqUvEiuYuNnNUd2TFWWaI
	 SZt3MvzGDciC2XN133so1fN+2QMwoj9vwVEQ8F4TGsuVBSJEz5GVe40WnmBFDrgdtb62f
	 NPa7ZSryLSsESH/fcAVQF4HljIp5KOCl2TQpKKGi+aIJsN1QVE47tQAUJlufPoFOvNGMz
	 ZPJP2gw2Myv9PHjMI9OcrdItl1T270WSS678ejVD8hAYKDnGHtuCQzE5jLSrCNPHjTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d3ALWO1J;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D151606A33E
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D151606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d3ALWO1J
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6df5e315bd1so1282247eaf.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296225; x=1794901025; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P993L3pKkA3TOlW1oH6hMlXPi4gc0hyHkMrVyG+TXBo=;
        b=d3ALWO1J7cV5nmdOj8g5izgawuezILc+pqVu/FYjMTRDMhceTqdmlQtAEgm6cnG3yF
         E93qf6JCnZ4Isi1JvFaOIy48V+13KXhpRbrXWrpGkhroX+qgB1VexLAoMupTG4iOfJ7h
         p/vBlKsucMn+wEW4VsMuGnpkNopnBPjee2QX2BBZlWfDQXiTjZISKDVwwLJew9nrAUSM
         olWWvidzpyKh/7K6S7rL7Za4ENWq9RV1H0IIv0h/d9sytEBp/aeZdsapd5NdPZmOeqtL
         NqLaqCd8WfkL0AVav4fp+1bAEcqNGHncYaSeb1Y8n6jgdjmB3SLzqtJwPNCkNEvr8N9I
         G3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296225; x=1794901025;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P993L3pKkA3TOlW1oH6hMlXPi4gc0hyHkMrVyG+TXBo=;
        b=QNxEmtIDBV8CdCZGIrvsMCaNQ6y5fuhG/LJLGgUkeInPNbav9P9mNX7if0u0kQr3nN
         bwOTMytfK71OK6oYozayxin+I+T+en+XFr2EFSDHEAst4i1eaG7LG272jgtuqlQL90Cm
         TZQ0r0utU1EJa8/YENQrSla+UkGOm6mylB11gTxIhbmDwMe34j/c3YArOF/9Ekvxp5x5
         2+dfQKEo7lmeOq9LjTw6ijHxNgy19VhmztumRN1BfFoXFpM0jZjO2RFOp3FFQBTwNmzO
         2MVzhd4zyL4dpcBu+aDp3apqCv/Lrvd+UuxttPD70K2ywsIkPwzub3FbMPojAtn6ITvV
         T9YA==
X-Gm-Message-State: APuU4Z8ccbBd8ncL+ACW76WdnoprCmRMzOMi/voLJe6ZFL4JYW9uN9vs
	z0/80UXmmOkCKJfAnhvgVPOO4mX2Y07R46BA87hlwN1iT7Bvk1e8cppZF25WRBK+
X-Gm-Gg: AYBFou2FotSXMOPrPWZ2IrNVdV2Td04RFZNI8OcgiHcVJlZEZJ+XDh3Ruou3rFGz3uZ
	dEADzFQ/qKfc7yjYBJ7u5UPFFU+uCIF4sy7KduXJpjFJqYLb5TWDZywxDncyCXTekfQ3rh8rLcX
	Tz5SvALAuxAsFB26QWdTjM/HTExa74Ixj8YOwtvppihc+nq4OIbknKVH6918kkpIwEcXpYL9f1g
	UGYqvyWQSvmwhpCdox0cjiry9QburyRJnFh+w7Uy1SoAj3JywQDkN7MxiC8DOYvg5yTc1LFmcqw
	sOzoS3C4M5W7Zbh4tAXXvaPcgUV+wYuD3AlJmBk2p2k1nYJRa+did0xC3EZl2Pg9D0+IXlcxxmO
	XwuwADzGbQO73oqP+cJHga+bJ5dR6ALsWcSkCMM+um1Kx1HqY9ZZu8bLFi2aY33Y+YBxbw++JHt
	dxR4vJ2gF1zoqUSxrJ80J7j91ztfutPL8REDyul8HKLL/ZqIkHDLjgjBzugZGMldi464I1ABhSb
	PCaX5s+TV1Y8NQxTI3fOdctf+k+bu0LxwOyIWcZNvBJfIM3rJFBGeoYvUxRAxDeX933ozMT/jr7
	tDlEF5sPGdc/6Deb1sDpRLH9BzGamp+V/FI=
X-Received: by 2002:a05:6820:f016:b0:715:2424:db12 with SMTP id 006d021491bc7-718a683fd87mr812797eaf.50.1794296224773;
        Mon, 09 Nov 2026 23:37:04 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22f6b225sm997085fac.3.2026.11.09.23.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:37:03 -0800 (PST)
Message-Id: <d4b49d1363b8ba7f67c19f827d023915165d60a9.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:36 +0000
Subject: [PATCH v2 06/15] remote: handle NULL value for remote.<name>.tagOpt
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A remote.<name>.tagOpt without a value makes "git fetch",
"git remote" and "git status" segfault: handle_config() passes the
NULL value to strcmp().

Reject a missing value with config_error_nonbool(), as handle_config()
already does for remote.<name>.url and remote.<name>.pushurl.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 remote.c          | 2 ++
 t/t5505-remote.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/remote.c b/remote.c
index 49ee2ea318..0db29d6dda 100644
--- a/remote.c
+++ b/remote.c
@@ -556,6 +556,8 @@ static int handle_config(const char *key, const char *value,
 		else
 			error(_("more than one uploadpack given, using the first"));
 	} else if (!strcmp(subkey, "tagopt")) {
+		if (!value)
+			return config_error_nonbool(key);
 		if (!strcmp(value, "--no-tags"))
 			remote->fetch_tags = -1;
 		else if (!strcmp(value, "--tags"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5fbfcb0848..bec2e51afa 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -90,6 +90,11 @@ test_expect_success 'remote information for the origin' '
 	)
 '
 
+test_expect_success 'tagOpt needs a value' '
+	test_must_fail git -C test -c remote.origin.tagOpt remote 2>err &&
+	test_grep "missing value for .remote.origin.tagopt." err
+'
+
 test_expect_success 'add another remote' '
 	(
 		cd test &&
-- 
gitgitgadget

