Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCC1397
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147346; cv=none; b=Q0+354Apb2R5Jl2AyGom9WwUhh2N3MQUmnhgjciIhXDaUCiTieZ2/DQex1/9I177ZUEVuvtp5augBItUQymSAAPIBGnAg7nG3xIpVbP8NiTn5nl98Ovy3gUWv74OJ7GzKnvda2tIPYwKUVFBigFPKTfxcix8Y5TOlIiOPl2i8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147346; c=relaxed/simple;
	bh=ybB+7k3yG5OBc1PyThVQ7BV5h88b0NGnUE/So2EtwIs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=t3PsWZn8omY+7/4JRutdcX8Nx6dn5WtYTk6uZive86USp9hvPC/krNM5KHn1XTtoDj46xx8O3GMFxwx0g3uTyCfrCZhbiFC0jlGShCOU//Mdnun5imin2ksVZpFkHu7TCE+ethraY3KqclFtSBvVore9DW2iU0oGK2gXeo3xBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIlgdrUv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIlgdrUv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4955de8797cso656595e9.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 17:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786147343; x=1786752143; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47/lgrt/aH2tU5Blf5SS/bpYglKTIIxJ7zOxc0VQZik=;
        b=PIlgdrUvjHvWLj6CMjtGu+BQ/T8a0Pc+baNkHcfKzfKKFsrTPYps+4+NLWd5V6NCd7
         930os/+BGWLX1s/9M/1Hf2IADqQsIqJ9anI/Wkt2ekxsp5HdVsoRiZabDav780pM0A/P
         /ejl06xMDWNtirns52uETNOEYQcWT9nChCqlyc76Hwc2lnop0ocy5QBHhlOKI4lfet5+
         ijacpCha2nrtdndvMY78wPkDZ+ANtlTemEAfDfhA8Pz3ey43Fw6vDGBjOEyk/WXx4DsA
         SmOibpng2VlIubA4cnWNP2PfHHdVg8rq/BuGbSCk2Ik32M0QrE3VxNdM6C7QZC62WbOm
         qY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786147343; x=1786752143;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=47/lgrt/aH2tU5Blf5SS/bpYglKTIIxJ7zOxc0VQZik=;
        b=LlDu6pRwc6aHikX5c7oygDnSKlVaGoiM6xzX2TlcN+8EXqKY452mg+U0t6peuO1D2d
         7MP+2PWuNVfo3yoGkZnQaoxcYJw2uPaJTW6nZ7ytl3U+otczGVFRa6jYUTxzM7/wXRMv
         qfVQWxKgD41T68Ie29SV8ELqIbJG6yl7WrPAuEekFWcwkvO46m/C1D1/A73b56SY3c5B
         O7lXQYgCgbmLF/NqWzyzu1KkEwZFM29nxsmOJMffsUXmwfaurecL3LvEvoFTX+zaOWPS
         ayt0s+Su3PNBuyg8o5gNr2hVGDJrm6DdMnm9DQvAjR4H7LYhMeY4gmqMe6dNLlfx1TRe
         m26Q==
X-Gm-Message-State: AOJu0YydZnoPUD16L5UHqj4WqW51Eg5Laev5HjzJYteL6B0hD0+Dbvoj
	UijV6BDD+UpJAujHS7XfIZfXqNTNNOXSz1Q6ItPkpdud56XrRdzh+j4A
X-Gm-Gg: AR+sD13Kujys6EFET41WCCB96EQtDy9CQLxAkNiotw2kvz1sbvT+bnchaQCJw8GSOS5
	AVWOHT8l+jJx9MM+kswjOD/ZzfchQLADyEBGsETZrLpi5arFrcEGSsFay6kNInT+1CPvTQBczbf
	mSJ9iCxRj99z1R0GgQ8tPL1vBF4VAEf4DVob4FdK6cTDivqqponNq9ZCTCtShP7EwuJ5+BE9Nu3
	HVI51fVQyMTFcvd0Jja/9eBfIFNFJOzfHITpd2ck1uAE+34r1NLlVPco71UM84+tskH/sj7Y/CE
	hnC056kNcGzsceEUkivmFdXibytAKi3jljoRrjq/forpre/KIEkKV5upr7t1efSeunsTzw85whQ
	mSNo/WR0Bx44L/yM0reppf1d8GPe7Ss2DYYuFPaZz3l8praTIA5MElVP7oQrnbB6U8jPvMvFYT4
	j7r3TOk5sUQGKMT2XoJLN2e9saODOoiW69SM4/8Wo18QvwcpR5q5mQlF7X/a5jf86KwZYiITRGx
	XFv4EIkg/sr5nfMSddk71+M+3IseZmWZIBMt/f/XygnVn/9hzheyoKLlYaoAMfRsgmRcPplqrG/
	6kQG6eJL4oUW9+ExqYu3veQdo7dfuDtafzeWF/cd+EUtIgQ8oi6+t0cB91XXvBLtJ9crNN+MeMk
	sTw5qBdfusKmJoc/vSJkBuREQdHdGcqj3JK0rvV185cTwRz2dGnC1y0tZO8b10mAyLsCB
X-Received: by 2002:a05:600c:46cc:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-4995e085347mr96261165e9.6.1786147343190;
        Fri, 07 Aug 2026 17:02:23 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm72424525e9.2.2026.08.07.17.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:02:22 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC v6 00/10] cat-file: extend remote-object-info to
 support %(objecttype)
Date: Sat, 08 Aug 2026 02:02:15 +0200
Message-Id: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QTWrDMBAF4KsEraui0W/SVaGLHqDL0oUkjxKFJ
 nIl2zQE372KE6gxXo548z0xV1IwRyzkZXMlGYdYYjrXQT9tiD/Y8x5pbOpMOOOaGS5pckf0XXd
 pkZa+bVPuKFrAoHcSGmZIXWwzhvg7oZ/k/SO9ka/7a+mn5Zv3yGX86Wtndw/fYodYupQv04cGm
 IhHt1rrHoAyyhvprXDOugCv+5ON388+nabWgc8IAasEr4QNyhipARtlloT4J7ZMrBKiEgaMDui
 D2Sm2JOScWD3iICshQAE4xgU4XBJqTmxXCVWJrQ6cO/RMOj4nxnH8A79cBu7tAQAA
X-Change-ID: 20260724-objecttype-support-ea1ef6941d07
In-Reply-To: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Neither the client nor the server knows how to handle type. This series
continues the work for git cat-file --batch-command extending
remote-object-info to support "%(objecttype)" end to end. It is based on
its predecessor series "cat-file: add remote-object-info to
batch-command" [1] merged into master.

Type is the last property that is identical on the server and on the
client once fetched.

Whether to support more metadata such as: - objectsize:disk
- deltabase
- objectmode (needs context)

should be discussed, unlike size and type, the rest depend on how things
are packed on the server and on what the client already has, so they
cannot reliably match local once fetched. IMO they are not worth
supporting, I can't find a use case for them.

To add a new placeholder, follow the steps in this series and add its
wants_* flag to struct fetch_object_info_results.

Patches 1-6 are preparatory. They don't change what the command does:
- [1/10] is a test cleanup.
- [2/10] fixes a possible bug in case of a malformed response.
- [3/10] and [4/10] refactor how the object data is stored and handled.
  The why about this refactor comes from [2].
- [5/10] drops the last error return left in fetch_object_info().
- [6/10] drops the remote object-info fields from the transport struct.

Patches 7-10 are the actual objecttype support:
- [7/10] teaches the server to answer type.
- [8/10] teaches the client to parse it.
- [9/10] advertises the capability so the client can start asking it.
- [10/10] unifies the default format.

Note that *_type appears from [8/10]. Before this series, "type" is
already listed in the client's allow-list, but the prep patches drop
that list, so the client knows nothing about type until [8/10] adds it
back.

I apologise for the spam as I've sent v5 and v6 very close together.

Github CI v6: https://github.com/pabloosabaterr/git/actions/runs/31227956862

Sorry for the inconveniences.

[1]: https://lore.kernel.org/git/20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com/
[2]: https://lore.kernel.org/git/xmqqzez67yg1.fsf@gitster.g/

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Changes in v6:
- Fixed static analysis CI fail with two forward declarations.
- Fixed s/%"PRIuMAX"/%" PRIuMAX "/
- Link to v5: https://lore.kernel.org/git/20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com

Changes in v5:
- New [6/10] by Jeff King: drop the remote object-info fields from the
  transport struct and pass them as function parameters instead.
- [5/10]: keep the const qualifiers on parameters of fetch_object_info(),
  matching how the signature was.
- Link to v4: https://lore.kernel.org/git/20260804-objecttype-support-v4-0-31511b0231be@gmail.com/

Changes in v4:
- Rebased onto master now that ps/cat-file-remote-object-info was merged.
- Dropped the Based-on trailer.
- Reworded [1/9] so it shows that we also benefit from preserving the
  exit status.
- Changed [2/9] to also check if a response returns more packets.
- New [5/9]: fetch_object_info() dies on its last error return and
  becomes void.
- Moved the introduction of ask_type, wants_type to [7/9] instead of
  [4/9].
- Link to v3: https://lore.kernel.org/git/20260803-objecttype-support-v3-0-7176fecf7950@gmail.com/

Changes in v3:
- 1/8 (was 2/6): reword the commit message to explain that "wc -c | xargs"
  only strips the padding some platforms add.
- New 2/8: die if the server sends fewer object-info lines than
  requested OIDs. Preexisting bug.
- New 3/8: drop struct object_info_args and pass its members directly to
  fetch_object_info().
- New 4/8: replace struct object_info with struct
  fetch_object_info_results to hold the results. This also drops the
  object_info_options string list, remote_atom_map[] and
  free_object_info_contents().
- Dropped 1/6, which replaced the hardcoded "size" in
  send_object_info_request() with a loop over object_info_options, as
  that list no longer reaches it.
- 6/8: follows the new result struct, so it only adds the type array.
- 7/8: quote $hello_type in the test.
- Link to v2: https://lore.kernel.org/git/20260731-objecttype-support-v2-0-af577461ed57@gmail.com/

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
Jeff King (1):
      transport: drop remote object-info fields from transport struct

Pablo Sabater (9):
      t5701: use test_file_size() to get the size of a file
      fetch-object-info: detect malformed server responses
      fetch-object-info: pass arguments directly instead of a struct
      fetch-object-info: use dedicated struct for the results
      fetch-object-info: die() on the remaining error path
      protocol-caps: add type support to object-info
      fetch-object-info: parse type from server response
      serve: advertise type capability
      cat-file: unify default format

 Documentation/git-cat-file.adoc        |  17 ++--
 Documentation/gitprotocol-v2.adoc      |  18 +++-
 builtin/cat-file.c                     |  73 +++++-----------
 fetch-object-info.c                    | 149 +++++++++++++++++++++------------
 fetch-object-info.h                    |  37 +++++---
 object-file.c                          |  10 ---
 odb.h                                  |   3 -
 protocol-caps.c                        |  21 ++++-
 serve.c                                |   4 +-
 t/t1017-cat-file-remote-object-info.sh |  78 ++++++++++-------
 t/t5701-git-serve.sh                   |  41 ++++++++-
 transport-helper.c                     |   7 +-
 transport-internal.h                   |   6 +-
 transport.c                            |  24 +++---
 transport.h                            |  10 +--
 15 files changed, 296 insertions(+), 202 deletions(-)

Range-diff versus v5:

 1:  77b048574a =  1:  99112fd453 t5701: use test_file_size() to get the size of a file
 2:  892e149f11 !  2:  e18da979aa fetch-object-info: detect malformed server responses
    @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
      	}
     +
     +	if (packet_reader_read(reader) != PACKET_READ_FLUSH)
    -+		die(_("object-info: expected flush after %"PRIuMAX" objects"),
    ++		die(_("object-info: expected flush after %" PRIuMAX " objects"),
     +		    (uintmax_t)args->oids->nr);
     +
      	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
 3:  05f4d26560 !  3:  8b4f6913c1 fetch-object-info: pass arguments directly instead of a struct
    @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
     @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version, struct object_info_ar
      
      	if (packet_reader_read(reader) != PACKET_READ_FLUSH)
    - 		die(_("object-info: expected flush after %"PRIuMAX" objects"),
    + 		die(_("object-info: expected flush after %" PRIuMAX " objects"),
     -		    (uintmax_t)args->oids->nr);
     +		    (uintmax_t)oids->nr);
      
 4:  832639ae1a =  4:  a81e1e3c1d fetch-object-info: use dedicated struct for the results
 5:  ffac30cef5 =  5:  a79f9957b4 fetch-object-info: die() on the remaining error path
 6:  748adf35fb !  6:  f14f3b0a2a transport: drop remote object-info fields from transport struct
    @@ transport-helper.c: static int fetch_refs(struct transport *transport,
      }
     
      ## transport-internal.h ##
    +@@ transport-internal.h: struct ref;
    + struct transport;
    + struct strvec;
    + struct transport_ls_refs_options;
    ++struct oid_array;
    ++struct fetch_object_info_results;
    + 
    + struct transport_vtable {
    + 	/**
     @@ transport-internal.h: struct transport_vtable {
      	 *
      	 * Uses object-info capability of v2 protocol.
 7:  c7ab410aef =  7:  c51d8ae137 protocol-caps: add type support to object-info
 8:  59da95f82c =  8:  1a9b320f36 fetch-object-info: parse type from server response
 9:  b249e9e16c =  9:  394bdd0885 serve: advertise type capability
10:  f8221fc1de = 10:  595b80c28d cat-file: unify default format

---
base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
change-id: 20260724-objecttype-support-ea1ef6941d07

