Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A153C13FB
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029516; cv=none; b=OEVN4sII5po2YazdDlMABoyLFN30u83tZB/ypMO965mu/LzeQgkqLv/6MQp3epKy3jBgTocS3vODvh9oKg9/01KbD6SYT6RMRdIU3q2OlR7UkvIo/WJkg9Vvmf8QJ9HR4ijgMm6ExTnhJmy83MuZjEcu+Qx4C2RzbiJxdTXJ0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029516; c=relaxed/simple;
	bh=Hf/xnYCJR3WYkOC1f7flbQjlqDIUAX381Vn7otmnu4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuzIi+nbyaboPvsc2ENvVz/4QpQN9iGJUkVAd6gu66A7YraZHSqVkq0kMdNTz/NVDz5gu68m1lXpg8MV7vY6S6dgEBeUKKc9FmN4TgJy9Cgjp7bbJUQxkHHVRU70ckyMaW/2s6b3pjaaqUQvWi0C0it3U4apIdXsv1tHTcJQgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oK7Sir+H; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oK7Sir+H"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso32634135e9.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029513; x=1784634313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0W6UpRK5Cvyf3QbdQfc799E3haUpkVwEOnacsMWMhM0=;
        b=oK7Sir+H3mSUtEEaOJbYvADtwR14KIXWYTuNE+kq0yxAq5U23P4D9jpyiOV3+K1FUw
         5NulcI5/51MOM6TyQoFfPnXH7Ob6WCcFP9KoMmSJMjOAD6ZNXCizzLoFVV5DcFeUogtG
         bpSCI0PwPZwwkXInUaNBrT8C5MYnidSb45E+CtEci4GiHnpF/DOQATtzItjxF2KYrXzT
         mr0WKOrgNQDkOyXahzCu9mK/j0i07yVfETgD2tpQjygelIg4TZ6CZCRwXLwvxghkH06h
         xUiswMRyg27u13o4N9M5fSFyMMbIQjZ8wVA4phTv70fJmvYNKgovWAbngiZdFxEhc0Y3
         DfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029513; x=1784634313;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0W6UpRK5Cvyf3QbdQfc799E3haUpkVwEOnacsMWMhM0=;
        b=lPRYn03gi73zm+QlBEfNxlTMqkHbBEfzVQU3z5z8goSTRCPv9fEmM9DlRzeZOIi6lq
         J+grVOMovbEbta9PCbwAzSqfIM9lfnT3WAN5DtbgUsEFcbUWpoDDVmmmBQ0ksI1y527C
         2q+2MEq/tiT/atFgkINX9GWSujs7Z50d4HzkhjjVGfdOB+VrcB8vVN+FUdWyrtYWROdA
         pZXY/Fwll6Ea8CIv6Bi/y9st5Cj2fOD1cwMh5tTcoJvcxZSmpuU+Bd3lG+vuXSy5IZIL
         tp0k+NcETIT/au/BOI50GrkH779e5Y5BQ759Qp62Mi7wFtUg3MQsLf/FBGT1JAfOlgUG
         fTyw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/7QGTIInzm1Us9tjtxLLIf97qQWTmwuxqKXEZzXpl/J9/nDaEqUZvTSE4Y5K1fhWPue0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQeLWevjgQpEeetdjDB8W7/m4op0dbVjkyEjfcMp1Rtj3i8npe
	W6w0OqEkrzWZbkDv/2BDhXJd8hIWqObWxXNmFMlNsfx0krQj2Hp0sczg
X-Gm-Gg: AfdE7cnSHBuO9sxFSxxAFIQ7Y/AZVtMVECir7yrDoir1QyBS4GW4dMeV9jwXf0c5NfJ
	fvJegVBfY3SQWEnuMMttH/MSFw+XPe2YNYsgzpyQa/wzJR/lJptiU5b1/OocGPhVe5uUS43qBtv
	akkJM/xhDp2asEY5ZF1n4UjqWAJm64TxIqjBySKYZQlQvtXEJL7kBKZTzN1fBOTHGjNOVUz/V5E
	wPm23xhJox24zZG/NkjJRUglUU2nszf2OedxCEkmDx4AqB1EU3tABQcd7exBtNDtBFKopVDdfwc
	wWo3YHtPlJDZc50+zJGNO1ryL2oBvUG84Vr2mkLSA6wUbnl5ViY1NTXIAYpC5mcWJ12u2rLT9cv
	2+89nvvtYMvSnRBbHJE3QeXTzbpxpX/qlvJ3PyymvrlRvRJKmXVZMOHtij6xaHGaHfLqphfWjDY
	czNBfptFY2SwB6yd8SHvfYOBPbYdYLdGNdanZqrIZh1wSBa4MFKP99nAghKFAhmXG16BllYk2Y9
	miR0JhMZGraSgv8E5RghGbpeuwzj16hLLuZFwIjz0WPDIZQqhj9XNiGCUyOvHncEboXWwQTTmem
	unOASmU0OlNFLjXveSRbJfIMAHrtQvDw+uL8aMuzuOAmdCWNOMtvXreCTFKxR6kGEG3CrDZITzq
	yz4I46Zvl03YZqP67rJos
X-Received: by 2002:a05:600c:a016:b0:493:f442:3de9 with SMTP id 5b1f17b1804b1-493f883174amr130645005e9.27.1784029512758;
        Tue, 14 Jul 2026 04:45:12 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:12 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v17 00/13] cat-file: add remote-object-info to batch-command
Date: Tue, 14 Jul 2026 13:44:56 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
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

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/28435046129

[1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
[2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
[4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/

Changes since v16:
- Droped a wrongly introduced include at transport.c

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
 fetch-object-info.c                    | 129 ++++++
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
 transport-helper.c                     |  15 +-
 transport-internal.h                   |   8 +
 transport.c                            |  45 +++
 transport.h                            |  10 +
 22 files changed, 1254 insertions(+), 86 deletions(-)

---
base-commit: f60db8d575adb79761d363e026fb49bddf330c73
