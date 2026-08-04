Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D641686B
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868982; cv=none; b=VG5MjP5QrjydkPds8DZ9Ebg229kupYxBi6KU87JjH8vs/v3eKy2m03R0+FK8DB3pDXDw7GJeQAnYyGuJpJ9j0UVQOxHEpVRORn5DC5yZMx/T/5F+3pkcYHeOuK1i86L/634lD9rQxGzucOl6MAq2R3hDaANaeDUOmv0J2LLQyn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868982; c=relaxed/simple;
	bh=GCv75SgcUEvorRdWCvHs3FGLA/XQisjX2o6BnJ88KCI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=jucaMmORcbu8QqSsPZPPeHwkU2A4ERUw4+2ZkEGj2Te74xpl2TuHfoBBdXr8fG/vxkbyo/pUsneHxlYbYQ8gliUH86zFwjDy1yerA+FQl6R9N8U82tO5SYD3QS38d+noVkTSRn8OIk/+qdwPPTHHpvbEW6Yo84Di9sMH3XPBTFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqzDR1PI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqzDR1PI"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso1014595e9.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868979; x=1786473779; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oi8ETu+RuM7m0A9H1a/xBLZhXuV1yZSdEe0TPTSO5xs=;
        b=HqzDR1PInSPOWotGPX6pHVaAY9aPvWnXUiRb4eHyj8HdLfmIF2GvmIW7/HcGPMnuvg
         xCBXchNR6k9zEu6Clk+kkqcF3Fob/6CGr415PAkquJ4tqZWd9RkOTkULuUBz+pyOPiWw
         d89tuG6ACjuun2yE5uHcDlYuIsIkl7abjeEvGU+91wxBX6nb5sVHr51I4B9KZl8Aoyv7
         cqh+0ItSrlGFSBj8h8P4+m6AEAg+kYkmO6OOUzOuFcTUU3+V5QHuzkS+x+6Ax/zf0snu
         yhMJwmRAtNNwgLIbDmr8axjMJWMKvzIyRwlzfHqXqVYxcUvSr33wh8EEFv4zkSxiaLEK
         acyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868979; x=1786473779;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oi8ETu+RuM7m0A9H1a/xBLZhXuV1yZSdEe0TPTSO5xs=;
        b=EOYVL3Vimp3qqYI3n+m2B2xpruFJThfjMpepCpfNVh1rS2Swgb+qsRIV/0aicuiHhD
         Gi4W7C8t5JA19aKWXVhpjmsHTNRd1HpztwCzQKjQZii3+pZNM8Atd+ZrAzPlbJdU916u
         fvMLm6Dah5c8577D95wobrPMcbtOOknGWknf3S57fPoIwJy8cJf5yA5bwoIrxqOVjnD3
         87WeZQmBKyK3QqiMunlv3ctCP9/AvLPezvUf1QCxcBoE13kIwV1yHLi+fv6vf+AqGNGM
         33hmIc5a7cds0zNW0xumChT8dexyPRDz8RyiIoYUrX/CoelBln47YBug1aj0w6R17OKQ
         rgSA==
X-Gm-Message-State: AOJu0YyWmrL/on7K0U51aQXVKXoy8Tp+IilVKoOf9gR+2dMa84wlmyB1
	bDGH7b7BTgNt7PBBq+p7WYLdyC9NykvmUhdjYHA5fe8aAZBnJSS5nEqL
X-Gm-Gg: AR+sD13Z9w8muHfNogQJ4HKn3rBbkUK1cVOtnqVD9b4dobK1R4BqzlMYL3I7q2605e9
	AMpaAU28y9RHDiYOOSgIpumwSPtNu4cujyJiJvL/Cpx9g+1sCyIERGhISOpctFsEPLdaupfLQbL
	in090QGnGl0xwPvVbAx/7BEa0Yw0AyufXjXsboznVo376olFgauGnd8cOv57nLawqVOEV5cKUNX
	68gVLgalVq0rNQt2Kr1j7uJ/i4RxtId4fv3+Yeu0W5tJkCQ/L+ziYDpRoH3WOA6y2RrsGEgvM18
	CV1XhYAte5xH1J+8UEo89+Y1Rts/4gdqeIkGrmzKe+BZiEIiYhuMslY+yXHUGhKmJ8rT03c0jsy
	2J6NhDTCsrAkA6s779uvceXtl6Jj4dBPRiGzafEClhqRHemG4T8zEEoKKiCKklOwNBzUeIYZFSW
	726vzKg5DAuQiINrQHaMxvekarHe1s52jNOeJsVwZ/d5bf8GNcC7ODRV3LifgmAoJbiP/eNzQ+f
	U+C47TjHavy1A+Nu7r4jpeiu1CEN8xci7B/zZWqdI8KRQMU7rooaLSwmsOHv7A51rg4uEy34IRq
	ek1h1QyeQI3vLw4/U4o1DvQr1tQ3ZPiqlp8QWPJNnDTRva/EQvTEUbMp8rrQJnO3S4h8Q1So0wI
	UTgPRYVEQzS/p9Ai0
X-Received: by 2002:a05:600c:4f83:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-4994e6c4194mr5443085e9.0.1785868978622;
        Tue, 04 Aug 2026 11:42:58 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm138877835e9.9.2026.08.04.11.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:42:57 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC v4 0/9] cat-file: extend remote-object-info to support
 %(objecttype)
Date: Tue, 04 Aug 2026 20:42:54 +0200
Message-Id: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OTQrCMBAF4KtI1kby10ZdCS48gEtxkaYTjVhTk
 7Qo0rsbo6BIlzO8+d48UABvIaDl5IE89DZYd0mDmE6QPqrLAbCt04wYYSWRTGBXnUDHeG8Bh65
 tnY8YFAVTLgStiUTpsPVg7C2jO7TZujXav7ehy8cv75PzcO1SZ3yHX7GjDdH5e36op5n4dBdj3
 T3FBLNaaMWrSlWGrg6NsueZdk1u7dkPwekowRKhTCGlKCnUhfwn+JeYEz5K8ERIKksD2shFQX6
 JYRiecsTQi2cBAAA=
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

Whether to support more metadata such as:
- objectsize:disk
- deltabase
- objectmode (needs context)

should be discussed, unlike size and type, the rest depend on how things
are packed on the server and on what the client already has, so they
cannot reliably match local once fetched. IMO they are not worth
supporting, I can't find a use case for them.

To add a new placeholder, follow the steps in this series and add its
wants_* flag to struct fetch_object_info_results.

Patches 1-5 are preparatory. They don't change what the command does:
- [1/9] is a test cleanup.
- [2/9] fixes a possible bug in case of a malformed response.
- [3/9] and [4/9] refactor how the object data is stored and handled. The
  why about this refactor comes from [2].
- [5/9] drops the last error return left in fetch_object_info().

Patches 6-9 are the actual objecttype support:
- [6/9] teaches the server to answer type.
- [7/9] teaches the client to parse it.
- [8/9] advertises the capability so the client can start asking it.
- [9/9] unifies the default format.

Note that *_type appears from [7/9]. Before this series, "type" is
already listed in the client's allow-list, but the prep patches drop
that list, so the client knows nothing about type until [7/9] adds it
back.

Github CI: https://github.com/pabloosabaterr/git/actions/runs/30938909345

[1]: https://lore.kernel.org/git/20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com/
[2]: https://lore.kernel.org/git/xmqqzez67yg1.fsf@gitster.g/

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
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
 builtin/cat-file.c                     |  69 +++++----------
 fetch-object-info.c                    | 149 +++++++++++++++++++++------------
 fetch-object-info.h                    |  37 +++++---
 object-file.c                          |  10 ---
 odb.h                                  |   3 -
 protocol-caps.c                        |  21 ++++-
 serve.c                                |   4 +-
 t/t1017-cat-file-remote-object-info.sh |  78 ++++++++++-------
 t/t5701-git-serve.sh                   |  41 ++++++++-
 transport.c                            |  14 ++--
 transport.h                            |   5 +-
 13 files changed, 276 insertions(+), 190 deletions(-)

Range-diff versus v3:

 1:  41172a72ce !  1:  301d7ccca9 t5701: use test_file_size() to get the size of a file
    @@ Commit message
     
         Use the test_file_size() helper, which outputs the size directly, and
         store the result in a variable. Because 'git rev-parse two:two.t' is
    -    also run twice, store its output in a variable as well.
    +    also run multiple times, store its output in a variable as well.
    +
    +    Storing them in variables outside the HERE-document has the added
    +    benefit of preserving their exit statuses.
     
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
 2:  a7a547c9b9 <  -:  ---------- fetch-object-info: detect truncated server responses
 -:  ---------- >  2:  445d65cc7e fetch-object-info: detect malformed server responses
 3:  6a9b839127 !  3:  107315bb32 fetch-object-info: pass arguments directly instead of a struct
    @@ Commit message
         struct object_info_args groups three pointers that already live in the
         transport and are given to fetch_object_info().
         Grouping them into a struct reduces the number of parameters, but it
    -    suggests that fetch_object_info() uses all three of them.
    +    suggests that the three belong together, when they are unrelated and end
    +    up being accessed as args->* independently.
     
         Drop the struct and pass those parameters directly to
         fetch_object_info() and send_object_info_request(). This should have no
    @@ fetch-object-info.c: static int parse_object_size(const char *s, size_t *res)
     +		      struct object_info *object_info_data,
      		      const int stateless_rpc, const int fd_out)
      {
    - 	size_t i;
    + 	int size_index = -1;
     @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version, struct object_info_ar
      		 * because the number of options is a small known number (the
      		 * supported placeholders which currently are size and type).
    @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
      		BUG("unknown protocol version");
      	}
      
    --	for (i = 0; i < args->object_info_options->nr; i++) {
    -+	for (i = 0; i < object_info_options->nr; i++) {
    +-	for (size_t i = 0; i < args->object_info_options->nr; i++) {
    ++	for (size_t i = 0; i < object_info_options->nr; i++) {
      		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
      			check_stateless_delimiter(stateless_rpc, reader,
      						  "stateless delimiter expected");
    @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
      					xcalloc(1, sizeof(*object_info_data[j].sizep));
      		} else {
     @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version, struct object_info_ar
    + 		}
    + 	}
      
    - 	for (i = 0;
    - 	     packet_reader_read(reader) == PACKET_READ_NORMAL &&
    --	     i < args->oids->nr;
    -+	     i < oids->nr;
    - 	     i++) {
    +-	for (size_t i = 0; i < args->oids->nr; i++) {
    ++	for (size_t i = 0; i < oids->nr; i++) {
      		struct string_list object_info_values = STRING_LIST_INIT_DUP;
      
    + 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
    + 			die(_("object-info: expected %" PRIuMAX " objects, got %" PRIuMAX),
    +-			    (uintmax_t)args->oids->nr, (uintmax_t)i);
    ++			    (uintmax_t)oids->nr, (uintmax_t)i);
    + 
      		string_list_split(&object_info_values, reader->line, " ", -1);
      
      		if (strcmp(object_info_values.items[0].string,
    @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
      			    reader->line);
      
     @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version, struct object_info_ar
    - 		string_list_clear(&object_info_values, 0);
    - 	}
      
    --	if (i != args->oids->nr)
    -+	if (i != oids->nr)
    - 		die(_("object-info: expected %" PRIuMAX " objects, got %" PRIuMAX),
    --		    (uintmax_t)args->oids->nr, (uintmax_t)i);
    -+		    (uintmax_t)oids->nr, (uintmax_t)i);
    + 	if (packet_reader_read(reader) != PACKET_READ_FLUSH)
    + 		die(_("object-info: expected flush after %"PRIuMAX" objects"),
    +-		    (uintmax_t)args->oids->nr);
    ++		    (uintmax_t)oids->nr);
      
      	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
      
 4:  0633ddc7e8 !  4:  b942beb9d7 fetch-object-info: use dedicated struct for the results
    @@ Commit message
         atom names, so drop it and build remote_allowed_atoms from the result
         arrays.
     
    +    Currently for wants_* and ask_* there is only the 'size' variant but a
    +    subsequent commit will add '*_type'.
    +
         free_object_info_contents() loses its only caller and is dropped.
     
    +    Dropping the allow-list check makes the final else reachable from the
    +    wire, so die() instead of BUG(): an unknown attribute is the server's
    +    error, not ours.
    +
         Helped-by: Jeff King <peff@peff.net>
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ builtin/cat-file.c: static void parse_cmd_remote_object_info(struct batch_option
      
      	if (data->info.sizep)
     -		string_list_append(&object_info_options, "size");
    -+		results.wants_size = 1;
    - 	if (data->info.typep)
    +-	if (data->info.typep)
     -		string_list_append(&object_info_options, "type");
    -+		results.wants_type = 1;
    ++		results.wants_size = 1;
      
     -	if (get_remote_info(count, argv, &remote_object_info,
     -			    &object_info_oids, &object_info_options))
    @@ fetch-object-info.c
      				     const struct string_list *server_options,
      				     struct oid_array *oids,
     -				     struct string_list *object_info_options)
    -+				     unsigned ask_size,
    -+				     unsigned ask_type)
    ++				     unsigned ask_size)
      {
      	struct strbuf req_buf = STRBUF_INIT;
      
    @@ fetch-object-info.c
      		packet_buf_write(&req_buf, "size");
     -	else if (object_info_options->nr)
     -		BUG("only size should be in object_info_options");
    -+
    -+	if (ask_type)
    -+		packet_buf_write(&req_buf, "type");
      
      	if (oids)
      		for (size_t i = 0; i < oids->nr; i++)
    @@ fetch-object-info.c: static int parse_object_size(const char *s, size_t *res)
     +		      const int stateless_rpc,
     +		      const int fd_out)
      {
    --	size_t i;
     +	unsigned ask_size = 0;
    -+	unsigned ask_type = 0;
      	int size_index = -1;
     +	size_t wanted;
    -+	size_t i;
     +
     +	results->nr = oids->nr;
     +	CALLOC_ARRAY(results->unrecognized, results->nr);
    @@ fetch-object-info.c: static int parse_object_size(const char *s, size_t *res)
     +		if (results->wants_size &&
     +		    server_supports_feature("object-info", "size", 0))
     +			ask_size = 1;
    -+
    -+		if (results->wants_type &&
    -+		    server_supports_feature("object-info", "type", 0))
    -+			ask_type = 1;
      
      		/*
      		 * Even if no options are left, we still send the oid so we get
    @@ fetch-object-info.c: static int parse_object_size(const char *s, size_t *res)
      		 */
     -		send_object_info_request(fd_out, server_options, oids,
     -					 object_info_options);
    -+		send_object_info_request(fd_out, server_options, oids, ask_size,
    -+					 ask_type);
    ++		send_object_info_request(fd_out, server_options, oids, ask_size);
      		break;
      	case protocol_v1:
      	case protocol_v0:
    @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
      	case protocol_unknown_version:
      		BUG("unknown protocol version");
      	}
    -+	wanted = ask_size + ask_type;
    ++	wanted = ask_size;
      
    --	for (i = 0; i < object_info_options->nr; i++) {
    -+	for (i = 0; i < wanted; i++) {
    +-	for (size_t i = 0; i < object_info_options->nr; i++) {
    ++	for (size_t i = 0; i < wanted; i++) {
      		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
      			check_stateless_delimiter(stateless_rpc, reader,
      						  "stateless delimiter expected");
    @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
     -					xcalloc(1, sizeof(*object_info_data[j].sizep));
     +			CALLOC_ARRAY(results->sizes, results->nr);
      		} else {
    - 			BUG("only size is supported");
    +-			BUG("only size is supported");
    ++			die(_("object-info: unknown attribute '%s'"),
    ++			    reader->line);
      		}
    + 	}
    + 
     @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
      		 */
      		if (object_info_values.nr >= 2 &&
    @@ fetch-object-info.h
     +	uint8_t *unrecognized;
     +	size_t nr;
     +	unsigned wants_size:1;
    -+	unsigned wants_type:1;
     +};
     +
     +#define FETCH_OBJECT_INFO_RESULTS_INIT { 0 }
 -:  ---------- >  5:  2e9cce44b6 fetch-object-info: die() on the remaining error path
 5:  7678f2ce77 =  6:  30d9898e3b protocol-caps: add type support to object-info
 6:  bfff160c38 !  7:  8ebdf712b8 fetch-object-info: parse type from server response
    @@ Commit message
     
         The server can handle type requests but does not advertise the
         capability yet. Prepare the client to know how to parse the server
    -    response once the server advertises the capability.
    +    response once the server advertises the type capability.
     
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
    @@ Commit message
     
      ## builtin/cat-file.c ##
     @@ builtin/cat-file.c: static void parse_cmd_remote_object_info(struct batch_options *opt,
    + 
    + 	if (data->info.sizep)
    + 		results.wants_size = 1;
    ++	if (data->info.typep)
    ++		results.wants_type = 1;
    + 
    + 	if (get_remote_info(count, argv, &results, &object_info_oids))
    + 		die(_("failed to get object info from the remote: %s"), argv[0]);
    +@@ builtin/cat-file.c: static void parse_cmd_remote_object_info(struct batch_options *opt,
      	string_list_append(&data->remote_allowed_atoms, "objectname");
      	if (results.sizes)
      		string_list_append(&data->remote_allowed_atoms, "objectsize");
    @@ fetch-object-info.c
      #include "pkt-line.h"
      #include "connect.h"
      #include "oid-array.h"
    -@@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
    +@@
    + static void send_object_info_request(const int fd_out,
    + 				     const struct string_list *server_options,
    + 				     struct oid_array *oids,
    +-				     unsigned ask_size)
    ++				     unsigned ask_size,
    ++				     unsigned ask_type)
    + {
    + 	struct strbuf req_buf = STRBUF_INIT;
    + 
    +@@ fetch-object-info.c: static void send_object_info_request(const int fd_out,
    + 	if (ask_size)
    + 		packet_buf_write(&req_buf, "size");
    + 
    ++	if (ask_type)
    ++		packet_buf_write(&req_buf, "type");
    ++
    + 	if (oids)
    + 		for (size_t i = 0; i < oids->nr; i++)
    + 			packet_buf_write(&req_buf, "oid %s",
    +@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
    + 		       int fd_out)
    + {
      	unsigned ask_size = 0;
    - 	unsigned ask_type = 0;
    ++	unsigned ask_type = 0;
      	int size_index = -1;
     +	int type_index = -1;
      	size_t wanted;
    - 	size_t i;
      
    -@@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
    + 	results->nr = oids->nr;
    +@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
    + 		    server_supports_feature("object-info", "size", 0))
    + 			ask_size = 1;
    + 
    ++		if (results->wants_type &&
    ++		    server_supports_feature("object-info", "type", 0))
    ++			ask_type = 1;
    ++
    + 		/*
    + 		 * Even if no options are left, we still send the oid so we get
    + 		 * at least an existence check.
    + 		 */
    +-		send_object_info_request(fd_out, server_options, oids, ask_size);
    ++		send_object_info_request(fd_out, server_options, oids, ask_size,
    ++					 ask_type);
    + 		break;
    + 	case protocol_v1:
    + 	case protocol_v0:
    +@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
    + 	case protocol_unknown_version:
    + 		BUG("unknown protocol version");
    + 	}
    +-	wanted = ask_size;
    ++	wanted = ask_size + ask_type;
    + 
    + 	for (size_t i = 0; i < wanted; i++) {
    + 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
    +@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
      				die(_("object-info: duplicate 'size' attribute"));
      			size_index = (int)i;
      			CALLOC_ARRAY(results->sizes, results->nr);
    @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
     +			type_index = (int)i;
     +			CALLOC_ARRAY(results->types, results->nr);
      		} else {
    --			BUG("only size is supported");
    -+			BUG("unexpected object-info option: %s", reader->line);
    - 		}
    - 	}
    - 
    -@@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
    + 			die(_("object-info: unknown attribute '%s'"),
    + 			    reader->line);
    +@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
      			    object_info_values.items[0].string,
      			    object_info_values.items[size_index + 1].string);
      
    @@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
      		string_list_clear(&object_info_values, 0);
      	}
      
    -@@ fetch-object-info.c: int fetch_object_info(const enum protocol_version version,
    +@@ fetch-object-info.c: void fetch_object_info(enum protocol_version version,
      void free_fetch_object_info_results(struct fetch_object_info_results *results)
      {
      	free(results->sizes);
    @@ fetch-object-info.h
      	uint8_t *unrecognized;
      	size_t nr;
      	unsigned wants_size:1;
    ++	unsigned wants_type:1;
    + };
    + 
    + #define FETCH_OBJECT_INFO_RESULTS_INIT { 0 }
 7:  8c58680108 =  8:  acfa7cb4b1 serve: advertise type capability
 8:  fb5032cea5 =  9:  9dc40ba2cb cat-file: unify default format

---
base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
change-id: 20260724-objecttype-support-ea1ef6941d07

