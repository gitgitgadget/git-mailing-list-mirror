Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36974A2A47
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091977; cv=none; b=WPZYS14OXqsPU8VXDRtLBHLJbwF33wRVuUHep/lA2Pp4MUwNH0pm7U5GL0+4cAggQvLB7pjfApk4rZIiO2lPw2DJZmQfxsgPIPT9YyuO6XBUMgfMupYY95u5rtdWL0XMoBvZqJQ9EWxShn3fQrp8z2xwFBw3FnXsvfpnzeZKFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091977; c=relaxed/simple;
	bh=Bsa68p93LhjEUIfSdtdnz3HTVvVemf5GjXZWU91T6Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqt+xzQcBTrm5PPx3BN6GZflxR459DKE5ppaCChAmDqBiiRBsNpufzyp5h+fcSeGqYxbFokPRel04sKWG0goC2B8haXLf9idloTW5Cp63MeIRoibko5bIHRLbR/uOqVooOmdCfRQuVa2v4zaJ9kkI6vs2RkgOyLbwJhqApf7t9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jydi8dLd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jydi8dLd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so35371745e9.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 12:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792091974; x=1792696774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bsa68p93LhjEUIfSdtdnz3HTVvVemf5GjXZWU91T6Qo=;
        b=jydi8dLdG8QHNSuRBsNWkOu+AVDuyQ+0XWntdSHJPUDNBBGB9uoeixvELoZS/zZC9h
         gyxV3PmenBa47OP0MbH0tLQwdrMBCAmXPYEaQpHjaI4AGnIvXWzJaAn/I6iWQoHoGvcT
         bJbDYdAxZpwdpu2FQhgvWVx/mUja0GaDUbiNQzGzSPbW9IHHuj9B0f2YvtETuFceHfGx
         dSW/f7BdIgNRea88AZPDSmofe2S7mZM8FAu081iMwYECJ+B5mW+EQ2cC2hlyZbfyCotJ
         1lcrqYfMdNPp2BeV4rv04+TWM6HZ5SUjQLIycpguw68BOWr70x1bdh5UATaoKFrFwVTS
         R3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792091974; x=1792696774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bsa68p93LhjEUIfSdtdnz3HTVvVemf5GjXZWU91T6Qo=;
        b=B9DA1Y44t5HqBdFb2NGsla2oWY1mWMuXGjYYiDisFfZT2cU6TuPd9U9vI3htNhnBpB
         1akEPTJ/sAFkR2keHkll4NVodbhvFr+MNRB6soYy5oCzcHhURnWAo51wufdjZ/BP0426
         xKYsRW6b9YJx54aVbi+tSYcJu08xpsN5O/K23F+ZHdxhgayWADFpOLqBmaRF188nlvm7
         7wh+XKZ5+CtrazrVX7V2C8d48XZPZrtCPjChAFagD9zs4Pk0sjTMsJV9TnBLvwVykZrm
         dr9roURi7fhr8ggMdd2h2o7i8Sdm4FnfIDl9Lt2Db6MQFT3Ldp5ez4Nm6Y1R7+mq0OY4
         cmag==
X-Gm-Message-State: AFq9FYKepKoHW4jROlyVVcPTFvblMbuPe5aUGAH++fvNsgtfM9u3Jghj
	6W0j0yKQRImx1H0WfZn//k5xozzwmKDLLBensPNk4rE56KgqjHkx90CK
X-Gm-Gg: AYBFou24tKnN+sv+8pnOdq2gHPpCK9MTQvAIqnjjzWrO27tELkfJz8cqEWiZSDRJyCY
	2MfJ2QeuW3ro7ws97fge+Qa4rzDvRBRHfxLNB1B410Tr3g0hW50MIbifcK/USNcDBNEicprHyI5
	40JPS6NY59PiBzyQAepqJR5jGwWCVGoOVp2E684kGMImDK2h4EBvQaOXzguvETzf0khYYzjru4Z
	CkxiHGbpSNgbc43IziwJPisGG0ywq7M5YR1ZqCTVO90h7WqPSCEXZIfFgTXBlUJleXdfGAsI1t5
	yAj/yeNoBZxSMOUEzbwWq/KouWBLqSQ+smQlclrnpfSGQMl4Eue7Ngsww9Gh6Hy7+0CpaMNElVk
	Q7smt8AegcqObgkEcBNAGMPckObClS0OoGSqrYuge/nxIZ5GSKa+QW820MWx43fEDClhtQXlo++
	qwvCOUlCLEscI43+hdaaFXMuK/cuCE9Cpcb8bo3W2iZ8it4oz3ZYg27g47EPy0VgSwhDlcVIXKx
	JA0ToVKE2pRshnOy9GuOk/OtZsCODpreDE=
X-Received: by 2002:a05:600c:810a:b0:4a0:2391:6533 with SMTP id 5b1f17b1804b1-4a18e4a954bmr390649955e9.21.1792091973963;
        Thu, 15 Oct 2026 12:19:33 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4978sm39174f8f.21.2026.10.15.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 12:19:33 -0700 (PDT)
From: kerylefondji7@gmail.com
To: usmanakinyemi202@gmail.com
Cc: git@vger.kernel.org
Subject: Re: [Outreachy] - Keryle
Date: Thu, 15 Oct 2026 20:19:28 +0100
Message-ID: <20261015191928.2051-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hope you have fun learning and contributing to the Git project.

Thank you so much Usman, I really appreciate your warm welcome and I'm excited to learn step by step.

Best regards,
Keryle
