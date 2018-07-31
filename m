Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541931F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbeGaOrr (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:47:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35956 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbeGaOrr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:47:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so1617371wmc.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qti6dWaLsHsnlChJVw5SVl8aHCO/sDG1+XZtvb2xU0A=;
        b=Woo9utqw+LRXcQgY+crXHHA/rGJuJZXnIRhqaDZq/sun0Eu3Zaf0NZ2jCDpv2k6WwF
         to6Ui70ekC/n5hiwjPLTXzZyuYThTFbBe+N/zsUhMoE0j502UYtc9goQboDpkmCMP1pR
         hlhaFXXeT0Z8u7dfQnDpe+igygrnr4f198dK50FxHmjFn8lnkhHzfvTBzi3nPpkJowCq
         xelTTXd3d2gLt67hin/Gm3CHjzYX6eJIJKAssswMlOpX3JDzV0GAw0/ZeoUruxAjuAY3
         e1boOJbNRxhcQxRlsY4SCTskNKyHHOv3WPLlxMRD4EZq29nYfm1HnD9esbANRaHPkWAH
         Fr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qti6dWaLsHsnlChJVw5SVl8aHCO/sDG1+XZtvb2xU0A=;
        b=di6OZZ5GTK318Mxj2hKmKwxPCccb1XZR/X1BIIs4O/ViyBON0xMduOKjemQa7KN08T
         rOfV4BtFXqOj7XK0DhxVQ/PWrY4Q5Sv++/8GYdC4PosUOdKVXQ7T2Bq0cYTT7rHXjzAf
         MtPoSk8kKzYUIrsRfoccwfxJ3XsfGJv/3F5c7Tzwpd/Jsjpjm0ffQct2GLpq7OZPL0YG
         wg8D6dEiRnTtseIZAVdbck2qDb9p3/HZtRgh3Hrfnj1Jfsds3Bzbm+1cfdWNMVkAq+CQ
         AjTxDYHs1GZ3Wji1yub3wbTVxNJvVMLX5LbjSwo5zeBA7YtRgDZbzAteBLvJby2k+Bnj
         LPqA==
X-Gm-Message-State: AOUpUlEhTqK17P1csiKzXY9m4+8niPYKPNM2KSu6L3EIppWZQ5mmblFJ
        sqXcPYlvPg3ajeuA967eifBl58UGWkc=
X-Google-Smtp-Source: AAOMgpfkVCegYstV7al4RA1X31JK2FurMHOfVMHuxyF5O5qYFxsyZU6Q65SVJ2Re9B73Gm7S1qmjlA==
X-Received: by 2002:a1c:c1c8:: with SMTP id r191-v6mr2096415wmf.103.1533042448995;
        Tue, 31 Jul 2018 06:07:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p25-v6sm894081wmc.29.2018.07.31.06.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:07:28 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] "git fetch" should not clobber existing tags without --force
Date:   Tue, 31 Jul 2018 13:07:08 +0000
Message-Id: <20180731130718.25222-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It took me a long time to submit a re-roll for this, but this should
solve all issues noted with v1, see
https://public-inbox.org/git/20180429202100.32353-1-avarab@gmail.com/
for the notes on that.

A range-diff with v1 follows below.

 2:  a47d861704 !  1:  77a612e89c push tests: fix logic error in "push" test assertion
    @@ -1,17 +1,13 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    push tests: fix logic error in "push" test assertion
    +    fetch tests: change "Tag" test tag to "testTag"
     
    -    Fix a logic error that's been here since this test was added in
    -    dbfeddb12e ("push: require force for refs under refs/tags/",
    -    2012-11-29).
    +    Calling the test tag "Tag" will make for confusing reading later in
    +    this series when making use of the "git push tag <name>"
    +    feature. Let's call the tag testTag instead.
     
    -    The intent of this test is to force-create a new tag pointing to
    -    HEAD~, and then assert that pushing it doesn't work without --force.
    -
    -    Instead, the code was not creating a new tag at all, and then failing
    -    to push the previous tag for the unrelated reason of providing a
    -    refspec that doesn't make any sense.
    +    Changes code initially added in dbfeddb12e ("push: require force for
    +    refs under refs/tags/", 2012-11-29).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -19,13 +15,30 @@
     --- a/t/t5516-fetch-push.sh
     +++ b/t/t5516-fetch-push.sh
     @@
    - 		git tag -f Tag &&
    - 		test_must_fail git push ../child2 Tag &&
    - 		git push --force ../child2 Tag &&
    + 	mk_child testrepo child2 &&
    + 	(
    + 		cd child1 &&
    +-		git tag Tag &&
    +-		git push ../child2 Tag &&
    +-		git push ../child2 Tag &&
    ++		git tag testTag &&
    ++		git push ../child2 testTag &&
    ++		git push ../child2 testTag &&
    + 		>file1 &&
    + 		git add file1 &&
    + 		git commit -m "file1" &&
    +-		git tag -f Tag &&
    +-		test_must_fail git push ../child2 Tag &&
    +-		git push --force ../child2 Tag &&
     -		git tag -f Tag &&
     -		test_must_fail git push ../child2 Tag HEAD~ &&
    -+		git tag -f Tag HEAD~ &&
    -+		test_must_fail git push ../child2 Tag &&
    - 		git push --force ../child2 Tag
    +-		git push --force ../child2 Tag
    ++		git tag -f testTag &&
    ++		test_must_fail git push ../child2 testTag &&
    ++		git push --force ../child2 testTag &&
    ++		git tag -f testTag &&
    ++		test_must_fail git push ../child2 testTag HEAD~ &&
    ++		git push --force ../child2 testTag
      	)
      '
    + 
 1:  4a3c29b593 !  2:  2386f0c6c6 push tests: remove redundant 'git push' invocation
    @@ -15,9 +15,9 @@
     +++ b/t/t5516-fetch-push.sh
     @@
      		cd child1 &&
    - 		git tag Tag &&
    - 		git push ../child2 Tag &&
    --		git push ../child2 Tag &&
    + 		git tag testTag &&
    + 		git push ../child2 testTag &&
    +-		git push ../child2 testTag &&
      		>file1 &&
      		git add file1 &&
      		git commit -m "file1" &&
 -:  ---------- >  3:  3eaea7c262 push tests: fix logic error in "push" test assertion
 3:  6c54d51a0e !  4:  9dbfb0c058 push tests: add more testing for forced tag pushing
    @@ -4,8 +4,17 @@
     
         Improve the tests added in dbfeddb12e ("push: require force for refs
         under refs/tags/", 2012-11-29) to assert that the same behavior
    -    applies various forms other refspecs, and that "+" in a refspec will
    -    override the "--no-force" option (but not the other way around).
    +    applies various other combinations of command-line option and
    +    refspecs.
    +
    +    Supplying either "+" in refspec or "--force" is sufficient to clobber
    +    the reference. With --no-force we still pay attention to "+" in the
    +    refspec, and vice-versa with clobbering kicking in if there's no "+"
    +    in the refspec but "+" is given.
    +
    +    This is consistent with how refspecs work for branches, where either
    +    "+" or "--force" will enable clobbering, with neither taking priority
    +    over the other.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -13,21 +22,38 @@
     --- a/t/t5516-fetch-push.sh
     +++ b/t/t5516-fetch-push.sh
     @@
    - 		git push --force ../child2 Tag &&
    - 		git tag -f Tag HEAD~ &&
    - 		test_must_fail git push ../child2 Tag &&
    --		git push --force ../child2 Tag
    -+		git push --force ../child2 Tag &&
    -+		git tag -f Tag &&
    + 	)
    + '
    + 
    +-test_expect_success 'push requires --force to update lightweight tag' '
    ++test_expect_success 'force pushing required to update lightweight tag' '
    + 	mk_test testrepo heads/master &&
    + 	mk_child testrepo child1 &&
    + 	mk_child testrepo child2 &&
    +@@
    + 		git push --force ../child2 testTag &&
    + 		git tag -f testTag HEAD~ &&
    + 		test_must_fail git push ../child2 testTag &&
    +-		git push --force ../child2 testTag
    ++		git push --force ../child2 testTag &&
    ++
    ++		# Clobbering without + in refspec needs --force
    ++		git tag -f testTag &&
     +		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
     +		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
    -+		git tag -f Tag HEAD~ &&
    ++
    ++		# Clobbering with + in refspec does not need --force
    ++		git tag -f testTag HEAD~ &&
     +		git push ../child2 "+refs/tags/*:refs/tags/*" &&
    -+		git tag -f Tag &&
    ++
    ++		# Clobbering with --no-force still obeys + in refspec
    ++		git tag -f testTag &&
     +		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&
    -+		git tag -f Tag HEAD~ &&
    -+		test_must_fail git push ../child2 tag Tag &&
    -+		git push --force ../child2 tag Tag
    ++
    ++		# Clobbering with/without --force and "tag <name>" format
    ++		git tag -f testTag HEAD~ &&
    ++		test_must_fail git push ../child2 tag testTag &&
    ++		git push --force ../child2 tag testTag
      	)
      '
      
 4:  0d6b780cb3 !  5:  64bae445e5 push tests: assert re-pushing annotated tags
    @@ -26,66 +26,82 @@
      	)
      '
      
    --test_expect_success 'push requires --force to update lightweight tag' '
    +-test_expect_success 'force pushing required to update lightweight tag' '
     -	mk_test testrepo heads/master &&
     -	mk_child testrepo child1 &&
     -	mk_child testrepo child2 &&
     -	(
     -		cd child1 &&
    --		git tag Tag &&
    --		git push ../child2 Tag &&
    +-		git tag testTag &&
    +-		git push ../child2 testTag &&
     -		>file1 &&
     -		git add file1 &&
     -		git commit -m "file1" &&
    --		git tag -f Tag &&
    --		test_must_fail git push ../child2 Tag &&
    --		git push --force ../child2 Tag &&
    --		git tag -f Tag HEAD~ &&
    --		test_must_fail git push ../child2 Tag &&
    --		git push --force ../child2 Tag &&
    --		git tag -f Tag &&
    +-		git tag -f testTag &&
    +-		test_must_fail git push ../child2 testTag &&
    +-		git push --force ../child2 testTag &&
    +-		git tag -f testTag HEAD~ &&
    +-		test_must_fail git push ../child2 testTag &&
    +-		git push --force ../child2 testTag &&
    +-
    +-		# Clobbering without + in refspec needs --force
    +-		git tag -f testTag &&
     -		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
     -		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
    --		git tag -f Tag HEAD~ &&
    +-
    +-		# Clobbering with + in refspec does not need --force
    +-		git tag -f testTag HEAD~ &&
     -		git push ../child2 "+refs/tags/*:refs/tags/*" &&
    --		git tag -f Tag &&
    +-
    +-		# Clobbering with --no-force still obeys + in refspec
    +-		git tag -f testTag &&
     -		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&
    --		git tag -f Tag HEAD~ &&
    --		test_must_fail git push ../child2 tag Tag &&
    --		git push --force ../child2 tag Tag
    +-
    +-		# Clobbering with/without --force and "tag <name>" format
    +-		git tag -f testTag HEAD~ &&
    +-		test_must_fail git push ../child2 tag testTag &&
    +-		git push --force ../child2 tag testTag
     -	)
     -'
     +test_force_push_tag () {
     +	tag_type_description=$1
     +	tag_args=$2
     +
    -+	test_expect_success "push requires --force to update $tag_type_description" "
    ++	test_expect_success 'force pushing required to update lightweight tag' "
     +		mk_test testrepo heads/master &&
     +		mk_child testrepo child1 &&
     +		mk_child testrepo child2 &&
     +		(
     +			cd child1 &&
    -+			git tag Tag &&
    -+			git push ../child2 Tag &&
    ++			git tag testTag &&
    ++			git push ../child2 testTag &&
     +			>file1 &&
     +			git add file1 &&
     +			git commit -m 'file1' &&
    -+			git tag $tag_args Tag &&
    -+			test_must_fail git push ../child2 Tag &&
    -+			git push --force ../child2 Tag &&
    -+			git tag $tag_args Tag HEAD~ &&
    -+			test_must_fail git push ../child2 Tag &&
    -+			git push --force ../child2 Tag &&
    -+			git tag $tag_args Tag &&
    ++			git tag $tag_args testTag &&
    ++			test_must_fail git push ../child2 testTag &&
    ++			git push --force ../child2 testTag &&
    ++			git tag $tag_args testTag HEAD~ &&
    ++			test_must_fail git push ../child2 testTag &&
    ++			git push --force ../child2 testTag &&
    ++
    ++			# Clobbering without + in refspec needs --force
    ++			git tag -f testTag &&
     +			test_must_fail git push ../child2 'refs/tags/*:refs/tags/*' &&
     +			git push --force ../child2 'refs/tags/*:refs/tags/*' &&
    -+			git tag $tag_args Tag HEAD~ &&
    ++
    ++			# Clobbering with + in refspec does not need --force
    ++			git tag -f testTag HEAD~ &&
     +			git push ../child2 '+refs/tags/*:refs/tags/*' &&
    -+			git tag $tag_args Tag &&function
    ++
    ++			# Clobbering with --no-force still obeys + in refspec
    ++			git tag -f testTag &&
     +			git push --no-force ../child2 '+refs/tags/*:refs/tags/*' &&
    -+			git tag $tag_args Tag HEAD~ &&
    -+			test_must_fail git push ../child2 tag Tag &&
    -+			git push --force ../child2 tag Tag
    ++
    ++			# Clobbering with/without --force and 'tag <name>' format
    ++			git tag -f testTag HEAD~ &&
    ++			test_must_fail git push ../child2 tag testTag &&
    ++			git push --force ../child2 tag testTag
     +		)
     +	"
     +}
 5:  277fa440a7 !  6:  2209f03463 push doc: correct lies about how push refspecs work
    @@ -36,10 +36,9 @@
      The <src> is often the name of the branch you would want to push, but
     -it can be any arbitrary "SHA-1 expression", such as `master~4` or
     -`HEAD` (see linkgit:gitrevisions[7]).
    -+it can be any arbitrary "SHA-1 expression" referring to a branch, such
    -+as `master~4` or `HEAD` (see linkgit:gitrevisions[7]). It can also
    -+refer to tag objects, trees or blobs if the <dst> is outside of
    -+`refs/heads/*`.
    ++it can be any arbitrary expression to a commit, such as `master~4` or
    ++`HEAD` (see linkgit:gitrevisions[7]). It can also refer to tag
    ++objects, trees or blobs if the <dst> is outside of `refs/heads/*`.
      +
      The <dst> tells which ref on the remote side is updated with this
      push. Arbitrary expressions cannot be used here, an actual ref must
    @@ -53,24 +52,25 @@
     -the <dst> ref even if it is not allowed by default (e.g., it is not a
     -fast-forward.)  This does *not* attempt to merge <src> into <dst>.  See
     -EXAMPLES below for details.
    -+on the remote side. Whether this is allowed depends on what where in
    ++on the remote side. Whether this is allowed depends on where in
     +`refs/*` the <dst> reference lives. The `refs/heads/*` namespace will
     +only accept commit objects, and then only they can be
     +fast-forwarded. The `refs/tags/*` namespace will accept any kind of
    -+object, but there commit objects are known as lightweight tags, and
    -+any changes to them and others types of objects will be
    -+rejected. Finally and most confusingly, it's possible to push any type
    -+of object to any namespace outside of `refs/{tags,heads}/*`, but these
    -+will be treated as branches, even in the case where a tag object is
    -+pushed. That tag object will be overwritten by another tag object (or
    -+commit!) without `--force` if the new tag happens to point to a commit
    -+that's a fast-forward of the commit it replaces.
    ++object, and any changes to them and others types of objects will be
    ++rejected. Finally, it's possible to push any type of object to any
    ++namespace outside of `refs/{tags,heads}/*`, but these will be treated
    ++as branches for the purposes of whether `--force` is required, even in
    ++the case where a tag object is pushed. That tag object will be
    ++overwritten by another tag object (or commit!) without `--force` if
    ++the new tag happens to point to a commit that's a fast-forward of the
    ++commit it replaces.
     ++
    -+By having the optional leading `+`, you can tell Git to update the
    -+<dst> ref even if it is not allowed by its respective namespace
    -+clobbering rules (e.g., it is not a fast-forward. in the case of
    -+`refs/heads/*` updates) This does *not* attempt to merge <src> into
    -+<dst>.  See EXAMPLES below for details.
    ++By having the optional leading `+` to a refspec (or using `--force`
    ++command line option) you can tell Git to update the <dst> ref even if
    ++it is not allowed by its respective namespace clobbering rules (e.g.,
    ++it is not a fast-forward. in the case of `refs/heads/*` updates) This
    ++does *not* attempt to merge <src> into <dst>.  See EXAMPLES below for
    ++details.
      +
      `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
      +
 6:  158fcc08d2 =  7:  844f4fb491 fetch tests: correct a comment "remove it" -> "remove them"
 7:  0134b9353f =  8:  cf9abd7c69 fetch tests: add a test clobbering tag behavior
 -:  ---------- >  9:  af1e1482a2 pull doc: fix a long-standing grammar error
 8:  57b7bc325d ! 10:  9c508fb926 fetch: stop clobbering existing tags without --force
    @@ -7,31 +7,34 @@
     
         This changes the long-standing behavior of "fetch" added in
         853a3697dc ("[PATCH] Multi-head fetch.", 2005-08-20), before this
    -    change all tag fetches effectively had --force enabled. The original
    -    rationale in that change was:
    +    change all tag fetches effectively had --force enabled. See the
    +    git-fetch-script code in fast_forward_local() with the comment:
     
             > Tags need not be pointing at commits so there is no way to
             > guarantee "fast-forward" anyway.
     
    -    That comment and the rest of the history of "fetch" shows that the
    +    That commit and the rest of the history of "fetch" shows that the
         "+" (--force) part of refpecs was only conceived for branch updates,
         while tags have accepted any changes from upstream unconditionally and
         clobbered the local tag object. Changing this behavior has been
         discussed as early as 2011[1].
     
    -    I the current behavior doesn't make sense, it easily results in local
    -    tags accidentally being clobbered. Ideally we'd namespace our tags
    -    per-remote, but as with my 97716d217c ("fetch: add a --prune-tags
    -    option and fetch.pruneTags config", 2018-02-09) it's easier to work
    -    around the current implementation than to fix the root cause, so this
    -    implements suggestion #1 from [1], "fetch" now only clobbers the tag
    -    if either "+" is provided as part of the refspec, or if "--force" is
    -    provided on the command-line.
    +    The current behavior doesn't make sense to me, it easily results in
    +    local tags accidentally being clobbered.  We could namespace our tags
    +    per-remote and not locally populate refs/tags/*, but as with my
    +    97716d217c ("fetch: add a --prune-tags option and fetch.pruneTags
    +    config", 2018-02-09) it's easier to work around the current
    +    implementation than to fix the root cause.
     
    -    This also makes it nicely symmetrical with how "tag" itself
    -    works. We'll now refuse to clobber any existing tags unless "--force"
    -    is supplied, whether that clobbering would happen by clobbering a
    -    local tag with "tag", or by fetching it from the remote with "fetch".
    +    So this change implements suggestion #1 from Jeff's 2011 E-Mail[1],
    +    "fetch" now only clobbers the tag if either "+" is provided as part of
    +    the refspec, or if "--force" is provided on the command-line.
    +
    +    This also makes it nicely symmetrical with how "tag" itself works when
    +    creating tags. I.e. we refuse to clobber any existing tags unless
    +    "--force" is supplied. Now we can refuse all such clobbering, whether
    +    it would happen by clobbering a local tag with "tag", or by fetching
    +    it from the remote with "fetch".
     
         It's still not at all nicely symmetrical with how "git push" works, as
         discussed in the updated pull-fetch-param.txt documentation, but this
    @@ -60,7 +63,7 @@
     -	`<lbranch>` unless the remote branch `<rbranch>` it
     -	fetches is a descendant of `<lbranch>`.  This option
     -	overrides that check.
    -+	When 'git fetch' is used with `<src>:<dst>` refspec it might
    ++	When 'git fetch' is used with `<src>:<dst>` refspec it may
     +	refuse to update the local branch as discussed
     +ifdef::git-pull[]
     +	in the `<refspec>` part of the linkgit:git-fetch[1]
    @@ -78,31 +81,29 @@
     --- a/Documentation/pull-fetch-param.txt
     +++ b/Documentation/pull-fetch-param.txt
     @@
    - `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
      it requests fetching everything up to the given tag.
      +
    --The remote ref that matches <src>
    --is fetched, and if <dst> is not empty string, the local
    + The remote ref that matches <src>
    +-is fetched, and if <dst> is not an empty string, the local
     -ref that matches it is fast-forwarded using <src>.
     -If the optional plus `+` is used, the local ref
     -is updated even if it does not result in a fast-forward
     -update.
    -+The remote ref that matches <src> is fetched, and if <dst> is not
    -+empty string, an attempt is made to update the local ref that matches
    -+it.
    ++is fetched, and if <dst> is not an empty string, an attempt
    ++is made to update the local ref that matches it.
    +++
    ++Whether that update is allowed without `--force` depends on the ref
    ++namespace it's being fetched to, and the type of object being
    ++fetched. If it's a commit under `refs/heads/*` only fast-forwards are
    ++allowed.
     ++
    -+Whether that update is allowed is confusingly not the inverse of
    -+whether a server will accept a push as described in the `<refspec>...`
    -+section of linkgit:git-push[1]. If it's a commit under `refs/heads/*`
    -+only fast-forwards are allowed, but unlike what linkgit:git-push[1]
    -+will accept clobbering any ref pointing to blobs, trees etc. in any
    -+other namespace will be accepted, but commits in any ref
    -+namespace. Those apply the same fast-forward rule. An exception to
    -+this is that as of Git version 2.18 any object under `refs/tags/*` is
    -+protected from updates.
    ++By having the optional leading `+` to a refspec (or using `--force`
    ++command line option) you can tell Git to update the local ref even if
    ++it is not allowed by its respective namespace clobbering rules.
     ++
    -+If the optional plus `+` is used, the local ref is updated if the
    -+update would have otherwise been rejected.
    ++Before Git version 2.19 tag objects under `refs/tags/*` would not be
    ++protected from updates, but since then the `+` (or `--force`) syntax
    ++is required to clobber them.
      +
      [NOTE]
      When the remote branch you want to fetch is known to

Ævar Arnfjörð Bjarmason (10):
  fetch tests: change "Tag" test tag to "testTag"
  push tests: remove redundant 'git push' invocation
  push tests: fix logic error in "push" test assertion
  push tests: add more testing for forced tag pushing
  push tests: assert re-pushing annotated tags
  push doc: correct lies about how push refspecs work
  fetch tests: correct a comment "remove it" -> "remove them"
  fetch tests: add a test clobbering tag behavior
  pull doc: fix a long-standing grammar error
  fetch: stop clobbering existing tags without --force

 Documentation/fetch-options.txt    | 15 +++--
 Documentation/git-push.txt         | 30 +++++++---
 Documentation/gitrevisions.txt     |  7 ++-
 Documentation/pull-fetch-param.txt | 20 +++++--
 builtin/fetch.c                    | 20 ++++---
 t/t5510-fetch.sh                   |  2 +-
 t/t5516-fetch-push.sh              | 90 +++++++++++++++++++++++-------
 t/t5612-clone-refspec.sh           |  4 +-
 8 files changed, 137 insertions(+), 51 deletions(-)

-- 
2.18.0.345.g5c9ce644c3

