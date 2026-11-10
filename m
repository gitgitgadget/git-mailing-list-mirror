Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327318;
	b=HnNKpuHZ9fpZj99ggLVgSE/T1wm44d7mv0FoW2TKFnQ1+Nbz4KZC/btXO+Wl2DzWRNr3
	 8uyRoWaUA6PtWRUsFATSMZn48ixSX5tggC0Mjb6zept9nqZYl13dE47ABk9hv4UEttmgf
	 n8+B+VwSzlKUEj1tsxzDGm3Itp19f5v5yaojIALelwy4D3e+1RD3TFK0fesi3BjgSc1o+
	 lX36lcvncu0hOM4U89qGQSyq9Et67XN3kB+3KcMLQ2Gooo2gWNt3P0FltxWNS08xG0YD5
	 Dxw890s8Tqj4HbsXzktlsoEv5RwChG9yrnq4/hV9N7pxHsfjEPxwx2l9iHf4fNgPcBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ghaoYG/LXqBKCQP76UvFpIMqQs71avEuo2dXOXCpSAc=;
	b=igWTkk62Fmr5CRYXutO7udtD0ZvpgsitiwJjrWZGgo/ttLh/kYzO3O1U/MUyVp9ZT7Vf
	 cZbtMePCak+2OSREeoppPlc3FpWBRj0SghXqFNoGfUm/hU+TjjT9orDL/7TJRCb1t0olo
	 azOxClHtBwXzUDp86r2L8GksVWQnF0+SA1dNOG1azsjyXJ5TmMOvLbJbD+ze0xctExfhJ
	 JuvyUPuAT5oPQhDTQEZXFcC711LJz59UldDWptD8ClzkRWwobxnwX2XmvBFwr/Pqndx5b
	 lxH+BpelrXqPXZmjvuzSmWtLOXpwk+ChJ7ymqiATIn3aFza3s+G5ozr6enluqVB4O/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R8+KVHNe;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB38606A320
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB38606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R8+KVHNe
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so3392631a12.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794327316; x=1794932116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ghaoYG/LXqBKCQP76UvFpIMqQs71avEuo2dXOXCpSAc=;
        b=R8+KVHNedopwK0DFCBpe/qdc4Wg8vdXOWya/3MnI4Y8J3+NnOFy7rGj3KXWof5u3Rz
         1YsELAwUsKdIdlV30VzvCGv4OKYqbPe1XvMQhvwarpf8uXkozgh1IPFne1uILlgFuoE3
         dZviBEiCvRpkm7rztrlOSvuR4tX78yAlQdJM7stL8BNdWHPzi0EMJuyO2NEYEjUkbISa
         HDdqS3JB3AKt7yapv1F94PBHCjcn2qCTWu6I34FMwuSDEkOX/nFKhQkIiBFnl3mhp+Ry
         FeANfd6DXmv2K6ITk+DDrFq429T/7VwKsM4+05E5tSQnMELW3/nJFCSSHC3k9qkSM+8s
         qWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327316; x=1794932116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghaoYG/LXqBKCQP76UvFpIMqQs71avEuo2dXOXCpSAc=;
        b=VQRLbYCZyBKZARIEFalR7KhQDUYABXWKpaZL8C0v1pDvaldjIO7GyM83bAHp1GI+tz
         SgWneEpZ0TJIt2ntvnFM4TxUbK/13LscV7ZRdbhP9TbXMw4ktJFO9aKK93U+h869ehZU
         9rQD+Y4iEPsyJSMfopI1oOn3sIQIdYyKO7QjQagkgZei3qkTsrb7rphEJQbn/lSL+3Hi
         Z+K35QUO5PmUW06uYZTkSrh6LC2sasRAQoa13lAC0AVmHAkoDqvSrOUoMEiTxRuzdMn8
         Qq0TrJUC8KCZI2Eb5UWkRjBR9QE7IQmeOdu4SSJhSt1vpGvzP1I1wiBYX0anELk5tadt
         mCZA==
X-Gm-Message-State: APuU4Z/Zz9T5Xm65b+nCf/3kYUPfE5i7mXJLH0zy0PmRdpai/9udFCMb
	oZIx0GSa3H2sDJc9uW3AjVdETh3I5GjIg8ncKAo08IaR8CtAfgTgQSc3b73d6gY2EkE=
X-Gm-Gg: AYBFou0sULBEXZNkIUoFjCFbKp0swdtEeBYCAo36ZmHwecDrtwEnHY7TN01ZjYdWqog
	ouwsHU2pi3CgrTmB6YiELz1Rj9yoW+wSbs8C5k+e6VGzvC7BXNijMd5n3lyQA37S7UWzB6fggzQ
	wB7EWZHOsaSuCgX//xpcfB+B4gT3gzEbQrSqa8jGVu7o4ya6QtCXd822n/Oqz8lfE03hEYIdcYg
	tnPjaspR31cMfFXaYLIHNXSavVbq9Fpto7LIRkblMDMnW9cMaNpjlQ6X5dqQJFsbejOlmBOQUeu
	TiXkoRynYtcMKrxDVSoX09b8A6P5lHeDu9AK8+whY67DQfCdPrOuQXN3+azbpnd9EMvcYTtc9aj
	D80skGmG7R39yA2djR2MRlbX0UF6aiaiZODsDDawO7B2M69xid51KFKXwuvJvoBzQMi4f8ilbx2
	Q7b4W+2QpoF8bMtMIDw4s7PcxOiBd10uxn8XtoQMp+CH55OJvzO5n8if1QsfwDhCma0LulHhuwD
	LZUFqN+q1imVn/4uWMauxJHBlxs276lry9RTTn5w8h+MaQj7y4Hp2FFThpW1zDVlUL3ifpkKLsg
	vpMH25kk/MwmLARnp7ypcv7BRstmVfhixqZJ3jDjD4qQ+NLr2eSehYzGYim6XXis
X-Received: by 2002:a17:907:2d94:b0:c49:a235:8e0c with SMTP id a640c23a62f3a-c504954d36amr257198666b.22.1794327316084;
        Tue, 10 Nov 2026 08:15:16 -0800 (PST)
Received: from zito.localdomain ([102.90.126.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a69ce38sm126209666b.84.2026.11.10.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:15:15 -0800 (PST)
From: Azuama Odinaka Maximus <azuama69@gmail.com>
To: git@vger.kernel.org
Cc: tangajoris@gmail.com,
	pushkarkumarsingh1970@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	Azuama Odinaka Maximus <azuama69@gmail.com>
Subject: [RFC PATCH 0/2] parse-options: improve early option scanning
Date: Tue, 10 Nov 2026 17:13:11 +0100
Message-ID: <20261110161314.35213-1-azuama69@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This RFC series shares my progress on improving early option
scanning in rev-list and exploring a reusable scanning API.

The first patch updates rev-list's early scan to account for
options that consume arguments.

The second patch introduces a generic early option-scanning API
with tests, as a step towards a more reusable solution.

The rev-list patch still uses an initial hardcoded option list,
which I recognise is fragile based on the review feedback.
I am investigating how to avoid this limitation and how best
to integrate revision-option argument parsing without triggering
unwanted parsing side effects.

I would appreciate feedback on the direction of this work,
particularly the API design and its integration with revision
option parsing.

Signed-off-by: Azuama Odinaka Maximus <azuama69@gmail.com>

Azuama Odinaka Maximus (2):
  rev-list: handle arguments in early option scan
  parse-options: add early option scanning

 builtin/rev-list.c            |  55 +++++++-
 parse-options.c               | 249 ++++++++++++++++++++++++++++++----
 parse-options.h               |  22 +++
 t/helper/test-parse-options.c | 236 ++++++++++++++++++++++++++++++++
 t/t0040-parse-options.sh      |   6 +
 t/t6022-rev-list-missing.sh   |  26 ++++
 6 files changed, 562 insertions(+), 32 deletions(-)

-- 
2.53.0

