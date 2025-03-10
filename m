Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6B22318
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635134; cv=none; b=KbMESwUY3zAyAqO+P666l1Qgk0BfxGK8ZnhvqfoHykDQX9V70HrCS/jgoT4VSOgKAXV1KjEGE1IVjPhveTfGoxOHC447bXKVp5/GvsKIRa73v9Q/pHF8LV8i2AoswzV/o/MugittocgkY/7+ph5MrxnH1r4xP0P9/lc81YD2M24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635134; c=relaxed/simple;
	bh=IiJZ+/lGHP62JKtFfeLKxVnblQNImWJDosg3k3zzM/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8668QrDG2SOdPFQKtsaGr6anmsli8uXVfpXPt6oEOBjClSqSxAifcHPxtimOxUNnkS18cJZpejumORm07IjZwkr+wHNYhcHKern3ZwhxvQ96s5PochlMqE5eJbFYHYn81vLtoXN/Sng9KUh9tMJE8jgwu/uEUMDh35uWrke3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUI7MIpJ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUI7MIpJ"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f6aa4b3a7fso727101b6e.3
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741635132; x=1742239932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h2KCUd0MoOanUKXP2Uhkc7oc6TjB038/p7mgg2sKQXk=;
        b=eUI7MIpJgJmQvaZiNOBQeqy3T/gyNU+jPmZ1H/6+uscB+9W2DkPlA/2a++kTqyZNNA
         DcShIzrI4UihlBIfsjg5cI6tO5BGJbaNJOpHdO61kTIwEFrQ+M9+F4C5TOZIq3PoCqOV
         +4UZnG64ERZuyzHPCblFo9l6dudjvLOIvKtvzi7SdfC2MIFY41Iap1OCHCc44o4i1EWD
         2Uwqnxq59nfQMLwSxd9qbeQWckVdlE3s2sFWSZKFVPzOI9FpDmaDRmfIFsSQgm5JMkDt
         kBL6DMLFNhmV2NAdo10BRHHBLtRsXrjzThdtonFhnE5qREdIY0O8jl6U4NLa4NFIf6rA
         qS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741635132; x=1742239932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2KCUd0MoOanUKXP2Uhkc7oc6TjB038/p7mgg2sKQXk=;
        b=XCmhGRxcOzu6zxoCTvXlObsPBH3R9KYakgoB2K91ZJmLUPAM6w9tv9QbG2vMjxnLCf
         E2xNr0kZBKYiyRNJhZ8ZlZZcxcSMJChrBAAfrYXlHiWXZLpC7Kef+WoFQNbnYBR5ru45
         FJSM+UslIOK0AmylFtFpNbEQOKNbdXaSYUDciLb1NjJ+XCKE+oF5DA202a/9cktfvfC0
         dGvz8w7vJ0wOWSv8huPfJCd5/imQ84jg7Gz+GWjqwMEkSRKxoaxzGb8kSj+IJMRS4CXi
         ynvuLQcJ2WlGShVJksvaKUUm36f10My5OfPTUzlSDwg7UYttMao6XJQYjwIjB2UPPeoO
         CQ6A==
X-Gm-Message-State: AOJu0YzG+iJYXjSiBDy0HGld5nVIj1srob0YPzgfLP4KuwgxQ6xrPkTL
	oPEV54e4daepB0EgflIGHhHHLiNG9gOLFqu2vMkQ1pBte/ql7WJc0ZUkcA==
X-Gm-Gg: ASbGncuHamv82ieogyX2R+sYWbtdgyHfWKasdobu2gbKsktt91InrMBV0bfXEQErbT+
	7wSZC1yeaj04TJMHHN9NWNLXZJZpAfeyq+VolwHlXMrUXgExRiokZqIiRJ1Ps6+LP4XvVMocjXV
	yS9IrgtYOibxNZiwn82VcWNTYtQte1luYUGbbxsCXh5tjbsx2yp9g7KBOXFhW+iB+n0cmnVMCS2
	DqcUY7LbyTNgDoaZbRYPM2UcEZp3Ds8ZTo5YfDxfH0oJBd/CHsn0R4jbmIreBHs8FQTkL7pIj1P
	EEWOxvN+8IUvCswBvpmEYuTbUUFIQP5teeGGIY1lXsnEpXG+z6pj
X-Google-Smtp-Source: AGHT+IGx6Va/3tVGJTf/fwoQf+ZLeokWa3IokSuHL7NBdpQ+QfRqTNuxrR3p/FTOTZdjCBjrWgxBWA==
X-Received: by 2002:a05:6808:3206:b0:3f4:e8d:ab8e with SMTP id 5614622812f47-3fa298c04c3mr526652b6e.8.1741635131519;
        Mon, 10 Mar 2025 12:32:11 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f861f30de5sm697819b6e.46.2025.03.10.12.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:32:10 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Date: Mon, 10 Mar 2025 14:28:25 -0500
Message-ID: <20250310192829.661692-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When walking objects, git-rev-list(1) prints each object entry on a
separate line in the form:

        <oid> LF

Some options, such as `--objects`, may print additional information
about the object on the same line:

        <oid> SP [<path>] LF

In this mode, if the object path contains a newline it is truncated at
the newline.

When the `--missing={print,print-info}` option is provided, information
about any missing objects encountered during the object walk are also
printed in the form:

        ?<oid> [SP <token>=<value>]... LF

where values containing LF or SP are printed in a token specific fashion
so that the resulting encoded value does not contain either of these two
problematic bytes. For example, missing object paths are quoted in the C
style so they contain LF or SP.

To make machine parsing easier, this series introduces a NUL-delimited
output mode for git-rev-list(1) via a `-z` option following a suggestion
from Junio in a previous thread[1]. In this mode, instead of LF, each
object is delimited with two NUL bytes and any object metadata is
separated with a single NUL byte. Examples:

        <oid> NUL NUL
        <oid> [NUL <path>] NUL NUL
        ?<oid> [NUL <token>=<value>]... NUL NUL

In this mode, path and value info are printed as-is without any special
encoding or truncation.

For now this series only adds support for use with the `--objects` and
`--missing` options. Usage of `-z` with other options is rejected, so it
can potentially be added in the future.

One idea I had, but did not implement in this version, was to also use
the `<token>=<value>` format for regular non-missing object info while
in the NUL-delimited mode. I could see this being a bit more flexible
instead of relying strictly on order. Interested if anyone has thoughts
on this. :)

This series is structured as follows:

        - Patches 1 and 2 do some minor preparatory refactors.

        - Patch 3 adds the `-z` option to git-rev-list(1) to print
          objects in a NUL-delimited fashion. Printed object paths with
          the `--objects` option are also handled.

        - Patch 4 teaches the `--missing` option how to print info in a
          NUL-delimited fashion.

Thanks for taking a look,
-Justin

[1]: <xmqq5xlor0la.fsf@gitster.g>

Justin Tobler (4):
  rev-list: inline `show_object_with_name()` in `show_object()`
  rev-list: refactor early option parsing
  rev-list: support delimiting objects with NUL bytes
  rev-list: support NUL-delimited --missing option

 Documentation/rev-list-options.adoc | 26 +++++++++
 builtin/rev-list.c                  | 86 ++++++++++++++++++++++-------
 revision.c                          |  8 ---
 revision.h                          |  2 -
 t/t6000-rev-list-misc.sh            | 34 ++++++++++++
 t/t6022-rev-list-missing.sh         | 30 ++++++++++
 6 files changed, 155 insertions(+), 31 deletions(-)


base-commit: 87a0bdbf0f72b7561f3cd50636eee33dcb7dbcc3
-- 
2.49.0.rc2

