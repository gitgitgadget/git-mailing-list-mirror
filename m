Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735533;
	b=XxDI8YRdAvicc17CGHZMBC7KO5f8aasVKrpctHy3EJ7rSwozU+ifzVMp2PabPF41lCK8
	 IfZ6WRDXbWUz6II36gu2afOqfMMafU+B4zxWXGQFximz9AeLOg5FXHs628pK77+E1i2DB
	 YW1sWnR6y52G6ibuhFc6cEe1T5Y8HUMWferaLjtF49ZoXBjF9eZ0gaBWw9Ettmfw+ICfz
	 A66gxD7kQ6mK353dGGiJiwyPhslv5X5lqOk92N8jmXD9EnoRDEFuOrvMqDn81ZSgzKFEf
	 O2EnZAmLS0uDwo9SxvpuYNBNJAD1rBBEzNI6F6/tsIQQEAqvddN0O3s9NolXvDu7olQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735533;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=rGP9Ia8lsECWDDpDMvuP3pQwZJRGjN2U/0ZeuR/riEc=;
	b=Rzfkgobt/cC5nMhvKWZ+PdeCQBKcKklvXvu4KV6CfXEySnr9Blz7OUpoTEkiqds0xY6I
	 znbzE0bt+reAMh5/VxfYlULaAU8uG+LvbqMMxs5FghvNO7vqoXkcD8FaeqyhU2Gvi/fz1
	 ai9z71lzH7T3VfxCqmLj1/K08+vtnTj9QhU9ki8voFCShj/UbkraC7rI/2gPHcZYisF0n
	 NFLtCCmdgxgbsbabiFkk15HCD1K7fCmVCVXdDCQwlsLyL2jzutAJ60c4r9s3jh+ZlUEnG
	 GRhLiFFcWfdRJc20I3bbNExQcYpHKeKWDG81Z9WPivXBUGBsnuMNlBhpnEGl0KJ8+Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=c26swZyo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cANkZIcj;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB5606A336
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6CB5606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=c26swZyo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cANkZIcj
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F2EE5EC06EA
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:52:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 14:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1793735531; x=1793821931; bh=rGP9Ia8lsECWDDpDMvuP3pQwZJRGjN2U
	/0ZeuR/riEc=; b=c26swZyosdtg5CmzrcCQ2Rrb59D/vLIu+umrvaOY3E0TbbI8
	HajNSpxTbSSjvdPJ33bYxq88TNQDIlzbKe/lxVPsBM4gdav4Oqg2Td5fwsLkTrn1
	xtS5ffdgiBp7Xpa7U/xLi5ZOjxPpnd7WzZ5LY1Y/m7g6B1kH61S+focF9gbMAEOY
	xsxLG4ivlqCnXHOBS80d6OuQHiqvKM+gziAtsVSfX9Ln5N+hz3kSA3Smy48yuyBk
	l/uKP3pNav0cznkWMtia7kDW+Oz6hWGLOmYAOxQlzYthSItzS4TEwSgs2rdeZf/A
	7s0HK/rt/6LsRLpFaTrDGuqrzwkR0Fj/o6foRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793735531; x=
	1793821931; bh=rGP9Ia8lsECWDDpDMvuP3pQwZJRGjN2U/0ZeuR/riEc=; b=c
	ANkZIcjdwCPSdVhFE0fJP9mufe00CJRoUrcw82TsXKaA0BSZ0/7D8P1etlA4TQBJ
	HeNcJcuWZiL8wEaC8QwAqH9njh7pSKEKm2UFG1XXFYV7UEKt5hyO6d+n6kdOB7Hn
	kNX7+KjmdPs959eth1IruJXb/cs6rrJev/K7rBT1ts5kdf8CQoudzIf6gESN9RIX
	hGy937/hcGxTdd5Us1UPTXXdpYreWB0V3QocQNS+ppMh3ehGvRyPgoU5foPnTild
	NC05DRiKBlGih7Lybv4iJ4Vu8hIhqT7fAAJzRArEyrb/RFDMoc2rgB05QES4qu/P
	EGLlu26TfoPldmpKph5vQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793735531; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VU9VWXxChsH5tq2QMVgxTRwMjpUnZo6mwUTkuNtdBE6Sxik
	Yd0kR8pFKfzk+Ilml1gAPIRtSWx2L1c0fvWTDn0xvYFCYYvl773modHoDzeGZbnG
	h7CmMNgkqJFQ8p6hvnfRlBCIA4kwqgvyGmqHdv3gMyV+24CozXqlg1YUnf7ox8sp
	/4NJR7TihoW0SQRiB1y+KS7zfPdp9VQr1aqzWru1K2IyJ3eMJNz4OS1I/lmfeCIs
	kjGAZqr8LdrL7x4bS0wcB4Pfb8lgcGWMmr5lecI774z9Frt3GSUguoiyTL/gIuLb
	9LMfnZiTbGv7Dp8lAzWxhB0tjejlMrPmNAhKjgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-type,date,feedback-id,from,message-id,
	mime-version,subject,to,user-agent;
Message-Instance: m=1; h=sha256:FbVVtIGe80PU8/LfzIH+bhzMu/s56rPapHG0dpE3mCE=:toiZ84SJdYjNTvhUrJWJc0l8FSl5cgdeyOCSjDC4gbk=;
X-ME-Sender: <xms:azvqar0xyG3myCP7Dbn0TpG87lTWBdhLWYkyJurqn2xhmRCiZXOFuA>
    <xme:azvqahjz-gxGuqoWn9ckrxGz2Mtidfjt8c4oC2d2yn4cKCwG3uClt8mEwTLzkQtDA
    F0DAJ5hIJ5vIQ7rPG1M64Te-HepwwX4B26xDpOmUfL06KPKbtpGngs>
X-ME-Received: <xmr:azvqapQZ3xt__7K-ONFj9PLZtneRyw2zc8olDSzV37cOwOTPrCTaondyryxzzMsw28S5obsdnP4DmjF4IGtink3kGtA7P9Otl1az>
X-ME-Proxy-Cause: dmFkZTF5i13OU3ERevPMe6xwGVz39B+QQpNXzyAUnDUFEC3kTy3zW1S8ZbE7uelvZVdcMo
    3A0ji9AaI0GTSNawqEaVwOYoWtgr5rsGzU11MiPBOOXUbfJ/zBLtWJNc2G/BoJ2OOYCC5d
    1fm3FDmrIjunXzaur3MtF5SpdpTpwutHBYQYBpX5TA/wdb5UHX2J8HHxRVWv3AQxO4Bjd5
    dv8Yytqrmopa1Rowt+zFqpXJHdu2kCdOfUAjLzvrCCbHGE8cPROOiiBWO3Av/W8UviWlIe
    5kQOmhu4AxK7Lx2K5hP+3V8/F0OYg5fXMc8thQ7yHG80KY+Cj565FH5gE6CMra0X3k9eHs
    fDjkdsCO7Q1CAumbgtsMRE1ZVIER976560zkAJRcunxfSS7JkxNhCOWqloW+FRiGPMCr4t
    vQfYfsF0q0TvDIQA9Cp+AeamLPuxEyHlE09kE7VLzRe4FgVHdWFGCpvYFu94koVKX5DJQw
    FUBCR6WnhzaaI+kmo4YMOPEAdSBmxZJhetrl2PmQIznNGnaTToqqyd0qql59TicRBkaQ4x
    U2Ee7Bu6ASYLLBtMGcMxVaoRh832DxRRgM/+hRS+gPBnrtjbuwVk3APUVGOQu8gseCyEZp
    5vrBOpZAR3h94CANY12GFyvZlTRWdlrPHzhA3FSNTVD4kNyoGdWaQXjUe58Q
X-ME-Proxy: <xmx:azvqaqhfMySRvBAsQ6edmFcHBhUsvots2skPCD6ZhecS1Z-jTGGL3Q>
    <xmx:azvqah4mEtvMCHLjiaWpJmQHW_jtdr7Gxh5Bf-qM8XtYWutcZcamAw>
    <xmx:azvqavCvMsfc9KQ14pRtGZuM_t4Huc8GafO7kXVD0yl1td_WvLSvEg>
    <xmx:azvqagaTuRlaKlFHxL8DD2OdS3iuaqtcNtN9vp5gKDuvEp2mT9bBrA>
    <xmx:azvqahrN5cbt7ELaq_5SQeQifgMNDk0RkmODJgvWxEtX51_2K1fdIuY4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 14:52:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] repo_config_values: freeze the structure for now
Date: Tue, 03 Nov 2026 11:52:10 -0800
Message-ID: <xmqq1p917kwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

The configuration and settings per repository is currently in an
unfortunate mess.  Especially given that repo_config_values() cannot
work on any repository instance other than the_repository, moving
more members into this structure is unwelcome.

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just for wider visibility.  This is a resend of the patch in
   https://lore.kernel.org/git/xmqqh5hzjdwr.fsf_-_@gitster.g/

 environment.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/environment.h b/environment.h
index 49c86e8879..87b0ab7251 100644
--- a/environment.h
+++ b/environment.h
@@ -123,6 +123,13 @@ enum object_creation_mode {
 	OBJECT_CREATION_USES_RENAMES = 1
 };
 
+/*
+ * See https://lore.kernel.org/git/anlmwaEtwcCPse1N@pks.im/ and later
+ * discussions.  Until we figure out what to do with this and
+ * repo_settings, and allow them to be truly usable on a repository
+ * instance that is not the_repository, do *NOT* add any new members
+ * to this structure.
+ */
 struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
-- 
2.56.0-511-g14903f623d

