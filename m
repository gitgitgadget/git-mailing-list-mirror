Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311406;
	b=vNZGTxafHrv+tnJrTnvPGJ+izmnkajbzvvaLFIdrSFtLHcTVFwtsIWa9+UZQ5pq8MEqE
	 KcllY435czj6NrdVtYWdczcUufN1WDRJxqsNqf2xArWK6PzPZuYrd9huoKBzR/7e9vOyn
	 p+s14gzWA+ZzbT9Qj/u0GB8kq4YK9v/sw0JleIGJ20Vh6Nwp6X8qu0gC4s49AC8Z4YF+M
	 xDGF+OgLZkk/5A14Z2lPwWSq1OhhLM/rWosepncxQNsxu6hnlHhZfT88g8DsRH7225+QD
	 FqZK5TZfzIIjlJrcNO17EtpeCUf+8Vv7dPvcYQadf5SlyZn3f4fdQr9lvzSLOZL/HXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=k42GiNdl/SqqRdQqNll2uzYVhjByZWB0TpLCFReW46Y=;
	b=n4tvbaEav+w/FVsKteluj4c2Pf9baqeooHEym2YpMBZcFuqDePN/MDnb9cswpj92Af6O
	 Jup9w3ZdkOO16ABQrMoalys+3LcMKJu8WNxYW5jsBlI/gg+8VnuryeYf2Cc/wcDB8dt00
	 6hztuzM5mbJgkm8WRnnq8JBkuGRgEgIMXsxg2/x0MxicALFgygtW1HjYsJ08j+/b4FPZr
	 8PzH6fwpqmE+FLMmZAbYzGJLIWIP6xP5SC6haB6cZv6A/pwFD4VGFYqCGkaBKfh/or9sk
	 plIr8BqTv3OngUm4jXFFNjzrmph0EDsbmtOu1Fo9j28Id+rhiQRwAnkXN7LS0t4jEHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x9zQbsfq;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8B60A2626
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E8B60A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x9zQbsfq
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a215e64962so21922385e9.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311404; x=1794916204; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k42GiNdl/SqqRdQqNll2uzYVhjByZWB0TpLCFReW46Y=;
        b=x9zQbsfqHK+smN042A0wP3HkUOZHs+7/CEihOj7CcF1hIP4TEJy8TV3GCGapY837J3
         B/Hrrxi0Rys1gJQQ7lF2y1WdARQEV6TJsCPFpzNeygMNY7k03mSx900b4nJ0vmLjXPAr
         AErGBAOBK82hLCLAY9EGuowZubYxSXJmXmKs2jGMJVLRFMFrC5O9HDHSR2bh62CmQAiu
         BBLDPQv2Nzrsj8K1Mg3Vcs1b7c//MnbDqSUh0wSkekJkTaNSqz2YhA5xdZHxo/WZCnWg
         44Y3/Il6xROOwI8fh90kWCG2wZ1Jg3+5SqbdL58IEG3r0F0o7zQPtHoK9DyOVVQyg64d
         9/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311404; x=1794916204;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k42GiNdl/SqqRdQqNll2uzYVhjByZWB0TpLCFReW46Y=;
        b=CpkjcRFoX/NtJ2My79KvBmYU2fTlTBKH2whupVVX5i8EtbG8SQ/HNoFUgBYWQVD3UX
         a0SZ49uOeD2Ygqfsnmory/Zmj54VGyhUemsSrpH+O25E4m73dlBbhC4P9PEvPKiT+UUv
         s9yB+nic0zh232ykzeY67lXv9Cv+ZBeScul2AYXy/uQcXo8XdrNYhCYUAasIiinJRRrF
         3WinLpb0COpE3IdxkcF7MWkYCzF8Yv1z7AHPAtZq7cwIG5FrZBxmuGW/fXOnExvACG/k
         A6uyLl9j0d7ZGCshyb/5lIOfe5SJ6mzBbiYoJT0J9vwWFqHjl/rGThnpReTwWd/jEwgZ
         u/DA==
X-Gm-Message-State: APuU4Z9wy/Pgu8DiCrwH1cEa3vJ1hZQnc8P8zid4ZL80IZR81/QzheCJ
	iYh9mblUmWjKs6A8kupaHD7+txUGEy36dm1RgyJhpAO/0eloHqd6XzkmzlHyYA==
X-Gm-Gg: AYBFou3IiDjzCMtFF0KtGxaYFBHq40ud07SYJg6O7WaIo6NegTq6nqaymMOJoIyYrPP
	dUbUwi+RicEoNSI5+FOJJ6zHcZYU7aZI5tpuupPe6WOSBWwUWoPPLRe+PhE2b50xxcPlqu/sESq
	fjeYSdr94OP34Bcz2+MZrg5koRrK5sozCT6ypYFRpSwZSGA4Si5enfOthnm8PG0yjlm+GzF2j9k
	pdKhvyJARB/PYA5DkyuhSyPVSXm65/+FzHUcj4q1w9jESSicwUY1A6y2JGYEXBm6IUoot/oGFDJ
	QqLa1GxflpLp+R1+atbrgCSuW3suWBORz4I/9sP8x51Cm6UEPKmwJ/5WyAF7cvWj8talMWVkjFD
	cbUVbgkV01j2cj5KDcImcVtYRgABTHlbT0AWs4XmbpY1oqZawzksVQrEQrhyTI4K5wFgLIYs1Ms
	2Cj95kJtmP+Divh8JMS6TQX/csEXPU//0T7zL/FFllcRLAVArr2NUZesAHz6/J2yKetvuU3Y3ll
	393AeIWiltDZBoZ5k9iFOi7KpDtmmwSw5/3KQd6YoXSehF+sMAvFUou9jL1g2e/AhQC9d9d8sOv
	Mb3N+p2pYzePs3P8w8tzahTfwOXNJucm1kzgk9ZszJ2MlHJzuxNHYRNr/BlhWkrd1t4Q
X-Received: by 2002:a05:600c:5254:b0:4a1:fe55:88ef with SMTP id 5b1f17b1804b1-4ba023494c0mr39557255e9.20.1794311404355;
        Tue, 10 Nov 2026 03:50:04 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:03 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 00/20] t9300: group and move tests to other files
Date: Tue, 10 Nov 2026 12:49:45 +0100
Message-Id: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMAyA4VeRnA00lW3gq4wdbI1bJlZp4hiI7
 746j9/h/zdQzsIKbbVB5o+ozKmA6griq0tPRumLwTt/JXIex4RDp4YyLXM2NFZTJHRNz5cbOYp
 NgBIvmQf5/sf3x2ldw5ujHTfY9x9foyPlegAAAA==
X-Change-ID: 20261102-kn-fast-import-tests-1-03de57101c3b
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2483; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=pO14jZydAbFp3tXodDH7NxEzsBcSq5K/71GP8Yip42k=;
 b=kA0DAAoBPtWfJI5GjH8ByyZiAGrzBODInx+eBOFL1rvXoxXliMKHd+sXQeDVnESAI26n1PF/G
 okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTgAAoJED7VnySORox/UbEL/A/V
 q6jRyDCKc4RsHHlYk/0CeTvB+HClOgsHOgZpZ5jxacoPmapDNeEPqELGjRz88KcnGI5dITPaYb9
 SMXkY8chQutIEshj8BTLKKmlX9M6Oj4NfDIAFLFblazkU+Ktc57KG2dGjBNHTSPH+E4zhMYqMAb
 qrJ/vt+/qdKV3paXwYfcKgXZ9r9CGOvx+9v2wcbJ4KwDleHuNBECHwmrONMqnS1wM0UDpMYmDrm
 K0D7nSdyM4mw3JQOgrcBcPl3qyQ7lpsbwsdGySHuqBn6dYkRmEGgYT3sspZj0J3hR2qyAthFrSX
 K+YsQoKVgI2TAes+J+PlZuBT2K13o3o0d77ot9DG+qZtLxh1EvR+r/i8AK6OrVXnnJXxXaIXGn6
 F+nO/rjfMZr5RovtSLpTU8moP8t9e0aVRe5vcDzIaFUvm6O8Fra+psEdUVKXS/UwRXlJ/dwn4m6
 nFAMzUHbPnu/vnQC6Z2cmQ8eqXaaBJl4p4dqut9s/wnzFv/EJr22ZjQX6fDw==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While reading the git-fast-import(1) code, I stumbled upon t9300. The
test file is around 4000 LoC and each test has some dependency on the
state setup by previous tests.

This long series unwinds some of these tests and moves them into
new/existing tests based on what they exercise. This leaves t9300 in a
better state. I think we can do more here, but I decided to stop before
this series got even longer. Based on the reception of this series, I
will follow up with more cleanups.

Also, we could squash some of the commits together. But I found them
easier to read through this way.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Karthik Nayak (20):
      t9300: move 'fastimport.unpackLimit' to the required test
      t9300: make the series B tests self-contained
      t9300: make the series T tests self-contained
      t9300: make the series S tests self-contained
      t9300: make the series V tests self-contained
      t9300: make the series Q tests self-contained
      t9300: make the series P tests self-contained
      t9300: make the series O tests self-contained
      t9300: make the big blob tests self-contained
      t9300: make the ref update tests self-contained
      t9300: make the date format tests self-contained
      t9300: make the pack edges test self-contained
      t9300: make the marks tests self-contained
      t9300: make the series Y tests self-contained
      t9300: make the cat-blob tests self-contained
      t9300: make the feature and option tests self-contained
      t9300: make the stream tests self-contained
      t9300: make the get-mark and encoding tests self-contained
      t9300: move self-contained tests into dedicated files
      t93xx: drop the series letter from the moved test names

 t/meson.build                     |    5 +
 t/t9300-fast-import.sh            | 2780 +------------------------------------
 t/t9301-fast-import-notes.sh      |  411 ++++++
 t/t9304-fast-import-marks.sh      |  393 ++++++
 t/t9307-fast-import-validation.sh | 1193 ++++++++++++++++
 t/t9308-fast-import-stream.sh     |  822 +++++++++++
 t/t9309-fast-import-checkpoint.sh |  188 +++
 t/t9310-fast-import-submodule.sh  |  341 +++++
 t/t9311-fast-import-refs.sh       |  194 +++
 9 files changed, 3548 insertions(+), 2779 deletions(-)


---
base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
change-id: 20261102-kn-fast-import-tests-1-03de57101c3b


Thanks
- Karthik

