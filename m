Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7E71F453
	for <e@80x24.org>; Fri, 26 Oct 2018 23:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeJ0Hq7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 03:46:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43535 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeJ0Hq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 03:46:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id t10-v6so2800951wrn.10
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 16:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bLIyjzJ7bDL9kgc3BSfF745cvs6WRRvLGyhKfobeGec=;
        b=D1GzF0sTCXXdTaT3vl/vLaSmZgoJ+8xToTlNEQu/KYWmhyoxW9l/9cDCTiVSF+EP+y
         hTHwoTVAO+4vVPYX1mq0YXnRqwWEu0xyyQL04O04mb+z1Dmmprzdz7G8Fy+p2nYgF+Em
         ePM12F58rkxBnkidyLx5suQ5B8DcsBUTj4xMAH75LGriAH7R5HoPUFnQEXOaQV+PuO1G
         cAuVeBhVDxuuYiW5g1bDLMkJYBHdOaa8dHkur2Qn6URAh1XiO8oNMxr6VTZU+vLSwybH
         Ob3MR2N9Apvv5wkQbGJv2YFH1VHSk3jTKMfj3MgSLjsLyDvvc0Q4UPrPfmpN2OecOIPd
         D90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bLIyjzJ7bDL9kgc3BSfF745cvs6WRRvLGyhKfobeGec=;
        b=YfuEveKx06u7AUJN18phtt7DIWer21c3mzteCkAmFXW3aAn9MgZNvwnAly1e9U2Vop
         LP+BSUOTJAER/Pwl6ZZyn9B8KVXfaDkvq5h8FH/Nf7zDjXoZt/gRvm3yV1087uPPtjCV
         MdurZd0WDrbSXM5G94R9ljCxhEu8pQyZrJER6K/8i7I8GZYRqOuozd1SEe9PFyxmKkcK
         vZZvnCjsp3G1jZ5Ffrcu3e6eGovUzzxS76Gk4RBxDBis0cb4tBBzPRlP52PtBo+H4ZxV
         oIzsvWvl5YOoX2h5aBPCeelExpSIVPRP9NaHAPemcZJL9kUhW0dv7u0OPFHfPr2pPmuH
         ITzQ==
X-Gm-Message-State: AGRZ1gJ+3LAcHhyK1NexXfITtRT86symJ/xsiSwvdpO/FmQhR86cnm3A
        6sAkYwZj8jQ9yyv5d4qQQvjGcH49TGk=
X-Google-Smtp-Source: AJdET5d8OfG5Y0FONyZ545diTXsWYmQQmBodBxBlQrStzn8vX+bULiClfq5W19oKUTgVg6utwu7UnA==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr7016740wrm.106.1540595280222;
        Fri, 26 Oct 2018 16:08:00 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 4-v6sm5632830wmt.16.2018.10.26.16.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 16:07:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/8] push: add DWYM support for "git push refs/remotes/...:<dst>"
Date:   Fri, 26 Oct 2018 23:07:40 +0000
Message-Id: <20181026230741.23321-8-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181026192734.9609-1-avarab@gmail.com>
References: <20181026192734.9609-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add DWYM support for pushing a ref in refs/remotes/* when the <dst>
ref is unqualified. Now instead of erroring out we support e.g.:

    $ ./git-push avar refs/remotes/origin/master:upstream-master -n
    To github.com:avar/git.git
     * [new branch]            origin/master -> upstream-master

Before this we wouldn't know what do do with
refs/remotes/origin/master, now we'll look it up and discover that
it's a commit (or tag) and add a refs/{heads,tags}/ prefix to <dst> as
appropriate.

The error message emitted when we still don't know what to do has been
amended to note that this is something we tried:

    $ ./git-push avar v2.19.0^{commit}:newbranch -n
    error: The destination you provided is not a full refname (i.e.,
    starting with "refs/"). We tried to guess what you meant by:

    - Looking for a ref that matches 'newbranch' on the remote side.
    - Checking if the <src> being pushed ('v2.19.0^{commit}')
      is a ref in "refs/{heads,tags}/". If so we add a corresponding
      refs/{heads,tags}/ prefix on the remote side.
    - Checking if the <src> being pushed ('v2.19.0^{commit}')
      is a commit or tag in "refs/remotes/*". Then we infer a
      corresponding refs/{heads,tags} on the remote side.

    None of those worked, so we gave up. You must fully-qualify the ref.
    hint: The <src> part of the refspec is a commit object.
    hint: Did you mean to create a new branch by pushing to
    hint: 'v2.19.0^{commit}:refs/heads/newbranch'?

I'm bending over backwards and assuming that someone might have hacked
in remote tracking tags (see [1] for a discussion of how that can be
done), but punting on any tree or blob objects found under
refs/remotes/*.

This is the first use of the %N$<fmt> style of printf format in
the *.[ch] files in our codebase. It's supported by POSIX[2] and
there's existing uses for it in po/*.po files, so hopefully it won't
cause any trouble. It's more obvious for translators than to have a
3rd argument to the function identical to the 2nd, by re-using the 2nd
it's clear that we're continuing to talk about the <src> part of the
refspec.

1. https://public-inbox.org/git/87zi1jxjqn.fsf@evledraar.gmail.com/
2. http://pubs.opengroup.org/onlinepubs/7908799/xsh/fprintf.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c          | 20 +++++++++++++++++++-
 t/t5505-remote.sh | 14 +++++++++-----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 93f802509d..c243e3d89e 100644
--- a/remote.c
+++ b/remote.c
@@ -973,6 +973,21 @@ static char *guess_ref(const char *name, struct ref *peer)
 		strbuf_addstr(&buf, "refs/heads/");
 	} else if (starts_with(r, "refs/tags/")) {
 		strbuf_addstr(&buf, "refs/tags/");
+	} else if (starts_with(r, "refs/remotes/")) {
+		struct object_id oid;
+		enum object_type type;
+
+		if (get_oid(peer->name, &oid))
+			BUG("'%s' is not a valid object, "
+			    "match_explicit_lhs() should catch this!",
+			    peer->name);
+		type = oid_object_info(the_repository, &oid, NULL);
+		if (type == OBJ_COMMIT)
+			strbuf_addstr(&buf, "refs/heads/");
+		else if (type == OBJ_TAG)
+			strbuf_addstr(&buf, "refs/tags/");
+		else
+			return NULL;
 	} else {
 		return NULL;
 	}
@@ -1024,8 +1039,11 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 		"- Checking if the <src> being pushed ('%s')\n"
 		"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
 		"  refs/{heads,tags}/ prefix on the remote side.\n"
+		"- Checking if the <src> being pushed ('%2$s')\n"
+		"  is a commit or tag in \"refs/remotes/*\". Then we infer a\n"
+		"  corresponding refs/{heads,tags} on the remote side.\n"
 		"\n"
-		"Neither worked, so we gave up. You must fully-qualify the ref."),
+		"None of those worked, so we gave up. You must fully-qualify the ref."),
 	      dst_value, matched_src_name);
 
 	if (!advice_push_unqualified_ref_name)
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 979a13b415..a6337b50e4 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1260,11 +1260,15 @@ test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and
 		git config --add remote.two.fetch "+refs/blobs/*:refs/remotes/two-blobs/*" &&
 		git fetch --no-tags two &&
 
-		test_must_fail git push origin refs/remotes/two/another:dst 2>err &&
-		test_i18ngrep "error: The destination you" err &&
-
-		test_must_fail git push origin refs/remotes/two-tags/some-tag:dst-tag 2>err &&
-		test_i18ngrep "error: The destination you" err &&
+		echo commit >expected &&
+		git push origin refs/remotes/two/another:dst &&
+		git -C ../one cat-file -t refs/heads/dst >actual &&
+		test_cmp expected actual &&
+
+		echo tag >expected &&
+		git push origin refs/remotes/two-tags/some-tag:dst-tag &&
+		git -C ../one cat-file -t refs/tags/dst-tag >actual &&
+		test_cmp expected actual &&
 
 		test_must_fail git push origin refs/remotes/two-trees/my-head-tree:dst-tree 2>err &&
 		test_i18ngrep "error: The destination you" err &&
-- 
2.19.1.759.g500967bb5e

