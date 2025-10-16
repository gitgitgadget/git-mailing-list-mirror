Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576A27732
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600318; cv=none; b=Bb1+Xydm80hn2mYPhRnJZ1zwv5NsJ9fF4PjEbPfWQHc7Frs5zkJ2wf38GHjH4tnoZedJbAEKC6AebRbjd2Jg3/A+YOzShIO8JiuCIjMHpaBz2ukJ20zaERKZ0axanmV46O2eYHrB7FBHhtdWttm2NWJOufVc2fnaBrcwir9kQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600318; c=relaxed/simple;
	bh=S8OePrTbQD1j2vyliXB7p+x5y9tqRHaDsY9P6mq4tL8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gLBb6+ZwpEXUXbveqyvxvXzF4DbhcmWTs3guo8KdD2gWoJ+hQAY1p5ltOqt4Lctw5nCSHuWeeJZDh/+9FgHIOdrD/hVGTFBgcwOg3jbEQZUNvzwLRBGboSK4BBxmkgTjYeAbdoxgeNoh+GBV9dqv6MSOOONQtjAZx6dcYV9dmWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpEHiU4Q; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpEHiU4Q"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-938bf212b72so17492239f.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760600316; x=1761205116; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vmQeechAZxXIdEOqVAe+ppw7VSy0/qX4HYjquTCi2qA=;
        b=GpEHiU4QpBulPcMDmOtJssiO1XADDFNivGjzNjigv7mdbmu32JmKZi7x5qM3swca7C
         XUeoe20f/BNiQcqdr1TXCZqorSg4N+mm+i1vQUMH9Nu9QOCLaJsEpshEBvUraKKjU2Ri
         siRLtghqw+Y9wOtpGsOxKaBO0vx/qyAY1EUucyxnQxe/6V1jqCv5Dpi/muyj+qnCOeId
         W/+TnXvnHomAQji2cxpBLCzofPzIRUHgLKelCyINqTFQTGGgN3UGajDuMFvb3nN14pzd
         0J0NL2T/D03KFL+cD9lGqwnj80RSBHJx19UIPtX4rZEzOrKfyjbRXuooJWkhEJmn5/70
         3DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760600316; x=1761205116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmQeechAZxXIdEOqVAe+ppw7VSy0/qX4HYjquTCi2qA=;
        b=GxCZ8Aagtce/S7TfepSGxNN/Cn5N24wX5nb3GP3g1uy4dFyXXhAnxxZnbefPR3ETM7
         FZyXZvv43uqgIf9wBJkKY+6AHZQAmtLUoYVQKgwHA3z2kExWGLkKeffDLEFriaUQbd/K
         RR8lTRUJ8U6kCcVV9UKYTLBtZJ3GXkCeTE5s2XxYFkfotu3xxUukp2L7+5q74AODxLMX
         bya88m4jc+mE7s96DExrsmWJx95P1uQ8t+La3X/EUUmpyGgUF6MJqlx3VTIjzqmasUDw
         3k0fzdBGYZwUO3tSupwSS322PYmOb8PfTLlu8xOrOfSeffWNeY1oTj0YFgYAV2EvqLEB
         7Xiw==
X-Gm-Message-State: AOJu0YxQtR6U0MW2mgw8P76ot0WNPbQoERcIQTZMKsdx8GtESm4dfEhy
	iicaMDSVBPbEaFSi4+ZnTBMDtl2K6mf09UcPtzUU85+eFspnYN/mTMVaSxSV5w==
X-Gm-Gg: ASbGncscO1fMWGHq0/pEKNHpj8cq6SK+fzCKFR8KOH19qrffaUI8ho4byCiouyZxSWW
	Fs/ohRsw8RBRTAKX2MDxlk+0wMpWBx6iC8HWAvl/7Nqpr3R7TfBqewzGIX0aOXFin6jKx9A4WsK
	GkX+BjzBb65Ks5PjlOFbu5sONnv6xN5ilmZL9K0i2kHi2/z3dgyFxo+R6wMcCyhEm1d20sChR7t
	fTbd3yN2WnOB/8Mtxq0PE/Xhe5c8o+EK0GaulrwVOU/LmoYUibY24/OfkgBao1ixXjWculdhThg
	No2gB6FKtsZfXYwqlDG/+xxIwM4SrYvC5uyqaIf74a0Xh8KHkqc65VpZs65gMAF9lmn1Oc5yTqt
	iKZvUlC3oNoO33sx/fi1HzMoIOG+CMvsHaYcTdrChMJFHXhpSrA2tuMk/4/z/NaGJDDs1feN5LG
	7dSTDLznflnKcAGQ==
X-Google-Smtp-Source: AGHT+IGp0Mm0Zrf9KUVTaXGXn+cQjrCfcZllV/0Z9mF3vdfPe2T1DxtooXYoPyOq5v9TCCwOGO+IfQ==
X-Received: by 2002:a05:6e02:190e:b0:426:e20b:f5d4 with SMTP id e9e14a558f8ab-42f8737049fmr360281015ab.10.1760600315741;
        Thu, 16 Oct 2025 00:38:35 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.209])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430b50b6945sm7986415ab.7.2025.10.16.00.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 00:38:34 -0700 (PDT)
Message-Id: <pull.1988.git.1760600313093.gitgitgadget@gmail.com>
From: "Queen Ediri Jessa via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Oct 2025 07:38:33 +0000
Subject: [PATCH] docs: fix minor grammar issue in MyFirstContribution.adoc
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
Cc: Queen Ediri Jessa <qjessa662@gmail.com>,
    QueenJcloud <qjessa662@gmail.com>

From: QueenJcloud <qjessa662@gmail.com>

This commit corrects a small grammatical error in the MyFirstContribution
document to improve clarity and readability for new contributors.

Signed-off-by: QueenJcloud <qjessa662@gmail.com>
---
    doc: fix minor grammar issue in MyFirstContribution.adoc

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1988%2FQueenJcloud%2Fdoc-typo-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1988/QueenJcloud/doc-typo-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1988

 Documentation/MyFirstContribution.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 02ba8ba5f6..91c6296ffe 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -26,7 +26,7 @@ useful additional context:
 [[getting-help]]
 === Getting Help
 
-If you get stuck, you can seek help in the following places.
+If you get stuck, you can ask for help on the mailing list or Git community channels listed below.
 
 ==== git@vger.kernel.org
 

base-commit: b660e2dcb98ed4eafe2781b7ba31b70d2fcbad80
-- 
gitgitgadget
