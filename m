Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27265494A1E
	for <git@vger.kernel.org>; Tue, 12 May 2026 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574644; cv=none; b=Wfw3yTB5ueTPSzwohvP63Y34X5/AODuMOFsNtfUovx1f64l5mTzqgJpEyAPxihHG0rcVyzAHk2igm74nUC7Ia05mJ2RBj41B90BKVTz4Vkq497vyBq6TcSDvBz6omh447SMuYe7bxilMNgQqLY+ryrLLxQMb1qsQ4WvFfReWd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574644; c=relaxed/simple;
	bh=yXAOAumBwtfer8SzKXNqzclQQog/B83nF5zbsBjyJ0I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=MpcnNynypaxQC44ZnYZejAqYisA9hmbu5d8xmKYpvyMhLkZO17NzDUI0Eje3yiHTICBo9eWqIZ0IYWnIb5BgmvWCb9BAdOgH8jwxZBcZhIOHHOc10BppPpsCQRJv44S56Q1zAdBSmnu6ZG61m3hGk7DCgilgEcO/1+G2p2b2VN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E+30H0hz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kYSJogI+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E+30H0hz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kYSJogI+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E1867EC020B;
	Tue, 12 May 2026 04:30:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 12 May 2026 04:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778574639;
	 x=1778661039; bh=MYP+7Rhu/kP3zJ7hczuyMzs4QsaSUThwzIXtHvxJDj4=; b=
	E+30H0hzSZplcmXGyH6SIP/zmzIQtFHtqbHshelg71H7PYQCEwoiUdnxr0GzMNw0
	tsesdEXHz4aL7jTmxmcUz7pvI1G1tDgwtPtapAJ+EQWPIEwT3X9sLDb9a2AWQMoa
	F8FZRqGv958wqWBY1MOKimYW00+byzHaFD6G5VKxpc7kkgvEaoNDQ5f31+7AUSFH
	pudfVtk7KeXlf7+q5Bt2ec1pgvQXOIOgu/ZuOwi15dIrj7clGepPNUjtZDqD7k0G
	4F3uMZglabxN8OjxyI01LQ8gIi+v9WAPFahrD8D6OTh7dkDlubZlMVJ4eVbWa6jr
	Iyup2rzlQVCsYA4tOVhkGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778574639; x=
	1778661039; bh=MYP+7Rhu/kP3zJ7hczuyMzs4QsaSUThwzIXtHvxJDj4=; b=k
	YSJogI+y5VFh35XSSI3E5NPIlYqMhlhfL74EH3cxw7KzkxJAYPsiCmeCGhsU92x/
	Oo8Hn7mgIHenRjZaW6vc4+liVetJptlBMC8bT+UeXev/FPRTmfKDX6e8LTbheP88
	BoxlpkqWvJHRbCjMjtOfFKI4+fgNQFmyYStA+WmKU5G1Zn3Snx8NtPzdOErfcmqo
	e6EeNoVz+f7vJMSjeyRXeX0O1mz3kFcJ4sUwV1VYSNY05tx25opFnnj34/ltBq1q
	LCVEVDsHBHd+48/uIN9zEmdt47UJFKN0aJ5NprQ53NL5TNjFetoZ8IbkCcdCHG0t
	0gl2MoHisXfTxms6XKavw==
X-ME-Sender: <xms:L-UCass0PkX3XszC-g3_mwyQHwmpCfPGNgwfc02B_MDu7m7wdqqxjg>
    <xme:L-UCarvg3BLVcLS6d7htEkRjhyezZ8Tcc3v74YA3R_nt6ASbX46HbVk01f8bB_JL0
    CbVZ0LDMJuwYUGOpnVOmv0f3uUVbWccYvsoU_lqhegjyAn0909h>
X-ME-Received: <xmr:L-UCaqCNm7t3jZcWyCBpw0KrFPFIcJ1NcHqEbWyrCHNX3ptup577z4t8Pwosxk4xNwERh2r-rtP8Pop6tRFqmz_dkK4ILc2uogxvVD4fRdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvffekkedtfeelteevgeeuteehtdefueeggedvvdfhvddtteeiieeukeehgfefheen
    ucffohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    rggtthhiohhnmhihshhtihhquhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhgrtghhuhesghhmrghilhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:L-UCalN7qIBgIo-BMocioWfphs-mD1R-nLzA77YzkJ9A4SpzvoWD9g>
    <xmx:L-UCarzowRhlj-m0iRc7uUA-PGNk53LPv4kHuPaL0XtN5bKZZve6sw>
    <xmx:L-UCatVfRqnU0CSwDeLJ6js5dzLfwd_8v-ovMPl9uIE6ArsS8NicIg>
    <xmx:L-UCalOHRs-rlUIk-V1KEtSTbEdPeWwKolgXXJdcqps4T-S06x3xkQ>
    <xmx:L-UCartoWE_VYn8thyHE3c_Vgia-6JVXJPJ8gcg2EB75o8hlhiarlHnJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 04:30:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 001c6930 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 May 2026 08:30:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] builtin/maintenance: fix locking and respect
 "gc.auto"
Date: Tue, 12 May 2026 10:30:29 +0200
Message-Id: <20260512-pks-maintenance-fix-lock-with-detach-v2-0-dc6f2d284b6d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACblAmoC/5WOTQ6CMBBGr0K6dkxptIor72FYlOloR6SQtqKGc
 HcLnsDlS973M4lIgSmKUzGJQCNH7n0GtSkEOuNvBGwzCyWVlvuyhKGN0Bn2ibzxSHDlNzx6bOH
 FyYGlZNCB0fJIVaONpUbkqiFQ9taZS/3j+GzuhGnpXgzHMfXhs/4Yy8X7c3IsQQKiPVitsDI7e
 c6xLXeinuf5C7niKxrnAAAA
X-Change-ID: 20260511-pks-maintenance-fix-lock-with-detach-a608e9b6adeb
In-Reply-To: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
To: git@vger.kernel.org
Cc: Jean-Christophe Manciot <actionmystique@gmail.com>, 
 Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this patch series addresses the issues reported in [1]. The series is
built on top of Git 2.54.0.

Changes in v2:
  - Clarify comment when dropping ownership of the lock in the parent
    process.
  - Properly treat "gc.auto" as an integer, not a boolean.
  - Link to v1: https://patch.msgid.link/20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im

Thanks!

Patrick

[1]: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>

---
Patrick Steinhardt (2):
      builtin/maintenance: fix locking with "--detach"
      run-command: honor "gc.auto" for auto-maintenance

 builtin/gc.c           | 27 ++++++++++++++--
 lockfile.c             |  9 ++++++
 lockfile.h             | 10 ++++++
 run-command.c          | 10 ++++--
 setup.c                | 31 +++++++++++++------
 setup.h                |  1 +
 t/t7900-maintenance.sh | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 157 insertions(+), 14 deletions(-)

Range-diff versus v1:

1:  d0609c03b4 ! 1:  8dda16ec8d builtin/maintenance: fix locking with "--detach"
    @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts
     +			lock_file_reassign_owner(&lk, getpid());
     +		} else if (child_pid > 0) {
     +			/*
    -+			 * We're in the parent process, so we assign ownership
    -+			 * of the lockfile to the child and then exit immediately.
    ++			 * We're in the parent process, so we drop ownership of
    ++			 * the lockfile to prevent us from removing it upon
    ++			 * exit.
     +			 */
     +			lock_file_reassign_owner(&lk, child_pid);
     +			exit(0);
2:  959ce46f7d < -:  ---------- run-command: honor "gc.auto" for auto-maintenance
-:  ---------- > 2:  d5507b5dd2 run-command: honor "gc.auto" for auto-maintenance

---
base-commit: 13ef77ce6e222bef3ab145642e6ef1486075211c
change-id: 20260511-pks-maintenance-fix-lock-with-detach-a608e9b6adeb

