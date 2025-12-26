Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBFF28504D
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766719705; cv=none; b=t1Qikkr6hyb/YLnUHgUME2MNYYR1RUSOw5WmJazTaK3no5Fr/ovWLO6viprh/Iuor/bGN7rPWC65vEk2oAdL5BUVJr0NcKuaJkO2lvRFMbELJslAYtMvZl8koJWKsf48lKYAyraDVRS4GnbwkaZnka4uSxFSyhPfnRChf5m3lbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766719705; c=relaxed/simple;
	bh=sUE5latcjfPcQlWFCohUVwf3CYYh5dXyKjHa6PJYFzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ix8PoX5V3MIAu2gOZ/o+zfqT1DdHX2Rye8JnKBV8c3MVKzIK/k8Li+FuxBk7/s59sf5V73/+SSWtAWz8NTEjBrPTbO7XZTsJKwc3IeY4VWKM6JFufW+cG5XduIoyUZh0RHuZAQjsDQFyyOUVgMVF+FsvLmCKfJcTjpS1NKbNsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHL6leRS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHL6leRS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a09757004cso88953085ad.3
        for <git@vger.kernel.org>; Thu, 25 Dec 2025 19:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766719703; x=1767324503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+DJEsjkbr1TckBgrvJwPavlbZf6JBoXJq/3nIGELPg=;
        b=ZHL6leRSdFeTnl2vxJ5L/2zgTFtJ0vA+4/5lCUO3QJHRk1D0HQt1CdjqZhpB2vX3Ob
         uV6Q8LPbiPeD7Sr29JdxiioE/efOg6t9nzJm4VjM1evDkbkhlg6ofUh3onbntUUr03ht
         vRoLW+07eopcc973GutDUfT+iKVgFWm4T0qdxQ5n3RTMkorv7mDPGQSUgpwXNryg7OkJ
         +alABlnG8uqxagVr+N7tOkZl/D6DAMOrDKNad37N85LipT2lmm5d0wdETZvJqsniGicL
         7xHAHp0B8+L0wd6wYPIRYjsO1aGKVlAFLYzPibVE/QAfWpT6c9F28HGBMeXC6kmit+Xq
         PrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766719703; x=1767324503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+DJEsjkbr1TckBgrvJwPavlbZf6JBoXJq/3nIGELPg=;
        b=Zy9S+Q93QBVNvCOM9YDwvf/DMNhzaQQr/VDLwQc3SOUk9WHW5WiHQ9Jr8RZRg9p4zR
         hM3WPrXNgfxuyjh6Hbwwp9rGqMbRxGHO3dLg+tJNPqRyrsuhT3/fPvv5LI9WRa8fek7p
         4fEpORLPmPx27oFyMtxUb/yHZgIEekKCnPdkHSkbq8Xj2jsUnO7XIdwIfY9PRnOiyRRE
         Zct0P5suAwjia2259Z49/kYimu99BFNzhcgDdmYwgEWeWM1G8/q2psuLJ7EBQEue1VJ2
         nrD78F19Ko+ZmUxgh02qrf+FDQ3lOjyFgTDtLpABUeUrcGlZbidMMdEkbFLJ0rDJe9Ve
         dseA==
X-Gm-Message-State: AOJu0Yx77LaGPtj2bwo1rba/Evvgm9zxL6pOh9i6O52Bk/GHdXQbGvMs
	5VdRooBoifaarsLr7etUw1tlBE4wC5upyu70d5kUfep7GiUmGtpWKkmzOyRqaS8B
X-Gm-Gg: AY/fxX7hGM0h5hHhdjLHk6QAxwOFV5jKCpHGDokLrs/ksdfbzbUPdVkHASi8k+7o399
	xJc63SZzGuxXpcoi2ONVtsBL4MKHfA4tb/Y4KEy2vGWQt34SW1UpDfKOOxiJB4YfCnuWmTs6XiJ
	5M20xxMOr1yGIEFK3OjVgdmZEMldsZZoJekDgYKA+jop+3hEMgnQ1LiSi0V4hz2k5NdsWf20Cd4
	SYb9yoDDXg+yZvHDBVN1UEn7viF2HZKgo/Er9H+xPLhH1hbTGiJU5IpQ6c/A7Q9ACiQO7/9XuXb
	zhYUIVu4X8lKwU7aIfp1WiHfVHaSDVbfEkWJ0CjtwGuXZos0zZldMLzgvwymU0D7L3tsf2vEKFO
	c/sfr6FJLQlVi+VWvuMcHBQ4nfkFp58ZH7cO3NblBF18Gk473mpD6CcKzMX/fWTJsEKYH66DSEk
	/I+v8OhwdZTJMPD3LDRxmw2tQNZuaWxXyT
X-Google-Smtp-Source: AGHT+IGX+GqYU4nQ1hBlKPneODyaMaicaNPCcDRfKSR8b2R6UFJVp1zBAT+QCiVbbK+1qAd+4RUf5A==
X-Received: by 2002:a17:902:dad0:b0:295:9db1:ff32 with SMTP id d9443c01a7336-2a2f2b53d65mr179895565ad.48.1766719703423;
        Thu, 25 Dec 2025 19:28:23 -0800 (PST)
Received: from Fedora-Gink ([2405:201:c005:b959:acb7:a699:c03a:f9fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c74490sm189293405ad.5.2025.12.25.19.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 19:28:23 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	sorganov@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH] branch: Remove unnecessary verbose flag
Date: Fri, 26 Dec 2025 08:58:04 +0530
Message-ID: <20251226032804.596058-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq1pkim1p6.fsf@gitster.g>
References: <xmqq1pkim1p6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --show-current option doesn't know how to handle verbose
logic. In such a case, we want the program to die when both flags
are used together.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/branch.c  | 2 ++
 t/t3200-branch.sh | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index c577b5d20f..433c213dc0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -860,6 +860,8 @@ int cmd_branch(int argc,
 		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
 		goto out;
 	} else if (show_current) {
+		if (filter.verbose)
+			die(_("options '%s' and '%s' cannot be used together"), "--show-current", "-v");
 		print_current_branch_name();
 		ret = 0;
 		goto out;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c58e505c43..5bb49de9c2 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1716,4 +1716,8 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --show-current rejects -v' '
+	test_must_fail git branch --show-current -v
+'
+
 test_done
-- 
2.52.0

