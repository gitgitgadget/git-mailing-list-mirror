Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975B31F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeHaARB (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:17:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54431 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaARB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:17:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so3156720wmb.4
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 13:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OjEzAveVbhbO6rK4BBp3Xsip7zanEUbB6zYTZPNocc=;
        b=AZOWsLLQNE/ix4du+NPT1YGev/JN+4jisw8ccWRq2Oy0USkQFpxunlCBvhz1W51RMG
         s3eVVcSvQcYmzAKkiq9obGHXz7KpK+f31FRawmbKUz2rcbwcp9eBltfBMGpVxDxE+mtz
         q7f/dfBmzqhQh8eZZX9SOMnMYvRQvOcWVzL2gzps5E+z7O4CLfCrtoeUjOF38p2ywSj4
         sEUs3s8rMSaiJg3jbkfls0+UAYeuhSN9SveLQuvvTXg8GFWo42MfX2FFRIxcV4BTxX7a
         Gsq6vkGWaWYy1b068VqP3nhRGyOCQP73SW0QMU9YnRC/4r6LHGFYmztzmNF7oV6Icler
         sSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OjEzAveVbhbO6rK4BBp3Xsip7zanEUbB6zYTZPNocc=;
        b=NrppeDtUVfEB5NguDKbthCcbRkDvffqGRkre4ZfM0qDEBGiEd4duy+pQEfBGeEuj4w
         fZl6NHWy0WTdpO7ZwIAUQIVzLhhkLryTuIArKhjSTOYusVAQSuzrp8QnGkYq+0UNFABq
         siJlSgoVnmU6FxBj+2C2iI1uHHJ/Av/mogIRRCOKTtq0+ZJmyAeA8euOiredv2ff7k4W
         B4wXahGZGXYSAeGv9IR94/Vi3WtXzLYw4C7V6CRHRH9jyi0boGI1W+gEtkeZKLnS/ec/
         XZywzrzb4QIrTl7sbMbZJhzfOw2GB/cAuY/+HF4kVihHhJY87JV9D6xXbyS8EnyqQdvg
         OHoQ==
X-Gm-Message-State: APzg51BauxVElDqoQT/SLaR5Doh2cRrNdwxBKZf01btjkLCiQdT9+bJg
        wNeokw5KwDSF8vI+jv684cjhBms7m4s=
X-Google-Smtp-Source: ANB0VdZtqfdHiVRcBsWTtgM9lNnKAErXHFrqG//q1LbaD3Ve+VJKPTK6qbyHwGiqR5FzIjvUtHwUKA==
X-Received: by 2002:a1c:8c08:: with SMTP id o8-v6mr2617727wmd.60.1535659986269;
        Thu, 30 Aug 2018 13:13:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b10-v6sm4903639wrr.88.2018.08.30.13.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:13:05 -0700 (PDT)
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
        =?UTF-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/6] fetch: stop clobbering existing tags without --force
Date:   Thu, 30 Aug 2018 20:12:44 +0000
Message-Id: <20180830201244.25759-7-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180813192249.27585-1-avarab@gmail.com>
References: <20180813192249.27585-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "fetch" to treat "+" in refspecs (aka --force) to mean we
should clobber a local tag of the same name.

This changes the long-standing behavior of "fetch" added in
853a3697dc ("[PATCH] Multi-head fetch.", 2005-08-20). Before this
change, all tag fetches effectively had --force enabled. See the
git-fetch-script code in fast_forward_local() with the comment:

    > Tags need not be pointing at commits so there is no way to
    > guarantee "fast-forward" anyway.

That commit and the rest of the history of "fetch" shows that the
"+" (--force) part of refpecs was only conceived for branch updates,
while tags have accepted any changes from upstream unconditionally and
clobbered the local tag object. Changing this behavior has been
discussed as early as 2011[1].

The current behavior doesn't make sense to me, it easily results in
local tags accidentally being clobbered. We could namespace our tags
per-remote and not locally populate refs/tags/*, but as with my
97716d217c ("fetch: add a --prune-tags option and fetch.pruneTags
config", 2018-02-09) it's easier to work around the current
implementation than to fix the root cause.

So this change implements suggestion #1 from Jeff's 2011 E-Mail[1],
"fetch" now only clobbers the tag if either "+" is provided as part of
the refspec, or if "--force" is provided on the command-line.

This also makes it nicely symmetrical with how "tag" itself works when
creating tags. I.e. we refuse to clobber any existing tags unless
"--force" is supplied. Now we can refuse all such clobbering, whether
it would happen by clobbering a local tag with "tag", or by fetching
it from the remote with "fetch".

Ref updates outside refs/{tags,heads/* are still still not symmetrical
with how "git push" works, as discussed in the recently changed
pull-fetch-param.txt documentation. This change brings the two
divergent behaviors more into line with one another. I don't think
there's any reason "fetch" couldn't fully converge with the behavior
used by "push", but that's a topic for another change.

One of the tests added in 31b808a032 ("clone --single: limit the fetch
refspec to fetched branch", 2012-09-20) is being changed to use
--force where a clone would clobber a tag. This changes nothing about
the existing behavior of the test.

1. https://public-inbox.org/git/20111123221658.GA22313@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pull-fetch-param.txt | 11 +++++++----
 builtin/fetch.c                    | 18 ++++++++++++------
 t/t5516-fetch-push.sh              |  5 +++--
 t/t5612-clone-refspec.sh           |  4 ++--
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index ab9617ad01..47c832b17c 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -43,10 +43,13 @@ same rules apply for fetching as when pushing, see the `<refspec>...`
 section of linkgit:git-push[1] for what those are. Exceptions to those
 rules particular to 'git fetch' are noted below.
 +
-Unlike when pushing with linkgit:git-push[1], any updates to
-`refs/tags/*` will be accepted without `+` in the refspec (or
-`--force`). The receiving promiscuously considers all tag updates from
-a remote to be forced fetches.
+Until Git version 2.20, and unlike when pushing with
+linkgit:git-push[1], any updates to `refs/tags/*` would be accepted
+without `+` in the refspec (or `--force`). The receiving promiscuously
+considered all tag updates from a remote to be forced fetches. Since
+Git version 2.20 updates to `refs/tags/*` work the same way as when
+pushing. I.e. any updates will be rejected without `+` in the refspec
+(or `--force`).
 +
 Unlike when pushing with linkgit:git-push[1], any updates outside of
 `refs/{tags,heads}/*` will be accepted without `+` in the refspec (or
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b0706b3803..ed4ed9d8c4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -667,12 +667,18 @@ static int update_local_ref(struct ref *ref,
 
 	if (!is_null_oid(&ref->old_oid) &&
 	    starts_with(ref->name, "refs/tags/")) {
-		int r;
-		r = s_update_ref("updating tag", ref, 0);
-		format_display(display, r ? '!' : 't', _("[tag update]"),
-			       r ? _("unable to update local ref") : NULL,
-			       remote, pretty_ref, summary_width);
-		return r;
+		if (force || ref->force) {
+			int r;
+			r = s_update_ref("updating tag", ref, 0);
+			format_display(display, r ? '!' : 't', _("[tag update]"),
+				       r ? _("unable to update local ref") : NULL,
+				       remote, pretty_ref, summary_width);
+			return r;
+		} else {
+			format_display(display, '!', _("[rejected]"), _("would clobber existing tag"),
+				       remote, pretty_ref, summary_width);
+			return 1;
+		}
 	}
 
 	current = lookup_commit_reference_gently(the_repository,
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3cde72ae47..6c5aa967ee 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1015,7 +1015,7 @@ test_force_fetch_tag () {
 	tag_type_description=$1
 	tag_args=$2
 
-	test_expect_success "fetch will clobber an existing $tag_type_description" "
+	test_expect_success "fetch will not clobber an existing $tag_type_description without --force" "
 		mk_test testrepo heads/master &&
 		mk_child testrepo child1 &&
 		mk_child testrepo child2 &&
@@ -1027,7 +1027,8 @@ test_force_fetch_tag () {
 			git add file1 &&
 			git commit -m 'file1' &&
 			git tag $tag_args testTag &&
-			git -C ../child1 fetch origin tag testTag
+			test_must_fail git -C ../child1 fetch origin tag testTag &&
+			git -C ../child1 fetch origin '+refs/tags/*:refs/tags/*'
 		)
 	"
 }
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 5582b3d5fd..e36ac01661 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -103,7 +103,7 @@ test_expect_success 'clone with --no-tags' '
 test_expect_success '--single-branch while HEAD pointing at master' '
 	(
 		cd dir_master &&
-		git fetch &&
+		git fetch --force &&
 		git for-each-ref refs/remotes/origin |
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" >../actual
@@ -114,7 +114,7 @@ test_expect_success '--single-branch while HEAD pointing at master' '
 	test_cmp expect actual &&
 	(
 		cd dir_master &&
-		git fetch --tags &&
+		git fetch --tags --force &&
 		git for-each-ref refs/tags >../actual
 	) &&
 	git for-each-ref refs/tags >expect &&
-- 
2.19.0.rc1.350.ge57e33dbd1

