Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280EB1F462
	for <e@80x24.org>; Sun, 26 May 2019 22:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfEZWzK (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 May 2019 18:55:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45794 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfEZWzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 May 2019 18:55:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so14985917wrq.12;
        Sun, 26 May 2019 15:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMUk3Qi7ehStox1DKoqfw3m6PEg9rEqP98IUbifxH40=;
        b=dL9U/Hs0k07/elOl2yV3Sfr5qMcxJeT6cjMsUmUZJA3LlNCcJKrMFVVv2fUK1Li/1x
         uEkLV78dO0oOnaD7IxTCWipjmoIAmpxYXWfq8MgJxcjFTgHGcq/0nEUtBuWPdRG1/bfC
         pqkRkoUP331yG072PeaywNnAcFwgpu5oDo/ZBuPY9TTTnbVcXf9f0hOeED+MTXuRsOJc
         hd4G1qrBRWElra2bY5T7eqK2IJBYbfESroRTfaPnmHm6D9TB11xtdeGNcNziO45sjf8w
         dxVbXHa6eZh1ZxrXhs7Gby0PRqEYQsmrggJiEfA68zI27ik/EfbX/fXH5wIXcAU5Okww
         zukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMUk3Qi7ehStox1DKoqfw3m6PEg9rEqP98IUbifxH40=;
        b=n/Kv2IWZvdueTDjtF9fFuD/D2MD+OSlbV396m1MB1NIMTeVeTjWB0uOe8QRprhfUbu
         bG+c/yoix73Hqtheny90R9abGLCsZmZL7xZgQ/zIfLAkL5fyFkS6if9ElqiuNDX+r4PZ
         O7cLqJigxwdR1W8hlZOF9XiD2g3MBdYEWO2Ed7FdiWKv1X7HzYmOThh+zchegno25b7g
         pKaksDPrzXOvb3mhboeNGjFYdBS3Ge/3ZA7dS54Ubox/7XIPtsTFCpjY3b6MLPAaDT9M
         H7bhGMdEm4Tdih35zv2hhR7x0VfRYLMjwiqynCiknQpcuLeb69OekWFXKGfH6CP0a7by
         IsEQ==
X-Gm-Message-State: APjAAAU/ucY6ZM2Npk3SKEQtM9B+GHpb7rnwqSWPWfMz0Ousj9RxBdA0
        4RXhCN/p/LCCgBm0x3AFG2c0CrbKGL0=
X-Google-Smtp-Source: APXvYqwsZJrMq2FvJYmaIUI2oleYd9y7vg8Rz7ZHXC5bOcQoX+zWMHLdmD+YOybLAcHepTNVEmL9xA==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr63637568wra.278.1558911306386;
        Sun, 26 May 2019 15:55:06 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z21sm9502851wmf.25.2019.05.26.15.55.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 26 May 2019 15:55:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH] refs: tone down the dwimmery in refname_match() for {heads,tags,remotes}/*
Date:   Mon, 27 May 2019 00:54:45 +0200
Message-Id: <20190526225445.21618-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com>
References: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a refspec like HEAD:tags/x is pushed where HEAD is a branch,
we'll push a *branch* that'll be located at "refs/heads/tags/x". This
is part of the rather straightforward rules I documented in
2219c09e23 ("push doc: document the DWYM behavior pushing to
unqualified <dst>", 2018-11-13).

However, if there exists a refs/tags/x on the remote the
count_refspec_match() logic will, as a result of calling
refname_match() match the detected branch type of the LHS of the
refspec to refs/tags/x, because it's in a loop where it tries to match
"tags/x" to "refs/tags/X', then "refs/tags/tags/x" etc.

This resulted in a case[1] where someone on LKML did:

    git push kvm +HEAD:tags/for-linus

Which would have created a new "tags/for-linus" branch in their "kvm"
repository, except because they happened to have an existing
"refs/tags/for-linus" reference we pushed there instead, and replaced
an annotated tag with a lightweight tag.

Let's tone this down a bit and not match the more general expansions
if they'd overlap with later expansions.

This patch is a hack, and should not be applied. We probably want to
fix this for "push", but we use refname_match() all over the place. We
probably want to start by undoing part of
54457fe509 ("refname_match(): always use the rules in
ref_rev_parse_rules", 2014-01-14) and having special rules just for
push.

Furthermore ref_rev_parse_rules is used elsewhere, should we be doing
this in other places? I think not if we undo most of 54457fe509 and
can just have a custom matcher just for count_refspec_match(). That
one shouldn't need any sort of magic, because elsewhere in the remote
push DWYM code we try to add implicit refs/{tags,heads}/ prefixes.

As the t/t5150-request-pull.sh change shows this results in a failing
test where a local "full" branch is being pushed to a remote
"refs/tags/full". So maybe this is something LKML people actually want
for some reason.

1. https://lore.kernel.org/lkml/2d55fd2a-afbf-1b7c-ca82-8bffaa18e0d0@redhat.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sun, May 26 2019, Linus Torvalds wrote:

> On Sun, May 26, 2019 at 10:53 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The interesting thing is that not only git will treat lightweight tags
>> like, well, tags:
>
> Yeah, that's very much by design - lightweight tags are very
> comvenient for local temporary stuff where you don't want signing etc
> (think automated test infrastructure, or just local reminders).
>
>> In addition, because I _locally_ had a tag object that
>> pointed to the same commit and had the same name, git-request-pull
>> included my local tag's message in its output!  I wonder if this could
>> be considered a bug.
>
> Yeah, I think git request-pull should at least *warn* about the tag
> not being the same object locally as in the remote you're asking me to
> pull.
>
> Are you sure you didn't get a warning, and just missed it? But adding
> Junio and the Git list just as a possible heads-up for this in case
> git request-pull really only compares the object the tag points to,
> rather than the SHA1 of the tag itself.

This behavior looks like a bug to me. This RFC-quality patch is an
initial stab at fixing it, and is all I had time for today.

 refs.c                   |  8 +++++++-
 t/t5150-request-pull.sh  |  2 +-
 t/t5505-remote.sh        | 17 +++++++++++++++++
 t/t9101-git-svn-props.sh | 12 ++++++------
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 92d1f6dbdd..729b921328 100644
--- a/refs.c
+++ b/refs.c
@@ -514,9 +514,15 @@ int refname_match(const char *abbrev_name, const char *full_name)
 	const int abbrev_name_len = strlen(abbrev_name);
 	const int num_rules = NUM_REV_PARSE_RULES;
 
-	for (p = ref_rev_parse_rules; *p; p++)
+	for (p = ref_rev_parse_rules; *p; p++) {
+		if (!strcmp(*p, "refs/%.*s") &&
+		    (starts_with(abbrev_name, "tags/") ||
+		     starts_with(abbrev_name, "heads/") ||
+		     starts_with(abbrev_name, "remotes/")))
+			continue;
 		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name)))
 			return &ref_rev_parse_rules[num_rules] - p;
+	}
 
 	return 0;
 }
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index fca001eb9b..0265871cf4 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -212,7 +212,7 @@ test_expect_success 'pull request format' '
 		cd local &&
 		git checkout initial &&
 		git merge --ff-only master &&
-		git push origin tags/full &&
+		git push origin full:refs/tags/full &&
 		git request-pull initial "$downstream_url" tags/full >../request
 	) &&
 	<request sed -nf fuzz.sed >request.fuzzy &&
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 883b32efa0..52507b9e50 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1277,4 +1277,21 @@ test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and
 	)
 '
 
+test_expect_success 'HEAD:tags/A and HEAD:tags/B should not be different one of refs/tags/[AB] exists' '
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
+		git push origin HEAD:tags/my-tag &&
+		git -C ../two rev-parse refs/heads/tags/my-tag >actual &&
+		test_cmp expected actual
+	)
+'
+
 test_done
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index c26c4b0927..f9e43f4e97 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -73,11 +73,11 @@ test_expect_success 'fetch revisions from svn' 'git svn fetch'
 
 name='test svn:keywords ignoring'
 test_expect_success "$name" \
-	'git checkout -b mybranch remotes/git-svn &&
+	'git checkout -b mybranch refs/remotes/git-svn &&
 	echo Hi again >> kw.c &&
 	git commit -a -m "test keywords ignoring" &&
-	git svn set-tree remotes/git-svn..mybranch &&
-	git pull . remotes/git-svn'
+	git svn set-tree refs/remotes/git-svn..mybranch &&
+	git pull . refs/remotes/git-svn'
 
 expect='/* $Id$ */'
 got="$(sed -ne 2p kw.c)"
@@ -95,7 +95,7 @@ test_expect_success "propset CR on crlf files" '
 
 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
 	'git svn fetch &&
-	 git pull . remotes/git-svn &&
+	 git pull . refs/remotes/git-svn &&
 	 svn_cmd co "$svnrepo" new_wc'
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
@@ -117,7 +117,7 @@ cd test_wc
 	 svn_cmd commit -m "propset CRLF on cr files"'
 cd ..
 test_expect_success 'fetch and pull latest from svn' \
-	'git svn fetch && git pull . remotes/git-svn'
+	'git svn fetch && git pull . refs/remotes/git-svn'
 
 b_cr="$(git hash-object cr)"
 b_ne_cr="$(git hash-object ne_cr)"
@@ -168,7 +168,7 @@ cat >create-ignore-index.expect <<\EOF
 EOF
 
 test_expect_success 'test create-ignore' "
-	git svn fetch && git pull . remotes/git-svn &&
+	git svn fetch && git pull . refs/remotes/git-svn &&
 	git svn create-ignore &&
 	cmp ./.gitignore create-ignore.expect &&
 	cmp ./deeply/.gitignore create-ignore.expect &&
-- 
2.21.0.1020.gf2820cf01a

