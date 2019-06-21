Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584071F461
	for <e@80x24.org>; Fri, 21 Jun 2019 14:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfFUOpD (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 10:45:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46640 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUOpC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 10:45:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so6805979wrw.13;
        Fri, 21 Jun 2019 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hs5jMxH1qfI9XrhkDS3mG+g/lMuciQerbzkd/y0dumE=;
        b=DDMiecOmc51/FZOpP5bE4oQthzjyVdWtY5f7Wc1yTI4FfwL3b7ramODW0HYE/8h1Ju
         Jr9lq3VZWrbhZMYkW2VJFzPDjn8YHyDShJnQvGgAz4DtBZTEeEeXOJKeTbynycQQKtdW
         qaLBBIwrp8r688mstge5x6C/M0xRxcQaxbw7ceiKcO3Z9o6eL8lvabD+wYvFawkU0y7U
         Qg6bDimLYou35qewIC3v29Ga2PjgFrKBz4fgvAZP0q2aVpmhULgixUqvV5gs7bLGM/he
         oGedlhq/x5sRHn3lFSwKdOYfQwZPwYYKjx+CPekwtLlWDnTEJcdQrNIbTQi+Rfzaudhl
         xjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hs5jMxH1qfI9XrhkDS3mG+g/lMuciQerbzkd/y0dumE=;
        b=eAfxJo7ApnXcx/m0V4DqcEdimL4NbnfsjNqV6RTb+jUGDs9oDZRM9OYhhTZJcDy92m
         esD+v/QA5lCqH/r9W2P6ZaJInRuJ/se/PO+g60sPrgJ+1zk0t1ThWWJqg6CFyN2Rj+9X
         1AoUHM0hVuO2iNzM1I/wKXGeiPYEdmdEuTY5iQOHebU1HbR+kv9ZqW625lbUhZqFV0/z
         QnZgyM0V+tiwavZU4IupWug0kb+yaHid7vfSXxHaF7KNIVisw7Qc61117cXylUYMWH+f
         gvPxhtevqKQ/9v6iVARZf1fMZGv07a4bE76VjyRF9xPq87m5m9RDcusvuv8XhVugsTad
         tVRA==
X-Gm-Message-State: APjAAAXEYJvvIAeHbrXxBV+m1eWg/78UlSc6AGLttlRgOtlp/lz3RCdB
        2IJX2F9F9MRcNDb9JOsHs3BC/wjGofA=
X-Google-Smtp-Source: APXvYqzjlZZ+/l+e7/a2gWk7FvhGbL5shM2ZbNQ6ZfMt2nhogNgaplgtbCJ9n9g9EEzZscE3RNmbgA==
X-Received: by 2002:adf:dd89:: with SMTP id x9mr19668029wrl.7.1561128299240;
        Fri, 21 Jun 2019 07:44:59 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm3516159wrd.51.2019.06.21.07.44.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 07:44:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] push: make "HEAD:tags/my-tag" consistently push to a branch
Date:   Fri, 21 Jun 2019 16:44:47 +0200
Message-Id: <20190621144447.21769-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190526225445.21618-1-avarab@gmail.com>
References: <20190526225445.21618-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a refspec like "HEAD:tags/my-tag" is pushed where "HEAD" is a
branch, we'll push a *branch* that'll be located at
"refs/heads/tags/my-tag". This is part of the rather straightforward
rules I documented in 2219c09e23 ("push doc: document the DWYM
behavior pushing to unqualified <dst>", 2018-11-13).

However, if there exists a "refs/tags/my-tag" on the remote the
count_refspec_match() logic will, as a result of calling
refname_match(), match partially-qualified RHS of the refspec
"refs/tags/my-tag", because it's in a loop where it tries to match
"tags/my-tag" to "refs/tags/my-tag', then "refs/tags/tags/my-tag" etc.

This resulted in a case[1] where someone on LKML did:

    git push kvm +HEAD:tags/for-linus

Which would have created a new "refs/heads/tags/for-linus" branch in
their "kvm" repository. But since they happened to have an existing
"refs/tags/for-linus" reference we pushed there instead, and replaced
an annotated tag with a lightweight tag.

We do want a RHS ref like "master" to match "refs/heads/master", but
it's confusing and dangerous that the DWYM behavior for matching
partial RHS refspecs acts differently when the start of the RHS
happens to be a second-level namespace under "refs/" namespace like
"tags".

Now we'll print out the following advice when this happens, and act
differently as described therein:

    hint: The <dst> part of the refspec matched both of:
    hint:
    hint:   1. tags/my-tag -> refs/tags/my-tag
    hint:   2. tags/my-tag -> refs/heads/tags/my-tag
    hint:
    hint: Earlier versions of git would have picked (1) as the RHS starts
    hint: with a second-level ref prefix which could be fully-qualified by
    hint: adding 'refs/' in front of it. We now pick (2) which uses the prefix
    hint: inferred from the <src> part of the refspec.
    hint:
    hint: See the "<refspec>..." rules  discussed in 'git help push'.

An earlier version of this patch[2] used the much more heavy-handed
approach of changing this logic in refname_match(). As shown from the
tests that patch needed to modify that results in changes that are
overzealous for fixing this push-specific issue.

The right place to fix this is in match_explicit(). There we can see
if we have both a DWYM match and a match based on the prefix of the
LHS of the refspec, in those cases the match based on the LHS's ref
prefix should win.

1. https://lore.kernel.org/lkml/2d55fd2a-afbf-1b7c-ca82-8bffaa18e0d0@redhat.com/
2. https://public-inbox.org/git/20190526225445.21618-1-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Now that the 2.22.0 release is out I cleaned this up into a more
sensible patch.

 Documentation/config/advice.txt |  7 +++++++
 Documentation/git-push.txt      | 13 +++++++++++++
 advice.c                        |  2 ++
 advice.h                        |  1 +
 remote.c                        | 23 ++++++++++++++++++++++-
 t/t5505-remote.sh               | 18 ++++++++++++++++++
 6 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index ec4f6ae658..36cb3db63a 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -37,6 +37,13 @@ advice.*::
 		we can still suggest that the user push to either
 		refs/heads/* or refs/tags/* based on the type of the
 		source object.
+	pushPartialAmbigiousName::
+		Shown when linkgit:git-push[1] is given a refspec
+		where the <src> in earlier versions of Git would have
+		matched a <dst> on the remote based on its existence
+		over appending a prefix based on the type of the
+		<src>. See the "<refspec>..." documentation in
+		linkgit:git-push[1] for details.
 	statusHints::
 		Show directions on how to proceed from the current
 		state in the output of linkgit:git-status[1], in
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 6a8a0d958b..5c46ef5e59 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -84,6 +84,19 @@ is ambiguous.
 
 * If <src> resolves to a ref starting with refs/heads/ or refs/tags/,
   then prepend that to <dst>.
++
+Versions of Git before 2.23.0 would override this rule and match
+e.g. `HEAD:tags/mark` to either `refs/tags/mark` or `refs/tags/mark`
+depending on, respectively, if `refs/tags/mark` existed or not on the
+remote.
++
+We'll now consistently pick `refs/heads/tags/mark` based on this rule
+and so that we're not so eager in guessing the <dst> on the remote
+that we'll pick a different <dst> based on what refs exist there
+already than we otherwise would have. This exception guards for cases
+where the match would be different due to a subsequent
+"refs/{tags,heads,remotes}/" matching rule". than a plain "refs/"
+prefix match.
 
 * Other ambiguity resolutions might be added in the future, but for
   now any other cases will error out with an error indicating what we
diff --git a/advice.c b/advice.c
index ce5f374ecd..c9217834e2 100644
--- a/advice.c
+++ b/advice.c
@@ -10,6 +10,7 @@ int advice_push_already_exists = 1;
 int advice_push_fetch_first = 1;
 int advice_push_needs_force = 1;
 int advice_push_unqualified_ref_name = 1;
+int advice_partial_ambiguous_ref_name = 1;
 int advice_status_hints = 1;
 int advice_status_u_option = 1;
 int advice_commit_before_merge = 1;
@@ -66,6 +67,7 @@ static struct {
 	{ "pushFetchFirst", &advice_push_fetch_first },
 	{ "pushNeedsForce", &advice_push_needs_force },
 	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
+	{ "pushPartialAmbigiousName", &advice_partial_ambiguous_ref_name },
 	{ "statusHints", &advice_status_hints },
 	{ "statusUoption", &advice_status_u_option },
 	{ "commitBeforeMerge", &advice_commit_before_merge },
diff --git a/advice.h b/advice.h
index e50f02cdfe..027ec396cf 100644
--- a/advice.h
+++ b/advice.h
@@ -10,6 +10,7 @@ extern int advice_push_already_exists;
 extern int advice_push_fetch_first;
 extern int advice_push_needs_force;
 extern int advice_push_unqualified_ref_name;
+extern int advice_partial_ambiguous_ref_name;
 extern int advice_status_hints;
 extern int advice_status_u_option;
 extern int advice_commit_before_merge;
diff --git a/remote.c b/remote.c
index e50f7602ed..be226fac11 100644
--- a/remote.c
+++ b/remote.c
@@ -1066,7 +1066,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
 			  struct refspec_item *rs)
 {
-	struct ref *matched_src, *matched_dst;
+	struct ref *matched_src, *matched_dst, *tmp;
 	int allocated_src;
 
 	const char *dst_value = rs->dst;
@@ -1094,6 +1094,27 @@ static int match_explicit(struct ref *src, struct ref *dst,
 
 	switch (count_refspec_match(dst_value, dst, &matched_dst)) {
 	case 1:
+		if ((starts_with(dst_value, "tags/") ||
+		     starts_with(dst_value, "heads/") ||
+		     starts_with(dst_value, "remotes/")) &&
+		    (dst_guess = guess_ref(dst_value, matched_src))) {
+			tmp = make_linked_ref(dst_guess, dst_tail);
+			if (advice_partial_ambiguous_ref_name)
+				advise(_("The <dst> part of the refspec matched both of:\n"
+					 "\n"
+					 "	1. %1$s -> %2$s\n"
+					 "	2. %1$s -> %3$s\n"
+					 "\n"
+					 "Earlier versions of git would have picked (1) as the RHS starts\n"
+					 "with a second-level ref prefix which could be fully-qualified by\n"
+					 "adding 'refs/' in front of it. We now pick (2) which uses the prefix\n"
+					 "inferred from the <src> part of the refspec.\n"
+					 "\n"
+					 "See the \"<refspec>...\" rules  discussed in 'git help push'.\n"),
+					dst_value, matched_dst->name, tmp->name);
+			matched_dst = tmp;
+		}
+
 		break;
 	case 0:
 		if (starts_with(dst_value, "refs/")) {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 883b32efa0..4d54f90ae3 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1277,4 +1277,22 @@ test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and
 	)
 '
 
+test_expect_success 'HEAD:tags/A and HEAD:tags/B should not be different depending on if refs/tags/[AB] exists or not' '
+	git clone "file://$PWD/two" tags-match &&
+	(
+		cd tags-match &&
+		test_commit A &&
+		git rev-parse HEAD >expected &&
+
+		git push origin HEAD:tags/my-not-a-tag &&
+		git -C ../two rev-parse refs/heads/tags/my-not-a-tag >actual &&
+		test_cmp expected actual &&
+
+		git push origin HEAD:tags/my-tag 2>advice &&
+		test_i18ngrep "hint: The <dst> part of the refspec matched both of" advice &&
+		git -C ../two rev-parse refs/heads/tags/my-tag >actual &&
+		test_cmp expected actual
+	)
+'
+
 test_done
-- 
2.22.0.455.g172b71a6c5

