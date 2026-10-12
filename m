Received: from mail-gateway-shared11.cyon.net (mail-gateway-shared11.cyon.net [194.126.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D5443315
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839107; cv=none; b=Cvb01/52sVyJ0f/63oW//FSQfzy6dXWO3QuJZ3+CjKVDcP/ZPOL7lTAVFXW7h/goTAPFMWM4qwZeDabvCGN8xlwp3sAiXuKZMCvrROU6j8yUVZCfYprkW/Tn7GeDho0cA9xo2hkp9ks06mhLQEn8dfCnFTBwyXLbRzI3AVE/xuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839107; c=relaxed/simple;
	bh=ktl4bQedDX15r0Fa08aPjdOKbdfAx4m9BHggowsdYxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kt4Pcnx642h1zL5LQ5jsXj84tfi/HCCLN2uFFYX1Kg0BQzXwIujVELhR6YeUEul5d0JLjKS2V0++PhP1SigY4wDOdmJ0YQ2NS1S5rvZ15zAw363CRn+rvQWn/+kc1S6QM4AoDINXoYS4LN98WLbEnK+q/+tIVT0cZcy9/sEfolY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared11.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1xGNCe-000sUs-2B
	for git@vger.kernel.org;
	Mon, 12 Oct 2026 23:05:02 +0200
Received: from [10.20.10.53] (port=46744 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.100.1)
	(envelope-from <ig@drbeat.li>)
	id 1xGNCa-0000000E5rZ-2kXJ;
	Mon, 12 Oct 2026 23:04:55 +0200
Received: by oh4.internal (Postfix, from userid 1000)
	id 2B94640610; Mon, 12 Oct 2026 23:04:55 +0200 (CEST)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] unicode: update the width tables to Unicode 18
Date: Mon, 12 Oct 2026 23:04:50 +0200
Message-ID: <20261012210450.994951-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.53.0
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

Unicode 18 has been announced on 2026-09-16 [0], so update the character
width tables to the new version.

[0] https://blog.unicode.org/2026/09/announcing-unicode-standard-version-180.html

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 unicode-width.h | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/unicode-width.h b/unicode-width.h
index b701129515..c8fcf68668 100644
--- a/unicode-width.h
+++ b/unicode-width.h
@@ -5,7 +5,7 @@ static const struct interval zero_width[] = {
 { 0x05BF, 0x05BF },
 { 0x05C1, 0x05C2 },
 { 0x05C4, 0x05C5 },
-{ 0x05C7, 0x05C7 },
+{ 0x05C7, 0x05C9 },
 { 0x0600, 0x0605 },
 { 0x0610, 0x061A },
 { 0x061C, 0x061C },
@@ -61,7 +61,7 @@ static const struct interval zero_width[] = {
 { 0x0B3F, 0x0B3F },
 { 0x0B41, 0x0B44 },
 { 0x0B4D, 0x0B4D },
-{ 0x0B55, 0x0B56 },
+{ 0x0B53, 0x0B56 },
 { 0x0B62, 0x0B63 },
 { 0x0B82, 0x0B82 },
 { 0x0BC0, 0x0BC0 },
@@ -143,8 +143,7 @@ static const struct interval zero_width[] = {
 { 0x1A65, 0x1A6C },
 { 0x1A73, 0x1A7C },
 { 0x1A7F, 0x1A7F },
-{ 0x1AB0, 0x1ADD },
-{ 0x1AE0, 0x1AEB },
+{ 0x1AB0, 0x1AF0 },
 { 0x1B00, 0x1B03 },
 { 0x1B34, 0x1B34 },
 { 0x1B36, 0x1B3A },
@@ -230,7 +229,8 @@ static const struct interval zero_width[] = {
 { 0x10D24, 0x10D27 },
 { 0x10D69, 0x10D6D },
 { 0x10EAB, 0x10EAC },
-{ 0x10EFA, 0x10EFF },
+{ 0x10ECB, 0x10ECF },
+{ 0x10EF0, 0x10EFF },
 { 0x10F46, 0x10F50 },
 { 0x10F82, 0x10F85 },
 { 0x11001, 0x11001 },
@@ -325,6 +325,7 @@ static const struct interval zero_width[] = {
 { 0x11D90, 0x11D91 },
 { 0x11D95, 0x11D95 },
 { 0x11D97, 0x11D97 },
+{ 0x11DF0, 0x11DF0 },
 { 0x11EF3, 0x11EF4 },
 { 0x11F00, 0x11F01 },
 { 0x11F36, 0x11F3A },
@@ -344,11 +345,13 @@ static const struct interval zero_width[] = {
 { 0x1BCA0, 0x1BCA3 },
 { 0x1CF00, 0x1CF2D },
 { 0x1CF30, 0x1CF46 },
+{ 0x1D127, 0x1D128 },
 { 0x1D167, 0x1D169 },
 { 0x1D173, 0x1D182 },
 { 0x1D185, 0x1D18B },
 { 0x1D1AA, 0x1D1AD },
 { 0x1D242, 0x1D244 },
+{ 0x1D25B, 0x1D25C },
 { 0x1DA00, 0x1DA36 },
 { 0x1DA3B, 0x1DA6C },
 { 0x1DA75, 0x1DA75 },
@@ -438,17 +441,19 @@ static const struct interval double_width[] = {
 { 0xFFE0, 0xFFE6 },
 { 0x16FE0, 0x16FE4 },
 { 0x16FF0, 0x16FF6 },
-{ 0x17000, 0x18CD5 },
-{ 0x18CFF, 0x18D1E },
+{ 0x17000, 0x18CDA },
+{ 0x18CFF, 0x18D20 },
 { 0x18D80, 0x18DF2 },
+{ 0x18E00, 0x19191 },
+{ 0x191A0, 0x191D2 },
 { 0x1AFF0, 0x1AFF3 },
 { 0x1AFF5, 0x1AFFB },
 { 0x1AFFD, 0x1AFFE },
-{ 0x1B000, 0x1B122 },
+{ 0x1B000, 0x1B128 },
 { 0x1B132, 0x1B132 },
 { 0x1B150, 0x1B152 },
 { 0x1B155, 0x1B155 },
-{ 0x1B164, 0x1B167 },
+{ 0x1B164, 0x1B168 },
 { 0x1B170, 0x1B2FB },
 { 0x1D300, 0x1D356 },
 { 0x1D360, 0x1D376 },
@@ -456,6 +461,7 @@ static const struct interval double_width[] = {
 { 0x1F0CF, 0x1F0CF },
 { 0x1F18E, 0x1F18E },
 { 0x1F191, 0x1F19A },
+{ 0x1F1AE, 0x1F1AE },
 { 0x1F200, 0x1F202 },
 { 0x1F210, 0x1F23B },
 { 0x1F240, 0x1F248 },
@@ -482,22 +488,22 @@ static const struct interval double_width[] = {
 { 0x1F680, 0x1F6C5 },
 { 0x1F6CC, 0x1F6CC },
 { 0x1F6D0, 0x1F6D2 },
-{ 0x1F6D5, 0x1F6D8 },
+{ 0x1F6D5, 0x1F6D9 },
 { 0x1F6DC, 0x1F6DF },
 { 0x1F6EB, 0x1F6EC },
 { 0x1F6F4, 0x1F6FC },
+{ 0x1F7DA, 0x1F7DA },
 { 0x1F7E0, 0x1F7EB },
 { 0x1F7F0, 0x1F7F0 },
 { 0x1F90C, 0x1F93A },
 { 0x1F93C, 0x1F945 },
 { 0x1F947, 0x1F9FF },
 { 0x1FA70, 0x1FA7C },
-{ 0x1FA80, 0x1FA8A },
-{ 0x1FA8E, 0x1FAC6 },
+{ 0x1FA80, 0x1FAC6 },
 { 0x1FAC8, 0x1FAC8 },
-{ 0x1FACD, 0x1FADC },
-{ 0x1FADF, 0x1FAEA },
-{ 0x1FAEF, 0x1FAF8 },
+{ 0x1FACC, 0x1FADD },
+{ 0x1FADF, 0x1FAEB },
+{ 0x1FAEF, 0x1FAFA },
 { 0x20000, 0x2FFFD },
 { 0x30000, 0x3FFFD }
 };
-- 
2.53.0

