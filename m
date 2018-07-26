Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60A36208E9
	for <e@80x24.org>; Thu, 26 Jul 2018 16:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbeGZSGv (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 14:06:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37918 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731800AbeGZSGv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 14:06:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so2670834wmi.3
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5Cki+RdnRpX79VHNA23JeXKguIsmIGY5uPIDhMsSmvA=;
        b=bjlDq7sS0eK6m3mMufizPlrT1cQaoeTJNJfIToGpUSdpbyIcWk/eR1+Xtjc2e6aKrW
         yjqwjcmS6IrcVu0gi1rhbRyJz9nW9/oa5aQ67x4O+DsKWt9j1lgMh41qXJDXYmabW5uV
         PYrhzyLTesFStoDEbTmXm6jnyo4Ck8VMfLQcYCmKa3Vpv27iNa29B0GKZINqMU30rcCU
         +0l0OOJc5IqbMm8dYToevJ0f5gMQtC2GSOgJVHNGdUpRiPbijwKf6IEb6O/ESSpFQrcw
         Kv1swNizIQVQMDKNEheoJioZWQb3CCddk/os1LWy5pinR4wVUf2EP9rV3gVLRAPV7mnA
         zibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5Cki+RdnRpX79VHNA23JeXKguIsmIGY5uPIDhMsSmvA=;
        b=MguqtJPCa85UzMa9MRICYBatNFpxyZjnmwhqaDgfrW4GxD+2m8i3RrN8hIZwebZsKM
         z1vhXRt75Qp3P3IV9Zyfnu/Tlm0VuRkXk/OhzApdYEhWULWUnVHrRz2C1+NtvbgZKv/9
         KwWIRwN87AUPum3oeUYOEL/6yTW22fPlAN8HlOTDn36nEcAAHFLF+FvjdxmmgRpAE8do
         J9J4jutJuH/DScZoF7ap2QaeFbxNMqXT+Lnexv7R/JsLXewk/Ql1hd3oNq70ZOP5fB8B
         JYprPbBfUMydWimStxBwJyIlcUBixLjNDV1t6UWSX6cJn7wgh5WGcSGJgHWaSVd4rG1m
         GAOg==
X-Gm-Message-State: AOUpUlFT5QwzSLkm1whamRk1pevLVuzUVNNdbZ2rdCKi4gbEmVzifp4Y
        qgnF915ezIELSmDfLW8X9IE=
X-Google-Smtp-Source: AAOMgpchUnQmBt3ai464FuT0q3iCWhw3fONBb2nC3Iucfu44KCVxKJp7RUgmM5S/0QcGS8U8pZfbNA==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr2218060wmf.114.1532623750007;
        Thu, 26 Jul 2018 09:49:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d15-v6sm35026wmb.0.2018.07.26.09.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 09:49:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chen Bin <chenbin.sh@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] add hook pre-p4-submit
References: <20180725134345.8631-1-chenbin.sh@gmail.com>
        <20180726134138.12183-1-chenbin.sh@gmail.com>
Date:   Thu, 26 Jul 2018 09:49:08 -0700
In-Reply-To: <20180726134138.12183-1-chenbin.sh@gmail.com> (Chen Bin's message
        of "Thu, 26 Jul 2018 23:41:38 +1000")
Message-ID: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chen Bin <chenbin.sh@gmail.com> writes:

> +Hook for submit
> +~~~~~~~~~~~~~~~
> +Hook `p4-pre-submit` is executed if it exists and is executable.

Just a lang nit, but "git grep pre-commit" shows me lines like

  Documentation/git-commit.txt:   This option bypasses the pre-commit and commit-msg hooks.

to tell me that the above is better phrased like

	The `p4-pre-submit` hook is executed...

The same comment applies to the patch title, the first sentence in
the log message and in-code ".description" field in git-py.py.

> +The hook takes no parameter and nothing from standard input. Exiting with
> +non-zero status from this script prevents `git-p4 submit` from launching.
> +So nothing is touched when it exits with non-zero status.

Isn't the last sentence redundant, saying only what the second
sentence already said?

> +
> +One usage scenario is to run unit tests in the hook.

Good thing to mention, I guess.

> +By default the hooks directory is `$GIT_DIR/hooks`, but that can be changed.
> +See githooks(5) manpage for details about hooks.

I do not think this is particularly a good change; it forces us to
maintain this sentence copied from githooks.txt every time the
original has to change, and documentation for no other command
duplicates it.

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

Hmmm, OK.

>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/git-p4.py b/git-p4.py
> index b449db1cc..f147a2d2f 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1494,7 +1494,17 @@ def __init__(self):
>                  optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
>                                       help="Skip Perforce sync of p4/master after submit or shelve"),
>          ]
> -        self.description = "Submit changes from git to the perforce depot."
> +        self.description = """Submit changes from git to the perforce depot.\n
> +    Hook `p4-pre-submit` is executed if it exists and is executable.
> +    The hook takes no parameter and nothing from standard input. Exiting with
> +    non-zero status from this script prevents `git-p4 submit` from launching.
> +    So nothing is touched when it exits with non-zero status.
> +
> +    One usage scenario is to run unit tests in the hook.
> +
> +    By default the hooks directory is `$GIT_DIR/hooks`, but that can be changed.
> +    See githooks(5) manpage for details about hooks."""

How do you plan to keep this in sync with the documentation?
Perhaps the last sentence of the new paragraph you added to
Documentation/githooks.txt should read

	See `git p4 --help` for details.

Then this hunk can be eliminated, I would think.

> @@ -2303,6 +2313,15 @@ def run(self, args):
>              sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
>                       (len(commits), num_shelves))
>  
> +        hooks_path = gitConfig("core.hooksPath")
> +        if len(hooks_path) > 0:
> +            hook_file = os.path.join(hooks_path, "p4-pre-submit")
> +        else:
> +            hook_file = os.path.join(read_pipe("git rev-parse --git-dir").strip(), "hooks", "p4-pre-submit")
> +

Isn't the GIT_DIR available as self.gitdir at this point in the
code, prepared by main() before this method is run?

It may be a style thing, but I somehow would find it easier to
understand if you wrote it like so:

	hooks_path = gitConfig("...")
	if len(hooks_path) <= 0:
		hooks_path = os.path.join(self.gitdir, "hooks")
	hook_file = os.path.join(hooks_path, "p4-pre-submit")

The point being hooks_path always point at the directory that holds
hooks with or without configuration, and hook_file is set based on
that to the same "p4-pre-submit" without any potential of typo
getting in to make the two cases diverge.

> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
> +            sys.exit(1)
> +
>          #
>          # Apply the commits, one at a time.  On failure, ask if should
>          # continue to try the rest of the patches, or quit.
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index 4849edc4e..8457ff617 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -261,6 +261,32 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
>  	)
>  '
>  
> +# Test following scenarios:
> +#   - Without hook ".git/hooks/p4-pre-submit", submit should continue
> +#   - With hook returning 0, submit should continue
> +#   - With hook returning 1, submit should abort
> +test_expect_success 'run hook p4-pre-submit before submit' '
> +	test_when_finished cleanup_git &&
> +	git p4 clone --dest="$git" //depot &&
> +	(
> +		cd "$git" &&
> +		echo "hello world" >hello.txt &&
> +		git add hello.txt &&
> +		git commit -m "add hello.txt" &&
> +		git config git-p4.skipSubmitEdit true &&
> +		git p4 submit --dry-run | grep "Would apply" &&

"git p4" on the upstream side of a pipe?

> +		mkdir -p .git/hooks &&
> +		write_script .git/hooks/p4-pre-submit <<-\EOF &&
> +		exit 0
> +		EOF
> +		git p4 submit --dry-run >out &&  grep "Would apply" out &&

Have each of these two on its own line, i.e.

	git p4 submit --dry-run >out &&
	grep "Would apply" out &&

> +		write_script .git/hooks/p4-pre-submit <<-\EOF &&
> +		exit 1
> +		EOF
> +		git p4 submit --dry-run >out && grep "Would apply" out || echo "Abort submit"

What is this last "|| echo I always succeed" about?  

Do you want to make sure "git p4 submit" exit with non-zero exit
status *and* its output does not say "Would apply"?  The way to
write that would be

		test_must_fail git p4 submit --dry-run >out &&
		! grep "Would apply" out

Then "git p4 submit --dry-run" that exits with 0 even though its
presubmit hook exits with 1 would fail to meet the expectation that
the command must fail and would be caught as an error.  If it exits
with non-zero status, but still write "Would apply" to its standard
output stream, it would also be caught as an error as "grep" would
succeed.

> +	)
> +'
> +
>  test_expect_success 'submit from detached head' '
>  	test_when_finished cleanup_git &&
>  	git p4 clone --dest="$git" //depot &&

