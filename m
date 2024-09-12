Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BA1C0DFD
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174145; cv=none; b=I8JS3lsWyHRj5rFVutsFhnyPjIlHkklpC14lhtqMomLGlafTsc+RW9K6b69YZ+7iSl3I2Zd/p0xIW/ShciQ04LONKqWGRv6E3M4RfH+W0JJ+g8To818u9Ku3pvJPrBGigJPLEnfws3BgoXQTyCzkoMvDhp2ABPz1Oa69px0TRXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174145; c=relaxed/simple;
	bh=bTu198aD6vuS97K44LBzkGjmGeVxsVZOXBK6+PEyd5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMXrBU9EdkwCPQVN8VFwnhu8eEJrXiYN9l2sWPzcZ71nch7CNnpeO+EVStlunA57WfqG8+mS4kdfRXAxdn+6mgPCdVXlNsiX8Q/aaGp1J8O8BIPZCy5fRxMv2z5M/KPBSN+8PlMkdAMXLaNkXG66PAquKzqdGqLsSKxKu1JqT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE_SECP256R1__RSA_SHA512__AES_256_GCM:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1soqci-003gRN-16
	for git@vger.kernel.org;
	Thu, 12 Sep 2024 22:41:05 +0200
Received: from [10.20.10.231] (port=48418 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1soqcd-009SE5-0k;
	Thu, 12 Sep 2024 22:40:59 +0200
Received: by drbeat.li (Postfix, from userid 1000)
	id E71CB1801E7; Thu, 12 Sep 2024 22:40:58 +0200 (CEST)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] unicode: update the width tables to Unicode 16
Date: Thu, 12 Sep 2024 22:40:47 +0200
Message-ID: <20240912204047.1020213-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Unicode 16 has been announced on 2024-09-10 [0], so update the character
width tables to the new version.

[0] https://blog.unicode.org/2024/09/announcing-unicode-standard-version-160.html

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 unicode-width.h | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/unicode-width.h b/unicode-width.h
index be5bf8c4f2..3ffee123a0 100644
--- a/unicode-width.h
+++ b/unicode-width.h
@@ -27,7 +27,7 @@ static const struct interval zero_width[] = {
 { 0x0829, 0x082D },
 { 0x0859, 0x085B },
 { 0x0890, 0x0891 },
-{ 0x0898, 0x089F },
+{ 0x0897, 0x089F },
 { 0x08CA, 0x0902 },
 { 0x093A, 0x093A },
 { 0x093C, 0x093C },
@@ -227,8 +227,9 @@ static const struct interval zero_width[] = {
 { 0x10A3F, 0x10A3F },
 { 0x10AE5, 0x10AE6 },
 { 0x10D24, 0x10D27 },
+{ 0x10D69, 0x10D6D },
 { 0x10EAB, 0x10EAC },
-{ 0x10EFD, 0x10EFF },
+{ 0x10EFC, 0x10EFF },
 { 0x10F46, 0x10F50 },
 { 0x10F82, 0x10F85 },
 { 0x11001, 0x11001 },
@@ -261,6 +262,11 @@ static const struct interval zero_width[] = {
 { 0x11340, 0x11340 },
 { 0x11366, 0x1136C },
 { 0x11370, 0x11374 },
+{ 0x113BB, 0x113C0 },
+{ 0x113CE, 0x113CE },
+{ 0x113D0, 0x113D0 },
+{ 0x113D2, 0x113D2 },
+{ 0x113E1, 0x113E2 },
 { 0x11438, 0x1143F },
 { 0x11442, 0x11444 },
 { 0x11446, 0x11446 },
@@ -280,7 +286,8 @@ static const struct interval zero_width[] = {
 { 0x116AD, 0x116AD },
 { 0x116B0, 0x116B5 },
 { 0x116B7, 0x116B7 },
-{ 0x1171D, 0x1171F },
+{ 0x1171D, 0x1171D },
+{ 0x1171F, 0x1171F },
 { 0x11722, 0x11725 },
 { 0x11727, 0x1172B },
 { 0x1182F, 0x11837 },
@@ -319,8 +326,11 @@ static const struct interval zero_width[] = {
 { 0x11F36, 0x11F3A },
 { 0x11F40, 0x11F40 },
 { 0x11F42, 0x11F42 },
+{ 0x11F5A, 0x11F5A },
 { 0x13430, 0x13440 },
 { 0x13447, 0x13455 },
+{ 0x1611E, 0x16129 },
+{ 0x1612D, 0x1612F },
 { 0x16AF0, 0x16AF4 },
 { 0x16B30, 0x16B36 },
 { 0x16F4F, 0x16F4F },
@@ -351,6 +361,7 @@ static const struct interval zero_width[] = {
 { 0x1E2AE, 0x1E2AE },
 { 0x1E2EC, 0x1E2EF },
 { 0x1E4EC, 0x1E4EF },
+{ 0x1E5EE, 0x1E5EF },
 { 0x1E8D0, 0x1E8D6 },
 { 0x1E944, 0x1E94A },
 { 0xE0001, 0xE0001 },
@@ -366,8 +377,10 @@ static const struct interval double_width[] = {
 { 0x23F3, 0x23F3 },
 { 0x25FD, 0x25FE },
 { 0x2614, 0x2615 },
+{ 0x2630, 0x2637 },
 { 0x2648, 0x2653 },
 { 0x267F, 0x267F },
+{ 0x268A, 0x268F },
 { 0x2693, 0x2693 },
 { 0x26A1, 0x26A1 },
 { 0x26AA, 0x26AB },
@@ -401,11 +414,10 @@ static const struct interval double_width[] = {
 { 0x3099, 0x30FF },
 { 0x3105, 0x312F },
 { 0x3131, 0x318E },
-{ 0x3190, 0x31E3 },
+{ 0x3190, 0x31E5 },
 { 0x31EF, 0x321E },
 { 0x3220, 0x3247 },
-{ 0x3250, 0x4DBF },
-{ 0x4E00, 0xA48C },
+{ 0x3250, 0xA48C },
 { 0xA490, 0xA4C6 },
 { 0xA960, 0xA97C },
 { 0xAC00, 0xD7A3 },
@@ -420,7 +432,7 @@ static const struct interval double_width[] = {
 { 0x16FF0, 0x16FF1 },
 { 0x17000, 0x187F7 },
 { 0x18800, 0x18CD5 },
-{ 0x18D00, 0x18D08 },
+{ 0x18CFF, 0x18D08 },
 { 0x1AFF0, 0x1AFF3 },
 { 0x1AFF5, 0x1AFFB },
 { 0x1AFFD, 0x1AFFE },
@@ -430,6 +442,8 @@ static const struct interval double_width[] = {
 { 0x1B155, 0x1B155 },
 { 0x1B164, 0x1B167 },
 { 0x1B170, 0x1B2FB },
+{ 0x1D300, 0x1D356 },
+{ 0x1D360, 0x1D376 },
 { 0x1F004, 0x1F004 },
 { 0x1F0CF, 0x1F0CF },
 { 0x1F18E, 0x1F18E },
@@ -470,11 +484,10 @@ static const struct interval double_width[] = {
 { 0x1F93C, 0x1F945 },
 { 0x1F947, 0x1F9FF },
 { 0x1FA70, 0x1FA7C },
-{ 0x1FA80, 0x1FA88 },
-{ 0x1FA90, 0x1FABD },
-{ 0x1FABF, 0x1FAC5 },
-{ 0x1FACE, 0x1FADB },
-{ 0x1FAE0, 0x1FAE8 },
+{ 0x1FA80, 0x1FA89 },
+{ 0x1FA8F, 0x1FAC6 },
+{ 0x1FACE, 0x1FADC },
+{ 0x1FADF, 0x1FAE9 },
 { 0x1FAF0, 0x1FAF8 },
 { 0x20000, 0x2FFFD },
 { 0x30000, 0x3FFFD }
-- 
2.45.2

