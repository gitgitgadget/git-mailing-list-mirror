Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690AD1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 23:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbeJLGop (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:44:45 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45208 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeJLGoo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:44:44 -0400
Received: by mail-wr1-f53.google.com with SMTP id q5-v6so11429649wrw.12
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=196s3xieVpY16Exvahqljv2UMaMVjAhgVtcJ55PiUjs=;
        b=h3plBfZ0wUMlJ1NJqfX4javy8O70I8aHp7AtsFaqPzj8LGjlDXMLvAQgGnqtYhdy5n
         DORVK40tiYxFyorCGg39xag8JpqkqQc78iXSaAytp5x5axwZN2tdMtC85njhzETrpXGm
         VjNTMXsRlaY9VOWiNlRhVElExY5oJs8ZB+IVY2VwIxTPdWDJLqbjCTgCeAgyM0MXQ2Zu
         AQmfJff+VB9/8oymZX9S6J2lhUBwjnFEtZ0kgJDWuD+vi+fwmDt42ajWfKvR2Qj7A8SZ
         mW8KL5mgVkfGYnnqx/PXAJrWIFef830FBEQHxKGcnUjElORecmspR5c6GNxpn5XqwotG
         ZWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=196s3xieVpY16Exvahqljv2UMaMVjAhgVtcJ55PiUjs=;
        b=WiCOapmPm64Sne5U6PhNs1e40junX01UbMGVgJNxxpV01bRIeNprzoQ8jOetnVYqoY
         HpM1cN/Ku1t5KqBMHy9l50nSjU17kYJVX9lOsusn+G1y41s73KVKhH8WM2bSDsnFzVZE
         cMO+IscSjDSYdeTV3jSsLGhNcrdYITGGGZQsvB+2QMWMkVr0g38rpA7/cr+mtzJeIS/N
         2F0k27mXXl+Jh1PqGRl9rsjX3U1Tv4QfNvoeqr4gQvO+OxltC4m6bDlcpv1jhPOJjyAZ
         7QP6IwG4jJqSqUHq4hbKAg/JgMs6d7nvix5PwW46ZoSbReJMX1MzPBoU8SYMr4paw0qC
         eWRg==
X-Gm-Message-State: ABuFfoiVEl4ZFWpWvh+/IogIGEHwetb7ygFkced+pjFymCDBe+k3fVcl
        8t0g59RvPwYvTvGFzTIbXnmR9vMDNhY=
X-Google-Smtp-Source: ACcGV61zMuDObkGwvVkvE5jt9PNNOHL8ij6hhlW9JcWwr1ojDSPWjmtZxbpF4F5WeIF2s7ID4Bn+9w==
X-Received: by 2002:adf:df88:: with SMTP id z8-v6mr3107882wrl.113.1539299712889;
        Thu, 11 Oct 2018 16:15:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b81-v6sm19433378wmh.47.2018.10.11.16.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 16:15:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] branch: introduce --show-current display option
References: <xmqq4ldtgehs.fsf@gitster-ct.c.googlers.com>
        <20181011222028.20008-1-daniels@umanovskis.se>
Date:   Fri, 12 Oct 2018 08:15:10 +0900
In-Reply-To: <20181011222028.20008-1-daniels@umanovskis.se> (Daniels
        Umanovskis's message of "Fri, 12 Oct 2018 00:20:28 +0200")
Message-ID: <xmqqva68dqip.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniels Umanovskis <daniels@umanovskis.se> writes:

> +static void print_current_branch_name(void)

Thanks for fixing this (I fixed this in the previous round in my
tree but forgot to tell you about it).

> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index ee6787614..8d2020aea 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -100,6 +100,47 @@ test_expect_success 'git branch -v pattern does not show branch summaries' '
>  	test_must_fail git branch -v branch*
>  '
>  
> +test_expect_success 'git branch `--show-current` shows current branch' '
> +	cat >expect <<-\EOF &&
> +	branch-two
> +	EOF
> +	git checkout branch-two &&
> +	git branch --show-current >actual &&
> +	test_cmp expect actual
> +'

OK, that's trivial.  We checkout a branch and make sure show-current
reports the name of that branch.  Good.

> +test_expect_success 'git branch `--show-current` is silent when detached HEAD' '
> +	git checkout HEAD^0 &&
> +	git branch --show-current >actual &&
> +	test_must_be_empty actual
> +'

OK, and at the same time we make sure the command exits with
success.  Good.

> +test_expect_success 'git branch `--show-current` works properly when tag exists' '
> +	cat >expect <<-\EOF &&
> +	branch-and-tag-name
> +	EOF
> +	git checkout -b branch-and-tag-name &&
> +	git tag branch-and-tag-name &&
> +	git branch --show-current >actual &&
> +	git checkout branch-one &&
> +	git branch -d branch-and-tag-name &&
> +	test_cmp expect actual
> +'

It is a bit curious why you remove the branch but not the tag after
this test.  If we are cleaning after ourselves, removing both would
be equally good, if not cleaner.  If having both absolutely harms
later tests but having just one is OK, then any failure in this test
between the time branch-and-tag-name tag gets created and the time
branch-and-tag-name branch gets removed will leave the repository
with both the tag and the branch, which will be the state in which
later tests start, so having "branch -d" at this spot in the sequence
is not a good idea anyway.

So two equally valid choices are to remove "branch -d" and then
either:

 (1) leave both branch and tag after this test in the test
     repository

 (2) use test_when_finished, i.e.

	echo branch-and-tag-name >expect &&
	test_when_finished "git branch -D branch-and-tag-name" &&
	git checkout -b branch-and-tag-name &&
	test_when_finished "git tag -d branch-and-tag-name" &&
	git tag branch-and-tag-name &&
	...

     to arrange them to be cleaned once this test is done.

(1) is only valid if they do not harm later tests.  I guess you
remove the branch because you did not want to touch later tests that
checks output from "git branch --list", in which case you'd want (2).

> +test_expect_success 'git branch `--show-current` works properly with worktrees' '
> +	cat >expect <<-\EOF &&
> +	branch-one
> +	branch-two
> +	EOF
> +	git checkout branch-one &&
> +	git branch --show-current >actual &&
> +	git worktree add worktree branch-two &&
> +	cd worktree &&
> +	git branch --show-current >>../actual &&
> +	cd .. &&
> +	test_cmp expect actual
> +'

Please do *not* cd around without being in a subshell.  If the
second --show-current failed for some reason, "cd .." will not be
executed, and the next and subsequent test will start inside
./worktree subdirectory, which is likely to break the expectations
of them.  Perhaps something like

	git checkout branch-one &&
	git worktree add worktree branch-two &&
	(
		git branch --show-current &&
		cd worktree && git branch --show-current
	) >actual &&
	test_cmp expect actual

or its modern equivalent

	git checkout branch-one &&
	git worktree add worktree branch-two &&
	(
		git branch --show-current &&
		git -C worktree branch --show-current
	) >actual &&
	test_cmp expect actual

Note that the latter _could_ be written without subshell, i.e.

	git branch --show-current >actual &&
	git -C worktree branch --show-current >>actual &&

but I personally tend to prefer with a single redirection into
">actual", as that is easier to later add _more_ commands to
redirect into 'actual' to be inspected without having to worry about
details like repeating ">>actual" or only the first one must be
">actual" (iow, the preference comes mostly from maintainability
concerns).

Thanks.

> +
>  test_expect_success 'git branch shows detached HEAD properly' '
>  	cat >expect <<EOF &&
>  * (HEAD detached at $(git rev-parse --short HEAD^0))
