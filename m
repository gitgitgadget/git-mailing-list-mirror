Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486510;
	b=RPDnwEXVQHHqWJrI4GTPMUotPT13JlX8ub+Ste8gDR70ljrEN6mcIK2MihC1WXQWm9OG
	 XXeyNm30hUJH5jwkM8V3vAK/VdsAic5P7Z9HtYZ1MhuENK450XA1UxvVRLyomUVX5/6aC
	 zgBBRrRelJQI9JjDp1rXitItD1byOSnedOEnsR4H8wQD9OFlYVYBN88rW16DXWDJCe9CK
	 DDIkeQBXm4mzC/P7+A6WarrbiFH9M0Vcsejy6XlK6tMchue9LbKL/HBSmEx66Ho2LueAy
	 KTGT/E4nSzqwZ8PANnx/zsSX0Fhw92+K0tkCowuuZI+OAm8ZgyrXVBGoCVrawiwuARQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486510;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=EVXPPUROEs7pTAAkbu+OkjMRwMeVaCNPad7/hcvDUc4=;
	b=LScMiI7/T6KusPOD98dTgPV8P6GXr0PLJmW0wtgDpyDKgAlbLO7X1RjITEt4+tVY2nxZ
	 eNy4AlsgIut04jO2o7NbxpiKQkL6o778DpC3nEP8RrNw7dhuXakkGTPq1zwyXHVOtYLlP
	 WM/pm8/OMgG4SEUxrIOFcKXMlUsMdJW2Rga6tijlFNNzb6WAMPugP/grs3DmimKmLpnxI
	 h4kPh5DSY720h27ZfdSQQnWP1FNtO95XBDcMs28WwLJCKH6JPp5hqUOiZ5PsiCJ+ru8T/
	 wckJ08BOaujyQKq3XG3bHwcdwupykEAlubSqgbumI1LprH/CsvlkeMGctRj445ps6qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Yfb53IAQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eIhw6aeK;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D91606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D91606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Yfb53IAQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eIhw6aeK
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F278EC00E0
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:55:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 04:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1792486509; x=1792572909; bh=EVXPPUROEs
	7pTAAkbu+OkjMRwMeVaCNPad7/hcvDUc4=; b=Yfb53IAQWYQSC3z9Xkjggi0JJ8
	lDw5PT/6ufyUwhrSEV9wHDzPZzPsYIa2YyfuUaL3+TnJRthMRdmYEE0Y2ULUCArO
	0Bvjb5hWXI0VPwYSRKaLoi+zmFlIlxKKzoKzzOpXlgVJflVsoG8EZ/sySIq9RgBE
	tyVo9gnTBjSA3q4uYCOqC1DJ7GA7b1B9q+GpUnvc2XBvf34mSjJcGVJ4gY1uA+h6
	Aq5dV+C6WSfC+BUMApjNTygvKo5vSvwj2T+UxqX8H8HlErOTSt1nHV3lFfB4um92
	FpvxNxd/lt2Mg5NS/Xrencikyt5JvO6RpC5KcMsdBpDFlKR3rujU16/hLcZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792486509; x=1792572909; bh=EVXPPUROEs7pTAAkbu+OkjMRwMeV
	aCNPad7/hcvDUc4=; b=eIhw6aeKs5zlzIg3uZKRosZYmoV6Tp/B6rnkUey7LOwF
	RF5xCFzvWjVfwfFUKJ5xMixkSbB2FQDXhJi3C7MVyYW/L4pOLXnL3qQIKsvNUXKI
	qzccnpgdmzo30cn+yrR9ltM/8138+qR5tMIPwzN/0gbe2rk/1Sx3xFJXvjfAEMdZ
	bpa0lf0FvXUYTMN01FA7pImib0Qb682fJiw2zySW3ZmxF6Ic+2pi1vjUXlLAAhZK
	XYqOWOBRmZlMcMsXG3EaY1j/bOK8CRSBN6Tzqp0QvUsmQ7id2KxizYBciV+t4i1L
	g6HxYo2JSi6m2GOjQLIyCo6qlIH5PTlTv67zyE6eew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792486509; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:tw0xxxEJGT7QCfcCZR0fFfL/QJF+NP41ILSXA2hb4Yq1RKP
	6QBvOgWbwuz0FSIDx/t2wUFd6PsabzBze0lb8b0yLUIfs3dcPsN+C63TbGb6/7Oc
	ieSjATx0Gp9xx83O27KIWJqoOSCnL4hNtj3LzZ2HqVlKMMpvwmePfDE9k9849neb
	HRgdddoeSzMHmi/Zskx53SBcwCf9ItM7bvQMNgNBCJ3RNbw4Pyaii6v6qJW5jN0D
	4r2aXvU9qOGLzDFheQ6aV7x49vFC9X5XJKPArCfzwkpDpvx9c/akiJdIrcJY/Bhk
	rCcbCkL8AEnLM0fbEzjRTp7SutgF+MJRJkwPXCg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:K0kiuRMfDTeUabKMWc9ifWjxVkhran1PfoZH8gD6TJc=:y0C/tCm0sEldqtWRdEqd4GFN/Rm+Jh/0AUJklCBB/Dg=;
X-ME-Sender: <xms:bSzXalWodx3ZX9X4wNWIcvQ2elx3txqo_WvcQMWy6fkLUIQGh8VPyA>
    <xme:bSzXasgeK5hDN5NLHjCy2bHtM9exAv3AVI7o3YobrE3yj_vrTyvt7TJqjhyWQXykd
    v_37RYjsRq7_KBNqglm_lIIbrWiax4Mpukh7I7AJTH_95PNpdeo4SE>
X-ME-Received: <xmr:bSzXanA2htSTCNdR9du_6Ct76JjSzaTljoioWbc5eRrZwQp8ZXGf3Gs9kmYzNzuSVw7lfQ>
X-ME-Proxy-Cause: dmFkZTG3OvtO8XWdmpKQDiDs0/FwbKP65hUhkLO/D65EbtH/1vGDRzmxlmSBxi4+nJ2qDl
    lvv+m/CZ6fs/nMezfYJ3qvm1POXtbkS8OfJ3DUVBUS72CE2OPDYVB8ArqZ51BlLWYVFTFa
    95DEdA1a2SOyGGBKRFVgw1Fy4TqiUYi+voQ5/fPMuOyE76m7DlTMuO3urN5HhoW+j4aG0y
    99KbQjVss/lQl4HqRl+JZg4XtdP8E0DGFEZ+kaT+7EKRkD2kxYvE2KlvLroPialhnCRv8M
    2xVom+1Z6G/ZXb/1FsAa7/R1A8sTaAznqTMwAQZhjG09vq/SU0ziXrTvRI2prh4yWRlKNv
    1p2zoc8Qku+e908JKzcyD0W/JrNXdBS2+CFjdvJPkTsPD3GBze1wHKFE4avxNazG64m0mv
    P2KWlSVsmZk4kvh69ym7369bFMURVxKe459fUX6fuLA6R4MELQgI1uozpxuVxAdRLSC6xl
    6CI523jS3Ptrbi3/fxi1HJUy98PwMfOOpSEdPTmBbNouw2GMt6if+axM9/UjhFgkv2ZcRC
    MCIp1nYwXJFQEprLOWeMzF6/vUlEXYLhkFfstewnnqKkYwkEjeRLTIqRf8DTBHXDeX3czN
    RyJ7IZKqD/FZhgF9611/T2+JtPvhyU1phj7q2NrQi2fk2wFbbmUTB/oNjtsQ
X-ME-Proxy: <xmx:bSzXatdOw8mbASxcjqLSZZsnvPB32JiURjvfGQ0i28PxfLBDxPDBuA>
    <xmx:bSzXavewViIZNrXGfoyv_L2Rhkwf62M_pt_nlFnd_RggxLM_ZLAHjA>
    <xmx:bSzXahgwRpl359GnWq91sk9huHDJsTOqqNGBmiQ077x_xE1_GB_6Tg>
    <xmx:bSzXarQTN4eZbYGy59Z-SF7wau3b85ugGvWFg0W59upkXTjLB3dR_A>
    <xmx:bSzXagkClXzUJrDHOK6pk2vO-DuXvHl8GPwVIR8PU2iBfNaL52hIiI59>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Oct 2026 04:55:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acffb1c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Oct 2026 08:55:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] odb/files: reload alternates on retry again
Date: Tue, 20 Oct 2026 10:54:51 +0200
Message-Id: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQoCMQxFrzJkbaAtMguvIi46TarR0g5NFWGYu
 xt1+R6f9zdQ7sIKp2mDzi9RadXAHyZIt1ivjELGEFyYvfNHXB+KjRbMUlixc2mRMJbBvcZhhnK
 aKTnbhgBWWTtnef8ezpc/63O5cxrfLOz7B2TlDQKDAAAA
X-Change-ID: 20261014-pks-odb-files-reload-alternates-dfc6dc010122
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

we recently noticed that we don't reload alternates anymore when an
object cannot be found. This used to be the case, but broke with
5946a564cd (odb/source: make `read_object_info()` function pluggable,
2026-03-05). And while it's a rather uncommon scenario that alternates
are getting rewritten while a Git process runs we managed to hit some
such scenarios in production systems.

In any case, this patch series fixes that. In practice, only the second
commit is really needed to restore functionality. I was a bit unhappy
about the performance impact of this change though, as fixing the logic
regressed us from 180ms when looking up 20k missing objects to 309ms. So
the last two patches do some optimizations that bring us down to 197ms.

The series is built on top of 47fdf2208c (The 7th batch, 2026-10-19)
with ps/odb-files-alternates-cleanups at f211a3f0b5 (odb/source: drop
`local` flag, 2026-10-15) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (4):
      odb/source-files: rename alternates-related functions
      odb/source-files: reload alternates on retry
      odb/source-files: avoid rechecking already-known alternates
      odb/source-files: only reload alternates when the file has changed

 odb/source-files.c  | 84 +++++++++++++++++++++++++++++++----------------------
 odb/source-files.h  |  4 +++
 t/t1006-cat-file.sh | 32 ++++++++++++++++++++
 3 files changed, 86 insertions(+), 34 deletions(-)


---
base-commit: c8e565497cff47f6b23a6b96bef6fa82afa11667
change-id: 20261014-pks-odb-files-reload-alternates-dfc6dc010122

