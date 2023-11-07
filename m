Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E481C01
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgTiiNmO"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF8103
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:26:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-407da05f05aso35771455e9.3
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 17:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699320364; x=1699925164; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vPMkUrm/MaEeW19EfF6+jHB0TPycQM1X2NzSAJw4eR0=;
        b=LgTiiNmOKCSdoKVvynckqHqMrI+bAMRtdZazvvg6PnGW0Hl6QgFWFikXgc7UmMaCV/
         JW4Quvig3eQF0+W2MqeDw74SMDcF5p4Anq0r0JsUDml+onsVvAY9sVjb+zBYDA0JRUBh
         CYzKzHXp0ea5FIrRQkMNK+cDrFRSCDWymy+djPESs7YF1+pHik40c6SX3WOZwj9veGX8
         sd/nRu6GWpee7pBdRFDPoh/4Ix5W4q3zp1wvPOTtHD/QwRi7TQT4rD9MBXYtDsw4wmIY
         2ej7KTx6teIILAb+O5dXv2EFxsQX/Q/HJNqTjq4PQzbcHmcUkgeZ03GnzYJKvTfXke9r
         ZfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699320364; x=1699925164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPMkUrm/MaEeW19EfF6+jHB0TPycQM1X2NzSAJw4eR0=;
        b=FbJQmsnkVSUxJB3XIiXVqXwyCNu6ZMtztYQHnXZB7LjSokidnV1DS7ye2TLKROGBGe
         IXbu38a7B+VhJWHmiQQN4fI6fnt3p5vWEY6wKcXd9dGC5sMQDwg8RWKCZQHK68kksLAM
         u48bYzqdfaurxvk3w43b2Zsg+Wts4dpHvC6ZEoXFkf7teH7HArtdw0kLkCt+r5q1egT5
         CfVWfgmdohKGaorztX85kHIA9mXyBng4LQiptQ7Pd1lXqxgnd0kGNpqCwY2bK/9vLCW9
         wJJMMuR9GbVN5aZDMI7PXuXe+CVLGVKd26Z3vGPhEHFiWY1DXYHfaNS9JZOl4oJ4qGVR
         r+7Q==
X-Gm-Message-State: AOJu0YyGijnUU2iye/y5ZMkMxvHoDTWbpw+TJON7X0z51SsTnzFZGpEz
	J1N5rEKPUJo2aJlxjxIbqFYF5vaJTzo=
X-Google-Smtp-Source: AGHT+IG54gjrnRevdYrfaNgOXZ4S9ACj/WwsKJEcQVy7PgFYQZkPqqRQYQXrA69AsTCzMJPmahvvQg==
X-Received: by 2002:a05:600c:a43:b0:405:40c6:2ba4 with SMTP id c3-20020a05600c0a4300b0040540c62ba4mr981824wmq.5.1699320363581;
        Mon, 06 Nov 2023 17:26:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d6a8c000000b0032db8f7f378sm898901wru.71.2023.11.06.17.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 17:26:03 -0800 (PST)
Message-ID: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Nov 2023 01:25:52 +0000
Subject: [PATCH 0/9] for-each-ref optimizations & usability improvements
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>

This series is a bit of an informal follow-up to [1], adding some more
substantial optimizations and usability fixes around ref
filtering/formatting. Some of the changes here affect user-facing behavior,
some are internal-only, but they're all interdependent enough to warrant
putting them together in one series.

[1]
https://lore.kernel.org/git/pull.1594.v2.git.1696888736.gitgitgadget@gmail.com/

Patch 1 changes the behavior of the '--no-sort' option in 'for-each-ref',
'tag', and 'branch'. Currently, it just removes previous sort keys and, if
no further keys are specified, falls back on ascending refname sort (which,
IMO, makes the name '--no-sort' somewhat misleading).

Patch 2 updates the 'for-each-ref' docs to clearly state what happens if you
use '--omit-empty' and '--count' together. I based the explanation on what
the current behavior is (i.e., refs omitted with '--omit-empty' do count
towards the total limited by '--count').

Patches 3-7 incrementally refactor various parts of the ref
filtering/formatting workflows in order to create a
'filter_and_format_refs()' function. If certain conditions are met (sorting
disabled, no reachability filtering or ahead-behind formatting), ref
filtering & formatting is done within a single 'for_each_fullref_in'
callback. Especially in large repositories, this makes a huge difference in
memory usage & runtime for certain usages of 'for-each-ref', since it's no
longer writing everything to a 'struct ref_array' then repeatedly whittling
down/updating its contents.

Patch 8 introduces a new option to 'for-each-ref' called '--full-deref'.
When provided, any format fields for the dereferenced value of a tag (e.g.
"%(*objectname)") will be populated with the fully peeled target of the tag;
right now, those fields are populated with the immediate target of a tag
(which can be another tag). This avoids the need to pipe 'for-each-ref'
results to 'cat-file --batch-check' to get fully-peeled tag information. It
also benefits from the 'filter_and_format_refs()' single-iteration
optimization, since 'peel_iterated_oid()' may be able to read the
pre-computed peeled OID from a packed ref. A couple notes on this one:

 * I went with a command line option for '--full-deref' rather than another
   format specifier (like ** instead of *) because it seems unlikely that a
   user is going to want to perform a shallow dereference and a full
   dereference in the same 'for-each-ref'. There's also a NEEDSWORK going
   all the way back to the introduction of 'for-each-ref' in 9f613ddd21c
   (Add git-for-each-ref: helper for language bindings, 2006-09-15) that (to
   me) implies different dereferencing behavior corresponds to different use
   cases/user needs.
 * I'm not attached to '--full-deref' as a name - if someone has an idea for
   a more descriptive name, please suggest it!

Finally, patch 9 adds performance tests for 'for-each-ref', showing the
effects of optimizations made throughout the series. Here are some sample
results from my Ubuntu VM (test names shortened for space):

Test                                                         this branch    
----------------------------------------------------------------------------
6300.2: (loose)                                              4.78(0.89+3.82)
6300.3: (loose, no sort)                                     4.51(0.86+3.58)
6300.4: (loose, --count=1)                                   4.70(0.90+3.73)
6300.5: (loose, --count=1, no sort)                          4.35(0.58+3.73)
6300.6: (loose, tags)                                        2.45(0.44+1.95)
6300.7: (loose, tags, no sort)                               2.38(0.44+1.90)
6300.8: (loose, tags, shallow deref)                         3.33(1.27+1.99)
6300.9: (loose, tags, shallow deref, no sort)                3.29(1.29+1.93)
6300.10: (loose, tags, full deref)                           3.76(1.69+1.99)
6300.11: (loose, tags, full deref, no sort)                  3.73(1.71+1.94)
6300.12: for-each-ref + cat-file (loose, tags)               4.25(2.16+2.17)
6300.14: (packed)                                            0.61(0.50+0.09)
6300.15: (packed, no sort)                                   0.46(0.40+0.04)
6300.16: (packed, --count=1)                                 0.59(0.44+0.13)
6300.17: (packed, --count=1, no sort)                        0.02(0.01+0.01)
6300.18: (packed, tags)                                      0.28(0.18+0.09)
6300.19: (packed, tags, no sort)                             0.29(0.24+0.03)
6300.20: (packed, tags, shallow deref)                       1.20(1.03+0.13)
6300.21: (packed, tags, shallow deref, no sort)              1.13(0.99+0.08)
6300.22: (packed, tags, full deref)                          1.57(1.45+0.11)
6300.23: (packed, tags, full deref, no sort)                 1.07(1.01+0.05)
6300.24: for-each-ref + cat-file (packed, tags)              2.01(1.81+0.33)


 * Victoria

Victoria Dye (9):
  ref-filter.c: really don't sort when using --no-sort
  for-each-ref: clarify interaction of --omit-empty & --count
  ref-filter.h: add max_count and omit_empty to ref_format
  ref-filter.h: move contains caches into filter
  ref-filter.h: add functions for filter/format & format-only
  ref-filter.c: refactor to create common helper functions
  ref-filter.c: filter & format refs in the same callback
  for-each-ref: add option to fully dereference tags
  t/perf: add perf tests for for-each-ref

 Documentation/git-for-each-ref.txt |  12 +-
 builtin/branch.c                   |  42 +++--
 builtin/for-each-ref.c             |  41 ++---
 builtin/ls-remote.c                |  10 +-
 builtin/tag.c                      |  32 +---
 ref-filter.c                       | 277 ++++++++++++++++++++---------
 ref-filter.h                       |  26 +++
 t/perf/p6300-for-each-ref.sh       |  87 +++++++++
 t/t3200-branch.sh                  |  68 ++++++-
 t/t6300-for-each-ref.sh            |  55 ++++++
 t/t7004-tag.sh                     |  45 +++++
 11 files changed, 532 insertions(+), 163 deletions(-)
 create mode 100755 t/perf/p6300-for-each-ref.sh


base-commit: bc5204569f7db44d22477485afd52ea410d83743
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1609%2Fvdye%2Fvdye%2Ffor-each-ref-optimizations-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1609/vdye/vdye/for-each-ref-optimizations-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1609
-- 
gitgitgadget
