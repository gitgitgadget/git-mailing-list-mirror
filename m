Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053508;
	b=mac0hNCpy8L8rCOMJ345Idm1ngaMYZ53+dIXzEl2i9J3WBt7219ITRIKnI/gKIoGn7np
	 8RGFNy4HvsGlkeFgJUmSRxRmhe86BT2xEZdZ8Awq1BCzWXxlhrg0hk04+ksKWmXbgXrcO
	 mxsRsRQ5L0Cyiz4FPaQoFtgXhBs7TJTWolFcB7UJhQxdHgh6iefqUq41xiKMru4CDK1wR
	 Zlso/1R8HL3QTY6lUA5iqKb3cAgA7PQqt8GOQkMLjjDdCVT/7LCGQwcRhZr4n1RMaJtSf
	 9P8LiCxeQV6uDfVJiHlIM//1q3nWs5s1sEH/DPofOh1NTwqZ/lDLloQICpDxxGE3xgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lXzafXbB8g8/LTGHHmou29rgBQ7NpUPgIkyCEAF0YUE=;
	b=WUv1AAiuJFGpc9lK3bebGp7Jj6nIdO9nEWUfZERjbu5qudMzIYF0V50iVUll0QYJZsnh
	 BFmvMaWcXWZp6hsyadb8VdyzXE9qJPBWA4KvG+pdJRFuJzihF3c7Wb3ycJPTIYGfQ2MAT
	 jB8jfpNcTU2z0ol1/JSs8hSYlo6UKnd3TzmNie2KwGa/73Hn1iiiSg4XwkdQ0IHWc2XEL
	 LvvtogJDYgHxY6Fr+NOfxpSUq/59L6OmpAP6Y9ib8EP7c9cUnq93HaYMHRSyLC/iuj7o3
	 m82Jwl41tnsu2FmbmWPo9tf6z9KQ0gEYfoLy4tQX775FX09iDmwySTBmB5S5ZR2AhOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pGJRMgpu;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6D606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 12:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FA6D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pGJRMgpu
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso592991f8f.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 04:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053506; x=1794658306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lXzafXbB8g8/LTGHHmou29rgBQ7NpUPgIkyCEAF0YUE=;
        b=pGJRMgpu2ftXNbBRtTcTIoSndYvFRzbFAo1C9oOmXjp+LD+YYn2muVPoQ1YLb/MY2H
         ro+8lU5pmpZ0LPR7Xp6lNVtEM3Rg7x7xzkxoD770FWGx57KfGhw9O7TkQ42UKKa7o6ib
         JJmikjKJjFkZSMMIQIjC9bO85xD1VqeNYPcfRYZunssFyOY+WPY6UbJg5nyd8ymZmX0J
         jmOJbjKkt9YJC3Jsp/U3rR4rup3CWarHqrR4GHVnNGS+60qcTFjjkhjX8eG3vFQEaTyW
         FhoBLRvM+QZ5+V5BuyYWg2B9E0mBK/l4HgTqwmZHCWMuTo92LWq99EKEgftJWF8xUqU6
         TKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053506; x=1794658306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lXzafXbB8g8/LTGHHmou29rgBQ7NpUPgIkyCEAF0YUE=;
        b=Sn18tbGpTC4JcuhSA6rDg8Tx4KrDLy88DexApK42OGykxds4wvtg9Sbiprh5h9I3Xd
         gI9R/haBt9XckE0dJihyFxcJKD3TgfNzBpDWfoMgpmNaWJhR3Q5jt/d1dIVOB2xvBk3j
         3nbzf/K5P3ju/WbH/MmxwiNWkLXgiFbb5o+RA2aUKgqx7ik8w0peEk4Nue/dnD9zaqzx
         /OaTCyU00uhDHKfpdy9c/kdUsMXB5XAdzq1SQ+0SZsXBLOiwbAUO2K8fxTsgykdLIO5i
         sDJcoFj0Tt+kcPgx1OgXRsnvMhQM1cdVeBFszvDiyjJx/qLqlmcXHJfAoSPwcY1F/dRj
         IF1A==
X-Gm-Message-State: APuU4Z9mZ2oYoBJraRdhWPhL948B4nBvFoDaQ+0uKCso3dFk3x4sDFWT
	TD7Mk9KbmgGgFJ/VRGwkgIf69EzuI28Z3jQ+nuBwZJlLju44/Gn+/25MaM1YDA==
X-Gm-Gg: AYBFou1V1NFblYtS7lFX767KA68D/hofaXWLmJeeK0TUtE6ubVyhiukto+6kJY0HpDb
	c0gjw1Y1LmTn4pel6bM4HrZ+ECPGA2jYwRvGxYA7n1OKu4K7R6VKWrRSPmmDWwY3brmakeShoi7
	ryjpn9GRd38IgcYQd/cUyfyNiIBq2uEQj54OBpRFCz/e/vGr76f3HPUf4i5OQ0FKEhyfks+gOnd
	06BUTQ+j7Vw0N7h2grd5TNe8PKLT4R9tR916sl29fnMOiePAPeXH6olaWGHIlwJdYH5LoZGmOxW
	choKxrO44gjPETedBTPnV78DiB3baFsjeFbxtf9Ng9oZckUeBgu3OozpWgUxKzf0cjt/qH1Ebfi
	PROphEzj3QUlVwLsMmH160Lnvt49wt1LrIU6I+k6GfUcaCw/pzH9HCQ9un/rx/ntqKFaDmo+G0U
	qbBczKVpy16AhWQbh/znsM1NyEf7LA3SPFOqYUrmM8tyKjmROWCiTH/iXth4w1pRNtlTIsLUfVy
	kTs+je6CrryGOv156qdNysOfYyr4zU4NdXCp/c+O/oBtmHD1Te1BmDSlBmEN10jNIfFIsvge9PG
	vvo754S5ZOjk2mW/8hqH9MOi86Jbg/EhkUPfdXhQbTjB+OchGDKUu4D5+u9r1wk+D3ujy8IARez
	44Ejou6iAkBNHWydlK+pu0w==
X-Received: by 2002:a05:6000:4025:b0:48c:77ad:d52d with SMTP id ffacd0b85a97d-49277d9c67dmr11443348f8f.43.1794053506468;
        Sat, 07 Nov 2026 04:11:46 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7233297sm9138625f8f.27.2026.11.07.04.11.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:11:45 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Subject: [BUG] splitIndex with skipHash corrupts index and crashes status
Date: Sat,  7 Nov 2026 12:11:16 +0000
Message-ID: <20261107121119.2995843-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With both core.splitIndex and index.skipHash enabled (the latter e.g.
via feature.manyFiles), index entries are silently lost or corrupted
whenever the shared index is written.

  $ git init -q r && cd r
  $ git config core.splitIndex true
  $ touch foo bar && git add . && git commit -qm init
  $ git config index.skipHash true
  $ git update-index --split-index
  $ git ls-files
  ./
  ./
  $ git status --short
  BUG: wt-status.c:585: multiple renames on the same target? how?
  Aborted (core dumped)

Without the explicit --split-index, this happens once the shared index
is rewritten because enough entries have changed.

In a new repository, the first git add writes a shared index, and the
added entry is lost straight away:

  $ git init -q r && cd r
  $ git config core.splitIndex true
  $ git config index.skipHash true
  $ touch foo && git add foo
  $ git status --short
  ?? foo
  $ ls .git | grep index
  index
  sharedindex.0000000000000000000000000000000000000000

Note the unexpected null OID.

Seen with v2.56.0 on x86_64 Linux.
