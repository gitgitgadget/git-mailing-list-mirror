Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38D27B32C
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300738; cv=none; b=MlOfeWFG4uBiGgJ1aBP3W7w5kRIy6Cf0Kh+pmJiNU53RnOLMpAv3tI/WymNVhKqL7rYsst+n+CPgF2r+JyHJqfFUo7Rt9q13b3hDb4LcQY0ysu1p/JGIBKj/5AK4BDCekJdf6auETx5fYXrtCmgEXR+HALpcpii4TdGnjOhU5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300738; c=relaxed/simple;
	bh=pZOOokaNM1Vks3ZpcIzl92Y85eND9+VSymSZJIkYic8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWtNtFeUPWnXCklt5OHAwYTvzmcrAjX+A4MUyEHQPCGZrUaC/T2dPQL2A7ucL2//5LdBojcNnr5WST1ifDyG2DsLUdK5/Q+lbaQv+FdgSdNpsRYhJaQsizW4IS9jO/eMlHzVUhcTFRUTIsNavQmDN2GJQVX9+FLUcgQNVzczrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oaBy8sGe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaBy8sGe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954afac04bso6434675e9.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300730; x=1784905530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qhVCYyhhrvrchptMzJk6w0Tsu6fUNJhCchPryNq8l6o=;
        b=oaBy8sGeKLdK4BazuFqKZu/CNWvZN8NV1OsLxFl2Pw7B9kzw4aZ3EH5hnzWb4LR6Xm
         AezeaNH2n9ZTCbsi4c1onyWx/E1xe6oAuJQDNN1muLmJW36BFKrOP/A9K5343DWRrGDx
         chlA9qnALAUcqS1jYDgqIu0s7JnbYlLQVgwIuA/lhi2JX5zEztMEg/hx4IZ4mOY/ucV7
         uyhxhEAwxLITXcl3B73WHXA65QUGu5JNzf9x0l7flJpkktx2SzyuWPBHqZyS488g/yAY
         N9qIeD0z++SgUS7QpKEKRLZc+rgmmQvgOICfSxjlCdt1UUabdHtOVTFXabax75nsBBXY
         U5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300730; x=1784905530;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qhVCYyhhrvrchptMzJk6w0Tsu6fUNJhCchPryNq8l6o=;
        b=N13syBIJnICD8le5Gg4WxuIIvtKOUYDX5hptYDg98gK840e3t8gH2Pt0y4ckn7dJTR
         FGnH/+6t0JugwRvFMx74ldmszfUC6PSyYrntW6gg6w5hO9Ss8rkq3poc95EP29ATy/xw
         V373MQyYLN5Ilsy5pAaQEqTfIxH3BFoC9eiXYVmAyrRyJq02q7dH0xmQNUvVsWWxA7wf
         TJiFMQNK/oyL/ndV78Et2wo1BC11QxqCFf5ZXR1X9i674A+fmXbUXd7onJQBto74kM7b
         tI0wEcuoti6G19pzTWvx850pfO+VPh/qvG4KnbfJyWQo9InmyvlKzFi0oslfKDQKW8Te
         pPdw==
X-Gm-Message-State: AOJu0Yy19JVbOEdK8dy152RhyF5HDn+BBYQ+0KzB0QnVUk0Zs6EBbOX9
	BQyLFjNe8fMYPeaxl/59UcuRP2n8CBcHvEFX1Eropx8Y5k7EA6HjyhjU2K3bxUv9
X-Gm-Gg: AfdE7cksvDNTyOkaz+G4SsbTU/OJ651WnC5+cLlNUwZMsaRuhlshrYtn8Oo97Q2hQuw
	MNDR6RCGANYh1AulBQl82C9+OJvAybtLuRvEqFy2CVeCL88PzPsMeOaqfkgp+y9UKD/k3TtJk7M
	w+HTUd7udLThoseScXPFhYHhMECHQTPxTS3d7o6XwMqrdJGtW+6ORYiFZ+Cuc6GpJaeivbG5ZG7
	Wq/378zMS0j0mRNOK4B5LwwaA0BhHkcuM/4qrxmVKlNTWitjLjpe8lvISHAQMUvXnaDwXVJTOT4
	44QTp1ExX79GDo5HaBFyoaT8A5NslRBlQrTBVFvZGmnNhVWIF3q7At+8GCvm+aMh0PoIO2/aT9+
	CIOJmfu6uL6BDlow10fOvn0KnPcDEjPwmifdiNleqijPlyWNvua5bJmEHYSA20KTIQd2qMvUTvt
	os9TguSIzluNmQP2MyEshJxAKpBkIJ9L8k4+O2gCFDQARfFlGp9RurU8xXJYtdlWIuos+gkiTt7
	O0xGAInOhdl/Qz5zawUPf1mUOmCjoCZ2CjGKHkMHZknd/vgLjiuQVIO9aaZUML3WXpUtTwY23sM
	Xr5CT8sVrGj+ZYEIT11RY9p92OUYdNTn
X-Received: by 2002:a05:600c:4687:b0:495:4df2:7412 with SMTP id 5b1f17b1804b1-4954df27450mr9740835e9.32.1784300729274;
        Fri, 17 Jul 2026 08:05:29 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:28 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v19 00/13] cat-file: add remote-object-info to batch-command
Date: Fri, 17 Jul 2026 17:05:10 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260608-ps-eric-work-rebase-b73ae84ba671
Content-Transfer-Encoding: 8bit

This patch series is a continuation of Eric Ju's
(eric.peijian@gmail.com) and Calvin Wan's (calvinwan@google.com) patch
series [1] and [2] respectively.

Sometimes it is beneficial to retrieve information about an object
without having to download it completely. The server logic for
retrieving size has already been implemented and merged in a2ba162cda
(object-info: support for retrieving object info, 2021-04-20) [3].
This patch series implements the client option for it.

Eric's series adds the remote-object-info command to cat-file
--batch-command. This command allows the client to make an object-info
command request to a server that supports protocol v2.

If the server uses protocol v2 but does not support the object-info
capability, cat-file --batch-command will die.
If a user attempts to use remote-object-info with protocol v1, cat-file
--batch-command will die.

Currently, only the size (%(objectsize)) is supported end to end in this
implementation. The type (%(objecttype)) is known by the client's
allow-list and request path but is not supported on the server side
nor the response parsing. A follow up series will add full end-to-end
support for %(objecttype).

The default format for remote-object-info is set to "%(objectname)
%(objectsize)". Once %(objecttype) is supported, the default format will
be unified accordingly.

If the batch command format includes unsupported fields such as
%(objecttype), %(objectsize:disk), or %(deltabase), the command will
return empty strings for each unsupported field.

This series completes Eric's work mainly with the refactor of the
validation of the placeholders with an allow-list that filters what the
client asks with what the server is capable of providing, following Jeff
King's idea [4].

Github CI: https://github.com/pabloosabaterr/git/actions/runs/29586719871

[1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
[2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
[4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/

Changes in v19:
- Changed the commit structure:
	- squashed v18 10th and 11th commits into:
	  cat-file: add remote-object-info to batch-command
	- Moved after the refactor and renamed:
	  connect: use unsigned int for hash_algo_by_name() calls.
	- Added a new commit:
	  protocol-caps: ...

- protocol-caps: check object existence regardless of the attributes
  requested; a bare OID request now gets an existence check

  Don't lazy-fetch on the server to answer object-info
  requests (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)

- gitprotocol-v2: correct the object-info response grammar to match
  the implementations

- fetch-object-info: validate that each response line echoes the
  requested object ID at that position

- cat-file: the remote-object-info default format no longer leaks into
  subsequent info commands in the same session

- commit message and documentation fixes

---
Calvin Wan (3):
      fetch-pack: move fetch initialization
      serve: advertise object-info feature
      transport: add client support for object-info

Eric Ju (3):
      cat-file: declare loop counter inside for()
      t1006: extract helper functions into new 'lib-cat-file.sh'
      cat-file: add remote-object-info to batch-command

Pablo Sabater (7):
      transport-helper: fix memory leak of helper on disconnect
      fetch-pack: drop the static advertise_sid variable
      fetch-pack: move write_fetch_command_and_capabilities() to connect.c
      connect: use unsigned int for hash_algo_by_name() calls
      connect: make write_fetch_command_and_capabilities() more generic
      protocol-caps: check object existence regardless of the attributes requested
      cat-file: make remote-object-info allow-list adapt to the server

 Documentation/git-cat-file.adoc        |  28 +-
 Documentation/gitprotocol-v2.adoc      |  21 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 214 +++++++++-
 connect.c                              |  38 +-
 connect.h                              |   8 +
 fetch-object-info.c                    | 156 +++++++
 fetch-object-info.h                    |  25 ++
 fetch-pack.c                           |  58 +--
 meson.build                            |   1 +
 object-file.c                          |  10 +
 odb.h                                  |   9 +
 protocol-caps.c                        |  45 +-
 serve.c                                |   5 +-
 t/lib-cat-file.sh                      |  16 +
 t/meson.build                          |   1 +
 t/t1006-cat-file.sh                    |  15 +-
 t/t1017-cat-file-remote-object-info.sh | 747 +++++++++++++++++++++++++++++++++
 t/t5701-git-serve.sh                   |  63 +++
 transport-helper.c                     |  12 +-
 transport-internal.h                   |   8 +
 transport.c                            |  44 ++
 transport.h                            |   9 +
 23 files changed, 1437 insertions(+), 97 deletions(-)

---
base-commit: 44de1520f08d1dfebc3ab2d9f644208eaa5ac925
