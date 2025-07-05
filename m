Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB6405F7
	for <git@vger.kernel.org>; Sat,  5 Jul 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751737163; cv=none; b=Y0lXHAZ3znqV4zEFPHNwIbUg4GdIVne20qUq5xxzku5eDwyNCl9cJWSp2OBmMeb/dpGzDSitRnUn+d3c7AJBfnIZU9Z6E5rN7gBd1olF+a5vweF6J3HWX0vnLNm82Iml9L0B9RtbEr4wMxx1pSjJRvITN/WkzFHb6E8clQv3u2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751737163; c=relaxed/simple;
	bh=3cXK2MiV7csvnHjSq1MuFK88yyNmhf3dS12lOGbJ2Pc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JKfX8uIXg9pc/HVKC94qql29aeRUTblZfmS3G0p4csZTWtPMydalrDFvS2NAoLwIutgjfJ99dvYQlzg3Rg7MPbKO4yLc+zQ1NckXYlVJJpOvVD2qlid708GemQxDJhMhK4ZxxbVxSXYnDk5ryg3anZ53/voDM158QZl9jsIUQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMnIk0bi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMnIk0bi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a51481a598so975135f8f.3
        for <git@vger.kernel.org>; Sat, 05 Jul 2025 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751737160; x=1752341960; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OPKRSU8tNADHFMUeKSZ9CIV2/J6h14Hq87JslXvFYHs=;
        b=hMnIk0bimBszixLpvPR2B/Qoc46B+orZxRQeF+vsgML6pioJGF3wsj9lLbUpGDGFh2
         yRZ3/OR4XkSAHiBymd513uLHMzwj20hIGZn4HPzmSw2YwwonkeBjrQdr5sa4c2EhZ9UX
         ovL/srjvxPsfbOpkOPWfBKwh64PdhMmsf4298MihNNCdmmlrcQPRoaeU+smwnVzNZkaI
         V+NH7p3NpaIRM5hyVGY8dT8cZDHLBgoZTZ3PIxIBcu1lSzkkhvy/lvUZlwxL240W+L1Z
         KMYDSsE2tsUBD3/PK11QSikGXJAv+c8VP3AYViohC8Ipiq1FHPVcG7yRgzX45CWf39eI
         MBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751737160; x=1752341960;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPKRSU8tNADHFMUeKSZ9CIV2/J6h14Hq87JslXvFYHs=;
        b=YtuS8RvRN05TBcfOMYAcnJamKaifN5FNABA3a2VG/JZtKP71EHVgc1xMdU4+hM4B6M
         +G4oEPlPlqOKY8GRxd3e/55uPbH7rCuU7+y9G3o3RnWkQAS33FKmA8kSfho2fbS6/GPO
         EK+Ms/P7M6YUgtDxEfQ9WPVPgdBjUZMeYtCT/3HmHjQ/9g5oae9WSLfi9zXY4q5WKoBb
         29HEMD2yyRTH6kUnYCnyUI7yYC6ocjvbo0koVS+5Djr/kPSOFB4XzHIJERKsqdZdKTZz
         QzvfckYZxRxW44A9y5IfrqpCIQKVlchJ7s3KophCEHkdZSmDisfa1sJKepIfFcZ6HPib
         PwaQ==
X-Gm-Message-State: AOJu0YwwjQss9uX7+Sh3ctm5CFBHWP+Rf7BrTRVzDhocstL5g6vDmevv
	ZDPBCbziM2rMUGPSehg0gxCBSX9enTu6dnTb/pTB+iySWFF9BjRxmAWnLCohtg==
X-Gm-Gg: ASbGncuNMvY6KfzuL8xEnmGTDdAF/VESF4YoUvtCECx6QgVp0+pqzJZ+73x+9DQKG3W
	vCYdT5ojckQOs61JxGPPad6m+rixhXOsHC/aBaupn0oqScJnghae930mj1dGR+cWuWFoo2ct7uq
	2d3oN2rUMIFtAQ1+aFtXejMprCTrom8hYSaLH9r7Np5Tkr4HpXrtoYQ30bnjashTYo5aKPUaVhh
	k6WbB3XIVhhmm/vG4dIqujscVE59NhTKnX3spzoZUnJ44xXTgGNZ1WIpDJGDnvdBm2SALXykAHA
	MMtNTJdcGKrHewZ2XEmlsVtcszUa8DT66UiMkI3Na0hxkOt0gc1zLqRfsHjqIFs=
X-Google-Smtp-Source: AGHT+IF30b8yqqPpNMBypZ+uYAwoGkx+vhybZdGTB659GJq2EUDNOOdTZmalO4Rv9BaqdAqfR82d+w==
X-Received: by 2002:a5d:5f48:0:b0:3a5:2b1d:7889 with SMTP id ffacd0b85a97d-3b49703dd8fmr5075371f8f.43.1751737159748;
        Sat, 05 Jul 2025 10:39:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a998a47dsm87029005e9.18.2025.07.05.10.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 10:39:19 -0700 (PDT)
Message-Id: <pull.1940.git.1751737158670.gitgitgadget@gmail.com>
From: "Timur Sultanaev via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Jul 2025 17:39:18 +0000
Subject: [PATCH] docs: correct mistakes in git-merge
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
Cc: Timur Sultanaev <str.write@gmail.com>,
    Timur Sultanaev <str.write@gmail.com>

From: Timur Sultanaev <str.write@gmail.com>

Documentation for git-merge incorrectly notes that
tip of the current branch on ascii diagram is C
, while it is actually G (current branch is
master, HEAD on diagram is G).

Additionally diagrams on the page are adjusted
to use spaces instead of tabs, so that they align
regardless of tab size. This is in line with
diagrams on other git documentation pages.

Signed-off-by: Timur Sultanaev <str.write@gmail.com>
---
    Correct mistakes in git-merge documentation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1940%2Fstrowk%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1940/strowk/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1940

 Documentation/git-merge.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
index d53923c3b73..a055384ad69 100644
--- a/Documentation/git-merge.adoc
+++ b/Documentation/git-merge.adoc
@@ -28,8 +28,8 @@ Assume the following history exists and the current branch is
 `master`:
 
 ------------
-	  A---B---C topic
-	 /
+          A---B---C topic
+         /
     D---E---F---G master
 ------------
 
@@ -38,11 +38,11 @@ Then `git merge topic` will replay the changes made on the
 its current commit (`C`) on top of `master`, and record the result
 in a new commit along with the names of the two parent commits and
 a log message from the user describing the changes. Before the operation,
-`ORIG_HEAD` is set to the tip of the current branch (`C`).
+`ORIG_HEAD` is set to the tip of the current branch (`G`).
 
 ------------
-	  A---B---C topic
-	 /         \
+          A---B---C topic
+         /         \
     D---E---F---G---H master
 ------------
 

base-commit: 8b6f19ccfc3aefbd0f22f6b7d56ad6a3fc5e4f37
-- 
gitgitgadget
