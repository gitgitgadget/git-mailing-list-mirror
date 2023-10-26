Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E98BFD
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="Wi6Oax0f"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB2F1A7
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b2018a11efso1450909b3a.0
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698360399; x=1698965199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvQDI6qG2Wul0sr9tPgVFGlxgeN1NIKWM0XgJwH3k6Y=;
        b=Wi6Oax0fkrvC1NN1uBZxOC33n+WnC3k6zkb5XWppo+CSZJNo1yI1d0UbgjcJ/foWPH
         6K5xQRZpQL75AZQ8A9hN1fI2oylN0SdjbCNsii1Es5VPjd+IBK6GGIXEU+IQYT3aRn2Z
         8jbVbPH5dtpXWUK1I7ZQUXSIfAz7jDH0wbvT88bB/PDCszJzn98tQRkpWnPe1Cc+oFmx
         O+TsyQJYbLSRmRXR1fjI+XuByFiqjXDfbQTKKVDDiNK1i9e2HI1jqO8S752BZK2E0yh4
         3OlbgDssJbtPAV/geD3fPyjg4JOXt8H79J1pK412zsMZzuysc2UdIYzqzWfzNbKMRMiu
         lDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360399; x=1698965199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvQDI6qG2Wul0sr9tPgVFGlxgeN1NIKWM0XgJwH3k6Y=;
        b=C/0FVC4xROD3jDdJxRnrLja18l/Ons6WNRkda4Y/Da0TwpLvmnCuFWERnNYvmHcgP4
         DRzR1LjsHfqWb+gYVRaOnYXF3JA/X+uE2d5b3nGC+NkxHRqM+cx1RFb5s3j7Y8l1tJIe
         kZ35efuUDvkoBUtAnO8m/iTQZx67z7tesfwLTo7FmRlK12SJbu+bvvH5Jv6PJOgX0NSi
         v9IqdMT8Q0cP/UiGevoDvAf+aEBWLFeuMYoYaTNHKwnxQw7Cx5CTxJ4okUz75i+7O30f
         Bgp4e0kHC9vKQicVw/GywjWBAUDX7WovOqMAJm5ukZRo8yv/MFqlbKEwMYiy7ET/bkx6
         Jm2Q==
X-Gm-Message-State: AOJu0YyJf2wRN5Dun5iJ9mU3eKvYrVMhpilrd92/kvoPKLvDUgxVtMGS
	3LA+diUdNNzY3ksekURGf/pVnaLxMWrlgBXwmic=
X-Google-Smtp-Source: AGHT+IGHjGHxbYIh0A058hhF4RwVYM3NdywhqwtyzEivhy8GssHEbRNEIp9rjCdgeWnYVjSelJqNAA==
X-Received: by 2002:a05:6a00:939a:b0:68b:eb3d:8030 with SMTP id ka26-20020a056a00939a00b0068beb3d8030mr993462pfb.1.1698360399340;
        Thu, 26 Oct 2023 15:46:39 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-45-225.mycingular.net. [166.170.45.225])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b0058ac101ad83sm112318pgc.33.2023.10.26.15.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:46:38 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [RFC PATCH v2 0/6] Noobify format for status, add, restore
Date: Thu, 26 Oct 2023 15:46:09 -0700
Message-ID: <20231026224615.675172-1-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.404.g2bcc23f3db
In-Reply-To: <20231020183947.463882-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take into account reviewer feedback by doing several things differently:

  * Rename this feature (for now) as "noob format mode" (or just "noob
    mode") instead of the original "--table" verbiage. As pointed out,
    this no longer ties the name of the setting to it's proposed
    implementation detail as a table. Noob mode is not necessarily the
    right name, just a placeholder for now. Unless people like it :D

  * Instead of manually having to invoke the -t, --table every time this
    format is to be used, set the config option "status.noob" to true.
    Although this is logically tied to the status command, there are many
    commands that produce status output, (and this series adds more), so
    assume that if the user wants to see the status this way, that it
    should be enabled whenever the status info is displayed.

  * When running "git add" and "git restore" while noob mode is enabled,
    perform the add/restore function as usual, but display the table
    formatted output with arrows showing how file changes moved around.
    Displaying the output in this understandable format after each
    command execution allows the noob to immediately see what they did.
    Although this series only implements for status, add, and restore,
    this output format would make sense in other commands like rm, mv,
    commit, clean, and stash.

  * Works consistently with commands that already have a --dry-run
    (-n) option. The dry run shows the exact same output, but
    doesn't actually do the thing.

  * If `advice.statusHints` is true, add a table footer with status hints.
    Shorten these hints so that they are still clear but better fit into a
    table. Make the hint text yellow to distinguish them. The hints only
    appear when explicitly running "git status", which helps the user
    answer the question "what can I do next?". Hints are omitted in
    "impact" commands like add and restore. Having hints here distracts
    from the file change moves being showed in the table by arrows.

TODO:

  * "git status" outputs myriad other information depending on the state
    of the repo, like branch info, merge conflicts, rebase info, bisect,
    etc. Need to think about how to convey that info with the new setting.

  * Some commands (like stash) might need more than 3 table columns to
    display everything clearly.

  * For destructive commands, think about adding a prompt describing the
    effect, so the user can confirm before the action is taken.

  * Fix horrible things in the patch series code.

  * Probably other things.

Play around with it! It's fun!

Jacob Stopak (6):
  status: add noob format from status.noob config
  status: handle long paths in noob format
  add: implement noob mode
  add: set unique color for noob mode arrows
  restore: implement noob mode
  status: add advice status hints as table footer

 Makefile           |   2 +
 builtin/add.c      |  47 +++++--
 builtin/checkout.c |  46 +++++--
 builtin/commit.c   | 157 +----------------------
 commit.c           |   2 +
 noob.c             | 198 +++++++++++++++++++++++++++++
 noob.h             |  21 ++++
 read-cache-ll.h    |  10 +-
 read-cache.c       |  41 +++++-
 table.c            | 301 +++++++++++++++++++++++++++++++++++++++++++++
 table.h            |   6 +
 wt-status.c        |  75 +++++++----
 wt-status.h        |   6 +
 13 files changed, 708 insertions(+), 204 deletions(-)
 create mode 100644 noob.c
 create mode 100644 noob.h
 create mode 100644 table.c
 create mode 100644 table.h

-- 
2.42.0.404.g2bcc23f3db

