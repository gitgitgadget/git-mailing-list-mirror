Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994330;
	b=TV9rshbrL0HgsK3/tkIaLUah1/dvvJewB32mjXegkQgSogvxo/AeabjFpHQvIH776DJQ
	 r83KTJi0Yp+3eeVA+KMGLhEd6oJ8idtWBP0CF+F8vIwAxp8su0Gt9Obt/YEqKfaTzoy+W
	 Zh6TSWR708Nch48AX0GCnNFldXPTq3qCnF10VFElu6+1AyJuOZVEYyJyoRH408WooiK1U
	 0CEzwyWopB/l0OOsd9bhdZ6ANr6iFPqJ56gPFcvp4GcoahqOfpY6Mrg5WmK24zN8Ki20D
	 1UwsKQfTGyp4eGHafWkmgtvRIzeuFEkO/7M0lFqhrJmvXBE+uuEKA2mQcTKLH88RuFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994330;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=DVcSKpGZSHUgAbq8rzehaHy5B7vJjSTT2mp3iqj+Gig=;
	b=h/zL4Py+MsiV9Gay9ZAX6RIUPwuqxK5lZvseyoS7f/eMlXFy3fb0h5+98JoeNZAa2Nfk
	 Z0t7b8CZCddYuqJ4HQWNbc0L8i/0WKBThVvB0dkPL6L8/yEgm7WMThW5JmSsK7mUrQMdx
	 83Sj1LgLUUyUtB+Y6NALhMFreAILBVGeFo8uZiNh88YlhjoDsmrL+SbOZdaloL8CuXlsh
	 wOqUZk9dDde53Mapfpg3t9PNWJsOXuOro0UMj9BYIzq3WhMzKI3eyJ/PtnMSV3mikXugP
	 38xMZ2jTcuYsqd9mNGAQLUBnk+fLiKRnRfBrBJiSwW7slI4IceEdFFJTcZWPVE8+inw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=HBoR+c35;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5F69KIDA;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4924606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4924606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=HBoR+c35;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5F69KIDA
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DC1E14000F1
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 04:32:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 18 Nov 2026 04:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1794994329; x=1795080729; bh=DVcSKpGZSH
	UgAbq8rzehaHy5B7vJjSTT2mp3iqj+Gig=; b=HBoR+c35B7Lje3aMyXa7UBSddT
	l5KUtRm/QV9v/7/omJQhQenr4w0YivQCrWmHdWvs7tXdHoh/IvmWozRhMRAVN3qs
	exMP7lQr+aQcCP3lEY2K8QHXEo4xGgUR825aW5wPKhhmCFZ4/D2OgM/bvbsIzp9p
	P7sYp97jd3fwdZxv4ZgTvdFD6w3N4u+nUEMN7Jr9jkW5kc9WbithWUgD6AQNuWd8
	sGX2k3Y5qg54B0hMCsQ8lABvR5wp8anQb4ThKX5ZJaOSNq6nUsI65w63lk7QyeAJ
	yFCWO/QxG/j6GjCxqlxOBwrmcp5AK9mFcsOXMlo8y8jrtw68LmtlP5ry9XYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794994329; x=1795080729; bh=DVcSKpGZSHUgAbq8rzehaHy5B7vJ
	jSTT2mp3iqj+Gig=; b=5F69KIDA1MKgnrt7Q45HIYvONW8nwxWg823+k4DeGQ8t
	BklnU5JrZt91kKYtWEvj4DeOrOMgxSbbcwE0Sh8UGssLCgG9CVHa2uaCeB/TLsNO
	h6JuxxZfKs0ryGmFt9bY+A4K5RWuj7TYgtehCmpaxOCc1XZNmcFTlAcwiIyt8Wca
	fuDUKPHjyMY4qMPVOH6qtYHbM/f9BjoVVxJ3+kIIQldnxI/dYqKtv8XxulwKjbEE
	WxokJJ87TBw8BzYm0kqsrJIXQnXDECJ5T/b02JrPgLEX7rbHui602Ge+R+HzEqXB
	vCLO/Klig7UTqRdm7JQGbw3MgGXJukoy1fO5AG13bA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794994329; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Wu1TULavId8URlOoJPLXVMcuJB8uzw2lPdjIso/huY+4IW5
	2oOZL2BnvxJ35ZCweEEmiWfvfvxHBpMnTM4lHRvvR9aubEN/Ep3Othw5jKYzvIfG
	udLPsmgG1Rr3DWlFb5QXLJ/SKG5PilQ7qBvS8gA56AjlB/l7ghHt9yg0yylZW6eL
	Az2RRRjbPOPSzcb+cIE39wvoHw9VGfcfDTGCnxTJYCDah069RrxPhV6lOm+1kXaK
	VOLVQvVek0kkHtTUklOg9nJteQg1hlhJkj2oo1TPqgEp9gbAj0GieAcLE3tATrGS
	apML6UAqafDWzpNofDoVSyuXfJkGuSHq9pzUzzg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:hYj+m1gOtEfgiWJ4LAN9b1SsA6sTlhYQCYiafGBMb88=:hVjE36u1ofFg/vclNpLSdxLJcoET0bOgrZg3JyBCnbc=;
X-ME-Sender: <xms:mHD9agNEWyaSSg8E1-nixU-qClWUvkurD5cHA3uFUQkhvGR1q6qpPQ>
    <xme:mHD9at67WkelgIyZPSkMUrAqqQeKzd3FyTLXS9AP6ZbQxcjZinpUrgAT3Bz45DtUP
    f1GaotVYjI7TM4fjpZowEQ17C6rXqzxmA9tGGQUpK3_FiJp6RCpjxw>
X-ME-Received: <xmr:mHD9as7cNRf4aZYN0qjun8G0UeX1uIolLeazkH8EsccCBVEH4bf-ww>
X-ME-Proxy-Cause: dmFkZTEAnuYqV8ad1ew3aktJZ+h3IcqhzXPxTuAEt+cG/jpG8JqNgwAZ4tvBYdSTiL3Ka/
    1dtkEpuZNZnsVZnhGX1l32iFUQLsRuJ/CRkQpJbFNMRVDtlJHG1VvT2+KzAFHQUyRqb226
    F7efvCGXCaJbqdZell3HuSW5ilVj1/TNIPHI66UgGy2Vfs73NQs2HbP/KrLO9ORVA3cBQ4
    N0Y4K2doaAhrVyYFOqW21+uV9XwEQUN4pkOxZpjNpykcfMRJlD/53rVy8sFrEnLxBYCz5r
    JV99YTt7vBJlT3dn2742BZ9FjV+YAT2mXXt0GMYliHU+bkVgxq5H50/nc4bkkX6qxEJHZV
    aGSZIa14MD1KtK94YrtK0pjtgnPtGpqFgArwqBVAgD/tsPN3p3H39lZfQ2+ZvV9P1XuweO
    /Dc0LotGSXojG1c10XJAo96Xeg3pRfm8hxWC4/LxWLwcjjjRFidcZCL3mFMdRpy8x9UGFc
    UHRJ/b8PufkmNpS8SptT4CtEHDdK3cXnAbqDans214ifUonGy8g4XNaqcLAxE0a9BpF2Fn
    2NT1OHNuwXrfC6iwEMKaLQWKG3Ph8t1X7+E/yuD8BUpX41wS3wiVKW0o66w8Sg5Ps1H5bV
    TbZdQRtwx5M29okd2C2c1QQ5zTBMWmpbK+rgd6AjQ3CErt/RgpCGz0DYYBjw
X-ME-Proxy: <xmx:mHD9at2YreCjKAtJdr_BoInqESPJfVTAwJFwt6FdQ51Ba3wwVpMtDg>
    <xmx:mXD9aoWZIdRRtV9fiQNPTZLCD8ip5NmWJIjrFoLRmn50p3Kpg7ZXIA>
    <xmx:mXD9ao7IgiA_4LjxA6Eo0PClzAVbuG_QZAMUG1KCxzgzSENMlGBUdg>
    <xmx:mXD9avIBxm11T_Wm8zvZXqxydn5DR0z4Z8RMddDc5P2T9NI4hBjSdw>
    <xmx:mXD9ao_ZXe0NgjNXxNkDSjm6y6cpk9F3oin0heJokYE8dlW7S_UKjcaw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 18 Nov 2026 04:32:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 652c1abd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 18 Nov 2026 09:32:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] Improve performance of reflog expiration
Date: Wed, 18 Nov 2026 10:30:59 +0100
Message-Id: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMWwrCMBBG4a2UeXYgU1GsWxEf0vinjpc0TKoUS
 vdu1McPDmehAlMUOjYLGd5adEwVsmkoXH0awHqppta1exE5cL4XNsTHODDmrAbOsDja06cAhtt
 J321j58RTfeSa6vz7n85/l1d/Q5i+U1rXD0QoZoCBAAAA
X-Change-ID: 20261118-pks-reflog-expire-performance-e051b93f901a
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

I recently noticed that a bunch of commands started hanging for almost a
second after they're essentially done already. As it turns out, this was
caused by auto-maintenance, which was blocking in the foreground for
~800ms.

The root cause of this is that the auto-condition of "reflog-expire"
doesn't properly evaluate reachability of reflog entries, so it instead
considered every single reflog entry to point to an unreachable commit.
Hence, all entries were evaluated against "gc.reflogExpireUnreachable"
instead of "gc.reflogExpire", and thus the auto-condition significantly
overcounts the number of entries that we'd prune. So every single run of
git-maintenance(1) ultimately ended up spawning `git reflog expire`.

This is fixed by the last patch in this series. But I was a bit
surprised that a no-op `git reflog expire` took this long, so the first
two patches optimize the reftable backend to be more efficient, too.
In my copy of "git.git":

  Benchmark 1: git maintenance run --auto (commit = master) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    853.2 ms  ±    99.9 ms     570.9 ms  …   901.9 ms
    Memory       117.5 MiB ±     0.3 MiB    117.2 MiB …   118.2 MiB

  Benchmark 2: git maintenance run --auto (commit = reftable-optimizations) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    392.3 ms  ±     2.3 ms     388.0 ms  …   396.6 ms           -54.0%  (2.2x faster)
    Memory       117.2 MiB ±     0.2 MiB    116.8 MiB …   117.4 MiB           -0.2%

  Benchmark 3: git maintenance run --auto (commit = auto-condition-optimizations) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time     18.6 ms  ±     1.1 ms      17.4 ms  …    20.9 ms           -97.8%  (45.8x faster)
    Memory        81.2 MiB ±     0.1 MiB     80.9 MiB …    81.4 MiB          -30.9%  (1.4x less)

So yeah, it's a bit more efficient now. :)

Thanks!

Patrick

---
Patrick Steinhardt (4):
      refs/reftable: don't write new table on dry-run expire
      refs/reftable: don't write new table when expire is a no-op
      builtin/maintenance: only consider `gc.reflogExpire` for "--auto"
      Documentation/config: fix typo in "maintenance.reflog-expire.auto"

 Documentation/config/maintenance.adoc |  2 +-
 builtin/gc.c                          | 33 +++++++++++++++++++++------------
 refs/reftable-backend.c               | 21 +++++++++++++++++----
 t/t0610-reftable-basics.sh            | 30 ++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 17 deletions(-)


---
base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
change-id: 20261118-pks-reflog-expire-performance-e051b93f901a

