Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0481E3AFD02
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521826; cv=none; b=FGOJRufSlexhqgftJgOYIjDy8e0t53zrmWRO1kdc6SgVeKEV4BxvRwNbVPiUcidFUA8N3G50SiKt4K74Ku0OScbF44qsCpFDe5r92VkjFpSySoeMV2Mib+i9EASf8RG7SgVF1W8//9Tli4xfY63pcJAaq6rkL4/nx+ZAHAskyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521826; c=relaxed/simple;
	bh=3xmFoFxSEuQnafaj3zEgUJo20mJcKUzb52SVfeT6Z5s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H/xafvOuuyOvbea437I5Bt9U8iZzk0qg+trs60q9djVH2nwcUpAH8b3wIqIVHW29hcnBP3WLljQ0lYk7VFJeHGG+upj5dXVMFReeZQfOWE8bl9mnCfFRbHPUsQtWK2TN1QWTe57JDGvUh8RjfGCn5zGN9kQsYU37+iWDIiXnXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKc+edo+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKc+edo+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so691487a91.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521824; x=1787126624; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OZ2XyPS4XdKkEnvZFJJ7lNUmYR3BDgYmSWS+zi1tbqA=;
        b=nKc+edo+cPys83P/vUOpeUC8kEfVoKXZ7IP42C6NC8yFiVzQlvaeOtFWalJgGy6vek
         C3uPgWhcizT0FqLxnzFyvUmGLrTwZ33G21acAgpcjLMlkS4ctiZcFjkfwZylKsPCHfdB
         rSQ0DNIcl2uECIuirwOUZn6/qhyeP3yMt4yyVwoalN5OmqZDLc7D77DqNoJVgHtP7sHW
         Sg7ABRUhfeanVIK1/pZouzOBZsJHQ098fC3GE7fir1m0kaHoM2bduuBeMYibCBMvQmDv
         nnKSCzDAEhlWjMB8waOejmLX9e89PwvWmK2dJzcaMj3NOosrmexo4lH4qa1bchRLdLKJ
         r4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521824; x=1787126624;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZ2XyPS4XdKkEnvZFJJ7lNUmYR3BDgYmSWS+zi1tbqA=;
        b=XMEToAxpng5Q0U3xOZ9NYUsnQxEfnJKW85x4WXoB1Df8HJwM14fQFFUI/0J6u5d677
         RH+mvDT5YO3gBgk5rpQc5KTCDd8vxS0BbG+wrta85sjLxdwt9gVIl2yhbzlfeRW4dgU3
         o220LJhBnQse2w0n0ql8rQdEPTtahlyLGCRjqrRd9QVJMOBJJHh3CgMeF8YZ14ojrRTo
         iASsMqfoO7Xl38g9up8RvmuBDuVCkad6PwEnLq8mR9t4d0TI4dNGPRwuFlWPUmyPLgiN
         WXINUTcn8zkw371gCZo1Em891bwnKH8b+aV2ZzNhYFVnNlKJEPkC1yfew9et+D/eYa58
         wyfQ==
X-Gm-Message-State: AOJu0YzMCbo9KAw0GrmP5TI7dEHZFwpkU5h3kFkocCmMW2XPA7hLnxaD
	gSn1+UGzqttsvJm/OGFFFwTBMVIhenkvn9YNnbCqGCAevkwNTOJtq85fhr2Fk4+9
X-Gm-Gg: AR+sD101Hy8D563RgoyP+ZdSbWrgYSDZKCSBbwyNwui9qKqd//zw8wWTMQ2mpF7TK1s
	/aNJhyy8BfL2Og1FAKh29nCgITIfSLZdqw+XhSNi0Z2e24mUVUmitLOzS8L09VE3SMZqozhsiqV
	Um+ws0oYHOsNShzlh2QQvFQIK1cIAG7UNlWzYlqNQw+HjyEyjI47rPDJn9fhp25kPXocA8mMkUH
	hLdEDqEpuHKz4iGvTJtL9xwIiC9KhdkGI9U02DKB0JzodcBb0kZHY81FDneT66G//o10ZmTrKZh
	Mg7h7wg36oeEdFH7/8DVxDhqNVvZejryVZShzq94oguhiZX+xQ781wUt/+iTwjhPFVUIPhHeLEA
	5krq5zLsd/JokGqX7ZABRKkW2IYY8InTcO63rgh9iBaFYZejUkoe7kjTzRuOetNSjCdKJg+DOYR
	FykaVOV7hCIXiUYFsMbcUXA8AR/mtTv53EJnt2y9+U8ctoYXYKTSOGlATnXZ0gJ1OJxBO7O3RL
X-Received: by 2002:a17:90b:1f83:b0:38e:59c2:cbc5 with SMTP id 98e67ed59e1d1-39301678a03mr3430691a91.18.1786521824055;
        Wed, 12 Aug 2026 01:03:44 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94d5cb7sm2553092a91.15.2026.08.12.01.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:43 -0700 (PDT)
Message-Id: <7db6ac2ab0d346da992b812c8588d90b16aebb49.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:18 +0000
Subject: [PATCH v3 10/12] bisect: check strbuf_getline_lf return when reading
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bisect.c         |  6 ++++--
 builtin/bisect.c | 11 +++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

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
index 798e28f501..69ab7ea248 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -498,9 +498,16 @@ static int get_terms(struct bisect_terms *terms)
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
+		FREE_AND_NULL(terms->term_bad);
+		goto finish;
+	}
 	terms->term_good = strbuf_detach(&str, NULL);
 
 finish:
-- 
gitgitgadget

