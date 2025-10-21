Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954532C33E
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040142; cv=none; b=hywL8QvnlyoDWDgdOo8P494UlIRvx0aifpeK4OAMzYtQA3zfZwNYLX4+VKN9c0+nLft1oRrazND3wwy3ME368i8q6pqlAFGG1duqC4/A04NLb3BD53Bk+V7p0nobWDdNKAGn07mzG1ilBGRHqwdlaIUtPgdRq84cCo4o2FtuIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040142; c=relaxed/simple;
	bh=kDEuvP1WrZy3wYDo28q5k6mRUXBDnkIhrulYdErM1WI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aGyuq50KKOwWwyOKF24GepicJnb00EMsGGnn67OJzult/Estz/VXgOT9yUJKtvstSACpxMOlC17+GxkLSV43WLhADXqIuKiFeHCyxWDpgl8GryBoeF81NzKkeDWTFbMKPE6XFptB42syMbhK0qZfMOj+gepHQJUXot9MPSkg0Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=quj5a08s; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="quj5a08s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761040132; x=1761644932; i=tboegi@web.de;
	bh=kDEuvP1WrZy3wYDo28q5k6mRUXBDnkIhrulYdErM1WI=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=quj5a08sDEI+rD6s8TWYgC7mEY1zKm9MF+9yajpBhxvjiEkIbzGZbtJ261NgSIqD
	 zuNXxxep5lhjNkZKrPnExMRoEs0qYF+dkG72Bk3K0Q5RJ6GhCJx/zVZneFYD+fXzZ
	 ffsRLc3idsA+Fjlo9MzsbqkavXwVuu7jevDpbmirGu0R5BhXd7VVKQmwZy8OBjsri
	 dkSB3XmEmsIhE/WyNGMcfatYR6VDS8a+eHRhP8ZOX5ETiQ1Y2gzBIem7KGTncwKYM
	 ybs0IXAIGM5jorGhI02rRKuN2AJb12gk2SwhxcjJC2+acLe26iZI/EpINhzsrkE6+
	 7Ff6Np7yHcxWKa6fsQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.231.143.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYclj-1ufSzY47Qh-00Im1f; Tue, 21
 Oct 2025 11:48:52 +0200
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org
Subject: [PATCH v1 1/1] unicode: update the width tables to Unicode 17
Date: Tue, 21 Oct 2025 11:48:49 +0200
Message-ID: <20251021094849.93284-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FTPb7xnLTLIpsBVrXYAEiwGjJJrCT0Oa15ZgPBgTDxdoqBUxwBI
 OPDz/lz+atcwm2SHEVhg8mDeAK/WdHSTg6ojgcYch9Kde5LcwGs+DfIDk7v71+AWfdB0ooV
 S/FijjLUH0GehO2AAe5m7eLG+wHTJwwFoIYktqKKxgwAVDtGZPHwyXC6Z7VqStW3HcsWrxT
 Q57DLa/70VOPLugSN3OLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mBRwACaLDBY=;vgESYbYBpS+fnAgjP/A0T0MO/Nq
 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
 ynC1w==

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Unicode 17 is out. Update the unicode with table.

https://blog.unicode.org/2025/09/unicode-170-release-announcement.html
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 unicode-width.h | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/unicode-width.h b/unicode-width.h
index 3ffee123a0..b701129515 100644
=2D-- a/unicode-width.h
+++ b/unicode-width.h
@@ -143,7 +143,8 @@ static const struct interval zero_width[] =3D {
 { 0x1A65, 0x1A6C },
 { 0x1A73, 0x1A7C },
 { 0x1A7F, 0x1A7F },
-{ 0x1AB0, 0x1ACE },
+{ 0x1AB0, 0x1ADD },
+{ 0x1AE0, 0x1AEB },
 { 0x1B00, 0x1B03 },
 { 0x1B34, 0x1B34 },
 { 0x1B36, 0x1B3A },
@@ -229,7 +230,7 @@ static const struct interval zero_width[] =3D {
 { 0x10D24, 0x10D27 },
 { 0x10D69, 0x10D6D },
 { 0x10EAB, 0x10EAC },
-{ 0x10EFC, 0x10EFF },
+{ 0x10EFA, 0x10EFF },
 { 0x10F46, 0x10F50 },
 { 0x10F82, 0x10F85 },
 { 0x11001, 0x11001 },
@@ -306,6 +307,9 @@ static const struct interval zero_width[] =3D {
 { 0x11A59, 0x11A5B },
 { 0x11A8A, 0x11A96 },
 { 0x11A98, 0x11A99 },
+{ 0x11B60, 0x11B60 },
+{ 0x11B62, 0x11B64 },
+{ 0x11B66, 0x11B66 },
 { 0x11C30, 0x11C36 },
 { 0x11C38, 0x11C3D },
 { 0x11C3F, 0x11C3F },
@@ -362,6 +366,10 @@ static const struct interval zero_width[] =3D {
 { 0x1E2EC, 0x1E2EF },
 { 0x1E4EC, 0x1E4EF },
 { 0x1E5EE, 0x1E5EF },
+{ 0x1E6E3, 0x1E6E3 },
+{ 0x1E6E6, 0x1E6E6 },
+{ 0x1E6EE, 0x1E6EF },
+{ 0x1E6F5, 0x1E6F5 },
 { 0x1E8D0, 0x1E8D6 },
 { 0x1E944, 0x1E94A },
 { 0xE0001, 0xE0001 },
@@ -429,10 +437,10 @@ static const struct interval double_width[] =3D {
 { 0xFF01, 0xFF60 },
 { 0xFFE0, 0xFFE6 },
 { 0x16FE0, 0x16FE4 },
-{ 0x16FF0, 0x16FF1 },
-{ 0x17000, 0x187F7 },
-{ 0x18800, 0x18CD5 },
-{ 0x18CFF, 0x18D08 },
+{ 0x16FF0, 0x16FF6 },
+{ 0x17000, 0x18CD5 },
+{ 0x18CFF, 0x18D1E },
+{ 0x18D80, 0x18DF2 },
 { 0x1AFF0, 0x1AFF3 },
 { 0x1AFF5, 0x1AFFB },
 { 0x1AFFD, 0x1AFFE },
@@ -474,7 +482,7 @@ static const struct interval double_width[] =3D {
 { 0x1F680, 0x1F6C5 },
 { 0x1F6CC, 0x1F6CC },
 { 0x1F6D0, 0x1F6D2 },
-{ 0x1F6D5, 0x1F6D7 },
+{ 0x1F6D5, 0x1F6D8 },
 { 0x1F6DC, 0x1F6DF },
 { 0x1F6EB, 0x1F6EC },
 { 0x1F6F4, 0x1F6FC },
@@ -484,11 +492,12 @@ static const struct interval double_width[] =3D {
 { 0x1F93C, 0x1F945 },
 { 0x1F947, 0x1F9FF },
 { 0x1FA70, 0x1FA7C },
-{ 0x1FA80, 0x1FA89 },
-{ 0x1FA8F, 0x1FAC6 },
-{ 0x1FACE, 0x1FADC },
-{ 0x1FADF, 0x1FAE9 },
-{ 0x1FAF0, 0x1FAF8 },
+{ 0x1FA80, 0x1FA8A },
+{ 0x1FA8E, 0x1FAC6 },
+{ 0x1FAC8, 0x1FAC8 },
+{ 0x1FACD, 0x1FADC },
+{ 0x1FADF, 0x1FAEA },
+{ 0x1FAEF, 0x1FAF8 },
 { 0x20000, 0x2FFFD },
 { 0x30000, 0x3FFFD }
 };
=2D-=20
2.50.0.rc0.46.g7014b55638

