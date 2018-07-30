Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1EEE1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 18:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeG3ToC (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:44:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40549 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbeG3ToC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:44:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id y9-v6so330585wma.5
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w2JUgejU+7/q5I7nMXfOXmkb14Gm2JR8jwhrTIhOtZk=;
        b=FYrk1LoZuLKRGXwN7rPOV3hxHIwrMZ4Pz5uRdlLmHeSSdqzMFq4noHGRrvxI0shGX6
         q2b5hlcheS7by9DmR13SDZR9Zc9MIFuhw3rDipWIWy6s5019arfQZ79JugIWt2Kw/49J
         5zHzKBbezBnjKTtyhmRQ/BOja88h6V0WY+rlgWcVGBJ1TdjdK6cit9U6seBqtV6kpCBi
         OfA4yymkNEZh9dKjx+EioG/ndXoU18kKW8VTZjdC/4ltJOvqHQTmwZ1HwH6+5w1+/fD0
         dlfphYly/RJuagETkT9QD96rKGKXIQNM1Sx3k37l0L2R3gsW890S1vLfr5gl8Sur4eud
         PKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w2JUgejU+7/q5I7nMXfOXmkb14Gm2JR8jwhrTIhOtZk=;
        b=bNvGYY7pQaVKZ04Qiadj/pDnuT4beJbvGlFcvdMZ7Rrhd2EP6gIJjeORsSR6wQ9OSc
         UwIYH5ARWqRxqpnAMJg5XshtmggYMvQ+OJFUSOrLAZ5nQ4h/CzI2T/Y/+MeHgVIX5EFG
         yL3zzD1T1uC7dcXlmb+AA90stzsQJ2L36TWnpTCtukUIA9wJ8ek9Vp109A9MYTLYdlwf
         EZspER76EiA3A9ZIl+9jqftt5TLtzjJ4k2VpeABF7AnNUQnUcllfZfpGxljzuMEa7vH2
         UNOrhygRPQBRBgwgmFY7pQaVpR5xpxHgIuEe2HlyI8ZtBOgQxsRb7ovSjMhLc4Q1qTpY
         7bHQ==
X-Gm-Message-State: AOUpUlEDprsbqe0xSf2zpnOlHnUtCSJ2hMGxdaviiMV0jyOXT0gO4kwk
        wdJCI4Tf+A3mk6lNS12KB2/y3pFo
X-Google-Smtp-Source: AAOMgpfgyPGs1BH/ccnd6p+WImIWHRBmQ7972imy7H0ZW8gVCMCxwto4nf4qcq0MqYxad9rXJ70FNg==
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr208136wma.143.1532974069384;
        Mon, 30 Jul 2018 11:07:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z141-v6sm344438wmc.3.2018.07.30.11.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 11:07:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, Chen Bin <chenbin.sh@gmail.com>
Subject: Re: [PATCH 1/1] Add the `p4-pre-submit` hook
References: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com>
        <20180727112222.19061-1-chenbin.sh@gmail.com>
Date:   Mon, 30 Jul 2018 11:07:48 -0700
In-Reply-To: <20180727112222.19061-1-chenbin.sh@gmail.com> (Chen Bin's message
        of "Fri, 27 Jul 2018 21:22:22 +1000")
Message-ID: <xmqqlg9sfvgr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chen Bin <chenbin.sh@gmail.com> writes:

> The `p4-pre-submit` hook is executed before git-p4 submits code.
> If the hook exits with non-zero value, submit process not start.
>
> Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
> ---

Luke, does this version look good to you?

I still think the addition to self.description is a bit too much but
other than that the incremental since the last one looked sensible
to my untrained eyes ;-)

Thanks, both.

>  Documentation/git-p4.txt   |  8 ++++++++
>  Documentation/githooks.txt |  7 +++++++
>  git-p4.py                  | 16 +++++++++++++++-
>  t/t9800-git-p4-basic.sh    | 29 +++++++++++++++++++++++++++++
>  4 files changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index f0de3b891..a7aac1b92 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -374,6 +374,14 @@ These options can be used to modify 'git p4 submit' behavior.
>      been submitted. Implies --disable-rebase. Can also be set with
>      git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
>  
> +Hook for submit
> +~~~~~~~~~~~~~~~
> +The `p4-pre-submit` hook is executed if it exists and is executable.
> +The hook takes no parameter and nothing from standard input. Exiting with
> +non-zero status from this script prevents `git-p4 submit` from launching.
> +
> +One usage scenario is to run unit tests in the hook.
> +
>  Rebase options
>  ~~~~~~~~~~~~~~
>  These options can be used to modify 'git p4 rebase' behavior.
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index e3c283a17..22fcabbe2 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -485,6 +485,13 @@ The exit status determines whether git will use the data from the
>  hook to limit its search.  On error, it will fall back to verifying
>  all files and folders.
>  
> +p4-pre-submit
> +~~~~~~~~~~~~~
> +
> +This hook is invoked by `git-p4 submit`. It takes no parameter and nothing
> +from standard input. Exiting with non-zero status from this script prevent
> +`git-p4 submit` from launching. Run `git-p4 submit --help` for details.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/git-p4.py b/git-p4.py
> index b449db1cc..879abfd2b 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1494,7 +1494,13 @@ def __init__(self):
>                  optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
>                                       help="Skip Perforce sync of p4/master after submit or shelve"),
>          ]
> -        self.description = "Submit changes from git to the perforce depot."
> +        self.description = """Submit changes from git to the perforce depot.\n
> +    The `p4-pre-submit` hook is executed if it exists and is executable.
> +    The hook takes no parameter and nothing from standard input. Exiting with
> +    non-zero status from this script prevents `git-p4 submit` from launching.
> +
> +    One usage scenario is to run unit tests in the hook."""
> +
>          self.usage += " [name of git branch to submit into perforce depot]"
>          self.origin = ""
>          self.detectRenames = False
> @@ -2303,6 +2309,14 @@ def run(self, args):
>              sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
>                       (len(commits), num_shelves))
>  
> +        hooks_path = gitConfig("core.hooksPath")
> +        if len(hooks_path) <= 0:
> +            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
> +
> +        hook_file = os.path.join(hooks_path, "p4-pre-submit")
> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
> +            sys.exit(1)
> +
>          #
>          # Apply the commits, one at a time.  On failure, ask if should
>          # continue to try the rest of the patches, or quit.
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 4849edc4e..2b7baa95d 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -261,6 +261,35 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
>  	)
>  '
>  
> +# Test following scenarios:
> +#   - Without ".git/hooks/p4-pre-submit" , submit should continue
> +#   - With the hook returning 0, submit should continue
> +#   - With the hook returning 1, submit should abort
> +test_expect_success 'run hook p4-pre-submit before submit' '
> +	test_when_finished cleanup_git &&
> +	git p4 clone --dest="$git" //depot &&
> +	(
> +		cd "$git" &&
> +		echo "hello world" >hello.txt &&
> +		git add hello.txt &&
> +		git commit -m "add hello.txt" &&
> +		git config git-p4.skipSubmitEdit true &&
> +		git-p4 submit --dry-run >out &&
> +		grep "Would apply" out &&
> +		mkdir -p .git/hooks &&
> +		write_script .git/hooks/p4-pre-submit <<-\EOF &&
> +		exit 0
> +		EOF
> +		git-p4 submit --dry-run >out &&
> +		grep "Would apply" out &&
> +		write_script .git/hooks/p4-pre-submit <<-\EOF &&
> +		exit 1
> +		EOF
> +		test_must_fail git-p4 submit --dry-run >errs 2>&1 &&
> +		! grep "Would apply" err
> +	)
> +'
> +
>  test_expect_success 'submit from detached head' '
>  	test_when_finished cleanup_git &&
>  	git p4 clone --dest="$git" //depot &&
