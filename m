Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F1DDA9
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846269; cv=none; b=mIKNNbTlnlE3vZcsPIugYgmlybKoJeP/X69R0NuaB7PMnOeDiy8x93pJOQnvdunddh2zuKOn9jJlVUdzhGikmtchKMwT1wWBboNDmhypms6UJwiuSA09AiAtk5eOXsEMgwC42Xb74cDxydkllXgBbpdZv42AyfgdRLXjABl/5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846269; c=relaxed/simple;
	bh=waaEs87VAF9Mt7kUIQ1j9+uwiJQkaUED6hAFOFv1oqk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qwhSXscxB1ZNubd5HBbEtm8V2Jc+r8XyjErdyhzCrZ/cJQQsjrCn/Pdfg/zDcP3Q4C/PYYiFJnOjnv02Yez/YVauqROJBS0dwKGQ2mGPvg3UQQPbBjb4MDmsw8rTrlYnnyU7vDUmPk0Y/TwIEZ3JqEH9bdH+JFgPMJMM923qIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=MV80lo0E; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="MV80lo0E"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 1wG6vu0kK2D8r1wG7vBSjI; Fri, 26 Sep 2025 01:24:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1758846264; bh=ZOs4yf3JbmHV01kXPH9yVb4i1cVUYJK+3mm83RWlWPY=;
	h=Date:To:Cc:From:Subject;
	b=MV80lo0EosRd7VeA/NdDFxqAsDN+8mOTGIUSxI9uUcEqpcavV/aK4HzjCEPrmPh6S
	 THPMt02tQREbtn9bh5axjMLrsGHBhE41yKSeJxOYDQ39IcT3Wl9vtpN9nCoYqpQfH9
	 nmp+F2rHwxQHFUlrzSz2vHIDAVz+KWRQ6rh11mOE/2OwoVzbgvSslKVxsEWFngiVZE
	 AzZ/TgGw4a5mw1h7oSaMH9xnXUuX802YfHiHN9Xx/mAfRyCvMn3W5iwYSFWKMdstC6
	 /70efgje9iF9oMhGY1bpcnLzTrj+28laYpaJbOhPFWv0gUxcFIj2Jt76ayZg+NB9D+
	 pDbq2rkI8Y9vA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=beTIU/PB c=1 sm=1 tr=0 ts=68d5dd38
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=iy8Wnop-l4UNZM7VUBIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <6dc8844c-8554-4c6c-a3bd-5ad2c04ab7a6@ramsayjones.plus.com>
Date: Fri, 26 Sep 2025 01:24:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 2/4] doc: remembering-renames.adoc: fix asciidoc warnings
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfL64zFTWtEX4boHW4Y7OPGBJVLowlyTZ1UVBAvCqGkwpqof5gBKmnZBBR9YUi4I4LeT57GeDoVPCsD4DeXT8kKKot8wB3sTfy8Mqqng4OCt75SL/I3eW
 w4DRX/0+1DnAcwGP/Z9UngJVXa5srksLg9/0ecIpSMLfrfBJDH4l9li+2gECL2IjNVS9u1tH/HqxL+4d+Yhc0AO65ZPWYVaQIgQ=


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 .../technical/remembering-renames.adoc        | 63 +++++++++----------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/Documentation/technical/remembering-renames.adoc b/Documentation/technical/remembering-renames.adoc
index 73f41761e2..89db8b406d 100644
--- a/Documentation/technical/remembering-renames.adoc
+++ b/Documentation/technical/remembering-renames.adoc
@@ -10,32 +10,32 @@ history as an optimization, assuming all merges are automatic and clean
 
 Outline:
 
-  0. Assumptions
+  0 Assumptions
 
-  1. How rebasing and cherry-picking work
+  1 How rebasing and cherry-picking work
 
-  2. Why the renames on MERGE_SIDE1 in any given pick are *always* a
-     superset of the renames on MERGE_SIDE1 for the next pick.
+  2 Why the renames on MERGE_SIDE1 in any given pick are *always* a
+    superset of the renames on MERGE_SIDE1 for the next pick.
 
-  3. Why any rename on MERGE_SIDE1 in any given pick is _almost_ always also
-     a rename on MERGE_SIDE1 for the next pick
+  3 Why any rename on MERGE_SIDE1 in any given pick is _almost_ always also
+    a rename on MERGE_SIDE1 for the next pick
 
-  4. A detailed description of the counter-examples to #3.
+  4 A detailed description of the counter-examples to #3.
 
-  5. Why the special cases in #4 are still fully reasonable to use to pair
-     up files for three-way content merging in the merge machinery, and why
-     they do not affect the correctness of the merge.
+  5 Why the special cases in #4 are still fully reasonable to use to pair
+    up files for three-way content merging in the merge machinery, and why
+    they do not affect the correctness of the merge.
 
-  6. Interaction with skipping of "irrelevant" renames
+  6 Interaction with skipping of "irrelevant" renames
 
-  7. Additional items that need to be cached
+  7 Additional items that need to be cached
 
-  8. How directory rename detection interacts with the above and why this
-     optimization is still safe even if merge.directoryRenames is set to
-     "true".
+  8 How directory rename detection interacts with the above and why this
+    optimization is still safe even if merge.directoryRenames is set to
+    "true".
 
 
-=== 0. Assumptions ===
+== 0. Assumptions ==
 
 There are two assumptions that will hold throughout this document:
 
@@ -91,7 +91,7 @@ this config setting, but we have to discuss a few more cases to show why;
 this discussion is deferred until section 8.
 
 
-=== 1. How rebasing and cherry-picking work ===
+== 1. How rebasing and cherry-picking work ==
 
 Consider the following setup (from the git-rebase manpage):
 
@@ -138,8 +138,7 @@ Conceptually the two statements above are the same as a three-way merge of
 B, B', and C, at least the parts before you decide to record a commit.
 
 
-=== 2. Why the renames on MERGE_SIDE1 in any given pick are always a ===
-===    superset of the renames on MERGE_SIDE1 for the next pick.     ===
+== 2. Why the renames on MERGE_SIDE1 in any given pick are always a superset of the renames on MERGE_SIDE1 for the next pick. ==
 
 The merge machinery uses the filenames it is fed from MERGE_BASE,
 MERGE_SIDE1, and MERGE_SIDE2.  It will only move content to a different
@@ -181,8 +180,7 @@ are a subset of those between E and G.  Equivalently, all renames between E
 and G are a superset of those between A and A'.
 
 
-=== 3. Why any rename on MERGE_SIDE1 in any given pick is _almost_   ===
-===    always also a rename on MERGE_SIDE1 for the next pick.        ===
+== 3. Why any rename on MERGE_SIDE1 in any given pick is _almost_ always also a rename on MERGE_SIDE1 for the next pick. ==
 
 Let's again look at the first two picks:
 
@@ -254,7 +252,7 @@ were detected as renames, A:oldfile and A':newfile should also be
 detectable as renames almost always.
 
 
-=== 4. A detailed description of the counter-examples to #3.         ===
+== 4. A detailed description of the counter-examples to #3. ==
 
 We already noted in section 3 that rename/rename(1to1) (i.e. both sides
 renaming a file the same way) was one counter-example.  The more
@@ -276,18 +274,21 @@ still somehow merge cleanly), then traditional rename detection would not
 detect A:oldfile and A':newfile as renames.
 
 Here's an example where that can happen:
+
   * E:oldfile had 20 lines
+
   * G:newfile added 10 new lines at the beginning of the file
+
   * A:oldfile kept the first 3 lines of the file, and deleted all the rest
+
 then
+
   => A':newfile would have 13 lines, 3 of which matches those in A:oldfile.
-E:oldfile -> G:newfile would be detected as a rename, but A:oldfile and
-A':newfile would not be.
+  E:oldfile -> G:newfile would be detected as a rename, but A:oldfile and
+  A':newfile would not be.
 
 
-=== 5. Why the special cases in #4 are still fully reasonable to use to    ===
-===    pair up files for three-way content merging in the merge machinery, ===
-===    and why they do not affect the correctness of the merge.            ===
+== 5. Why the special cases in #4 are still fully reasonable to use to pair up files for three-way content merging in the merge machinery, and why they do not affect the correctness of the merge. ==
 
 In the rename/rename(1to1) case, A:newfile and A':newfile are not renames
 since they use the *same* filename.  However, files with the same filename
@@ -394,7 +395,7 @@ cases 1 and 3 seem to provide as good or better behavior with the
 optimization than without.
 
 
-=== 6. Interaction with skipping of "irrelevant" renames ===
+== 6. Interaction with skipping of "irrelevant" renames ==
 
 Previous optimizations involved skipping rename detection for paths
 considered to be "irrelevant".  See for example the following commits:
@@ -421,7 +422,7 @@ detection -- though we can limit it to the paths for which we have not
 already detected renames.
 
 
-=== 7. Additional items that need to be cached ===
+== 7. Additional items that need to be cached ==
 
 It turns out we have to cache more than just renames; we also cache:
 
@@ -482,9 +483,7 @@ we store the trees to compare with what we are asked to merge next
 time.
 
 
-=== 8. How directory rename detection interacts with the above and   ===
-===    why this optimization is still safe even if                   ===
-===    merge.directoryRenames is set to "true".                      ===
+== 8. How directory rename detection interacts with the above and why this optimization is still safe even if merge.directoryRenames is set to "true". ==
 
 As noted in the assumptions section:
 
-- 
2.51.0
