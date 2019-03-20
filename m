Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DAE420248
	for <e@80x24.org>; Wed, 20 Mar 2019 01:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCTBAs (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 21:00:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37753 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfCTBAs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 21:00:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15so855000wro.4
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 18:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NuJSRjl7FSEGXGWufoYJreT71F7HHplp2o17wkP93Js=;
        b=SXsKhHybiuSWVmVTZk2pjXi8pSUG4aexjExmGIWIo/hv1gqv/JJYMrxff3KmW0JpWi
         3CNc8ygNugOL7S0MfNlLstKp27hTBe2NYTLMy3GiBKW4QsL6DLv/ge1i3S8dtHmhvKFR
         TqsfIe2ahOGeuqBosA4cs9q77IR3y6nflfCPBDPR4Qi/JsW7woRkEgdSlY2W23jNH3IP
         yDkXZIFm8fn1XyseQ6dXmQwO9Vb6NoVoDSSfBNO5bUo1zAzHmO2Gtz3jodXIkF1jdLP3
         /fnSfzSVi2ZzPnhveTX7Bn4q0isKst6ZjOu3DUS8yqqFE/CgL1dEwhZidOJ5E6fxn8O8
         yW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NuJSRjl7FSEGXGWufoYJreT71F7HHplp2o17wkP93Js=;
        b=SEJPixNVasartWQCU5WcjtW1xhAzIgymQyIGHQscB66I0CAqcZ5yRaKLHKF8KIFBiS
         XF5kqU50AvAjB8gqHd8H9waFDxQEFufh0gktbzpFXL8kcVvfwO9wV6euPvBeyUitQZgf
         DSOOSS+2S2yOQ3S5JiGLgtarVhtlvaU6bDPTvDop4clPCBY4vGtwC8Of83uDwXo5UWtG
         Jq71a0B0sujPF0XyJjs9tBvWNKRWXHuCPKpt3ZCAac9emtoBbqIG5wl15/J4Cb4GFYr8
         eEhZD8CBj9L41BHaAphO020l+lnSEJBgrNTp+OU9Z7zmRGkxsEPNl+eFB538t+AyDmIM
         d/WA==
X-Gm-Message-State: APjAAAWQcFQxETSamSQj6JPRGppGBgYWtWTD6PkVBazpbQ/px8HbnGWN
        3HX8tcTDuvujJHHmfAKkANwUxaFcYBs=
X-Google-Smtp-Source: APXvYqx6ZyUoMjpz9GisalcTaVtoIgx8vaHMYbLjpliiRzKqnrI7i/jMcKFE7CNqRjGtlpnXYa7LZA==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr15067240wrw.167.1553043646151;
        Tue, 19 Mar 2019 18:00:46 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x17sm1153590wrd.95.2019.03.19.18.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 18:00:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [REGRESSION ps/stash-in-c] git stash show -v
References: <20190319190503.GA10066@dev-l>
        <20190319231826.GB32487@hank.intra.tgummerer.com>
Date:   Wed, 20 Mar 2019 10:00:43 +0900
In-Reply-To: <20190319231826.GB32487@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Tue, 19 Mar 2019 23:18:26 +0000")
Message-ID: <xmqqwokuwe9w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Subject: [PATCH] stash: setup default diff output format if necessary
>
> In the scripted 'git stash show' when no arguments are passed, we just
> pass '--stat' to 'git diff'.  When any argument is passed to 'stash
> show', we no longer pass '--stat' to 'git diff', and pass whatever
> flags are passed directly through to 'git diff'.
>
> By default 'git diff' shows the patch output.  So when we a user uses
> 'git stash show -v', they would be shown the diff, because that's the
> default behaviour of 'git diff', but not actually directly triggered
> by passing the '-v'.
>
> In the C version of 'git stash show', we try to emulate that
> behaviour using the internal diff API.  However we forgot to set up
> the default output format, in case it wasn't set by any of the flags
> that were passed through.

Well explained.  It might have avoided such a bug if the code did
not manually stuff the diffopt.* structure fields (instead, e.g.
prepare an array of strings like {"diff", "--stat", NULL} and let
the option parser diff_opt_parse() to do its job), but that is
lamenting over water under the bridge.

> So 'git stash show -v' in the builtin
> version of stash would be completely silent, while it would show the
> diff before.

That sounds reasonable.  Thanks for a quick diagnosis and a fix.

> Fix this by setting up the default output format for 'git diff'.
>
> Reported-by: Denton Liu <liu.denton@gmail.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/stash.c  |  4 ++++
>  t/t3903-stash.sh | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 51df092633..012662ce68 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -761,6 +761,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
>  		free_stash_info(&info);
>  		usage_with_options(git_stash_show_usage, options);
>  	}
> +	if (!rev.diffopt.output_format) {
> +		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
> +		diff_setup_done(&rev.diffopt);
> +	}

Hmph.  Does this result in setup_done() called twice?  As it would
indicate another bug in the original code if setup_done() was never
called, I am assuming that another setup_done() call in the same
codeflow is already there.

>  	rev.diffopt.flags.recursive = 1;
>  	setup_diff_pager(&rev.diffopt);
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 97cc71fbaf..e0a50ab267 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -612,6 +612,24 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'stash show -v shows diff' '
> +	git reset --hard &&
> +	echo foo >>file &&
> +	STASH_ID=$(git stash create) &&
> +	git reset --hard &&
> +	cat >expected <<-EOF &&
> +	diff --git a/file b/file
> +	index 7601807..71b52c4 100644
> +	--- a/file
> +	+++ b/file
> +	@@ -1 +1,2 @@
> +	 baz
> +	+foo
> +	EOF
> +	git stash show -v ${STASH_ID} >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'drop: fail early if specified stash is not a stash ref' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD && git stash clear" &&
