Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0341474A2
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734481015; cv=none; b=WuUZ0S2vj+eUsv39bDn8FEobuAUUn1kW85t4m7OAWgu6TTq0hPLeZP3HmAj7WAsqtyUqoS5YsVfi3K8llRwYBwIP3PsUKfrHqrgcPsH2xe+tY9UisaRrINFSBdDAz9sfsICRDdQI9vlhherRh4t8AScwjGCtjjMa7e3IUnRJ/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734481015; c=relaxed/simple;
	bh=U3QdKnHeQ12EJUMbqnEOlKsqDLcmh8CPNDSonbC/r3g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sD/h8B7vs6NxdlBkiBF9Hf7V+G9mpmQOgfbZZSezWatqU3dreDOP/NmjB5ib94PDQ95G1HBgLinY7mRXHSMZDMY55zqkpxs5T/Hn/DyXOKFKyXuxLkiBvrpfXXZUd3Tz+VyB/yFHTQ+8/0xcNFhjtINxuD1pjTd8ngHV1ZipRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXUP7y+d; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXUP7y+d"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385eed29d17so3000776f8f.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734481011; x=1735085811; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tA5WXywanuPL9MXFM0Lu/Vemi3S/KKcIehh3+6hpa8=;
        b=EXUP7y+dcu6Ve4fa49+bxsB8Q+Qdslxb7X4WL9giCd8tLtsJe5aRJ/Ton6eaqXvK3W
         kuwHTsPo1nhFFiPFsvYDUmD+n4USFm4v+lR8RW9ECeJhM3VC5IlZxQPSvHyDldPjId/+
         jhJVA1+ukox2zvtxw77MgRkDSQHrhZDCs6WVMjpSzpTo/nWIw/06WRsI7qDD1K/QTDqo
         Wfisv860PjsGP38Yfb8CYL9OS9nfxjX0kLZX4LJxXElGMlNar0GTaYM7O6jjVdLGgVGg
         Ia8vT9OX339qKWl43wxjYnVpPppg/hHT9GMySk/D+qkfoQHz/qOgdXVFhpHyB4QMUbrN
         EOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734481011; x=1735085811;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tA5WXywanuPL9MXFM0Lu/Vemi3S/KKcIehh3+6hpa8=;
        b=g5GEF6BXPgtsuIdBA0iQ4nvysFhvZQP7tNZT2ab+H6BtLx4igimXJwJDvHcEClr+fj
         xn0NnHDIF0jvo/U92FW2mltDn1kp5b5krjd1cDv59nog1x1fK8i0ITvklWyq0vmcN/7r
         GY/wOno3OtKFT+1P3ScjpnKk7OKdgg5RC3SIpAQRLxIK41lOmaSai+bClo+5G3TxB1+x
         PWLfDh+nB810JX/4vytacOJez4hrOOVJlGvLv1cctCX5PUwJ4na4l1UPvBH/qoXpJO0A
         Fx/EEVyDu9ns6s5v6CyJnQ8/qmoTr6fJ5tqdvex7fbHuEcYtK1N/WEMb8yB3Gohte+xf
         QEFg==
X-Gm-Message-State: AOJu0Ywl5Xl2loOxNtBK8C6eQTe8xC/I1xTCoCf08kVam2Ne650UCazw
	PGFiUbttkS4jalZ3tNUH/AwzYZ9x1CTiofsSDL05UrSkooF7BQzMeHGf0w==
X-Gm-Gg: ASbGncvmHZjEi2b9surtZY1v9Kk/yyfscgZRQDGWev1L6MuOkin7JNSNlfNWBRYTLuw
	GD6+rW0CIFLGQPBMAVpUETnmjuu4w3elzl0EjW01B9IXPkh6GfVUg3VZ6VrEjb4fWPOQa7YP0nM
	GoG8i/1s9bUbIUs3QmKc/Sw2Upxtzqd+zYD9XHnyoeIzzlsBD4NcTFixg/KFoiAmU8w36z9E6Sp
	WRVjjhxteGOySfoV3h7pmBXRdm7K5anRPh41VhD+X7LGodkOXflza2Stg==
X-Google-Smtp-Source: AGHT+IEquEtD8546G7FTV7yCrgkfXg2IHq4op1uk4emP5v3k2+oS2kXqNH5JmQ0iB786juFW4/AOmg==
X-Received: by 2002:a05:6000:186d:b0:386:3cfa:62ad with SMTP id ffacd0b85a97d-388e4d4b417mr564750f8f.1.1734481010841;
        Tue, 17 Dec 2024 16:16:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8016678sm12441213f8f.27.2024.12.17.16.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:16:50 -0800 (PST)
Message-Id: <pull.1620.v2.git.git.1734481009264.gitgitgadget@gmail.com>
In-Reply-To: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:16:49 +0000
Subject: [PATCH v2] Use ^=1 to toggle between 0 and 1
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
Cc: Dragan Simic <dsimic@manjaro.org>,
    Jeff King <peff@peff.net>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

If it is known that an int is either 1 or 0,
doing an exclusive or to switch instead of a
modulus makes more sense and is more efficient.

Signed-off-by: Seija <doremylover123@gmail.com>
---
    Use ^=1 to toggle between 0 and 1
    
    If it is known that an int is either 1 or 0, doing an exclusive or to
    switch instead of a modulus makes more sense and is more efficient.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1620%2FAreaZR%2Fbuffer-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1620/AreaZR/buffer-v2
Pull-Request: https://github.com/git/git/pull/1620

Range-diff vs v1:

 1:  1bdc62e1b19 ! 1:  5819a51526b Use ^=1 to toggle between 0 and 1
     @@ Commit message
          doing an exclusive or to switch instead of a
          modulus makes more sense and is more efficient.
      
     -    Signed-off-by: Seija Kijin doremylover123@gmail.com
     -
     - ## builtin/fast-export.c ##
     -@@ builtin/fast-export.c: static void anonymize_ident_line(const char **beg, const char **end)
     - 	struct ident_split split;
     - 	const char *end_of_header;
     - 
     --	out = &buffers[which_buffer++];
     --	which_buffer %= ARRAY_SIZE(buffers);
     -+	out = &buffers[which_buffer];
     -+	which_buffer ^= 1;
     - 	strbuf_reset(out);
     - 
     - 	/* skip "committer", "author", "tagger", etc */
     +    Signed-off-by: Seija <doremylover123@gmail.com>
      
       ## diff.c ##
      @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
       				flipped_block = 0;
       
      
     - ## ident.c ##
     -@@ ident.c: const char *fmt_ident(const char *name, const char *email,
     - 	int want_name = !(flag & IDENT_NO_NAME);
     - 
     - 	struct strbuf *ident = &ident_pool[index];
     --	index = (index + 1) % ARRAY_SIZE(ident_pool);
     -+	index ^= 1;
     - 
     - 	if (!email) {
     - 		if (whose_ident == WANT_AUTHOR_IDENT && git_author_email.len)
     -
       ## t/helper/test-path-utils.c ##
      @@ t/helper/test-path-utils.c: static int check_dotfile(const char *x, const char **argv,
       	int res = 0, expect = 1;


 diff.c                     | 2 +-
 t/helper/test-path-utils.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 266ddf18e73..5c2ac8d6fd1 100644
--- a/diff.c
+++ b/diff.c
@@ -1231,7 +1231,7 @@ static void mark_color_as_moved(struct diff_options *o,
 							    &pmb_nr);
 
 			if (contiguous && pmb_nr && moved_symbol == l->s)
-				flipped_block = (flipped_block + 1) % 2;
+				flipped_block ^= 1;
 			else
 				flipped_block = 0;
 
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 3129aa28fd2..0810647c722 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -188,7 +188,7 @@ static int check_dotfile(const char *x, const char **argv,
 	int res = 0, expect = 1;
 	for (; *argv; argv++) {
 		if (!strcmp("--not", *argv))
-			expect = !expect;
+			expect ^= 1;
 		else if (expect != (is_hfs(*argv) || is_ntfs(*argv)))
 			res = error("'%s' is %s.git%s", *argv,
 				    expect ? "not " : "", x);

base-commit: 2ccc89b0c16c51561da90d21cfbb4b58cc877bf6
-- 
gitgitgadget
