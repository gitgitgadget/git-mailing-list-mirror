Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4AD91F597
	for <e@80x24.org>; Fri,  3 Aug 2018 23:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeHDBDN (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 21:03:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33130 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbeHDBDN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 21:03:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id r24-v6so6123946wmh.0
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fdh3roy37h2uUBHp18b4cXYsZ1kYrLyueugl9dHlE6w=;
        b=kMgEpYkt1RYy461rAHSNETXSlqnsky5pNyKnlvTLGA31Q5MvW+5JQG9sURg4SYgWac
         0SiD2wWhmz8/6awpY4laIzCcwdSa0/M6gcehF8CXEX+CrLRezkTnT9yWqXF+QW/o2HOw
         P4OAEu1ZEg1ZSPpOq3tzsGLis0xVIT/Wxf7cwQsPJeCQBkIgNJSsnN8utMo6glJCquCd
         DoRb2p7Rx4kNBPBXITxfVmeQnyvLtfQlBYm0P7FGSDx+suHuxqkcpF55yan5I3AWKw9K
         2zr9uqSLzXD+wtGVr103MmZEnZNp2JHbTTnYu1i9xgYkLmdfsn6pLUXGqMKMN6fEwbIy
         e5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fdh3roy37h2uUBHp18b4cXYsZ1kYrLyueugl9dHlE6w=;
        b=foqvLEe0AEeZK2hIdhYf3yv7Fsblv7GQeH6fZdFNRtznAO42vbQh141yF3qW4/NsI6
         5NkoJlhfJ8EqfJEeTicXD5thoqpMfvR0lDb5xMFyroidkpRCmPg6l5uhC+yVwphxxkZb
         3jTchejR7DP9GjQcUP2dl6EcQJNLBxWmkIRw/YkDW4yKPr+Ydadstevjp3OS88r8sK5t
         h8ES4JSPXDtDxyUbtYM8UaQKjozJwFqOU1SrVfIGCwbcbj/T/VtTvpEQt1kthBXUBkf9
         6s3phGNF4z5KF2QrxdqIM4/ieU6kQJcOBvOZb15nxsPpRRoqg25O33HYKiqWaLoaS+bA
         /2eA==
X-Gm-Message-State: AOUpUlFZDIKZJtlQu8xWZc4sANEwKMC4aanE0N24S4CNbdT1P1FzByFE
        BhJou6xMrbRQbbfLt5jF6JE=
X-Google-Smtp-Source: AAOMgped86FQWii3iTIcfdD4DF4ywvJGAOyoNq5IzCwAL5fxGYPVqkXsT/up4mAewgXS+jIDBKGnZQ==
X-Received: by 2002:a1c:aa0c:: with SMTP id t12-v6mr5877744wme.109.1533337491342;
        Fri, 03 Aug 2018 16:04:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q2-v6sm383729wmc.44.2018.08.03.16.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 16:04:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] t4150: fix broken test for am --scissors
References: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
        <8f69d82b-0f35-754f-0096-853d6b463db7@gmail.com>
Date:   Fri, 03 Aug 2018 16:04:50 -0700
In-Reply-To: <8f69d82b-0f35-754f-0096-853d6b463db7@gmail.com> (Andrei Rybak's
        message of "Sat, 4 Aug 2018 00:39:40 +0200")
Message-ID: <xmqqh8kbuk4t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Tests for "git am --[no-]scissors" [1] work in the following way:
>
>  1. Create files with commit messages
>  2. Use these files to create expected commits
>  3. Generate eml file with patch from expected commits
>  4. Create commits using git am with these eml files
>  5. Compare these commits with expected
>
> The test for "git am --scissors" is supposed to take a message with a
> scissors line above commit message and demonstrate that only the text
> below the scissors line is included in the commit created by invocation
> of "git am --scissors".  However, the setup of the test uses commits
> without the scissors line in the commit message, therefore creating an
> eml file without scissors line.
>
> This can be checked by intentionally breaking is_scissors_line function
> in mailinfo.c. Test t4150-am.sh should fail, but does not.
>
> Fix broken test by generating only one eml file--with scissors line, and
> by using it both for --scissors and --no-scissors. To clarify the
> intention of the test, give files and tags more explicit names.
>
> [1]: introduced in bf72ac17d (t4150: tests for am --[no-]scissors,
>      2015-07-19)
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>

Thanks for digging and fixing.

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index e9b6f8158..23e3b0e91 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -67,17 +67,18 @@ test_expect_success 'setup: messages' '
>  
>  	EOF
>  
> -	cat >scissors-msg <<-\EOF &&
> -	Test git-am with scissors line
> +	cat >msg-without-scissors-line <<-\EOF &&
> +	Test that git-am --scissors cuts at the scissors line
>  
>  	This line should be included in the commit message.
>  	EOF
>  
> -	cat - scissors-msg >no-scissors-msg <<-\EOF &&
> +	printf "Subject: " >subject-prefix &&
> +
> +	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF &&
>  	This line should not be included in the commit message with --scissors enabled.
>  
>  	 - - >8 - - remove everything above this line - - >8 - -
> -
>  	EOF

So... the original prepared a scissors-msg file that does not have a
line with the scissors sign, and used it to create no-scissors-msg
file that does have a line with the scissors sign?  That does sound
like a backward way to name these files X-<.  And the renamed result
obviously looks much saner.

I see two more differences; the new one has "Subject: " in front of
the first line, and also it lacks a blank line immediately after the
scissors line.  Do these differences matter, a reader wonders, and
reads on...

> @@ -150,18 +151,17 @@ test_expect_success setup '
>  	} >patch1-hg.eml &&
>  
>  
> -	echo scissors-file >scissors-file &&
> -	git add scissors-file &&
> -	git commit -F scissors-msg &&
> -	git tag scissors &&
> -	git format-patch --stdout scissors^ >scissors-patch.eml &&

OK, the old one created the message with formta-patch, so it
shouldn't have "Subject: " there to begin with.  How does the new
one work, a reader now wonders, and reads on...

> +	echo file >file &&
> +	git add file &&
> +	git commit -F msg-without-scissors-line &&
> +	git tag scissors-used &&

So far, the commit created is more or less the same from the original,
but we do not yet create an e-mail message yet.

>  	git reset --hard HEAD^ &&
>  
> -	echo no-scissors-file >no-scissors-file &&
> -	git add no-scissors-file &&
> -	git commit -F no-scissors-msg &&
> -	git tag no-scissors &&
> -	git format-patch --stdout no-scissors^ >no-scissors-patch.eml &&

The old one committed with scissors and told format-patch to create
an e-mail, which does not make much sense to me, but I guess users
are allowed to do this.

> +	echo file >file &&
> +	git add file &&
> +	git commit -F msg-with-scissors-line &&
> +	git tag scissors-not-used &&
> +	git format-patch --stdout scissors-not-used^ >patch-with-scissors-line.eml &&

Now we get an e-mail out of the system, presumably with a line with
scissors marker on it in the log message.

>  	git reset --hard HEAD^ &&
>  
>  	sed -n -e "3,\$p" msg >file &&
> @@ -418,10 +418,10 @@ test_expect_success 'am --scissors cuts the message at the scissors line' '
>  	rm -fr .git/rebase-apply &&
>  	git reset --hard &&
>  	git checkout second &&
> -	git am --scissors scissors-patch.eml &&
> +	git am --scissors patch-with-scissors-line.eml &&
>  	test_path_is_missing .git/rebase-apply &&
> -	git diff --exit-code scissors &&
> -	test_cmp_rev scissors HEAD
> +	git diff --exit-code scissors-used &&
> +	test_cmp_rev scissors-used HEAD

Hmph, I am not quite sure what is going on.  Is the only bug in the
original that scissors-patch.eml and no-scissors-patch.eml files were
incorrectly named?  IOW, if we fed no-scissors-patch.eml (which has
a scissors line in it) with --scissors option to am, would it have
worked just fine without other changes in this patch?

I am not saying that we shouldn't make other changes or renaming the
confusing .eml files.  I am just trying to understand what the
nature of the breakage was.  For example, it is not immediately
obvious why the new test needs to prepare the message _with_
"Subject:" in front of the first line when it prepares the commit
to be used for testing.

	... goes back and thinks a bit ...

OK, the Subject: thing that appears after the scissors line serves
as an in-body header to override the subject line of the e-mail
itself.  That change is necessary to _drop_ the subject from the
outer e-mail and replace it with the subject we do want to use.

So I can explain why "Subject:" thing needed to be added.

I cannot still explain why a blank line needs to be removed after
the scissors line, though.  We should be able to have blank lines
before the in-body header, IIRC.

>  '
>  
>  test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
> @@ -429,10 +429,10 @@ test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
>  	git reset --hard &&
>  	git checkout second &&
>  	test_config mailinfo.scissors true &&
> -	git am --no-scissors no-scissors-patch.eml &&
> +	git am --no-scissors patch-with-scissors-line.eml &&
>  	test_path_is_missing .git/rebase-apply &&
> -	git diff --exit-code no-scissors &&
> -	test_cmp_rev no-scissors HEAD
> +	git diff --exit-code scissors-not-used &&
> +	test_cmp_rev scissors-not-used HEAD
>  '
>  
>  test_expect_success 'setup: new author and committer' '
