Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9533438BD
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069348; cv=none; b=TTuvXrRDRsa0/GYtTR81RJSHJdzO6gRMtdZgEICNLUddSLdQAh794YOTKusYNCjKgA4OGeGEscs7VT3JOfPSsnH0Of0kUx4ZpxsBeaYqZT0e4dkB5F1vX1OIhVCT/L8mXzS92r5OMTqXPS2Ue6S2uvyUmSbVoqYJWR1gorhSBBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069348; c=relaxed/simple;
	bh=c4IB+LZf3QBJImq/iXUzwaX/gWOpmObp477H2yfiH70=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lF7/IbC+H6mG3X0ZQSIeXP+5sz2bAger+NpL3RBIkBvMyXEhz0Tfwryy4q0hSUz3mZ3sKi+POzthGhufBoc7j40Ez1PmtMDslN6Hn4LEc4TWFzfAEGwiCIQrhOaG6pxnJz0kK//OL2MqwAYtFkSK46G1A6C01WW8im4FStfljG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXAH1MIJ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXAH1MIJ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb5a9f02e8so2407613a34.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069346; x=1784674146; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ppXkLrKr9dD1BWqTgFHJgqIvZf064lOrFX8UpXcr8E=;
        b=oXAH1MIJlmWF8+IJq+VJdhQaiy9A0Vj9kvbYMguqkcp25nex3C55sgRR0lvTam8yfJ
         GnZ7J+p3mf0hirdNU/Bx3XIadDYVFZOdbfxHS6svpXGPATFD5Fz21Y05P1KozI2tMeoI
         VeClRC4rs+jyLnDn8jOgG2XorT44Cbsp/JCk0JPbQVF76ul+hTudr6Sbj4o2DekzGKdB
         gwNIhYpV4PVaf+gHjlJ8EpycBiDRU6DP8Ku9sGWTltk33bPwnE7+wTZIAdI3GPyt816f
         HpkrDd3EI9RO/QEm0IL21wcwsxRRYEEEZPa5i4KDKK9WjE6qfDDQRoroLNRmNz+QO2N3
         TU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069346; x=1784674146;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ppXkLrKr9dD1BWqTgFHJgqIvZf064lOrFX8UpXcr8E=;
        b=kRoNHrza/cQGzoGwrCrykswZxkQHB1KlfcEPbkxyDzOMecXsxBl1NhZaSZZxPGafL/
         OdDVe3ZmDocVpq31ab1yu6Q8Sttn6J3XNfc508cur3uKRY4t8dQRXZ5ue6QFzjyCeIyJ
         Xt9B15XGYtOoa1//Br/Rt40qcmFNpmYDUHW/prJkjToHWIDQEmZFADp5IF88IA/jPBoB
         3N1wKN9YpDrQKwDqzAqwDotqxS9XIfp4BXr8fXRgO4UESu3hLKBGG3CBhoad36IAhwjI
         oFsB/ubopSuhMBNst2MUCrZeGTpg9SS+9mXvHjGnclxq6DuMbynsR2ygx5Iy6qwkIvZZ
         w8Sg==
X-Gm-Message-State: AOJu0Yw+URnekQFn1Mc9uHcMojgQDygyV5t7pDVnd5fJgsz4YpvReZor
	FCl1orxvzHLq0f8JptaIWkTGwwqs+0sgKdpdJynr2/i7gGJMYzX1zQaXRtzQCw==
X-Gm-Gg: AfdE7clXMLfSLhKpRgSOT8K/bkhCXZ5HI9kJpl64LNzALnWtDJOLQ9pThj5gFhOe7iM
	/oIXGgcmWSLfdA90qtKK6Pb0+VArOa2eQnKIUryuLNlFJpKb6biVVx00zQ2dV1o7l3YR8fGcZ2y
	h3QpvExnzyC2nOUdzWgtwjy1oByZVVZdZjaUc2CnwpUHP7C62UuLVbtgL8ZAfLMbA7k1BpS9zq2
	Rv3RlaUBC2qibA7nqL8b+vLYurjbRL3OcOPE+bEs8+7CBejWT2HHRDHbRW0xijBN8IJyZQvJXMT
	vBTddNJe0ziOyPsmSD64Sxl0BGKuQpLw1ApnGoJYMGIqe1WVF/Qqm6Jl01RU+8eXcpejhBVQz/q
	kn/BKF5+to3hLq5hyQnZSxwwKkvSSLp7IFuN5/JVJ2Swb1f2M7yJ5Hj5yVPDsIIvp4rt21FkdoT
	kYH/MXZkRNvg0QbdoE
X-Received: by 2002:a05:6830:3c04:b0:7e9:f0e6:fd55 with SMTP id 46e09a7af769-7ec59de481emr352846a34.30.1784069345878;
        Tue, 14 Jul 2026 15:49:05 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf73c87sm16472321a34.7.2026.07.14.15.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:49:04 -0700 (PDT)
Message-Id: <17c382fdf46eada79ce03a7604dd7e0454d8bea4.1784069325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:42 +0000
Subject: [PATCH 09/11] bisect: check strbuf_getline_lf return when reading
 terms
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

get_terms() in builtin/bisect.c and read_bisect_terms() in
bisect.c both read the BISECT_TERMS file but do not check the
strbuf_getline_lf() return values. If the file is truncated
(e.g., a partial write from a crash or disk-full condition),
strbuf_getline_lf returns EOF and the strbuf remains empty.
strbuf_detach then returns an empty string, and the term names
silently become "" instead of the expected "bad"/"good" or
custom terms.

In get_terms(), check for EOF and return -1 on truncation,
matching the existing -1 return for a missing file.

In read_bisect_terms(), die with a descriptive message when a
line cannot be read, consistent with the die_errno for a
non-ENOENT open failure in the same function. Unlike get_terms(),
read_bisect_terms() returns void and uses die() for all error
paths, so the die is the appropriate error handling here.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bisect.c         |  6 ++++--
 builtin/bisect.c | 10 ++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 94c7028d2a..c2ef5da462 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1019,10 +1019,12 @@ void read_bisect_terms(char **read_bad, char **read_good)
 			die_errno(_("could not read file '%s'"), filename);
 		}
 	} else {
-		strbuf_getline_lf(&str, fp);
+		if (strbuf_getline_lf(&str, fp) == EOF)
+			die(_("could not read bad term from file '%s'"), filename);
 		free(*read_bad);
 		*read_bad = strbuf_detach(&str, NULL);
-		strbuf_getline_lf(&str, fp);
+		if (strbuf_getline_lf(&str, fp) == EOF)
+			die(_("could not read good term from file '%s'"), filename);
 		free(*read_good);
 		*read_good = strbuf_detach(&str, NULL);
 	}
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 798e28f501..fe66d84382 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -498,9 +498,15 @@ static int get_terms(struct bisect_terms *terms)
 	}
 
 	free_terms(terms);
-	strbuf_getline_lf(&str, fp);
+	if (strbuf_getline_lf(&str, fp) == EOF) {
+		res = -1;
+		goto finish;
+	}
 	terms->term_bad = strbuf_detach(&str, NULL);
-	strbuf_getline_lf(&str, fp);
+	if (strbuf_getline_lf(&str, fp) == EOF) {
+		res = -1;
+		goto finish;
+	}
 	terms->term_good = strbuf_detach(&str, NULL);
 
 finish:
-- 
gitgitgadget

