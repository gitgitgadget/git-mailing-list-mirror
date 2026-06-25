Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8B3D9DC1
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389623; cv=none; b=kAt0iLuPHSiCn/UJuVoz3R3wbo8oMe8BXcjiNJb1mboVFpGeAkRIvmZP76crTiMSfEd+3J80Snpoo7Xf8MVOfBNnfUogjFF2swIm510yfU8LgxR1TL3WRl+tfI2+/czQPjz+3FBb3KMBxml1WzX8Kg3OKWOfKaq5p/hQY+aLoUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389623; c=relaxed/simple;
	bh=ozn7HGygY5zUyrQkd4hh0H/C10NJ4SJN4sxlI427VR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+rzg6HQer5jun6bXZkZCSyC86eB8gd2RmLX9gz4CjEm3PFkTmvKT7IqP+wqWqacbAO7p6xWqTUMfhJqyt4RGzNryUFM7qGSLoAKH7bRP17MM5FHR6Vmf6jSwgWgES8YkPyjAKq3pN3D+QY9FSfNNLlM3wBAhVejJKYjB7bduv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmId5w0B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmId5w0B"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so10619595e9.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389620; x=1782994420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2oVJ0CXj8Z2YuA23HsfdcuHT4AwCBSjQ64nAVjq7vA=;
        b=qmId5w0BPE2mUSZhwEAw0sE4+h1tRBqK2k44A7xh3HIxiISDqcpPw9dhi1WDei1oMY
         tk8M61fWnKYe/sK0Y3hbViJ0HNu1d1BI5wdvQYZZSXA5uApIM6usXw3NOlYlSCv3mDQ2
         0PBW2z4wNO2M+rHkmvT5Xzyn3AZyGbZg2HY4yi1ZA2crGGCBWVZ/qtgMsIzd5LnSxjQG
         NwOEBnu7kWyMrUSm54l0J/cYSy2QdyIFGwWc4j8OzkL/MFLYHU/IX/gSrRBU9NyufomN
         3UFmQwAZXRGA2YtW2BJRqobVSCwLhzkoyqzeDqBcOqL9dGZOt4jDGM2qZBEkM6KEJjmH
         nU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389620; x=1782994420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2oVJ0CXj8Z2YuA23HsfdcuHT4AwCBSjQ64nAVjq7vA=;
        b=b3HWp6V6+jNPi2WyHsUOGt9wZTBMwKhUWSIO/Vi5LKpp+7/V2i47FNrvovOhr6Y6e+
         Vp0r+GTCmdPco9uNN9z/i9XsZG1tbKRQ+aD0dHYMEKCjYluxqWKPHN71YA36/GYM6Qxg
         WbUeiPGpLPptA02hE9rEWeRdCVJFZTs3vrZChqC15hg+6hCZ5VpW1XgPyEdr5uajgoS5
         FAEraLrpUcojBPT+b1bTOlnupWZc8ZZqbwPNnPPUtKQTMGdB0BVIlZZKK9C2yezvH/ky
         JKUeUguBgrRxDokXEdNmF/nMGzOafyWnWnXWig51gMBFJFqGKjE8DWBumJTZgaGQ35Dc
         By3A==
X-Gm-Message-State: AOJu0Yzos+sw54VlLOxfKoAFlnTZDrfLPMyU5oxF8imfdZIiTu0q+rN/
	XBMaAFXBx+vxSHLxjRqhUW8e61vbXPMrJdc3ARXmF2ImmwWNtU78NgEHgpeqW09C
X-Gm-Gg: AfdE7cmkMQ9BcXhQQUcjKi8szr/1TvvrlzXI+QWD5j6S3Pi4bfhDRkhO3cz8fJQyVbc
	hX393s46V+HH9UQ5fVZ4sHyMEJViYUSLbu1G2N+QIScaR4P3cf99LZMoohxm4kmMP78bTeKeO3h
	Buzmt5hdn7+ZOFnIwuiYf7DVC/LzK6ZshxyZosJ1VjBcJ1asSXBxVoSeUueyXj+q7tn85GyyN0W
	vgg1xWUD7gPhcMMX/gGVIW5BA529BYvqg6xJlHTW+f+4txynzRLyKEdh/W1yQdMdmEmOIPAnuJP
	A9DKyMkHTT22QhoxkymIscT+JKkdyXhoncf8XY3uV7i0RssrdBvD45DoOiQN6ppgNbgJO1zylLv
	eYgN8pzUgmnJgN/LUigRg0YTiV6CCQg4vIlRBfROrQp8gVUe3f5m6PwdREuqWXNr4mN+d5UaO7t
	CHKJncJcA3e1Q3ARemyCx2jGgA9NuFRhCsMnkxGZMI9KlpkBH9UgJ/jkjScTJcBn3O37HdXPKxT
	tIaKogc1UhYAl05Gq5ddmMY1DwtkFK/Zt32kT3qO+PjC1+YatKOFldc6OWKmjZdiqd1aPSqIiy0
	+YwiSUntuua6pdXdeOB33C06zy3m+3cQ8NmId1m4R62eN89k/gXHkoQs/x1F9MWs9ffnqxSWbvJ
	KjAxCqWNL9g==
X-Received: by 2002:a05:600c:638e:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-492663ea3d3mr24169795e9.8.1782389620032;
        Thu, 25 Jun 2026 05:13:40 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:39 -0700 (PDT)
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
Subject: [PATCH GSoC v14 00/13] cat-file: add remote-object-info to batch-command
Date: Thu, 25 Jun 2026 14:13:22 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260608-ps-eric-work-rebase-b73ae84ba671
Content-Transfer-Encoding: 8bit

This patch series is a continuation of Eric Ju's (eric.peijian@gmail.com) and
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

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/28159024232

[1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
[2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
[4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/
[5]: https://lore.kernel.org/git/CAN2LT1D3d=yMYVhBjpj5PvyjfTVjwqcFPNViuCJ=f49YbCZuJg@mail.gmail.com/

Changes since v13:
- Changed the introduced strtoul_ul to strtoul_szt as a recent patch
  changed the type of object_info.sizep to size_t.
  <37d030d8675e94caee2eecb8398691d385d444bd.1781524349.git.gitgitgadget@gmail.com>
- Fixed commit typos and style.
- "fetch-pack: move function to connect.c" is now 2 different commits:
  first a cleanup and a second to only move the function.
- Fixed old code brought from the rebase to match upstream: use
  SHA1_LEGACY instead of SHA1
- Remove static declarations from cmd_remote_remote_info() and
  get_remote_info().
- Add a comment justifying why there will be no overflow on explicit
  cast.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Calvin Wan (3):
      fetch-pack: move fetch initialization
      serve: advertise object-info feature
      transport: add client support for object-info

Eric Ju (4):
      git-compat-util: add strtoul_szt() with error handling
      cat-file: declare loop counter inside for()
      t1006: split test utility functions into new "lib-cat-file.sh"
      cat-file: add remote-object-info to batch-command

Pablo Sabater (6):
      transport-helper: fix memory leak of helper on disconnect
      fetch-pack: prepare function to be moved
      fetch-pack: move function to connect.c
      connect: refactor packet writing
      cat-file: validate remote atoms with allow_list
      cat-file: make remote-object-info allow-list dynamic

 Documentation/git-cat-file.adoc        |  25 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 222 ++++++++++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    | 110 ++++++
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
 21 files changed, 1220 insertions(+), 75 deletions(-)
---
base-commit: ab776a62a78576513ee121424adb19597fbb7613
change-id: 20260608-ps-eric-work-rebase-b73ae84ba671

Best regards,
--  
Pablo Sabater <pabloosabaterr@gmail.com>
