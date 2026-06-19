Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5139E2DC32C
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881011; cv=none; b=UQW7KKifFxSkvwPfGTw/KJkgIIvsw/CCXdJlo7Ay14a+JSJUndAAZkZJHu36yJK+wYyZmJDZqIPhyQQFGekI2ebn6ystlkSgNDpTP+jwVzWF18A6c0QLxLojuS+kji6hTbPO7z3lsfkXTGQpWLpzJOsZ1WNRrgKtb1HQySnFo54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881011; c=relaxed/simple;
	bh=shuJGkLRom7ynwyZkbca/VHWSaBPKKATssFG8IPm6aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVgO0X7aqzle2gGPCKinpykyQugvzZBco8i5TjnOIKpaiDNecwB4IUfOnf3kl5Ocm/M7aeKNlQIGJj2Yg3LquNOa+1zjOoIxKeZmdBP3zxgyQLEW1SrbBge+T5e9NAkZw2PmyBWhWvWGoEMucULIVBohBdIcJDXgwf43xEImP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToxqH0zv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToxqH0zv"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490afc47455so9187935e9.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881007; x=1782485807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGczc0SWnPbU2EjU0FYJpiIxDvOfiFmU2Kt+GQjhDso=;
        b=ToxqH0zvVJoQYehUdvoMfORxB1dxvTqEiIulkqNvj6g51tR70I5a4hAGnrPkZETYh3
         HgAHcbMJQJAmEVayHUAHLfiPklxrk0+4pCaXDFLXwdOGrgBQPoy2Z5xYrIx9oZ0Z38xu
         FpcOVrXmPc3I+urq2vamgw/1ljGtDcL7DT61/eVPgTPZq/r2ISS+TMgobFZi3BG+9vsW
         OX3ScaigPxuKgKj9KQjU1Sg5scfmCLfzQKFVOLLnBeZm34s5sL5I20TCmqEYJfMz0w/K
         hXmTtOOUIEsfuRj64Al9u53S7dlzR55+rv1tegrMKbibrS2VptVcZW2TIGvzVlgzM4E7
         Ap/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881007; x=1782485807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGczc0SWnPbU2EjU0FYJpiIxDvOfiFmU2Kt+GQjhDso=;
        b=AEmH+F9589GPcvRzhg6MupdtILVo5EKN/G8iJaZ56l2I2GxdY0F30vxJHaFEfRtNGp
         brSM4pi9flte61fKc3WCnK2RRFY5G+4H53VrlQ0dkAVzzIvLUCrrFotZhhp+bEaT4DK7
         U7H6Zb4g97tJo5wf9kc2yWCI7ZkX07jGCbBQq8+ZV8HT5+o53LDtIUXMrVCUgxqKBOrF
         00vER9YhD/gsDzW0HZeAgl9fekWqhqSknM9PcUIIlaBLniiwqOsSceX4R7jFfYmg6bCA
         k+brvAJhL+G9488wN1KSKvsHL/ItaBo+cgf1wAXA3J63Cq6qRewwKTHnokxEnxRBcYGH
         r+EQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WvhwSdhW/R8ci1ZGiDbS9K//4lXVx1a63P7wMpVjQP5LfwnTpTnnazBOUOmEZ9HJ8Ps8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSU6SjMtv+6FEphCVMNqFgVDWee4WKBaumjOfZ96aYO7GdEfPR
	fllnrkTObHIQFgp4gmeSB9bQnI7C+aoAbPcmYvpiepsSRRLcliuDcBgT
X-Gm-Gg: AfdE7ckbZzEpNeKOB0aiireLu94fhbgPrWmyWTRU/UdnpQTlXipGlvYUKWiGMWeMXj9
	/KAXK0ezRL/NxtP2enFSO/8nHZS6OGRG4Lsggul6Tx+1ZFJtDmgRpVHZvUw1+NGYZ2LrJkrITPr
	zORusUjcv5ApjhJYzL3ViRhlVDzWX0r7SyVy3NMraoWzp0ljaApiKt1JXBTXHvFosa8yp4fUt2S
	qeAy/WpLqd4jiRkUtwUCgcqPUkZ6QunmWEA+/0RMpOVGXuUppeRL5Pve4eyRa2hFkYrAWjAVhAE
	Fmi5PjRunfyABnSffZoCGvDqvmm4RtGCWctwUXi2ssz08C2wyeN76f3IO6VI5tpEO/xsTVsiA1d
	vNe3lvnpBECAUfSEKD9G3yvdSwNl1qsNvXo7XzOAManj1G/kqRxQCOHZYTudcONEqRXOYdJS+h2
	bBb5SZ7lBQxZTO7C0YK0uZbaEr8f65I8ws9L8ZLo2ZeU14kXzL5GWKe1ujh1luQCO31/kr0JUxM
	oyw8oJasE0MMRMWe59E+QU8sp/pcZSQ0Z24AY3QKkDc9u2RSy8EBpOFD5KiS7l4wd1YSjISUsDy
	v1Zb3s8j6aceLD8g3K99RaU1NGz36hj+WE89GR836ZpbkmNVnAlWMzCUsKCqJLa+nFA0+6aXY2j
	KoFV2hHj+p0HdCg==
X-Received: by 2002:a05:600c:6216:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-4923f571e98mr68882445e9.22.1781881006287;
        Fri, 19 Jun 2026 07:56:46 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.56.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:56:45 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: gitster@pobox.com
Cc: peff@peff.net,
	eric.peijian@gmail.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v13 00/12] cat-file: add remote-object-info to batch-command
Date: Fri, 19 Jun 2026 16:56:29 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260608-ps-eric-work-rebase-b73ae84ba671
Content-Transfer-Encoding: 8bit

This path series is a continuation of Eric Ju's (eric.peijian@gmail.com) and
Calvin Wan's (calvinwan@google.com) patch series [1] and [2] respectively.

Sometimes it is beneficial to retrieve information about an object without
having to download it completely. The server logic for retrieving size has
already been implemented and merged in "a2ba162cda (object-info: support for
retrieving object info, 2021-04-20)"[3]. This patch series implement the client
option for it.

Eric's series adds the `remote-object-info` command to
`cat-file --batch-command`. This command allows the client to make an
object-info command request to a server that supports protocol v2.

If the server uses protocol v2 but does not support the object-info capability,
`cat-file --batch-command` will die.

If a user attempts to use `remote-object-info` with protocol v1,
`cat-file --batch-command` will die.

Currently, only the size (%(objectsize)) is supported end to end in this
implementation. The type (%(objecttype)) is known by the client's allow-list
and request path but is not supported on the server side nor the response
parsing. A follow up series will add full end-to-end support for %(objecttype).

The default format for remote-object-info is set to %(objectname) %(objectsize).
Once %(objecttype) is supported, the default format will be unified accordingly.

If the batch command format includes unsupported fields such as %(objecttype),
%(objectsize:disk), or %(deltabase), the command will return empty strings for
each unsupported field.

This series completes Eric's work mainly with the refactor of the validation
of the placeholder with an allow-list that filters what the client asks with
what the server is capable of provide following Jeff King's idea [4].

I have a question for the design:

1. If the format includes unsupported fields such as %(objecttype) or
   %(deltabase) it currently returns an empty string for each unsupported
   field, this follows what for-each-ref does with known but inapplicable
   atoms. However future placeholders that will be implemented: %(rest),
   %(objectmode) can return empty strings. How should we differentiate
   "unsupported" vs "no data".
   Eric proposed to use a placeholder like "???" [5].
   Should a placeholder be used?

2. _tangent/not related with this series_
   'a2ba162cda' is designed to only work with full OIDs, which is
   inconsistent with local `info` that does support short OIDs and in
   case of being ambiguous returns a list of what possibly the user meant.

   Because V2 protocol is thought to be stateless supporting short OIDs
   could become more inconsistent with other remote commands that do not
   support short OIDs. Maybe a --pick-first option? That does accept
   short oids and picks the first match.

   Alternatively, would sending a list of possible OIDs to the client so
   it can re-request with the correct one be ok?

[1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
[2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
[4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/
[5]: https://lore.kernel.org/git/CAN2LT1D3d=yMYVhBjpj5PvyjfTVjwqcFPNViuCJ=f49YbCZuJg@mail.gmail.com/

Changes since v12:

- Remote-object-info no longer dies when the server doesn't recognize
  the object, printing "<oid> missing" like `info` does.
- On 12th commit explicitly cast to int and add a comment explaining why
  the backward iteration of the list.
- Renamed 3rd commit and in the commit, change the signature of
  dispatch_calls() as it is only called with size_t instead of ints.
- Because remote-object-info does not support short oids add a check to
  improve the error report if the oid passed is valid but not long
  enough or if it is an invalid oid.
- Fixed overly long lines.
- Reworded 4th commit.
- Avoid unnecessary request to the server when no placeholder is supported.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Calvin Wan (3):
      fetch-pack: move fetch initialization
      serve: advertise object-info feature
      transport: add client support for object-info

Eric Ju (4):
      git-compat-util: add strtoul_ul() with error handling
      cat-file: declare loop counter inside for()
      t1006: split test utility functions into new "lib-cat-file.sh"
      cat-file: add remote-object-info to batch-command

Pablo Sabater (5):
      transport-helper: fix memory leak of helper on disconnect
      fetch-pack: move function to connect.c
      connect: refactor packet writing
      cat-file: validate remote atoms with allow_list
      cat-file: make remote-object-info allow-list dynamic

 Documentation/git-cat-file.adoc        |  25 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 221 ++++++++++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    | 106 +++++
 fetch-object-info.h                    |  22 ++
 fetch-pack.c                           |  51 +--
 fetch-pack.h                           |   2 +
 git-compat-util.h                      |  20 +
 meson.build                            |   1 +
 object-file.c                          |  10 +
 odb.h                                  |   3 +
 serve.c                                |   5 +-
 t/lib-cat-file.sh                      |  16 +
 t/meson.build                          |   1 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 699 +++++++++++++++++++++++++++++++++
 transport-helper.c                     |  13 +-
 transport.c                            |  28 +-
 transport.h                            |  11 +
 21 files changed, 1215 insertions(+), 75 deletions(-)
---
base-commit: 4621f8ce5e9b97aa2e8d0d9ffe9d25df2471074d
change-id: 20260608-ps-eric-work-rebase-b73ae84ba671

Best regards,
--  
Pablo Sabater <pabloosabaterr@gmail.com>
