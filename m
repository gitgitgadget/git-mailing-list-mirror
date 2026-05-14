Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854AF33893D
	for <git@vger.kernel.org>; Thu, 14 May 2026 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775934; cv=none; b=iiI6DXlEWLSrHCFzo+Lj8LmNxzxIs5/ydsEcHmZJHvWN4I91Cv7T+rkX9LtlysAy3TGKSKQsZJBddvzcs2M1F2Jk8Io5PPCJZrg/BYzA//PH6vu7KI858yQGDJHqi4pXGiBayKJHklPlwIGOIiR7XK5RvHpMQa4H8o5K9dZvh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775934; c=relaxed/simple;
	bh=lGmaA7HQpL4fc921lV+KimhO650Cr4sQocwTfRp2N1A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xb9P5zUa68vWTI4xAuo6SpggI2Tdi2+RHXZeDThn678nKMRohgI1ot6KffmiZp1U6I+Qn3YdPJnaJkFTajMNIp9uSVZ1cThzJKxIInsfSv3HHa7CC9ASPwZ8l96UMwTXzXrrS3/+/bHP8yp9Trlo9kN0pbUL1kjBj6lt3hLW9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaU7oFwP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaU7oFwP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bd2051167eso15095185ad.1
        for <git@vger.kernel.org>; Thu, 14 May 2026 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778775933; x=1779380733; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwAcFLxBMUqEyAsFL9q41zuA9nhWvwzTk+WOQ6O1RbI=;
        b=RaU7oFwPvZJHqZLU1JXI2B1z2vcGKR24CLVRcgFfKvTQmC4+0z3+XWLOOYW8ah8fIn
         ROOFB2tiGSxvBxM1GM4IuGLiGjcFa17WK3ZHSiPKZr25dcIsm+aTblChJcYQMDvB9ZKq
         3SKPaQew3a4rH6RWsWRET4XJgC3Q9Td/zL1d9L6hSynQ6txxsU3CfJbISGLqsrlMz0dK
         oDU3n+GM/4FW3OcGVaY9zJi+c2pMoOi5eSYcQq2trIbOWVqH2WTzTGm95UBscj0G2Fc2
         Me621dNzYLDTLi2+CCX8wMVshSeeRKiosNUD9O+NSDBtYIMrtDovtiA4NKPP7PlWQhJH
         d8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778775933; x=1779380733;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwAcFLxBMUqEyAsFL9q41zuA9nhWvwzTk+WOQ6O1RbI=;
        b=UM0t/fmSiWlJ5P05t8kO4aYP5Vqp4HIo1RBy/iSQsXKkzbBV2YIjyhAirjotw09g78
         maat29IE7+wnAXFPdl00eSAM41KC0NSkHf//FoIPAT1KmkktjMdhyvfPcU7Y5xL79JDw
         6RIKSEXnlrrfeHMaAtcnr5fslPM1FtLZGB6mkkVE47N3gnjV2/3XvTSbjK99MhxUbHaZ
         n/OLYe0fEjYrYHYPYgBydtaifw2Y9WG53JOArP5AQV2WdoiVCHYq6EY1FPRmzwOyMOkB
         3qWPj8ypIXBQTCRlmNvaGLsRTGtIoGAHNjor7rLId4T5G2NbavyIfsH1wsLQY9ZjTbhp
         1/rA==
X-Gm-Message-State: AOJu0YyDJ2GOrcmBqc27m/izV7clml5OMwNkhFnCtMTMm9gsm/DqHaIx
	IAQzI0AOlHNJAJewN+zCx1v+0Ej/az1b8Q9g9ZP01Kflmj6qXzXBa/1Tmb+Fqw==
X-Gm-Gg: Acq92OEfeVMw0aJZaSlVAcdyJ6ugZG7kIPcTkhpOkMtjMqHz5q4sUN/ocBhWu4M8Bnk
	UbRanRwrskn/2/dFz6kqINKyPwVGw6YK/j/TPWVCwPgGFSpB4pfPwywykJXO5nRXV0ESgxhuEvd
	mSco/w+IAPyXsDC8ehz7ck/HmKkNOMykZ2dsuxV+vN9kv7jzA3cbFYkh+61HJagbvnhO6jrcpre
	0Eaq0f0/XsJdgnBqqI3IE5AaneFm8aocSamBM5gC52nj3UOz0qdDfhSH4AngPakra6pDuxglmyA
	dlS0hKXi7MY7IkDDrgElBpwYqfDfyM7glcqGzHXjPcy7QH2eeOmWWIMf63Cni/pR3TQwK3KaToj
	YKkf8lZ1i9VV91+Lc/SiDOCbyqfD9l05MT0X5271a+ohBIne1S+dRRWA2XRHhC/Pdly0HmYp1Fx
	6WN8ti4VlvgqIixaLVSF+DrbhO
X-Received: by 2002:a17:902:b181:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2bd7e862606mr2077065ad.1.1778775932654;
        Thu, 14 May 2026 09:25:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.174.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd7e8e5904sm1285345ad.64.2026.05.14.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:25:32 -0700 (PDT)
Message-Id: <08a2c6517bfc75fd7ee514fa513b6f57659acca7.1778775928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
References: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
	<pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 16:25:26 +0000
Subject: [PATCH v3 2/4] patch-ids.h: add missing trailing parenthesis in
 documentation comment
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 patch-ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patch-ids.h b/patch-ids.h
index 490d739371..57534ee722 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -37,7 +37,7 @@ int has_commit_patch_id(struct commit *commit, struct patch_ids *);
  *   struct patch_id *cur;
  *   for (cur = patch_id_iter_first(commit, ids);
  *        cur;
- *        cur = patch_id_iter_next(cur, ids) {
+ *        cur = patch_id_iter_next(cur, ids)) {
  *           ... look at cur->commit
  *   }
  */
-- 
gitgitgadget

