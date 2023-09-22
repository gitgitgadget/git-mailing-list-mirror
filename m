Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECE2E6FE32
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 14:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjIVOOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjIVOOA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 10:14:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20BCF7
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:13:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so10326045e9.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695392030; x=1695996830; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NgiopyDASfCwOUXHCRlqr0tW3eoBamk6Iad5+ti8yAc=;
        b=HLZFEQM6g0L5Vwmry4xpJVATTQnrOjXuWy0OoumvPSoGGRUBeLt1xbRA0mX9VA7/AK
         HtA0uAqjfAmHKhtJLrgyMMDy0FM1nTmh0Q8NrO0CWTweHQZHqB8Q8S4GHi/nn7JF+ekD
         GovYJbc1hEu/BpIFqlIqhOwWqhCyPsQXkZT+yJM0kj7/UKMC6frDrp6X+mzhSQE1tJHI
         0lGppPNS5QrhAP3t583jaIIqN/thTYMxb17RsnHmp8NlrYYGou1HouErIVUbX7VW5BVp
         E8Uj5ljTz/cS5iZnxdhNntQhXy/lf4sxGCyW4eS0gWgC+E4lRenyRv+oIKrvBBUOHsWM
         AFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695392030; x=1695996830;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgiopyDASfCwOUXHCRlqr0tW3eoBamk6Iad5+ti8yAc=;
        b=DYCKOySnjtUUKVKeTEIJJgEv2OUOM5VCN1ZLoTfXIqx8m7ZilRKuyT18YQYzO9x5AC
         60z4QY4arPLMYk6tBopzjzeSBQc3Qm2YJZNs3Ih1wU+v0ZpT8+cmympfRP0bEiGlANBd
         2xuE+5KChD4QOz8vzhzNF2/9BRRrWiUYzZeJA1u4hK4XRs85xKWmv3ixj2EIXUnXeYkS
         cm75uXyPJUZzK1WKQbGkNENSlWLHYH8Bfhuz2jryu2juoXyAeqFul2eoS42wOp+BQMMT
         GkoWEwsz5p/b9/V/4L2THHi9FWgFbKvoatnhKPa5jvwr+D0meygL+w0YIxPakAFFGeob
         QzdA==
X-Gm-Message-State: AOJu0Yw+C0dMyP7sFRSvO4pdFImDwrrSfk3ANL4g8hk3zoaeSrd0vJAV
        TZzYpxb1VRDMLkJd2BFUMGhmDplaNPA=
X-Google-Smtp-Source: AGHT+IHfEozbqO77TJGQKWYbJSsn7eDoJgl61XCRHKUqzYhb+w2znH70RaTjIFbx2QTk+nAN9a+tkw==
X-Received: by 2002:a05:600c:1e02:b0:405:315f:e67e with SMTP id ay2-20020a05600c1e0200b00405315fe67emr849297wmb.5.1695392029725;
        Fri, 22 Sep 2023 07:13:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d5643000000b0032167e49619sm4565941wrw.5.2023.09.22.07.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:13:49 -0700 (PDT)
Message-ID: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 14:13:43 +0000
Subject: [PATCH 0/4] Switch links to https
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a couple of categories of http links

 * links that are required to be http: because they're copied from something
   that mandates it (the apache license, xml namespaces, xsl docbook
   things?)
 * pages which exist at both http: and https: and can be safely switched
 * pages that have jittered a bit but are now available as https:
 * pages that have jittered a bit and are not available over https:
 * pages that are gone and for which the best source is
   https://web.archive.org
 * urls that were imaginary

In order:

 * doc: switch links to https -- the simplest
 * doc: update links to current pages -- I found the current pages for
   these, it should be easy enough to verify these / reject them
 * doc: update links for andre-simon.de -- I've split this out, I don't like
   the idea of having to download binaries over http. If this were my
   project, I'd be tempted to remove the feature or self-host w/ https...
 * doc: refer to internet archive -- the original urls are dead, I've found
   internet archive date links for them. (There are some in git already, so
   this seemed like a very reasonable choice.)

Josh Soref (4):
  doc: switch links to https
  doc: update links to current pages
  doc: update links for andre-simon.de
  doc: refer to internet archive

 Documentation/CodingGuidelines                       |  4 ++--
 Documentation/MyFirstContribution.txt                |  2 +-
 Documentation/RelNotes/1.6.2.txt                     |  2 +-
 Documentation/RelNotes/1.6.3.txt                     |  2 +-
 Documentation/RelNotes/1.6.4.txt                     |  2 +-
 Documentation/RelNotes/1.6.5.txt                     |  2 +-
 Documentation/RelNotes/1.6.6.txt                     |  2 +-
 Documentation/git-cvsimport.txt                      |  4 ++--
 Documentation/git-format-patch.txt                   |  4 ++--
 Documentation/git-imap-send.txt                      |  2 +-
 Documentation/git-ls-remote.txt                      |  4 ++--
 Documentation/git-send-email.txt                     |  2 +-
 Documentation/git.txt                                |  2 +-
 Documentation/gitcore-tutorial.txt                   |  6 +++---
 Documentation/gitprotocol-http.txt                   |  4 ++--
 Documentation/gitweb.conf.txt                        |  4 ++--
 Documentation/gitweb.txt                             |  2 +-
 .../howto/keep-canonical-history-correct.txt         |  2 +-
 Documentation/signoff-option.txt                     |  2 +-
 INSTALL                                              |  2 +-
 Makefile                                             |  4 ++--
 README.md                                            |  2 +-
 compat/nedmalloc/malloc.c.h                          | 12 ++++++------
 compat/obstack.c                                     |  2 +-
 compat/obstack.h                                     |  2 +-
 compat/poll/poll.c                                   |  2 +-
 compat/poll/poll.h                                   |  2 +-
 compat/precompose_utf8.h                             |  2 +-
 compat/regex/regcomp.c                               |  2 +-
 compat/regex/regex.c                                 |  2 +-
 compat/regex/regex.h                                 |  2 +-
 compat/regex/regex_internal.c                        |  2 +-
 compat/regex/regex_internal.h                        |  2 +-
 compat/regex/regexec.c                               |  2 +-
 compat/vcbuild/README                                | 10 +++++-----
 contrib/completion/git-completion.bash               |  2 +-
 .../credential/libsecret/git-credential-libsecret.c  |  2 +-
 contrib/fast-import/import-directories.perl          |  2 +-
 contrib/hg-to-git/hg-to-git.py                       |  2 +-
 contrib/mw-to-git/t/test-gitmw-lib.sh                |  4 ++--
 contrib/persistent-https/LICENSE                     |  2 +-
 contrib/persistent-https/README                      |  4 ++--
 contrib/thunderbird-patch-inline/appp.sh             |  2 +-
 contrib/update-unicode/update_unicode.sh             |  6 +++---
 convert.c                                            |  2 +-
 ewah/bitmap.c                                        |  2 +-
 ewah/ewah_bitmap.c                                   |  2 +-
 ewah/ewah_io.c                                       |  2 +-
 ewah/ewah_rlw.c                                      |  2 +-
 ewah/ewok.h                                          |  4 ++--
 ewah/ewok_rlw.h                                      |  2 +-
 git-cvsimport.perl                                   |  2 +-
 git-gui/git-gui.sh                                   |  6 +++---
 git-gui/lib/encoding.tcl                             |  2 +-
 git-gui/po/README                                    |  2 +-
 git-instaweb.sh                                      |  4 ++--
 gitk-git/gitk                                        |  4 ++--
 gitweb/INSTALL                                       |  2 +-
 gitweb/gitweb.perl                                   | 12 ++++++------
 gitweb/static/gitweb.css                             |  2 +-
 gitweb/static/js/lib/common-lib.js                   | 10 +++++-----
 graph.h                                              |  4 ++--
 http.c                                               |  2 +-
 imap-send.c                                          |  4 ++--
 json-writer.h                                        |  4 ++--
 kwset.c                                              |  2 +-
 kwset.h                                              |  2 +-
 list.h                                               |  2 +-
 perl/FromCPAN/Error.pm                               |  2 +-
 perl/Git/SVN.pm                                      |  2 +-
 protocol.h                                           |  2 +-
 sh-i18n--envsubst.c                                  |  4 ++--
 sha1dc/sha1.c                                        |  2 +-
 t/README                                             |  4 ++--
 t/helper/test-regex.c                                |  2 +-
 t/lib-gpg.sh                                         |  2 +-
 t/perf/perf-lib.sh                                   |  2 +-
 t/t9114-git-svn-dcommit-merge.sh                     |  2 +-
 t/t9801-git-p4-branch.sh                             |  2 +-
 t/t9816-git-p4-locked.sh                             |  2 +-
 t/test-lib-functions.sh                              |  2 +-
 t/test-lib-github-workflow-markup.sh                 |  2 +-
 t/test-lib-junit.sh                                  |  2 +-
 t/test-lib.sh                                        |  2 +-
 trace.c                                              |  2 +-
 utf8.c                                               |  2 +-
 utf8.h                                               |  6 +++---
 xdiff/xdiff.h                                        |  2 +-
 xdiff/xdiffi.c                                       |  2 +-
 xdiff/xdiffi.h                                       |  2 +-
 xdiff/xemit.c                                        |  2 +-
 xdiff/xemit.h                                        |  2 +-
 xdiff/xinclude.h                                     |  2 +-
 xdiff/xmacros.h                                      |  2 +-
 xdiff/xmerge.c                                       |  2 +-
 xdiff/xpatience.c                                    |  2 +-
 xdiff/xprepare.c                                     |  2 +-
 xdiff/xprepare.h                                     |  2 +-
 xdiff/xtypes.h                                       |  2 +-
 xdiff/xutils.c                                       |  2 +-
 xdiff/xutils.h                                       |  2 +-
 101 files changed, 144 insertions(+), 144 deletions(-)


base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1589%2Fjsoref%2Fhttps-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1589/jsoref/https-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1589
-- 
gitgitgadget
