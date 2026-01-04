Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704853C465
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767556099; cv=none; b=h7vyXETSxvTmw4unYqCRzbn6680DtYM8shGiXeWBgmgSeNNq6naIeBvUZW9ON8TIzgyY0AK3/rpF9rFebkQywNaVJItgcxf5x+x4JTebEp/6pyZJy2jKg5CBNZyruV9NqDm0fw1jS6/8NZlX7VgdEqjdfm81DIIBZwxozIlqBeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767556099; c=relaxed/simple;
	bh=nE14aKBAja8zPwVG/wSI/p+Hhnx1VpXqMI3StCDM8xk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2W5OPLhSIF/y3wcRw8RaUwCsjya2as1vexqHg90c+FE1NoaJowYoH/frBr3JlsinZOfT6/ZBaLQHJ+JzLIVNZJBx323uBrciIDZD58Q0LfrxDfy5FSK5IDXAXOq4OFCPIBfj3394MUJ15NlTaLGkA6AJ6foscFyjdDLWpz2ydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTZ/GlKb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTZ/GlKb"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso17801090b3a.1
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 11:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767556097; x=1768160897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWvyt5vqC+PBw3BgzokctFQZadkV/5i0hW2m7qcYPwY=;
        b=GTZ/GlKbPSV07xBan3ME83hptULW1Jh9IS72pcM5RVTlfYZUki3FGuj1Hz1NGQJ0tz
         tKNY/5CYZgiQpoDFV0U1NnEd0dC8AvoZCSCGTYk4+BB6VO2vqfDt1iMnaIDqZqfEzFht
         rXpGGCuln2+juZuTQmHf0At9xKM3Q9puf9HW/9y2bQcGHafHX/IV9CZVsGWdGrwu8wkM
         0wX67yqex9I0MrNZqT8Tc9MTuGuH8+vPg0GjErBUm73k6vNUzg+ptJR4dOw0i9X5vPdu
         DTdm9kbV58OyxftzGeUVc3u04MFcbhYuDOOZuXc4TD+fq2J7iXR5qRccoerX022eBt1k
         WI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767556097; x=1768160897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TWvyt5vqC+PBw3BgzokctFQZadkV/5i0hW2m7qcYPwY=;
        b=Ap/816XzzC3r1Dv30m2TdLY90Rb/Z/uzHawr8ezgH7RkZDAJEcg+CJfStOn9bx7Hmw
         a13Hu0LiVXbnNHDghpL8rd5FON9HN464SyV9xlSCW6izpfXu/oi9E2tQdInEVZoB+lSV
         e0EQZHeOERxxeigipXw4Xw6fbQF27NrumSFixtQXV+oTQ3NkpxEws8ZW1B3txuTptA9n
         AaJXrQjkOf3clAP3IlpEqzkFtg4sDWBQ9nqnLlSzv3x06JxPMLGo6/GbxXljsoEaJ236
         vSwgrTatLk1+S20SfRRAHwY2vLaXTDjCSsUXgHfULl4bjHr0owPRHyL85P00vy+VJDfF
         eG1A==
X-Gm-Message-State: AOJu0Yxn0/baez2MOK0iG+JEHFSB4XCapMwnP/O9k8iZ1Od07x6Frk82
	RhDHBKZv+uI5euEewo+861IBDD98E4yM8s5wREdFHipKY51DtmghHY3Fto178g==
X-Gm-Gg: AY/fxX7HmQtm2UNIJ5FP2FRYOIHJB4Y60Mj61yc6O2Vf1JAl25TqI4UFJ5b12M1/7WK
	t64qP1YXrmVUwGxv1HqMQGhnXfbR6yDMxednaNDCHRJAhnXY8fhneydrcjgFwXpMeTf0F8JqrXG
	R2XL2cAC67nFf0jUKnQ7su3cnykwiagWETRB5/XmncVnaCxAJJPC1BeXnqegduQva3qwLecay0z
	0aDrwTYMJDPSYyF2woNxJ/ZQzeY1Iu2kdmnHWdEWMeanzZggd9QkxCU56tklLOMo8kxVGqgjjGl
	UDYEOlsRzuukYXS5wU4qAWq86keMrKvfKGROxcIji5yHXqahGlfBDTqu8tWAG6m5YxoPecadUw9
	4nSTDTIP3MDqMnOGp1N3EeJaZFsx+9UaOBzYTR+aFusyLwGoC91HS84xNbzMnwszyiSUZADRf3x
	+PGf9J5MYn/I9EIWDHOkbMD37LNJEOIT/F
X-Google-Smtp-Source: AGHT+IEz00YLmcLAKTMQkfP6+CoGAw8Z/3mHAWZmZFKuRHqsZrhawgfCIpk3xvfzFd9/LUIMoiG2nw==
X-Received: by 2002:a05:6a20:244f:b0:34e:409e:eea0 with SMTP id adf61e73a8af0-376a75ef1d1mr53015190637.12.1767556097524;
        Sun, 04 Jan 2026 11:48:17 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79620bd3sm39555821a12.4.2026.01.04.11.48.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 11:48:16 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH v4] t1300: use test helpers instead of test builtins
Date: Sun,  4 Jan 2026 19:47:59 +0000
Message-ID: <20260104194812.15134-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260104124255.15609-1-pushkarkumarsingh1970@gmail.com>
References: <20260104124255.15609-1-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace test -f and test -h checks with test_path_is_file and
test_path_is_symlink. Using the test framework helpers provides clearer
diagnostics and keeps tests consistent across the suite.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
Changes in v4:
- Update commit message to avoid calling `test` a shell primitive
- No code changes

 t/t1300-config.sh             | 8 ++++----
 t/t2021-checkout-overwrite.sh | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 358d636379..9850fcd5b5 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1232,12 +1232,12 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 	test_when_finished "rm myconfig" &&
 	ln -s notyet myconfig &&
 	git config --file=myconfig test.frotz nitfol &&
-	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_symlink myconfig &&
+	test_path_is_file notyet &&
 	test "z$(git config --file=notyet test.frotz)" = znitfol &&
 	git config --file=myconfig test.xyzzy rezrov &&
-	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_symlink myconfig &&
+	test_path_is_file notyet &&
 	cat >expect <<-\EOF &&
 	nitfol
 	rezrov
diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index a5c03d5d4a..38c41ae373 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -27,7 +27,7 @@ test_expect_success 'checkout commit with dir must not remove untracked a/b' '
 	git rm --cached a/b &&
 	git commit -m "un-track the file" &&
 	test_must_fail git checkout start &&
-	test -f a/b
+	test_path_is_file a/b
 '
 
 test_expect_success 'create a commit where dir a/b changed to symlink' '
@@ -49,7 +49,7 @@ test_expect_success 'checkout commit with dir must not remove untracked a/b' '
 
 test_expect_success SYMLINKS 'the symlink remained' '
 
-	test -h a/b
+	test_path_is_symlink a/b
 '
 
 test_expect_success 'cleanup after previous symlink tests' '
-- 
2.43.0

