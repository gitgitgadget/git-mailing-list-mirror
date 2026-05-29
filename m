Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF93AFD01
	for <git@vger.kernel.org>; Fri, 29 May 2026 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087707; cv=none; b=J9Mz3caxrwiszbCdFpoA49xQ8lQbxnC1Lzu3s23chPAHY820Lfk3moka7wrnh3OhnqzHsaWsBD1OIuO/jcK6yskFTEM3yUlnCv3LZesGm2OszjrBf7IISpczp++g0XamMo4xO0NMpKa+lomhWVXeFQmhQCqQ/5J2+gvvBQg3np8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087707; c=relaxed/simple;
	bh=2baiNy+Jjq6Yilhn5lnAsr4QlbWAYZt+CUZsglcF7Nw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qoio2ueuZFTGsr6GGw3dYYM/SdBSTN4YcHWGB3aAfB6fn0T17yQGJgKcEPv6Jb1/syW8ytJnE2BsgeqJQ21zTI5sm1zza8dGbcMPGnjVG4109oRVieUQepeYBkQlM3YuCLMTDJ5pD6ADoQVPZG7aGHTTr2+He/K9ljL8ldYQZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBqqeP/8; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBqqeP/8"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-137d452574cso625064c88.0
        for <git@vger.kernel.org>; Fri, 29 May 2026 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780087706; x=1780692506; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxrcAsI4YagiLEdW0veW1on3/8xXAXYBty3PggY9xsw=;
        b=mBqqeP/8RTIlUGB4I0n2PuxCBNnQZPwH+h6ufKHGcpQll1iFBvXF2XbBjwDbUIUQgT
         PYLI00HRZmgE27SkVTH46kVSQHk3VCZ3/MaJWyRum7G4txsqclDjOpAXtcHmsGv5hUD2
         raOPCDbmzQlTYaeRHG5cOKUtAyiG/tZoqisFIIctE0sUeZtrvRSQKeV0qQ+uAihZDPhK
         yTcLM5dEco7MY/0XcGtQ1bQO/qFzwKBFpepjBpZiCz9SGQVrxv4OdHaHs5zbc5Wv/1m2
         TgOSv5Qm5jnajlnqfwKtP8GFl5wj1GGcudVYMsnCLjuSSN+w1AUnF3C2e83lZFNZAsfA
         ZHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087706; x=1780692506;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vxrcAsI4YagiLEdW0veW1on3/8xXAXYBty3PggY9xsw=;
        b=rlyO1jMgfjdjkc3eJSueGFBPXPdXJM8Pw0u0d1zJCu7dQ2FgfHERIZP13PT7vJBD0Q
         yYx+shX+EcBOKi2tUEmdfdhyuDfDJOR9L6op7zCIr3WC0UPwNKgT7esnALUnfkE0GC6P
         6iP8lzoLFT50jDlcuJF2XfJOMF4eoORB26v5K3FNu96rDF368N3y+Jw2B39jF7O3Z9IU
         dtSBw4go6QGZpVn6e+6zwYmSbeqLVGTfE4wQSvTXyZhljin0aiY2opacKQMy6qQu+Okg
         WjUfRWLe0ofm7/VQ8t6TsnPDyjTGU541e7MaVusao/P4cbd0XuSk4PxmaS4ODXAtB6jB
         tDpw==
X-Gm-Message-State: AOJu0YypxisvL3vxaFfsU+lMSoHMceqU5/I0IV4t0PeooNft4rhGuiFQ
	rKEYS7EOP6s30rhDElfA9qsvg6sfj8RxNNE1a7P/294nFb6BWsN+1P5nnBwZpw==
X-Gm-Gg: Acq92OGx88P37rE3uhH5R1J7Gu5GeQKbzYJ/FD5DHcwW8aqmCktL/K2EHPdeERbw0z3
	d/VXWfmELejlwLt6JiEuSuRmwh3PVqYL4+2yFQjHI3TbmaoQHC7SX5NAutdlBWRVi1TUiJQOMTH
	MVyW2EfhGBLC1raGxFD8GrNltcmtXVnTFI+hTDqVkH4In+OdXYAY9CJI551BepeP1Nsj/PyWHHf
	ajIgkNhP2VqfoLN0GK7Ly+IeCbEOFi0BxtmjYsVdiH878bBP5l5fqBGxBNjYmbY6zVqVPgDHf1u
	9EcWUGjUTIr13Fyo4rOFMWzM7PpgEMl1jdxnAXBfh5qbiilq3ZQPQmnO8LQsyPh0coseNvskfjl
	WnUt4WK0+sFSgFzZL+f/W3KfmQ948U5CIeTi12U4eH+44OMEBDVehDCyIPBPpcAR9vwiCVAoGrV
	eckAFVw9Jj+ClFCXlpUiknyPT3O3bhgsuruAuwva8sSDqSgG9U
X-Received: by 2002:a05:7301:fa06:b0:304:bc25:3cfd with SMTP id 5a478bee46e88-304fa7440a6mr776303eec.31.1780087705632;
        Fri, 29 May 2026 13:48:25 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.227.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2bdda4sm2170892eec.2.2026.05.29.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:48:25 -0700 (PDT)
Message-Id: <58f4763c63cc4175ba84849842dee387a0f9d14c.1780087700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 20:48:15 +0000
Subject: [PATCH v3 2/6] userdiff: add diff.<driver>.process config
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Add the process field to struct userdiff_driver and teach the
config parser to populate it from diff.<driver>.process.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 userdiff.c | 7 +++++++
 userdiff.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index fe710a68bf..81c0bebcce 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -499,6 +499,13 @@ int userdiff_config(const char *k, const char *v)
 		drv->algorithm = drv->algorithm_owned;
 		return ret;
 	}
+	if (!strcmp(type, "process")) {
+		int ret;
+		FREE_AND_NULL(drv->process_owned);
+		ret = git_config_string(&drv->process_owned, k, v);
+		drv->process = drv->process_owned;
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index 827361b0bc..51c26e0d41 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -31,6 +31,8 @@ struct userdiff_driver {
 	char *textconv_owned;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
+	const char *process;
+	char *process_owned;
 };
 enum userdiff_driver_type {
 	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
-- 
gitgitgadget

