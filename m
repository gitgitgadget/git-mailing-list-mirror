Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5B41F453
	for <e@80x24.org>; Fri, 26 Oct 2018 19:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJ0EGQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 00:06:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52333 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbeJ0EGP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 00:06:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so2517061wmw.2
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WO52Esx7LxXhQWvq4InBQlre6hFeAOB1Z13N24I2YGs=;
        b=H3U1sZthzJNf2x+hicRXwm6D+SWMRbeBzN/X3aRBjMx3yvYQjRqwtjnQc7fSKXNbmr
         Avsewgoj2JjBkB7UyLP5nNZsniC9Ps4EmESywdqOS0IAaHQNhIP4XN5l1yo/jAtDGZiU
         nBPMFPSjf5yihfgIVqBAqmujdOY8BMy29A598p+1/AyBE95ApnWCAC53vA9ZYdWGt6Rv
         pfoA8jJ+I+5A9HoLBSu/FUuGV0wAu3W2KAQgXeiIHfxFBLAh++z4rk2xb/KmU4n44vfs
         op62FHiLul88hTc2uy2CsSpC1bKnO7C+eiHJUMl5Qw+Y13gicJrvCl+G+g3sqOk7S6QA
         w/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WO52Esx7LxXhQWvq4InBQlre6hFeAOB1Z13N24I2YGs=;
        b=s3RkxqYfqVCrAkdDDQqm0qOL90qXSZofSCe+jZng6LMcNTFoNCKRgaXhMCzjLi8WoQ
         eXORrRVrLwhcuSgDBe1vJeAwUWra+Z42KJKFjeRhKC7tI+LcaPlmHzif9SAoOEXFAzri
         4DoI22e13xn1s3+qIUKPIen6AQjqNYCOLuaacfEJN1eP9S9OM7KFVDlx4JmEi2BnPWDO
         +D18gHe8Mlb9ajIhTOY2CIRuQpzr7rNDU/0BwLSnCNRXizY0k078wZweMvRyAf5eqtUq
         JDBu8j4AVE91l3SA1ms1ha3rm7Tpi1hlEQFu7ncNypaIxH8wkDhpBMmVw2Ya8z1W96tJ
         Tj6g==
X-Gm-Message-State: AGRZ1gLRFh+GsduFVovyBzfP6dKcLsRHj+8gXYyHwQyS9/W9DrXwuRlG
        GoaoWieBOFYUeOMO8GUR/geJ2j2/rKY=
X-Google-Smtp-Source: AJdET5fzbHvyEieUoIhmlfiFfaA6LVjQH99o+/HnPJa/F5DN7vZVrFdpESOcwfEWTzqyVp3MN5ZDWw==
X-Received: by 2002:a1c:1f92:: with SMTP id f140-v6mr1858610wmf.105.1540582076452;
        Fri, 26 Oct 2018 12:27:56 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e196-v6sm10738981wmf.43.2018.10.26.12.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:27:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/7] push: add DWYM support for "git push refs/remotes/...:<dst>"
Date:   Fri, 26 Oct 2018 19:27:34 +0000
Message-Id: <20181026192734.9609-8-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
References: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add DWYM support for pushing a ref in refs/remotes/* when the <dst>
ref is unqualified, e.g.:

    git push origin refs/remotes/origin/master:upstream-master

Before this we wouldn't know what do do with
refs/remotes/origin/master, now we'll look it up and discover that
it's a commit (or tag) and add a refs/{heads,tags}/ prefix to <dst> as
appropriate.

I'm bending over backwards and assuming that someone might have hacked
in remote tracking tags (see [1] for a discussion of how that can be
done), but punting on any tree or blob objects found under
refs/remotes/*.

This is the first use of the %N$<fmt> style of printf format in
the *.[ch] files in our codebase, but it's supported by POSIX[2] and
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

