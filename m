Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D54480342
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830448; cv=none; b=HnKs6NZwCYm1v+kMGfoD/36U24tNdwD5/bXAL3JoYr/CuaUhW8rX9xhRk3ErhrqYu11AOZ7NRZaVv8Jvp0f+Q0BOEvpl8piaVmnXyl8Nw9AEGn2Wht+OJLBlsSaPTCZHkhGuoGlXSx3krBsQ29cEMP5l+JNS+FMkUAG6P87H64Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830448; c=relaxed/simple;
	bh=SimSezPDUX3sWC+meBWBAnslS8/egIYa67DAQbmHWxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDbuxPp9iR/6b1d/Ve78Qw3HCh61iUmjXQgH46a8PSa9s2q0eTImSuXGl+Wd4xlQMdzroo/NMGKEvrrmA0oz6HancRFJofEkQnDSG8dtB5uubrgw82ll9pQc+z+h1/3Z2lL3sbJbfK8lMoJTswqsLlYIWmSZSYTf++5tALg8KtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrSyNH1S; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrSyNH1S"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-415b23dd6e5so1803127fac.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772830445; x=1773435245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imne22hxy8MEPoK1faX4yqNl5eOW77+XOAOfx/LPR1c=;
        b=nrSyNH1Sl1Bi/ICBQNBXtTIkCGO6Qxq3FfpY/22ai9yi1VjWc1zm8Vw1PLU+nRX3rb
         bxabOYYR9CAtZI3L/n8UKNz36n8fY74gh7gHbKDzNvx5RI87SFEyS9PMLEpTi/JLM5S/
         H0W/LfpQRCDlNvS5KveFAFjfdgI7kTWanlIbyjm4ww0W/ml6b+4FFmWgXoCL3ZSNNopK
         2UAqbPCL0wZEccDHaRmiroTkyGqpkAr/JQb1y/xkt7LuwBQqBVnX59DuHsFukSgT4/2/
         NrMOxj6Aq3rA13dBF2u5Bi7eU9AkUTABa+p2AL2vGUS6fjKYULqyW7kpZvAKymLDCvBc
         +ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772830446; x=1773435246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imne22hxy8MEPoK1faX4yqNl5eOW77+XOAOfx/LPR1c=;
        b=QWsU0GR/K3Ea84O2UxDDqBQu5beXsqJ3MoEv6auZNn5XOhvtMxV9abHkgi+Khy4W6f
         w9lt50xQ8uisLwxMHhpuN/2c5J61izMU2QJgjAv7H15sX3trUkEYQi/Isp5p5JREtBQG
         ZGoOjxSINC0WfTqOEOzvqrbfblTGuCpMeMC8/5iAc17qhu66zQHfV92wS5pDDuvP3YQB
         X1Df0pyssDiIrs55btZ0uB3ZXk8zvFarhbEYjEdGHIZLxUQsUn1XAwA190CMgkQkRC5z
         /smJ0vzdThoswToXWbNUwXMaEHIxhyNfd1KzjjdKcqA/66ZeSlUO/cqp+cxh5UZ1en67
         mQHA==
X-Gm-Message-State: AOJu0YwUIBjXzgrnJV+F2TUmoTHeWeCU0+yCx6opScotR+jVxpfOxGt8
	pjTs7/62waxP+iXi4lhZSeS8EYXz+iDkos9pbbgleGDACGoIPpNqnQvRCcB+Xg==
X-Gm-Gg: ATEYQzyLa2zCUsbkOv63kXant3F3Bn4zc9bgjgrBzBRiHL0Ogwq45/Zdo5F6FTWWvy/
	fh78qc+1uBX9qj4DTFq4h6fVIj2R1hPraFXdB6ik048CyXxJsySVRGx6vBADx/CFKG51L02J3+z
	WlCP5nBFGGDr8rI+UmgnB3rkd2luyadM5H2X/F/8bXO4ZbN44saqaslXQ5jhaRVoVGwraVc38ls
	zhpY0kc1ApIB/yRjzL1bP9yuKdJv0I7sX9MCycUvdVHRnQl8nKN0tYUscC8msctXIyw1v/rRhqj
	dcwOycBfLI29jEIegkaihfIXZ3VEE7vxsxtGxacgs0uPKwwLuKUJ66ynKKt4QAfP7OaGKRtk/GH
	nlBksbkAhkxAKwT3U4aAKjnFqNljXHUBXirHmcI+Q+kqnl7yL5z7/XRA6RWsiMAbntyX4v59PNC
	CWV0C0mOMUPoSw9xaGzY0aSfXDdtoP/xw=
X-Received: by 2002:a05:6870:718d:b0:36d:287c:694f with SMTP id 586e51a60fabf-416e448ac1dmr2119544fac.30.1772830445630;
        Fri, 06 Mar 2026 12:54:05 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e688d5cdsm2278014fac.20.2026.03.06.12.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:54:05 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gister@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/3] commit: remove unused forward declaration
Date: Fri,  6 Mar 2026 14:53:57 -0600
Message-ID: <20260306205359.1723254-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260306205359.1723254-1-jltobler@gmail.com>
References: <20260223194146.3476768-1-jltobler@gmail.com>
 <20260306205359.1723254-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 6206089cbd (commit: write commits for both hashes, 2023-10-01),
`sign_with_header()` was removed, but its forward declaration in
"commit.h" was left. Remove the unused declaration.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 commit.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/commit.h b/commit.h
index 1635de418b..f0c38cb444 100644
--- a/commit.h
+++ b/commit.h
@@ -390,8 +390,6 @@ LAST_ARG_MUST_BE_NULL
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    int *invoked_hook, const char *name, ...);
 
-/* Sign a commit or tag buffer, storing the result in a header. */
-int sign_with_header(struct strbuf *buf, const char *keyid);
 /* Parse the signature out of a header. */
 int parse_buffer_signed_by_header(const char *buffer,
 				  unsigned long size,
-- 
2.53.0.381.g628a66ccf6

