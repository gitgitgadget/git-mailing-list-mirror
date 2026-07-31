Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143EA2222AC
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527399; cv=none; b=GahtDof+2roZHszoG0hSIn5K9IkbghYu8SIB7vWoLZ7cG9kRprznNKR3cSa1vZzTXiTn6yC4VvMmZMLKAKZ9WOhvTTVVJ7MWC9fABu1doK9k+LUsqB/cHlJvlbalwsUeYUmwybP/cH86BK4mix7BaOoomLKx6VeKrLFJ3GidRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527399; c=relaxed/simple;
	bh=n+HpoSbyKTqrPnfYawN5qRuZ5+TP9xvyOisFs6PNRdI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=dSI0Ol+ciuPBv4xJy2apeUoKTzf2DzY1dzoUqEBs9cBUjmxNazxiUDXR8uAoTXtTYWp4O844A9vbm0awKNibq0/hifhNdBCYZOz/ERzmnJXjq114+iXdcsfeRWkOUaU4wV3K2ktU1aRTr4u5Cmf2Ccb07OcOUfsVhp4/oaQoRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk8TFoO8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk8TFoO8"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47fd4531020so726378f8f.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785527396; x=1786132196; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Kjgw1MhiZbTaWNRdjXu5AqhyIj7/pBA7e2j4ulJpVI=;
        b=Kk8TFoO8LVLRuy+GIG6szfNQHTVnezi2W0B2jqjRCbz+TVtS9zac1CWsK6/thz6sRW
         Ib+1tE96iV5HDHUpeOtVW9Uz/uRCEHlfVnIAtAyqALqnNkdNIQdGgoa1JKgEGhC8kHJX
         NzYqNOl8kezaNqT2+/VTQJqu55zEHStus0iyc5w4J5DlFqFfB0BE+aGF/sR3nz+jWTyl
         FJoCazVz8UlSMwDiz+7kO0bC9c44Nmc1mh2siQ/lxoy8kHxvSuzdOh2KlNRkYrlr4sl4
         vrQCSOgPsZn6Vz/EN5htHz5zk3lwiNMqhD8b7dOBU072V171A5Dk3FUhuPxcNXX6yQnF
         Wa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527396; x=1786132196;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Kjgw1MhiZbTaWNRdjXu5AqhyIj7/pBA7e2j4ulJpVI=;
        b=QsBAE6BvN3atgSEXkrdJJe3Ywa3G6uyHhnRh2o2A6gzitOvblszBuqIjT/1WTXc7zL
         H1r6yEmdNVaUgU2ByFpPhmvg07CoWjPt4a+HKxjTlN28p36S1wPYHneIsYUoP79SC7rT
         KbG1BdPY5yjFuVfEwYVVPFMpZ3p81+hnZEjJu+NMJ78KwOKngMIw3J2epvkoSx5mEbNJ
         c3juF8UvNa+Zmvs7p2ZOtQzl6mvy0jcGQw6u97sW5nfKICSgImV7NDDUTZvViI5ovda5
         QWc9hwFqWle/P2jJDJ0KAsmvbgPkjoNMKuA3O/KNgYsdSJrmVbmabkgwuQAS3FWU5znA
         1mxA==
X-Gm-Message-State: AOJu0YzcBtdXVZ1gyD913km6EXJMm9fbsivQN426ZMT0meoKmkFhBfzU
	Kv9mp+CDPzpdzuWBb5GT9jLVEkojOWNbY6jboyzmX+qSHp9Iv6i4T4qw
X-Gm-Gg: AR+sD13P1nBTF7FsteoiOEUWojk7rK0zsqvTLZ1h7IPlry3hAA43bWECPRIYspTNr6I
	26TgvVivBBoi85/xIaPfa2yErXxjB+Seb7WuazQScdC2pRfR28cC3EKxoRR4gFAGPINMIHdShyY
	Z3/IJNvG+VObZs7bDKAFruN8S2UkFl2fWswnppKK1oHH4WtOKdt4kuhT5tKe9D7Tm5CvL9Nddpy
	m3BzEuDkpVPdAp3omMxckBJXZv5/JXMHLRvhWKxEZH68scOh61SbL32uxfa/xcXMR/Wssx4XJ1P
	Yc0faQ3Drw9+707exvt+QYC3cUs44emrqsoAVHlfDJRZUjmUX1AO809bPCcl0A8rQiue6lepssW
	Gg10P72P47rj5w3vAEeNdA0PwwGv3/VIMiy3e75BmnAuZ74keFAYsF7Ixka/YVr/b0A5xOJUhJ1
	iKPAPldsIr8COjpGQsi/P47rT0kSJH/Uxs6LzUKhSBa/0FOZUcbET+Vv7LsolbO1jvckvZ9cc1a
	jlhxXMOEwtAkCu1s1VsFgrA79I1qVKYXXDXL7tgDLOgjViARV5cCJF1586cO3l2N8NNGinmoa+N
	sAmAFMel8u1A4Y7LjEbeClEY0EYLsJhjzN0JjhGUmniOE0dwpEmJScTePLSRHBqyUETCTqozYKR
	pNAoI1sa1grGTiLPzrO3CDIzawdY8YZWVYl/fDbv54M6vmrkKlijK6/Z6K0XP69RD+05z3yC9Hn
	qyyT0u3oyN+DXx1Ik0jA==
X-Received: by 2002:a05:6000:470e:b0:47f:810c:8abe with SMTP id ffacd0b85a97d-47fd72f17e3mr1966175f8f.36.1785527395975;
        Fri, 31 Jul 2026 12:49:55 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2cf1sm8248568f8f.10.2026.07.31.12.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:49:55 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC v2 0/6] cat-file: extend remote-object-info to support
 %(objecttype)
Date: Fri, 31 Jul 2026 21:49:33 +0200
Message-Id: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ6CMBBFr2JmbQ2tCNGViQsP4NKwaMsANUJrW
 4iEcHdLYenyT97/byZwaBU6uOwmsDgop3QXAtvvQDa8q5GoMmRgCcuSnKVEixdK70eDxPXGaOs
 JcopVdk5pmeQQisZipb5x9An3h75BsV5dH8vL3sZZ/PTB6Vd4wRrlvLZjfGigcWJzn/65B0oSw
 spU8qMQXFT0WrdcvQ9St1DM8/wDRD/+quEAAAA=
X-Change-ID: 20260724-objecttype-support-ea1ef6941d07
In-Reply-To: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

"%(objecttype)" is already known by the client's allow-list, but neither
the client nor the server knows how to handle type. This series continues
the work for git cat-file --batch-command extending remote-object-info
to support "%(objecttype)" end to end. It is based on its predecessor
series "cat-file: add remote-object-info to batch-command" [1].

Type is the last property that is identical on the server and on the
client once fetched.

Whether to support more metadata such as:

- objectsize:disk
- deltabase
- objectmode (needs context)

should be discussed, unlike size and type, the rest depend on how things
are packed on the server and on what the client already has, so they
cannot reliably match local once fetched. IMO they are not worth
supporting, I can't find a use case for them.

Adding new placeholders has become trivial.
To add a new placeholder, follow the steps in this series and add it to
the client's allow-list at 'builtin/cat-file.c'.

Based-on: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>

Github CI: https://github.com/pabloosabaterr/git/actions/runs/30660227202

[1]: https://lore.kernel.org/git/20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com/

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Changes in v2:
- Changed t5701 test to use test_file_size.
- Changed the for loop to use for_each_string_list_item().
- Moved "fetch-object-info: request all supported options dynamically"
  patch to be the first one as it is prep patch.
- Typos and nits.
- Restored the test mixing info and remote-object-info, adapted to the
  unified format.
- Link to v1: https://lore.kernel.org/git/20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com/

---
Pablo Sabater (6):
      fetch-object-info: request all supported options dynamically
      t5701: use the test_file_size() helper
      protocol-caps: add type support to object-info
      fetch-object-info: parse type from server response
      serve: advertise type capability
      cat-file: unify default format

 Documentation/git-cat-file.adoc        | 17 +++-----
 Documentation/gitprotocol-v2.adoc      | 15 +++++--
 builtin/cat-file.c                     |  7 ---
 fetch-object-info.c                    | 23 +++++++---
 protocol-caps.c                        | 21 +++++++--
 serve.c                                |  4 +-
 t/t1017-cat-file-remote-object-info.sh | 78 +++++++++++++++++++++-------------
 t/t5701-git-serve.sh                   | 31 +++++++++++++-
 8 files changed, 133 insertions(+), 63 deletions(-)

Range-diff versus v1:

-:  ---------- > 1:  f635361786 fetch-object-info: request all supported options dynamically
-:  ---------- > 2:  5195b2db2e t5701: use the test_file_size() helper
1:  acdff1bbd3 ! 3:  08a4a86ac9 protocol-caps: add type support to object-info
    @@ Commit message
         field. When the client includes type in its object-info request, the
         server returns the requested object type.
     
    -    While at it, fix requested_info->size bit field style.
    +    While touching send_info(), wrap an over-long line and fix the bit field
    +    style of requested_info.size.
     
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
    @@ protocol-caps.c: static void send_info(struct repository *r, struct packet_write
     +
      	for_each_string_list_item (item, oid_str_list) {
      		const char *oid_str = item->string;
    ++		enum object_type object_type;
      		struct object_id oid;
      		size_t object_size;
    -+		enum object_type object_type;
      
      		if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
      			packet_writer_error(
    @@ t/t5701-git-serve.sh: test_expect_success 'basics of object-info' '
      	test_cmp expect actual
      '
      
    -+test_expect_success 'type' '
    ++test_expect_success 'object-info supports type' '
     +	test_config transfer.advertiseObjectInfo true &&
     +
     +	test-tool pkt-line pack >in <<-EOF &&
    @@ t/t5701-git-serve.sh: test_expect_success 'basics of object-info' '
     +	cat >expect <<-EOF &&
     +	size
     +	type
    -+	$(git rev-parse two:two.t) $(wc -c <two.t | xargs) blob
    -+	$(git rev-parse two:two.t) $(wc -c <two.t | xargs) blob
    ++	$(git rev-parse two:two.t) $(test_file_size two.t) blob
    ++	$(git rev-parse two:two.t) $(test_file_size two.t) blob
     +	0000
     +	EOF
     +
2:  c1a8a83acf = 4:  4d8e2ddb5d fetch-object-info: parse type from server response
3:  ed0215c3e5 < -:  ---------- fetch-object-info: request all supported options dynamically
4:  27efd907bd ! 5:  973b490b75 serve: advertise type capability
    @@ t/t1017-cat-file-remote-object-info.sh: test_expect_success 'remote-object-info
      		git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
      		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
      		EOF
    +@@ t/t1017-cat-file-remote-object-info.sh: test_expect_success 'unsupported placeholder on remote returns empty string' '
    + 	)
    + '
    + 
    ++test_expect_success 'unsupported placeholders on remote return empty string' '
    ++	(
    ++		set_transport_variables "$daemon_parent" &&
    ++		cd "$daemon_parent/daemon_client_empty" &&
    ++
    ++		fmt="%(objectmode) %(objectsize:disk) %(rest) %(deltabase)" &&
    ++
    ++		# The hardcoded SPs between the atoms are respected.
    ++		echo "   " >expect &&
    ++		git cat-file --batch-command="$fmt" >actual <<-EOF &&
    ++		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
    ++		EOF
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    + test_expect_success 'requesting only objectname echoes back' '
    + 	(
    + 		set_transport_variables "$daemon_parent" &&
5:  ab5a44d40e ! 6:  1668033b31 cat-file: unify default format
    @@ Commit message
         cat-file: unify default format
     
         %(objecttype) is supported both by the client and by the server.
    -    Change the temporary default format to the unified version that other
    -    commands use.
    +    Change the temporary default format to the unified version that the
    +    other commands use.
     
         Update documentation to remove %(objecttype) from the caveats of
    -    remote-object-info.
    +    remote-object-info and show %(objecttype) support.
     
    -    Update tests that used the default format to expect type.
    -    Update documentation to show %(objecttype) support.
    +    Now that type is supported and the default format unified, update the
    +    tests to expect the new default format.
     
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
    @@ Documentation/gitprotocol-v2.adoc: object-info
     -information without having to fully fetch objects. Object size is the only
     -information that is currently supported.
     +information without having to fully fetch objects. Object size and type are the
    -+only information that is currently supported.
    ++only information currently supported.
      
      An `object-info` request takes the following arguments:
      
    @@ t/t1017-cat-file-remote-object-info.sh: test_expect_success 'batch-command remot
      '
      
     -test_expect_success 'remote-object-info does not change the default format of info' '
    --	(
    --		set_transport_variables "$daemon_parent" &&
    --		cd "$daemon_parent/daemon_client_empty" &&
    --
    --		local_content="local object" &&
    --		local_oid=$(echo_without_newline "$local_content" | git hash-object -w --stdin) &&
    --		local_size=$(strlen "$local_content") &&
    --
    --		echo "$local_oid blob $local_size" >expect &&
    --		echo "$hello_oid $hello_size" >>expect &&
    --		echo "$local_oid blob $local_size" >>expect &&
    --
    --		git cat-file --batch-command >actual <<-EOF &&
    --		info $local_oid
    --		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
    --		info $local_oid
    --		EOF
    --		test_cmp expect actual
    --	)
    --'
    --
    - test_expect_success 'batch-command --buffer remote-object-info git://' '
    ++test_expect_success 'remote-object-info and info can be mixed using the unified default format' '
      	(
      		set_transport_variables "$daemon_parent" &&
    + 		cd "$daemon_parent/daemon_client_empty" &&
    +@@ t/t1017-cat-file-remote-object-info.sh: test_expect_success 'remote-object-info does not change the default format of in
    + 		local_size=$(strlen "$local_content") &&
    + 
    + 		echo "$local_oid blob $local_size" >expect &&
    +-		echo "$hello_oid $hello_size" >>expect &&
    ++		echo "$hello_oid blob $hello_size" >>expect &&
    + 		echo "$local_oid blob $local_size" >>expect &&
    + 
    + 		git cat-file --batch-command >actual <<-EOF &&
     @@ t/t1017-cat-file-remote-object-info.sh: test_expect_success 'batch-command -Z remote-object-info git:// default filter'
      		set_transport_variables "$daemon_parent" &&
      		cd "$daemon_parent/daemon_client_empty" &&

---
base-commit: 71e19e8d2713f385c3fcef59cf6f29bcbd93d91f
change-id: 20260724-objecttype-support-ea1ef6941d07

