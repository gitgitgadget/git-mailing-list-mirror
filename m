Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ECE3750B9
	for <git@vger.kernel.org>; Wed, 20 May 2026 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258537; cv=none; b=hoc38f+W2UVUS1CBCqOD+B0rMlNgVBcKN6k65RaBHZ3vnCtuYTo0NiNarkC4WiFbeTcYKExupxlkhcauRRRvBqP9DhJbcRG1f9c1Vkfaa38ruO4PIXZh+y8Pa7J14caZSXGgX1bqZleQ5cxZrZL2kI5tOyAf0TekzafluVelM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258537; c=relaxed/simple;
	bh=Q9Ok2gATg2KCErXDQvdSuTRMnH+Unvzb/Mv63IM799w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b5k3ErTbh/0h5CIw3vmOCSwTFDhsWGFd9E0bm3+3SDdpmRou8zrCraO5Xft0lg/1je4NRUtIgJl4YIC0A9QVrDE+MWPuSJ9mvE3uC/PAgAL73xo3UuyQd2ALuHKWy3VHLOBN9SaJAJjAjuQZlcyXlrZvYLToBn9gwBMl/AuLy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pu6vXZcY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gwJGy0Hv; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pu6vXZcY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gwJGy0Hv"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 369821D000B4;
	Wed, 20 May 2026 02:28:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 20 May 2026 02:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1779258534; x=1779344934; bh=UfIb00wD1cNWnj4FiG5BpJQsIkuu+s+t
	7R0uNTTfteI=; b=Pu6vXZcYdWJlsRqrbgsOBiCBLYy/KXH/vrx9ssEX6xZyjOhr
	4Uj0CqEdyxiPHKsfTcdnRS08En6IwJJnSXClMBW0LH8TkS5xNysSrX4z+Jx1SawJ
	z75NzVBqRkvO+A10dE9VnCmte1Ahv4u1dfDNVeyH3AZpVQQDo6j6mnL9JiF3+FRj
	MjDHngoxeZzYmM+A3L33U342qEKqSZLjO1iDT//DplycU0B5AY8vD+w/I3Htgo6C
	8eqdmPVNZBbt+Bv5RhB5HJZoBue8g1Vgi48pXc8Wxobvjmfb7P1RM1fxwA3iv6lo
	AnZ4JkgzOJFtddOF+Qh7rWhM1sSFs2lsVuhqHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779258534; x=
	1779344934; bh=UfIb00wD1cNWnj4FiG5BpJQsIkuu+s+t7R0uNTTfteI=; b=g
	wJGy0Hv6fuCDUsrqwmkgFWXB1ovyXT2sJe3lwRMF6FQ4YISVBT4Wpvjvxn4apAfo
	l8dLRklDqYdp2QBOIT/BGSDUuItmA5TJLsm27sG/TMYP1PyX9xY2Fbuw0sfPM2/6
	zVHiIqLjz141C8qWMSqEcsHaRwefziM+o0n2MM+Vj54tQ3ynApn3lc+Ks5Lu+qby
	dtDYTfuVmatJuhJNHWoeN+nzD+nWugN22sjHBG5IEiJo7mPO4lSVxu6Rzv4RMzRp
	lSLiyhRUg2FaTXNz7j8duvupD7H/YZD6Mh8RgOq3k4NIXAF2gK9DiDyFDRVWcUbQ
	nx6xi1IFHX6ZRIwetpRew==
X-ME-Sender: <xms:plQNaje2R3NtqPUZmDCXzBAI8e0mUOEkQfiMhmey9WurH_p9V7Iz6g>
    <xme:plQNavOehQg_6W8g2N0-V4ur4DskvI3T1HLeaOZql5vOZrVLjtsz2p5OG8xcmnRdy
    wNn83Iq4Nchz7DxaP1uoXJisGMkBlDUhzOZZkAkmB33-PcTNT3lPw>
X-ME-Received: <xmr:plQNaqL1_yPLP8m_BhNTBNs1euXvKGglnYsybik53DgjzqyjqtQxC9ewI9wEbd4-zKlEgwqHWO8ecIRR2dOc4TPhEvvHcxnntQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:plQNagFr3V9OBnpy9u7Vi8RMa521CEGbCI3cX5RMwUkA_Ph-jJDxJg>
    <xmx:plQNaiTzGyyA2rvU4obI4s8YNtQVaOJ5tQsvJH0Zfeo2E-leBSwu9A>
    <xmx:plQNasHJIN9qPcU6VPgstek-bB5dsyIznbgmf8Gx8dfwRjb-YIldHw>
    <xmx:plQNau__ua1bqg9UZSjGdD03wbiVO1szxGmacLyEGwcI4snhx61UKg>
    <xmx:plQNau0rn24iPbqZYhfI_4We1YzpxAspePilHJmnAu0wZ8p8dhJQf4ct>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 02:28:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] apply: plug strbuf leak
Date: Wed, 20 May 2026 15:28:53 +0900
Message-ID: <xmqq33zm4msa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Depending on how read_patch_file() fails, it may already have read
many bytes into the supplied strbuf.  Either the caller or the callee
should release the strbuf.

Here we choose to make the sole caller of the function responsible
for releasing it, as it makes the error handling slightly simpler.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 4aa1694cfa..0167902325 100644
--- a/apply.c
+++ b/apply.c
@@ -4881,8 +4881,10 @@ static int apply_patch(struct apply_state *state,
 
 	state->patch_input_file = filename;
 	state->linenr = 1;
-	if (read_patch_file(&buf, fd) < 0)
+	if (read_patch_file(&buf, fd) < 0) {
+		strbuf_release(&buf);
 		return -128;
+	}
 	offset = 0;
 	while (offset < buf.len) {
 		struct patch *patch;
-- 
2.54.0-398-ga4b2d32071

