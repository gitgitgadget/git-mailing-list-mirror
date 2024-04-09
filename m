Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AF0158D74
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699824; cv=none; b=FBEaI7VsRM9jCGf0UCzq8E6lamqu/erB9i3UxeQZRf/HeFcx9R8436chyILIJZX3STHHMXRm3Lv4YE414ArKGW6EJL6zB59uy8FNP1O37jblUutyp9DorUAPDcan7mrnXdLf+BK7C3KM3/46NmDbWWXcsL8FGq2eNj15eOpuzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699824; c=relaxed/simple;
	bh=OS2xoQ0I3I/WzFYlGj0iXuJRTReu6U3egxUrzXd+0vg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lWmu6LzTyLJtnjNYeN8cTPZAu1PkM7yTJaS/KD5A/dnMNCapfQgoW2/iZBnvUOCsRloVo4VztU8J8kElpmjZT7/CpIbwmJ7vHrKdOAaha2KG68n2Cx6fVszstUMluu1zUazQkrw4oVWLe/VAPajBXnfBJ79N96+xolLIBmfLjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJMvwnsd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJMvwnsd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-416c4767b07so1720395e9.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699820; x=1713304620; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9jqNylnkl/Oo19J6SRdOvDdCpMoEF+q1h7XhVbXYK0=;
        b=GJMvwnsdcG8Ee+GYaUquQcOw/5Rp3d375MQMGqP+Er2nEkMWXHNQwGg+qSFVP7QZVr
         8tujcIUGmjvaLvytX9b7x4XKGQqVHZburQ2vAMwBxKbfqh+kcJwvk2VG7PdFdmlS62SC
         LI4GhmV+yifXO7/blUMKEX0lCvyse1JubQn9xNbSaZQ5isRso9qBk7nsEkVOH3bbkHp+
         xRGTLm1CG8SQ408C650QpIBYiz2wxRKQoZ78FPCUovAAcziHk3TJZljZ0G6EZE/8qTwv
         Kdjtev5HeQpAtBCvL42DNMylyB0/VkZR+pAXk1dY5wso7Z0bwtlOU2bIHhcf7OZVMOzj
         hRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699820; x=1713304620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9jqNylnkl/Oo19J6SRdOvDdCpMoEF+q1h7XhVbXYK0=;
        b=nwj1uMD5Cpqe84UMtjY5Ibosa+KfSdKEL/lO4fb2zHMC5LcAgUMtywJnhbm0apGQiI
         EE0ubuDNe2VOUF3dCLpPt0Aa2KpKoM9RrXTkSsVbJeGL0UcF1E3SfgXV3xbUYDYxkpzM
         PcDARSfj+3YnQ9HTVybpqBmEbcKDIsE7oDcDUGHPObPQ/2NPfCtR8rd2XTFDKCMAnd3s
         Khl3Ww4a09qNnJlTbQH/etMO3dyOLH08E/2DPdp7Y5wKw0GUxuoFD+24auzbYq9L2HtM
         FQk8Vx/kPYxkrxOUyykljaR/UQEt2xkxUpwEzj6TPsmSfdPnt217AE7OJLJhXMg1zxrc
         EKhA==
X-Gm-Message-State: AOJu0Yz952K8Ytjph7QkNXHQZjaVFgKBEWADO9QPKi+YBvhfcfM6QGWl
	IBx+l7DGVUHoy39ombM0zThJHRSrvo9D8dadxjcjBWiVcrBSuEUECrvm23kJ
X-Google-Smtp-Source: AGHT+IHXY11PuVYE8WBY0hbCYPapOqZH4BqlOjGTfEPwbPoAoMl6RXHJjFViRVNZJicv4CX1Nvt3ew==
X-Received: by 2002:a5d:660b:0:b0:343:b9e4:d254 with SMTP id n11-20020a5d660b000000b00343b9e4d254mr609905wru.13.1712699820094;
        Tue, 09 Apr 2024 14:57:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b0041680911b0fsm211612wmq.30.2024.04.09.14.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:56:59 -0700 (PDT)
Message-Id: <7f8fdc053f729076e5e8c18fa167c71d6eb8b2e7.1712699815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 21:56:50 +0000
Subject: [PATCH v3 3/8] SubmittingPatches: mention GitGitGadget
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index a33fe7e11f6..c1933c97cb7 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -408,6 +408,10 @@ are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
 type e-mails) might render your patches unusable.
 
+NOTE: Here we outline the procedure using `format-patch` and
+`send-email`, but you can instead use GitGitGadget to send in your
+patches (see link:MyFirstContribution.html[MyFirstContribution]).
+
 People on the Git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
-- 
gitgitgadget

