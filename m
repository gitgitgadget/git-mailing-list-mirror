Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98982512EE
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623090; cv=none; b=DzD5vIYj2shC5d4bFPxxPBLLvr1NNuFaUWyn2GSuwceUttvd2LEFNWs277kc4aTDqZaKw6+NUtXGMDYNXVNazs06qK3Dgw7IADZlz0mrLG15dlytNpcpck4DDJhNDlGuxWOnZGkVflBhvx9wA+53y9ojJm79jA6iWxMmwoRHU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623090; c=relaxed/simple;
	bh=siF1NQT4eY9dFQJzesIXZ6gHV4Jv10IulqPMcsnJnck=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=qwF9eCEV+hdU9/5WOtsnZAiZDyt1WAfT0LQ8EYIN65c4IizmleilRLCy4830BCkpMROBr7diFN5LkRrSKZ3KkVRaZXM3E+5TGnM9Yx/9kE0W27n57+dzh/uW3t9NyduuSi3krPihUYmPuQFv2+0X1jEF/n2aBb4uTI0f+Y1KKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyGkrPDm; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyGkrPDm"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3f660084016so6345545ab.3
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757623087; x=1758227887; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=al4VzNBqxWWOskH1QQv+oZGjh/913EFQSVfoUgDw8fA=;
        b=OyGkrPDm/sYI8UKK/QbxJFiFnAzYhthXaqSrn55PaKMSTWyd8mn/hZQOv7LJfuPuH7
         S6Z8N6sYgY/FK2Qo4E7ZhDdfntiN5Z+2/nW3+zUzW3vuVSkRFMamR65G6IB2of6AK89T
         Bq7dA6a7m/VXOOkmqaeB//tgyWJrWXww50Zhmj3TB6eZyadoZgtQUx7EUegFVZN5BNzl
         W7bAduN3ob30HzpKjFbNJcCafnCxAVztf/Rs1Kc/4H+vgDSXxc35ujqnEz/Vxd8yS0Lo
         Zw3B8vNggzdllng/Oj0sWCfwf8601w6hZSlqk200l6Mcn/AzeT8bU4U1UiPBKw/YH55l
         RCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757623087; x=1758227887;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=al4VzNBqxWWOskH1QQv+oZGjh/913EFQSVfoUgDw8fA=;
        b=snGWkzWXd7RNlM8JpGsZvBissgHRZekEmUTfsycF4Lt6AZAlwVZvys2M61hYL4OsXv
         TQ4PS/wIH0MeOETcoZFvNHw51s9FsFvxlTHnnn+SnOnUFJ6fwnSCPIXexMCXgeB8wEPm
         a9yD9X3Zy+Pd6loS7da5f+S98NKfPLgnO6NNBpUvqPrD/ohun8BvZA/jrtriJJgX6spR
         3RxjkODvSN+3Ljxt8Cfpb1JJSu2modYzQpBdvAPx1VPeam5YX7QSM1k+aPdT7moNfGM3
         PlJ4u6zzBAtd9ylMH9CkMgMeeQ1hb3492HHR+0J2R3s3fTz6ct/cCbhdaoDMkfOThU7v
         YNpQ==
X-Gm-Message-State: AOJu0Yy9HrD9Yn9AIBocB/i+oNdaWN4TjNBpS/ksAg1dfuhXAZbxBTI0
	sqUtpHJH+SUzH/t+jfHX77pJO/mBltxZAwwK+ICS0GlGK6lz/hHZVDTdTWwuEQ==
X-Gm-Gg: ASbGncvN5TFAs7dI7nvySh7pBIfEkMFX9P2DeCGsyeeQia93tJPFnP5Ufw7AMtbkPSW
	caCRe7pcb1lBSIE/FcKBQ0lMG9s89nftVOB8eRIehBFKFpu0wvC5/C1B36tEheYxWEWQMNNvnSu
	l/bJCiIFfOWYd9WQQnHV9fBf4Kvp3HmVopV+a+KoxmktqPs1LBACmscuzLoU22R529xRJU5uf/d
	UlCo5Rc6UtijOn9RIEo9E4NFJYKNSniw529kgHZqCjkNxi/iZ1wpYJRx3Ap2vMKlTdCrmUz7KiS
	HcQdEvJObJTfID7v9t3BxPHfsYFGq8BNTgse13GHwrfYspnHYe3CB8iPtc6bbZANfSHi54LCQY6
	+f/J7yYxlioRuiu/ehXOI/Sk7BLqUVUG03wQ=
X-Google-Smtp-Source: AGHT+IGoJfBQUr6WO3IqwnushyiGr8qjSIhWEncGGL6xa0DrQj+Nyvx6/5K7glPGJ+xFun4QWOFFSg==
X-Received: by 2002:a05:6e02:170c:b0:41e:96c7:adaa with SMTP id e9e14a558f8ab-420a4737623mr15451365ab.23.1757623087391;
        Thu, 11 Sep 2025 13:38:07 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.163.41])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3062bc3sm945539173.47.2025.09.11.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:38:06 -0700 (PDT)
Message-Id: <pull.1970.git.1757623086030.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Sep 2025 20:38:06 +0000
Subject: [PATCH] libsecret/Makefile: add install target
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
Cc: M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    libsecret/Makefile: add install target

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1970%2Fhickford%2Flibsecret-makefile-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1970/hickford/libsecret-makefile-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1970

 contrib/credential/libsecret/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/credential/libsecret/Makefile b/contrib/credential/libsecret/Makefile
index 97ce9c92fb..6fe70065ab 100644
--- a/contrib/credential/libsecret/Makefile
+++ b/contrib/credential/libsecret/Makefile
@@ -26,3 +26,7 @@ $(MAIN): $(OBJS)
 
 clean:
 	@$(RM) $(MAIN) $(OBJS)
+
+install: $(MAIN)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
+	$(INSTALL) -m 755 $(MAIN) $(DESTDIR)$(gitexecdir)

base-commit: 4975ec3473b4bc61bc8a3df1ef29d0b7e7959e87
-- 
gitgitgadget
