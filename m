Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDDFB1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeIAATX (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:19:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45879 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeIAATX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:19:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so12234817wrb.12
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rTnE2CcKohLByRhZjFy6guLmcMj0307039NW8UA4Y0Y=;
        b=l8f86df9SwH9R0Azani/5Psv0dSDNXUSGAvcyAnslLo9jyL83wejnRtOaoJSaOaSdj
         m7drVG5O1WAzZ5auQG6vhVtCuTGl36VHLFX59Se/JLW3Xz8s3lvr01GjRVQ+dKM29UTq
         CpDWYG7MheMe+4xns5DeCnSuepAwT5plUnnWTG5Z901hD+SB49AB6GFm4hlAx882SWpB
         mZxnlrUCGPon4GAcmEHUVRGQNyyQ9KyGoFIXdMlJqqOGr1+P6OOod/Gfe/AOirk4Xh8F
         jjqP3c+gRLaNRqvw+2jsJvBcZetHk6PN9WdVR8pldWx87ae0mAyYT+ZbPGKcCTLXTQOp
         Z2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTnE2CcKohLByRhZjFy6guLmcMj0307039NW8UA4Y0Y=;
        b=EfoXTLshFr+anHvsXmQwBP3Lq0ApI/2t9bo2rvijWkVjhTWQN0YBkjlX5S9IfHOq3j
         cT/67UjWYKr4Pa1ZJ1UiZtHYpX3/SXZkBMOJY9TG5MSub9H5lmugV7mPq3wUecPEtvEl
         264Iokj7m7Z1SZXhTPHkuBxOGPWuqVp4A+bv0YlN0Btg53Qivt855F8WBn9h7OU0pyfd
         auRRyOBTtbEe7o/Y3wLypPmT8JdosSLRntNkULAZsb3RANRUhZLeM6+nf74JkyMiRzO0
         L8brwrsZjS0id17NxueIi9ynnGHdAo7YcpFtyPTANwaPreAdxGebRsvYBa2TmRkqim4e
         v4Ag==
X-Gm-Message-State: APzg51DKsK9u4gCjxC6x4Eo4+YEgNrsEVWHkE1trMHrhcoFtUhlXHZ4P
        5vfpu4RLFrnnJsFhHRB+ADLp45ZGpWg=
X-Google-Smtp-Source: ANB0VdZTUNtNcgyhpD1S+MffFlOsuABtNdFDZ6bZ2NyVqysKx7dSnWu/mrKGbkYPiRbt68/wIcfvBw==
X-Received: by 2002:a5d:53cf:: with SMTP id a15-v6mr12386086wrw.151.1535746217341;
        Fri, 31 Aug 2018 13:10:17 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4486753wmc.38.2018.08.31.13.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:10:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/9] git fetch" should not clobber existing tags without --force
Date:   Fri, 31 Aug 2018 20:09:55 +0000
Message-Id: <20180831201004.12087-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180830201244.25759-1-avarab@gmail.com>
References: <20180830201244.25759-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses Junio's comments to v4, and I had a few fixes of my own. I
don't know if this range-diff is more or less readble than just
re-reading it, but here goes:

 1:  d05fd561f3 =  1:  d05fd561f3 fetch: change "branch" to "reference" in --force -h output
 -:  ---------- >  2:  28275baca2 push tests: make use of unused $1 in test description
 2:  013ecd83b3 !  3:  834501afdc push tests: correct quoting in interpolated string
    @@ -1,24 +1,11 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    push tests: correct quoting in interpolated string
    +    push tests: use spaces in interpolated string
     
    -    The quoted -m'msg' option is passed as a string to another function,
    -    where due to interpolation it'll end up meaning the same as if we did
    -    just did -m'msg' here.
    -
    -    In [1] this was pointed out to me, but in submitting [2] the patches I
    -    missed this (since it was feedback on another patch I was holding
    -    off), so this logic error landed in 380efb65df ("push tests: assert
    -    re-pushing annotated tags", 2018-07-31).
    -
    -    Let's just remove the quotes, and use a string that doesn't need to be
    -    quoted (-mtag.message is a bit less confusing than -mmsg). I could try
    -    to chase after getting the quoting right here with multiple
    -    backslashes, but I don't think it's worth it, and it makes things much
    -    less readable.
    -
    -    1. https://public-inbox.org/git/xmqq4lgfcn5a.fsf@gitster-ct.c.googlers.com/
    -    2. https://public-inbox.org/git/20180813192249.27585-1-avarab@gmail.com/
    +    The quoted -m'msg' option would mean the same as -mmsg when passed
    +    through the test_force_push_tag helper. Let's instead use a string
    +    with spaces in it, to have a working example in case we need to pass
    +    other whitespace-delimited arguments to git-tag.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -30,7 +17,7 @@
      
      test_force_push_tag "lightweight tag" "-f"
     -test_force_push_tag "annotated tag" "-f -a -m'msg'"
    -+test_force_push_tag "annotated tag" "-f -a -mtag.message"
    ++test_force_push_tag "annotated tag" "-f -a -m'tag message'"
      
      test_expect_success 'push --porcelain' '
      	mk_empty testrepo &&
 3:  2d216a7ef6 !  4:  5f85542bb2 fetch tests: add a test for clobbering tag behavior
    @@ -14,7 +14,7 @@
      +++ b/t/t5516-fetch-push.sh
     @@
      test_force_push_tag "lightweight tag" "-f"
    - test_force_push_tag "annotated tag" "-f -a -mtag.message"
    + test_force_push_tag "annotated tag" "-f -a -m'tag message'"
      
     +test_force_fetch_tag () {
     +	tag_type_description=$1
    @@ -38,7 +38,7 @@
     +}
     +
     +test_force_fetch_tag "lightweight tag" "-f"
    -+test_force_fetch_tag "annotated tag" "-f -a -mtag.message"
    ++test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
     +
      test_expect_success 'push --porcelain' '
      	mk_empty testrepo &&
 -:  ---------- >  5:  6906d5a84d push doc: remove confusing mention of remote merger
 -:  ---------- >  6:  a16a9c2d7f push doc: move mention of "tag <tag>" later in the prose
 4:  b751e80b00 !  7:  9f8785e01a push doc: correct lies about how push refspecs work
    @@ -38,18 +38,20 @@
     -a tag (annotated or lightweight), and then only if it can fast-forward
     -<dst>.  By having the optional leading `+`, you can tell Git to update
     -the <dst> ref even if it is not allowed by default (e.g., it is not a
    --fast-forward.)  This does *not* attempt to merge <src> into <dst>.  See
    --EXAMPLES below for details.
    +-fast-forward.).
    +-+
    +-Pushing an empty <src> allows you to delete the <dst> ref from
    +-the remote repository.
     +on the remote side. Whether this is allowed depends on where in
    -+`refs/*` the <dst> reference lives as described in detail below. Any
    -+such update does *not* attempt to merge <src> into <dst>. See EXAMPLES
    -+below for details.
    ++`refs/*` the <dst> reference lives as described in detail below, in
    ++those sections "update" means any modifications except deletes, which
    ++as noted after the next few sections are treated differently.
     ++
    -+The `refs/heads/*` namespace will only accept commit objects, and only
    -+if they can be fast-forwarded.
    ++The `refs/heads/*` namespace will only accept commit objects, and
    ++updates only if they can be fast-forwarded.
     ++
     +The `refs/tags/*` namespace will accept any kind of object (as
    -+commits, trees and blobs can be tagged), and any changes to them will
    ++commits, trees and blobs can be tagged), and any updates to them will
     +be rejected.
     ++
     +It's possible to push any type of object to any namespace outside of
    @@ -67,17 +69,26 @@
     +new tag object which an existing commit points to.
     ++
     +Tree and blob objects outside of `refs/{tags,heads}/*` will be treated
    -+the same way as if they were inside `refs/tags/*`, any modification of
    -+them will be rejected.
    ++the same way as if they were inside `refs/tags/*`, any update of them
    ++will be rejected.
     ++
     +All of the rules described above about what's not allowed as an update
     +can be overridden by adding an the optional leading `+` to a refspec
     +(or using `--force` command line option). The only exception to this
     +is that no amount of forcing will make the `refs/heads/*` namespace
    -+accept a non-commit object.
    - +
    - `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
    ++accept a non-commit object. Hooks and configuration can also override
    ++or amend these rules, see e.g. `receive.denyNonFastForwards` in
    ++linkgit:git-config[1] and`pre-receive` and `update` in
    ++linkgit:githooks[5].
    +++
    ++Pushing an empty <src> allows you to delete the <dst> ref from the
    ++remote repository. Deletions are always accepted without a leading `+`
    ++in the refspec (or `--force`), except when forbidden by configuration
    ++or hooks. See `receive.denyDeletes` in linkgit:git-config[1] and
    ++`pre-receive` and `update` in linkgit:githooks[5].
      +
    + The special refspec `:` (or `+:` to allow non-fast-forward updates)
    + directs Git to push "matching" branches: for every branch that exists on
     
      diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.txt
      --- a/Documentation/gitrevisions.txt
 5:  b120051957 =  8:  3e90699b9f fetch: document local ref updates with/without --force
 6:  25df331fce !  9:  0e183b6f23 fetch: stop clobbering existing tags without --force
    @@ -66,13 +66,24 @@
     +Until Git version 2.20, and unlike when pushing with
     +linkgit:git-push[1], any updates to `refs/tags/*` would be accepted
     +without `+` in the refspec (or `--force`). The receiving promiscuously
    -+considered all tag updates from a remote to be forced fetches. Since
    -+Git version 2.20 updates to `refs/tags/*` work the same way as when
    -+pushing. I.e. any updates will be rejected without `+` in the refspec
    -+(or `--force`).
    ++considered all tag updates from a remote to be forced fetches.  Since
    ++Git version 2.20, fetching to update `refs/tags/*` work the same way
    ++as when pushing. I.e. any updates will be rejected without `+` in the
    ++refspec (or `--force`).
      +
      Unlike when pushing with linkgit:git-push[1], any updates outside of
      `refs/{tags,heads}/*` will be accepted without `+` in the refspec (or
    +@@
    + a commit for another commit that's doesn't have the previous commit as
    + an ancestor etc.
    + +
    ++Unlike when pushing with linkgit:git-push[1], there is no
    ++configuration which'll amend these rules, and nothing like a
    ++`pre-fetch` hook analogous to the `pre-receive` hook.
    +++
    + As with pushing with linkgit:git-push[1], all of the rules described
    + above about what's not allowed as an update can be overridden by
    + adding an the optional leading `+` to a refspec (or using `--force`
     
      diff --git a/builtin/fetch.c b/builtin/fetch.c
      --- a/builtin/fetch.c

Ævar Arnfjörð Bjarmason (9):
  fetch: change "branch" to "reference" in --force -h output
  push tests: make use of unused $1 in test description
  push tests: use spaces in interpolated string
  fetch tests: add a test for clobbering tag behavior
  push doc: remove confusing mention of remote merger
  push doc: move mention of "tag <tag>" later in the prose
  push doc: correct lies about how push refspecs work
  fetch: document local ref updates with/without --force
  fetch: stop clobbering existing tags without --force

 Documentation/fetch-options.txt    | 15 +++++---
 Documentation/git-push.txt         | 57 ++++++++++++++++++++++++------
 Documentation/gitrevisions.txt     |  7 ++--
 Documentation/pull-fetch-param.txt | 39 +++++++++++++++++---
 builtin/fetch.c                    | 20 +++++++----
 t/t5516-fetch-push.sh              | 29 +++++++++++++--
 t/t5612-clone-refspec.sh           |  4 +--
 7 files changed, 136 insertions(+), 35 deletions(-)

-- 
2.19.0.rc1.350.ge57e33dbd1

