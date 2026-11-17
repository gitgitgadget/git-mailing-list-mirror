Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937468;
	b=ZtxLOMW17iccqMuwdcPo5On64eaouAkFSE1SvXM83egOpKwr14xOMzQvbquBJjiIj31F
	 iXuXTHOqbC1hWRmvL7qckyC0MdruXAFBxHH7103Xj6WZt1XehjxsVC+kWZv+p0dC3WaAM
	 +Zj820ud3re5rkYNSoVwBExZwdrd314ORNBQyFusCYCBKhnoa9lVmvnMSkMLwKps2m+eD
	 2k0IIyKj3PzaCfnalWpBM7SJGDbDZzd5VOkHYlnx3rImX+DMjcDACNCHR/BhUp5UllTAo
	 Kdz/+AhQHq89QzgYqBLgCO7W3ZUeOZRB46akRGpRg5MQLgQyaostloTG4o+TykGlNkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eJPBlDee2qKhnySbxjTxynKyUfMc+GGtfZ/VYgKFv1Y=;
	b=EeiyKqZC6yPyZycZN+BBJaS7SsV0eyilEYuf9w/5WwdMX6POjXSoHhqsHco4QCrR9js4
	 c3CvdIPIVXMRgyc7ERq8gkYMUxK0pM/ZPj8OsHtkF206+iKmMCbO0Turkq0FWmQaUmwtv
	 ivPn2MYiELaUahMSSxtXJeiPOmqx8XHZufrrYlHqHKuiZH5kg55RX8xpPv4Z11fE1lntb
	 yYwwq8Viq5Ig+qUWxRn2iOcneRjJwqncPaCm3GaYBESYrw2BCnb5hQF2Zd+8Jg5PPRNJB
	 Pv0OX6lgU7kswRFb3JpdlEknqR/lg9Gbf8xEh54O7jlqv+lADgDSeSmpPpvNIW7WAOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvFmfHqD;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE63606A33D
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE63606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvFmfHqD
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c445c95d553so731406966b.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 09:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937466; x=1795542266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJPBlDee2qKhnySbxjTxynKyUfMc+GGtfZ/VYgKFv1Y=;
        b=KvFmfHqDHN1NquQ0si3ZIiLSvEI1yn7sQMaH03EA/mjgRgKsrc70gPZV+TeiGMu1i9
         GzaN65Enu6R6lxbQxfGEWFvQuHiBgJlvlKePXmPJVBFQauL+b3k8hBnQ2Rafz7PvT1Zo
         YHy4s5EkZx3IQeRpEApHUDAFWITmF1TxhSlwXQgQOY6Z1cQDNZhav+Ms+kBLB1gOQlXv
         thMxLl9JHmg8nVKykRx3a13RwJfL6bxOANZpRU0LrM0jabLbHYXTPDPK6CNJbQL9sMDf
         VTZcB2uHGXgspfivtjTZQcOG9n+vFYq9nfc76C934/UdyodELLx8t/JUUKPOnDiwJFi0
         7JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937466; x=1795542266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJPBlDee2qKhnySbxjTxynKyUfMc+GGtfZ/VYgKFv1Y=;
        b=id7Z/p91ppBjdeDX25P92Mu+ucJ+hGFPkqK7j58XokIgg/4O4TSQjfED0afkYmlCAE
         UsrYg6cgs9EDmk+4IdZW97jq9AvT2g7AsnfV3XhFW91EaIEEm+7rYkrWMYTIl6loGaIu
         h8qXpLsqYSl1lApTr5CCzfva/CWGdQ/Xq/WtDVgswARF8W30Bnrmi/qHdnn7n6a+GI4e
         4kQ2K8uJrZtRHIVXdt7nO2q1ynW8YxGAm8D6+tgxdWCxs0BsHCGA8rIENiZHr/H5W8IW
         ArqSdz1Y0I6SboMKNTACkfMayvwAmHWQznqyxvVSUfQqbWQDVhCdQJel/KgXpCR1qLrP
         UUpw==
X-Gm-Message-State: APuU4Z/H9D6sUY+K1MPYWEozzqwO+dOZmEoRSLeptYia0CVvG3qcRvJF
	Pf+uFUDARHVCJg1C/vxhJ19jKgrOqSm8dKoZOy7usE4yonjw5m+YAGvyx3BflQ==
X-Gm-Gg: AYBFou3ugIYSg5OvFdEnWlw6rZyUj2U47yt4GU5HF4xC2ztzcCYlGGw492NU7t8NxvT
	WqZ1wJfpyrVdRJMalvioGjDbGRgYCzlcbKQ8YB8aChy67/IVdrLP9h7tvbkdIZVIjQKdbmuwOhc
	swDweaGfXBEtdY8+VjHlmqar6I4mGlzBG4kzVgTif2IN0R4gdg0/IHZMxgYBZ9XpSSQpQ3BqzYj
	28qPA3guQDHRsky5ccDKRXNyhM8A28Dd1qkHA74//DNiUDoIHNSrR/+gGOVgT20xy8HcJAC53dm
	0P31V3uEp6dKOWvx3beMYmVcJ2CnyaLZKJpa3P1B7iTMUnB8SZjgmfafoNqVB53BkC5nzakQHYP
	o2AtUTg1oIRPv/VkJS3bgvHtGsq0LtblNSNsBzo9ZGgpZ7rOjuxZehtX4lk7vPPUT+N7rAi5Xwl
	F4qBqhtMbaDypc/MKby00TkU74tAPGffkGmNOyn3PyCqVs3o8UDAw96QDZ1HU3W7tK3HJfszjmk
	/mcpIYlJIGfpZVhDsEXM79GAA7ZpTpSNipob8BHVPR7A7K/v+u+Qbupb2E+1tbUPUAkW82zgvWn
	Vrqh+8rsziyt3alEjhYLqHC3y7FCp3if8w4yJMTtvnorRnmgViisvVmHfQl+gwxnc5RuO0PtTFT
	ZqNxmIp8/zmcPxQpyBxyAeOkooW+0rkR3T9iI+i568ArCRIz0WOPCxCV+MEgIunM8QdwA1ZKgPF
	G1oP4uIrVZtJLRxA6eN7DUS/Mv7FCKw4nj26MxHf0=
X-Received: by 2002:a17:907:1b16:b0:c49:8fa2:4a22 with SMTP id a640c23a62f3a-c50963d4060mr1275916866b.41.1794937466325;
        Tue, 17 Nov 2026 09:44:26 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83fe47sm7947366b.5.2026.11.17.09.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:44:25 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/3] Allow merges with results over 2 GiB on 64-bit Windows
Date: Tue, 17 Nov 2026 18:43:54 +0100
Message-ID: <20261117174353.1158905-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.495.ge87f5c5eed.dirty
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

Two recent series improved how merge results are sized:

  - `jk/xdiff-size_t` (merged by 81db32ddce) replaced `mmbuffer_t`
    with `mmfile_t`, whose size is a `size_t` instead of a `long`.

  - `kn/safer-mem-arithmetic-in-xdiff` (merged by 1c93cc03ea) computes
    the merge buffer size as a `size_t` instead of an `int`, with
    overflow checks.

As the latter targets the `maint` branches, which don't have
`jk/xdiff-size_t`, it also makes `xdl_do_merge()` fail when the result
is bigger than `LONG_MAX`, so that it cannot be silently truncated
when stored into mmbuffer_t's `long` size on LLP64 platforms like
64-bit Windows.

On `master`, that check is not needed for `mmfile_t` anymore, but as
Kaartic pointed out when that series was discussed, merge results were
still passed on to a few functions taking an `unsigned long`. This
series converts those to `size_t`, and then removes the check.

Patch 1/3 also fixes an existing bug: since c6a4629e32 (odb: use
size_t for object_info.sizep and the size APIs, 2026-06-15), a
delete/modify conflict in `git notes merge` on a note of 4 GiB or more
silently writes a truncated note on LLP64 platforms. That patch could
be applied on its own.

## Overview of the patches

  - Patch 1/3 changes the size argument of `write_buf_to_worktree()`
    in "notes-merge.c" from `unsigned long` to `size_t`.

  - Patch 2/3 uses `size_t` for the length argument of
    `odb_write_object()`, `odb_write_object_ext()`, the
    `odb_source_write_object()` wrapper and `write_loose_object()`,
    and for the size stored in `struct inmemory_object`, so that
    object lengths are not truncated before reaching the already
    `size_t` backends.

  - Patch 3/3 removes the `size > LONG_MAX` check in `xdl_do_merge()`,
    lets the `t4300` tests that expect a successful big merge run on
    LLP64 platforms, and removes the test that expected a failure
    there.

## Testing

The code paths changed here only behave differently where `long` is 32
bits and `size_t` is 64 bits, so Linux and macOS CI cannot exercise
them. It would be very nice if someone with a 64-bit Windows setup
could run `t4300` with `GIT_TEST_LONG=1`. Beware that it needs enough
memory and disk for a merge result just over 4 GiB.

## CI

Some test scripts didn't want to start on MacOS but otherwise all the
tests passed, see:

https://github.com/chriscool/git/actions/runs/44118577071


Christian Couder (3):
  notes-merge: use size_t in write_buf_to_worktree()
  odb: widen odb_write_object() length to size_t
  xdiff: drop LONG_MAX check on merge result size

 notes-merge.c         |  2 +-
 odb.c                 |  2 +-
 odb.h                 |  4 ++--
 odb/source-inmemory.c |  2 +-
 odb/source-loose.c    |  2 +-
 odb/source.h          |  2 +-
 t/t4300-merge-tree.sh | 13 ++-----------
 xdiff/xmerge.c        |  4 ----
 8 files changed, 9 insertions(+), 22 deletions(-)


base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
-- 
2.56.0

