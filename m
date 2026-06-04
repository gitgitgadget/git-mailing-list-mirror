Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F53CBE7D
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555734; cv=none; b=hLVV3rLGj28A3NG/ppYM5IxVXfKqIrjc62HlD19Hdr2g1q0W+ufqNI96S72s1cY8OuZPN17YA4h2XUZ3gOv46KrQ/kuYLcMhDhmc4AxV+mMHCZz9XpPl0OyTnxgrKkFcjkjvwqhG4Bs+RfzoNO1ye34Ls2K7jhcLK2gc936QNQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555734; c=relaxed/simple;
	bh=XOqb1TPDCgPAL8PSvFnvlItBDXDH/7LHxhOuwgKtb/4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VocAHj9gAKjY6GUewUVSi9JFxMcdEjjJIhvCFC/o4fk5Znxo2DbugxZgvFXa5Ips1UHLoep/ZrZ4n+46VAfMI5P7C/1GMPbSVwcXc1S/hCO+DYXmvE969KYcTzoNEKgXnVEP6IOjtUn8fQZhbgW26wTrOntKPxWnu7O/P4L5/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+jaJxTv; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+jaJxTv"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304d7f31215so267270eec.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 23:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780555732; x=1781160532; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rZZn5o1mgNB6/67jafgvzbYkZU6C3ZmpXgEy46Yl2c=;
        b=R+jaJxTvtaWQ063dgBgyrdFnZjiIFDwAh8XKJtZBtupksMmcgcnFzUA0RWRUUUYnkP
         gLuMJ7FNFNzYDCAd2khEd5hYNl3nWagkp8h3zA7v6/5UbSO3Sg7p5tt1ZRyxEa2btLZ8
         dziNH7NmVoRyyInbe4dfygEVM2tHFZLd/NAWpnx1yovq+BgMdvLjoi7mAisZH76IOpQE
         B8KQ0Cgrnfwq9TdTaetxyLjQ5JLDPTl6bWvwwH9hOhgB+u2Dcn+IRnKRE+akDRF3ABK2
         Ks8G4OoaoCiR5PSTy+Uo++oKfbe0enoycIISD4jiqHmomt1ElmGV3oWlTIud/6hlt9zn
         18aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555732; x=1781160532;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rZZn5o1mgNB6/67jafgvzbYkZU6C3ZmpXgEy46Yl2c=;
        b=E6aeShvwsvwk4y8G3GJjxx3xMhI7n4wiU0QiuqlP2wjgHhjL8S0cV/AdpLwxkoxo+N
         oaQ5CXNngiGnykgULMR+CivDBZbDFsU4nbOhUMrc7A5klgV6+oCK/QsUGPY/E+8l0Jkj
         gkEDQFkoIAiU8F7yLSx2bsPyrfblvH6qfNcinXdDutv6FLXCDeW37ukGTIkbPt7jYztb
         H663wcQD0C5a5d6jTKyGkOaf9iU4rRhU6a9SJMhVMLCPWSgXDjApHztgcUyrldbuVclM
         iWb1CpY2f5x0MmDACyabYbG3njB9ttdHCz0RZeY7in4XXASkfQvcNNM3kVhvNXCJl0t7
         MwPw==
X-Gm-Message-State: AOJu0YzrgVdB+1hyv7dPkkqQPrlLzQ4z9ZnfC0fabgEsvgLD1pgLdb2f
	CLTunhLrGEFS6xVFK9tDOKntAiEBiKPjtrIIkn+Ibhlch/7A3auH4NBmpCILcw==
X-Gm-Gg: Acq92OGDGUDq1lola3Rrfk+J4pgYMuMaxo3gtoQi8oOxLC3TvUZDTzuJZhsWm7xPFzX
	TTJQ3ssaZQu8GvzLEfhMpNATaATDxmqPbWNSZGmqpUNuf3OTGGNWKwcYiXz/hRgwBMQ5KknqO0+
	wzY40XFAMjV+sC++qIjevn3zJamUMn6oxDL0DSnuNwbySayD87MsfXnc7LIcaZaLiwtxYT2yXsg
	xIfTN4bR+fvm0TB8Bhor1yZ1hmQ/L7YGOARsNTjrnKRtOLkG3nf+SqyPkd3+0jgKdVPIvfTapX7
	Mks6OpOWYqGk7XrAQroxYV+LKbUdV9t0mp9qSQcM0iNk5toFRlFILdzBnt7YDqK8lz2LybWC1Cd
	eszcE1uYqWOdPYTfsrb2iT+yUMII890FLRMlAz3s3ilCq35QL5aQ6Vq4i//D+4aR0oOwZ7eKktw
	kwCUOWxYoX1INFXwXH4mt7GCPk5Tpy8W3f3aoNLA==
X-Received: by 2002:a05:7301:19ad:b0:304:5b0d:489b with SMTP id 5a478bee46e88-3074fc2be91mr3938985eec.27.1780555731707;
        Wed, 03 Jun 2026 23:48:51 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea89easm4437407eec.14.2026.06.03.23.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 23:48:51 -0700 (PDT)
Message-Id: <pull.2318.v3.git.git.1780555730228.gitgitgadget@gmail.com>
In-Reply-To: <pull.2318.v2.git.git.1780510415838.gitgitgadget@gmail.com>
References: <pull.2318.v2.git.git.1780510415838.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 06:48:50 +0000
Subject: [PATCH v3] git-gui: silence install recipes under "make -s"
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Several install and uninstall recipes embed "echo" calls that fire as
part of the recipe itself, so the install banners (DEST, INSTALL,
LINK, REMOVE) were visible whenever the variables expand non-empty.

Guard the whole "ifndef V" block on "-s" so the loud variants are
selected only when "-s" is absent and V=1 is unset. The existing
"-s" check also had its findstring arguments in the wrong order
(needle "-s" never fit in haystack "s"), so swap them while moving
the check to wrap the block.

Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
---
    git-gui: silence install recipes under "make -s"
    
    Added sentences to the commit message noting that the old findstring arg
    order was broken (needle never fit haystack).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2318%2FHaraldNordgren%2Fgit-gui-respect-silent-flag-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2318/HaraldNordgren/git-gui-respect-silent-flag-v3
Pull-Request: https://github.com/git/git/pull/2318

Range-diff vs v2:

 1:  4e4029c8e8 ! 1:  1375fdc1aa git-gui: silence install recipes under "make -s"
     @@ Commit message
          LINK, REMOVE) were visible whenever the variables expand non-empty.
      
          Guard the whole "ifndef V" block on "-s" so the loud variants are
     -    selected only when "-s" is absent and V=1 is unset.
     +    selected only when "-s" is absent and V=1 is unset. The existing
     +    "-s" check also had its findstring arguments in the wrong order
     +    (needle "-s" never fit in haystack "s"), so swap them while moving
     +    the check to wrap the block.
      
          Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
      


 git-gui/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index ca01068810..d33204e875 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -64,6 +64,7 @@ REMOVE_F0  = $(RM_RF) # space is required here
 REMOVE_F1  =
 CLEAN_DST  = true
 
+ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),s)
 ifndef V
 	QUIET          = @
 	QUIET_GEN      = $(QUIET)echo '   ' GEN '$@' &&
@@ -89,6 +90,7 @@ ifndef V
 	REMOVE_F0 = dst=
 	REMOVE_F1 = && echo '   ' REMOVE `basename "$$dst"` && $(RM_RF) "$$dst"
 endif
+endif
 
 TCLTK_PATH ?= wish
 ifeq (./,$(dir $(TCLTK_PATH)))
@@ -97,10 +99,6 @@ else
 	TCL_PATH ?= $(dir $(TCLTK_PATH))$(notdir $(subst wish,tclsh,$(TCLTK_PATH)))
 endif
 
-ifeq ($(findstring $(firstword -$(MAKEFLAGS)),s),s)
-QUIET_GEN =
-endif
-
 -include config.mak
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))

base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
-- 
gitgitgadget
