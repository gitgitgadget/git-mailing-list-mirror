Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1871F453
	for <e@80x24.org>; Mon,  5 Nov 2018 00:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeKEKNf (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 05:13:35 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:40151 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeKEKNf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 05:13:35 -0500
Received: by mail-wm1-f43.google.com with SMTP id b203-v6so6407789wme.5
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 16:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Wzpz+Y2UFFjQRwV2iQ3sr5k01zQF4go5L/+QMVU0hsc=;
        b=JzkyuuT6a8IiGrJvcmB+OD64Cp3JeLvjIDp/IPNkMiHskgfrTT3BtfqbvDI8T3dtwA
         RpXCnp70HYe/Nkpd7cvDf+pn1PAJA0mvI4vvPTBX5xMyTAxC0pUBhxn00XtoxyavTeAl
         AA+uXrobJCcbacCvxyggsxbcu36fTjdyMWo8N2W2ApTcqtFwsWPrU3prYX2uYANf5u/q
         MiXiLHdzxnI3Ud7DHpC8vt9yuLwDG/FLobah3FbI8Ghl15dGpK+KByeHG/qBAvTOWYZe
         i0Swjfc3nBbUCorrxzjEu9RD+mVMyhJnhkLtqSadSUlywYJFrGsSWf5Q8RvgIl9P1erQ
         xJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Wzpz+Y2UFFjQRwV2iQ3sr5k01zQF4go5L/+QMVU0hsc=;
        b=DA/46V78KX0qx3PHXu9iiRJiMmco8rNWIc3f8/bpXyzzhz21KCSvmKRrklimCJ9+KX
         rGdVvVAcv1q8JDc2XFYv2Kr4yssVUeejk3vrVrVsEqgHnQQnwuDtU2OHZdD6VJlNeUdP
         7deo8uBThq2rkwbvWGjFNzz/t8U4FoVgYW3+yr71AlemF9C1zTqhT8yFT61YtJD31mWz
         b8/gFhn2p18LMXLXka98oxj0Qya6EsRTEQT/y1Vt/0gxH2chu/wJuEaGfT9PvdeP0Ajk
         aNym7l8AG5xFrZIl0qOH4ULAilkPorjUuYqeAIBK/qjp6+XuT0ZvXmIqpjRLg/EvI/2c
         9HGg==
X-Gm-Message-State: AGRZ1gKSWg3O1w9ur+21vtDYi49NXp539RpsTLSBe2UnFOVhy8KfE8c8
        GKDFoIvHw13wL2IdhYTY7thqLBqKNPQ=
X-Google-Smtp-Source: AJdET5cz2uYJDk4FNjMAH+pecDqxcSFJmvEeqCkKRlghLyv3X+28EDA8XE0qSyuuX18KLqSn4//sYQ==
X-Received: by 2002:a1c:650b:: with SMTP id z11-v6mr4545642wmb.28.1541379393219;
        Sun, 04 Nov 2018 16:56:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y2-v6sm3188413wrh.53.2018.11.04.16.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 16:56:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] sequencer.c: record revert/cherry-pick commit with trailer lines
References: <20181104072253.12357-1-pclouds@gmail.com>
Date:   Mon, 05 Nov 2018 09:56:31 +0900
In-Reply-To: <20181104072253.12357-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 4 Nov 2018 08:22:53 +0100")
Message-ID: <xmqqtvkwl4u8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> A reverted commit will have a new trailer
>
>     Revert: <commit-id>

Please don't, unless you are keeping the current "the effect of
commit X relative to its parent Y was reverted" writtein in prose,
which is meant to be followed up with a manually written "because
..." and adding this as an extra footer that is meant solely for
machine consumption.  Of course reversion of a merge needs to say
relative to which parent of the merge it is undoing.

> Similarly a cherry-picked commit with -x will have
>
>     Cherry-Pick: <commit-id>

Unlike the "revert" change above, this probably is a good change, as
a"(cherry-pickt-from: X)" does not try to convey anything more or
anything less than such a standard looking trailer and it is in
different shape only by historical accident.  But people's scripts
may need to have a long transition period for this change to happen.


>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  I think standardizing how we record commit ids in the commit message
>  is a good idea. Though to be honest this started because of my irk of
>  an English string "cherry picked from..." that cannot be translated.
>  It might as well be a computer language that happens to look like
>  English.
>
>  Documentation/git-cherry-pick.txt |  5 ++---
>  sequencer.c                       | 20 ++++++--------------
>  t/t3510-cherry-pick-sequence.sh   | 12 ++++++------
>  t/t3511-cherry-pick-x.sh          | 26 +++++++++++++-------------
>  4 files changed, 27 insertions(+), 36 deletions(-)
>
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index d35d771fc8..8ffbaed1a0 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -58,9 +58,8 @@ OPTIONS
>  	message prior to committing.
>  
>  -x::
> -	When recording the commit, append a line that says
> -	"(cherry picked from commit ...)" to the original commit
> -	message in order to indicate which commit this change was
> +	When recording the commit, append "Cherry-Pick:" trailer line
> +	recording the commit name which commit this change was
>  	cherry-picked from.  This is done only for cherry
>  	picks without conflicts.  Do not use this option if
>  	you are cherry-picking from your private branch because
> diff --git a/sequencer.c b/sequencer.c
> index 9e1ab3a2a7..f7318f2862 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -36,7 +36,6 @@
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
>  const char sign_off_header[] = "Signed-off-by: ";
> -static const char cherry_picked_prefix[] = "(cherry picked from commit ";
>  
>  GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
>  
> @@ -1758,16 +1757,10 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		base_label = msg.label;
>  		next = parent;
>  		next_label = msg.parent_label;
> -		strbuf_addstr(&msgbuf, "Revert \"");
> -		strbuf_addstr(&msgbuf, msg.subject);
> -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
> -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> -
> -		if (commit->parents && commit->parents->next) {
> -			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
> -			strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
> -		}
> -		strbuf_addstr(&msgbuf, ".\n");
> +		strbuf_addf(&msgbuf, "Revert \"%s\"\n\n", msg.subject);
> +
> +		strbuf_addf(&msgbuf, "Revert: %s\n",
> +			    oid_to_hex(&commit->object.oid));
>  	} else {
>  		const char *p;
>  
> @@ -1784,9 +1777,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  			strbuf_complete_line(&msgbuf);
>  			if (!has_conforming_footer(&msgbuf, NULL, 0))
>  				strbuf_addch(&msgbuf, '\n');
> -			strbuf_addstr(&msgbuf, cherry_picked_prefix);
> -			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> -			strbuf_addstr(&msgbuf, ")\n");
> +			strbuf_addf(&msgbuf, "Cherry-Pick: %s\n",
> +				    oid_to_hex(&commit->object.oid));
>  		}
>  		if (!is_fixup(command))
>  			author = get_author(msg.message);
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index c84eeefdc9..89b6e7fc1e 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -390,10 +390,10 @@ test_expect_success '--continue respects opts' '
>  	git cat-file commit HEAD~1 >picked_msg &&
>  	git cat-file commit HEAD~2 >unrelatedpick_msg &&
>  	git cat-file commit HEAD~3 >initial_msg &&
> -	! grep "cherry picked from" initial_msg &&
> -	grep "cherry picked from" unrelatedpick_msg &&
> -	grep "cherry picked from" picked_msg &&
> -	grep "cherry picked from" anotherpick_msg
> +	! grep "Cherry-Pick:" initial_msg &&
> +	grep "Cherry-Pick: " unrelatedpick_msg &&
> +	grep "Cherry-Pick: " picked_msg &&
> +	grep "Cherry-Pick: " anotherpick_msg
>  '
>  
>  test_expect_success '--continue of single-pick respects -x' '
> @@ -404,7 +404,7 @@ test_expect_success '--continue of single-pick respects -x' '
>  	git cherry-pick --continue &&
>  	test_path_is_missing .git/sequencer &&
>  	git cat-file commit HEAD >msg &&
> -	grep "cherry picked from" msg
> +	grep "Cherry-Pick:" msg
>  '
>  
>  test_expect_success '--continue respects -x in first commit in multi-pick' '
> @@ -416,7 +416,7 @@ test_expect_success '--continue respects -x in first commit in multi-pick' '
>  	test_path_is_missing .git/sequencer &&
>  	git cat-file commit HEAD^ >msg &&
>  	picked=$(git rev-parse --verify picked) &&
> -	grep "cherry picked from.*$picked" msg
> +	grep "Cherry-Pick: $picked" msg
>  '
>  
>  test_expect_failure '--signoff is automatically propagated to resolved conflict' '
> diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
> index 9888bf34b9..db11dd2430 100755
> --- a/t/t3511-cherry-pick-x.sh
> +++ b/t/t3511-cherry-pick-x.sh
> @@ -32,7 +32,7 @@ mesg_with_footer_sob="$mesg_with_footer
>  Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
>  
>  mesg_with_cherry_footer="$mesg_with_footer_sob
> -(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
> +Cherry-Pick: da39a3ee5e6b4b0d3255bfef95601890afd80709
>  Tested-by: C.U. Thor <cuthor@example.com>"
>  
>  mesg_unclean="$mesg_one_line
> @@ -81,7 +81,7 @@ test_expect_success 'cherry-pick -x inserts blank line after one line subject' '
>  	cat <<-EOF >expect &&
>  		$mesg_one_line
>  
> -		(cherry picked from commit $sha1)
> +		Cherry-Pick: $sha1
>  	EOF
>  	git log -1 --pretty=format:%B >actual &&
>  	test_cmp expect actual
> @@ -129,7 +129,7 @@ test_expect_success 'cherry-pick -x inserts blank line when conforming footer no
>  	cat <<-EOF >expect &&
>  		$mesg_no_footer
>  
> -		(cherry picked from commit $sha1)
> +		Cherry-Pick: $sha1
>  	EOF
>  	git log -1 --pretty=format:%B >actual &&
>  	test_cmp expect actual
> @@ -154,7 +154,7 @@ test_expect_success 'cherry-pick -x -s inserts blank line when conforming footer
>  	cat <<-EOF >expect &&
>  		$mesg_no_footer
>  
> -		(cherry picked from commit $sha1)
> +		Cherry-Pick: $sha1
>  		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
>  	EOF
>  	git log -1 --pretty=format:%B >actual &&
> @@ -178,7 +178,7 @@ test_expect_success 'cherry-pick -x -s adds sob when last sob doesnt match commi
>  	git cherry-pick -x -s mesg-with-footer &&
>  	cat <<-EOF >expect &&
>  		$mesg_with_footer
> -		(cherry picked from commit $sha1)
> +		Cherry-Pick: $sha1
>  		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
>  	EOF
>  	git log -1 --pretty=format:%B >actual &&
> @@ -201,7 +201,7 @@ test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists fo
>  	git cherry-pick -x -s mesg-with-footer-sob &&
>  	cat <<-EOF >expect &&
>  		$mesg_with_footer_sob
> -		(cherry picked from commit $sha1)
> +		Cherry-Pick: $sha1
>  		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
>  	EOF
>  	git log -1 --pretty=format:%B >actual &&
> @@ -215,7 +215,7 @@ test_expect_success 'cherry-pick -x handles commits with no NL at end of message
>  	git cherry-pick -x $sha1 &&
>  	git log -1 --pretty=format:%B >actual &&
>  
> -	printf "\n(cherry picked from commit %s)\n" $sha1 >>msg &&
> +	printf "\nCherry-Pick: %s\n" $sha1 >>msg &&
>  	test_cmp msg actual
>  '
>  
> @@ -226,7 +226,7 @@ test_expect_success 'cherry-pick -x handles commits with no footer and no NL at
>  	git cherry-pick -x $sha1 &&
>  	git log -1 --pretty=format:%B >actual &&
>  
> -	printf "\n\n(cherry picked from commit %s)\n" $sha1 >>msg &&
> +	printf "\n\nCherry-Pick: %s\n" $sha1 >>msg &&
>  	test_cmp msg actual
>  '
>  
> @@ -252,19 +252,19 @@ test_expect_success 'cherry-pick -s handles commits with no footer and no NL at
>  	test_cmp msg actual
>  '
>  
> -test_expect_success 'cherry-pick -x treats "(cherry picked from..." line as part of footer' '
> +test_expect_success 'cherry-pick -x treats "Cherry-Pick:" line as part of footer' '
>  	pristine_detach initial &&
>  	sha1=$(git rev-parse mesg-with-cherry-footer^0) &&
>  	git cherry-pick -x mesg-with-cherry-footer &&
>  	cat <<-EOF >expect &&
>  		$mesg_with_cherry_footer
> -		(cherry picked from commit $sha1)
> +		Cherry-Pick: $sha1
>  	EOF
>  	git log -1 --pretty=format:%B >actual &&
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'cherry-pick -s treats "(cherry picked from..." line as part of footer' '
> +test_expect_success 'cherry-pick -s treats "Cherry-Pick:" line as part of footer' '
>  	pristine_detach initial &&
>  	git cherry-pick -s mesg-with-cherry-footer &&
>  	cat <<-EOF >expect &&
> @@ -275,13 +275,13 @@ test_expect_success 'cherry-pick -s treats "(cherry picked from..." line as part
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'cherry-pick -x -s treats "(cherry picked from..." line as part of footer' '
> +test_expect_success 'cherry-pick -x -s treats "Cherry-Pick:..." line as part of footer' '
>  	pristine_detach initial &&
>  	sha1=$(git rev-parse mesg-with-cherry-footer^0) &&
>  	git cherry-pick -x -s mesg-with-cherry-footer &&
>  	cat <<-EOF >expect &&
>  		$mesg_with_cherry_footer
> -		(cherry picked from commit $sha1)
> +		Cherry-Pick: $sha1
>  		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
>  	EOF
>  	git log -1 --pretty=format:%B >actual &&
