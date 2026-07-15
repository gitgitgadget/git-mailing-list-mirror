Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912DE433032
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109149; cv=none; b=GalScw+19gHH9w/5F1M7G9S+8/qR4IvHodnfjZyO8bUvjhC+CVpUmRnQ1bWwN3WczRvbY6E8KzuiXfKFGKS5Alxhafiiq2CjwDrcYLiC1T5hvsF50zSRe405wuw21+i/R65GEwy8JFxVBV/t0DWAXkxl0Xv5pyADKGm4uKnS5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109149; c=relaxed/simple;
	bh=sTmu9m8iARBf8Va3Nc1OP71MYfbB7VAIMxOw+uOPBVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wpv2kaIw7COBp9PQEWOM3NPl8+b/tvBMs+w+WNk4L+7nI74FNkRa3WvKVA63LDs6JqkafzG0X8bP1H80xF/Fia5upZiThuAJedYmu3O1gZzjhek50VwjPHCmno/8ejC848q1hb3IQgYVEy2iPGwYFAQLXvMgPd3sc/9Sxhy43kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjF/g3if; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjF/g3if"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so3902340f8f.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109146; x=1784713946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s5SibpM1AdgDQC7nQ86G4cayF+YLNbd8M2QFihclh/A=;
        b=KjF/g3iftpw8qmKFeGK1Ih8JW6N/8ZZpb8ixJam831oyiUKbFvrLEPLKpZyXrZ8pEV
         2SWo0xFrS+RmGkbJ7u9kmK1IGG3KqUurWKbbCyEXopJrhxU9L1b/YLRorPFwHoAMsr4p
         w08Q7czsg4qA/5WP8Mx7J8k7LDVPVrSfl3hlWJJ6/PG4NmOvu4WpvqIR5iSI4gNgAAZr
         jyWIY7tq1C8b9Ky7t5ZLsNlQRVXEkAGFHnDaqL7O7liTdZ4CoF7GsLjAZNAtKKyySy9D
         sfQWglx8H77y4kZRoe5n+zv95cfUbuMGDstUvhxY0p0ZKxxxJ4fGCkRvMByFt+FT7rE8
         F74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109146; x=1784713946;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s5SibpM1AdgDQC7nQ86G4cayF+YLNbd8M2QFihclh/A=;
        b=rgG8q9D5diR7GPu3/Q0GW3dOmA+yL1HAsNvTFReaLkM5rCtmj+NK9bAfPgPk/KQp5d
         lccJdu97IkZYEpRZia8xKoluEarUPV3K9hPUT23xxm9+XaNh4YAJDzy6ZLtPAeNO5Hsa
         PETEnKMVSAneqV2uO6bgEIFxkYIP8ZN4cMXOmL4W7Xhe3iOyrjkydXakx3PqQQkvHW4b
         je1FIRYjBo5dYqy0BU1N8Wx6QvlH5U5T/zC4FJQMbc5Y959EIaCZ0r25J8MfF5qLdLh9
         WrlA+jJ3KyadjjOn1jK4MHVO2stlJn6zZnqc8wr1mRHwJyRrS1rC8qLhJFfKMLaRZGzz
         /tMw==
X-Gm-Message-State: AOJu0YzFKCd2gz7aM55RUVtr3uDSrgzCYphMTUXrdAfYXWYmh11gCQiB
	Jo3RB/wSy1ranrnE1buFtx8JezL8eL6RV7X4VTCZdUUeZiOYgn7v5ypyj5iew4CA
X-Gm-Gg: AfdE7cl6JsnZCQLipKUGfqgr69B4yOhj8SwYfr0au4xJRNyALjj96IWeACn95OFUHc6
	CgZuS+KgESA/L9hmfYujr5M0NpU2Qz9KpGU7P6FTOWtPDeGElIIyABWdeH4Pg0NBOf4wrHFqrzq
	DXuYVvYQ5QFRmmUg5XpFiY1MjKy3FN2JZpPrXTLv7PaAXaFn0EznMOIZ2JRS012pnZ9maOrN4Bc
	3rZbpcJ6Q+MGQfCuoDDkvcUlI7gDjBZyY9mFoiFYwWtN5zci+pQahD8BXPrCxceCBjtOeVExNnc
	Q1vIpyoPu3K5aWbFjqHxzrUhzhP5N3DRi3CUTL7QWJe/IRRXcebwKZBMpWe6SjwmMQLhSV4cOTe
	TaCSVVA+kj4mjUqrXWijjd0K0Pf9n0tYLUmPACaJWSNVa4A2dsSmBJfRLDt0PLCX0KYpRdPNbx8
	UPS/NRS8Ll+4bMxwBaagAz/RaSWgPfQ/yuRffylvGtF3uod5aElA8XK1IZFd31gtYmG4GjNIAx2
	MG6JasQ6njfL8vXwHuK5X50p1yhPZ8GauoY/cyjv69O405Z8czs6G+57Go95GtAIuLROCI8wkja
	KkkV1ckcpmkZZvJvmpYFIlXIh12/oabE4vpcp3wQDqecGtiibMObSRDYZnKLNpU1mwPOZtF/x5G
	NSUmmh8p89Q==
X-Received: by 2002:a05:6000:4904:b0:47f:3e80:7c3b with SMTP id ffacd0b85a97d-47f4fd1fd44mr2430796f8f.48.1784109145540;
        Wed, 15 Jul 2026 02:52:25 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:24 -0700 (PDT)
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
Subject: [PATCH GSoC v18 00/13] cat-file: add remote-object-info to batch-command
Date: Wed, 15 Jul 2026 11:52:08 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
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
This patch series implement the client option for it.

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
validation of the placeholder with an allow-list that filters what the
client asks with what the server is capable of provide following Jeff
King's idea [4].

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29404390713

[1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
[2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
[4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/

Changes since v17:

At 10th commit: transport: add client support for object-info
- style
- enforced the server response handling, not allowing bare "<oid>" or
  responses with a different number of attributes different from the
  number asked.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>

---
Calvin Wan (3):
      fetch-pack: move fetch initialization
      serve: advertise object-info feature
      transport: add client support for object-info

Eric Ju (3):
      cat-file: declare loop counter inside for()
      t1006: split test utility functions into new 'lib-cat-file.sh'
      cat-file: add remote-object-info to batch-command

Pablo Sabater (7):
      transport-helper: fix memory leak of helper on disconnect
      fetch-pack: fix hash_algo variable type
      fetch-pack: drop static advertise_sid variable
      fetch-pack: move write_fetch_command_and_capabilities() to connect.c
      connect: make write_fetch_command_and_capabilities() more generic
      cat-file: validate remote atoms with an allow-list
      cat-file: make remote-object-info allow-list dynamic

 Documentation/git-cat-file.adoc        |  29 +-
 Documentation/gitprotocol-v2.adoc      |  11 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 221 ++++++++++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    | 141 +++++++
 fetch-object-info.h                    |  22 ++
 fetch-pack.c                           |  58 +--
 fetch-pack.h                           |   1 +
 meson.build                            |   1 +
 object-file.c                          |  10 +
 odb.h                                  |   3 +
 serve.c                                |   5 +-
 t/lib-cat-file.sh                      |  16 +
 t/meson.build                          |   1 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 699 +++++++++++++++++++++++++++++++++
 transport-helper.c                     |  12 +-
 transport-internal.h                   |   8 +
 transport.c                            |  45 +++
 transport.h                            |  10 +
 22 files changed, 1265 insertions(+), 84 deletions(-)

---
base-commit: f60db8d575adb79761d363e026fb49bddf330c73
