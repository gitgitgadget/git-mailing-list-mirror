Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F081202BB
	for <e@80x24.org>; Mon,  4 Mar 2019 04:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfCDERk (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 23:17:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32998 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDERk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 23:17:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id c13so3037547wmb.0
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 20:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=twEJjBhWpj2Pae7D5AO16Gtb0hbTdEC8k/1jCDawnxw=;
        b=T57EPJDzEI2DcidabKnTA3Tht75Oas1e86RpQv2hMnRqUTtQzZI8szuM5UnTzpVb5d
         pGueZIoBLn+hCmW2fnXqmeyb7pj0io0CtDKlf9M7uCWzs/TMkuukMaZ7kpSJeBaX3W5k
         hl0xHwUnA96h1WPmjUrCr7dnkjWO/n+HtFdj2BcxA9+uwGRBoqGICHrJT547obs0Hfbb
         7qD5ahQnX9LGzNydkpnpuZoCfL2LzbBuAI4KqccbqrzxdJFdM96DM1r5b34iuaSf2z7L
         avnLrCP+Yx8pDOWJEtjnQW7nI7lJ2HRUjWBMPOObPhasHYib8Q0sDEaIWnjw/cTPl1z4
         Gpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=twEJjBhWpj2Pae7D5AO16Gtb0hbTdEC8k/1jCDawnxw=;
        b=tBWiQNYha/H6YoXFEuyn3H601qNscyZgUCK7V1OXo3iUwJu2JXulaEE0t+WY/7TSt+
         dfd+4/EzRjPmOATAaf4Icz1OPVHesOts1Ze4gcSiGWwAqvSGXtP/dzPEebZXmzjTMjdh
         L1t+xyAzeCQMKCRl2izIvrPWQPLy9yGWrCipdex3y4da3BS7Eo3wEhfkOwExbOouw+qC
         9z+eD8V/us74q6z6BhO6rSqS+ea+XVIjrinRvrB1pblpy2GBYw2au+Hf/A/DQhzFX/dk
         goYZ3q57ymPgeEJg1g3BXbwcQh9SnH919/aIOr4Cp4pEZYiZ3TWofUXzaBIXBFCOdojn
         1AoA==
X-Gm-Message-State: AHQUAuZbJy9zr9hThsGOO/TDTpnoIrry2x8yg2IC88EsReOTMuK+iKhw
        3EMnlxJobFx8N5SugzWlsnc=
X-Google-Smtp-Source: APXvYqzDgKyzJV4NlCJTLOD/X9hSoSYzP3grXsg5iHyHiNAiJBN3/8Da+o+4NDKwabW8JCd8lMZ0yQ==
X-Received: by 2002:a1c:230e:: with SMTP id j14mr10427340wmj.9.1551673057208;
        Sun, 03 Mar 2019 20:17:37 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u13sm9785325wmf.3.2019.03.03.20.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 20:17:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v2 2/3] t3600: restructure code according to contemporary guidelines
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
        <20190303233750.6500-1-rohit.ashiwal265@gmail.com>
        <20190303233750.6500-3-rohit.ashiwal265@gmail.com>
Date:   Mon, 04 Mar 2019 13:17:35 +0900
In-Reply-To: <20190303233750.6500-3-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Mon, 4 Mar 2019 05:07:49 +0530")
Message-ID: <xmqqsgw3w9wg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> Replace leading spaces with tabs
> Place title on the same line as function
>
> The previous code of `t3600-rm.sh` had a mixed use of tabs and spaces with
> instance of `not-so-recommended` way of writing `if-then` statement, also
> `titles` were not on the same line as the function `test_expect_success`,
> replace them so that the current version agrees with the coding guidelines

Styles and conventions are different from project to project, but
around here, we do _not_ start the log message with an itemized list
of what was done.  I can sort of see why some project might find it
useful, but we do not do that here.

Instead we talk about the status-quo in present tense, point out
problems (which can be omitted when they are obvious from the
description of the status-quo) and describe the approach to addres
the problems (again, which can be omitted when it is obvious from
what is written already).  We then summarize the solution in
imperative mood, as if we are giving an order to the codebase to "be
like so" (you can think of it as giving a command to a patch monkey
to "make the code like so").

	Subject: t3600: modernize style

	The tests in t3600 were written long time ago, and has a lot
	of style violations, including the mixed use of tabs and
	spaces, not having the title and the opening quote of the
	body on the first line of the tests, and other shell script
	style violations.  Update it to match the CodingGuidelines.

is probably what I would summarize this change as..

> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>  t/t3600-rm.sh | 184 ++++++++++++++++++++++++++------------------------
>  1 file changed, 94 insertions(+), 90 deletions(-)
>
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 04e5d42bd3..f1afda21e9 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -8,91 +8,95 @@ test_description='Test of the various options to git rm.'
>  . ./test-lib.sh
>  
>  # Setup some files to be removed, some with funny characters
> -test_expect_success \
> -    'Initialize test directory' \
> -    "touch -- foo bar baz 'space embedded' -q &&
> -     git add -- foo bar baz 'space embedded' -q &&
> -     git commit -m 'add normal files'"
> +test_expect_success 'Initialize test directory' "
> +	touch -- foo bar baz 'space embedded' -q &&
> +	git add -- foo bar baz 'space embedded' -q &&
> +	git commit -m 'add normal files'
> +"

Swap '' and ""; it is very rare that use of double-quotes around the
test body is justifiable (for one, any $variable reference would be
expanded _before_ the test runs, which is almost always not what you
want, if you used double-quote around the test body).  

There are many other instances of this in the remainder of this
patch, which I won't mention.

> -if test_have_prereq !FUNNYNAMES; then
> +if test_have_prereq !FUNNYNAMES
> +then

Good.

> -test_expect_success FUNNYNAMES \
> -    "Test that \"git rm -f\" succeeds with embedded space, tab, or newline characters." \
> -    "git rm -f 'space embedded' 'tab	embedded' 'newline
> -embedded'"
> +test_expect_success 'Pre-check that foo exists and is in index before git rm foo' '
> +	test_path_is_file foo &&

The point of having 2/3 and 3/3 as separate steps is because 3/3 is
about using the test-path-is... helpers, while 2/3 is about modernizing
the codebase before doing 3/3 so that the it can be reviewed more easily
without distracting changes 2/3 needs to make.

So you would want to turn the "[ -f foo ]" into "test -f foo" in
this step, and then you will further turn it in the next step into
"test_path_is_file foo".

It would not show in the end result, but paying attention to this
kind of detail shows how careful the author was when future readers
read the patch, so I try to be careful when I am structuring a
series like this myself.

> +test_expect_success 'Post-check that foo exists but is not in index after git rm foo' '
> +	test_path_is_file foo &&
> +	test_must_fail git ls-files --error-unmatch foo
> +'

Likewise.

> +test_expect_success 'Pre-check that bar exists and is in index before "git rm bar"' '
> +	test_path_is_file bar &&
> +	git ls-files --error-unmatch bar
> +'

Likewise (I'll stop pointing these out from here on).

> +test_expect_success FUNNYNAMES "Test that \"git rm -f\" succeeds with embedded space, tab, or newline characters." "
> +	git rm -f 'space embedded' 'tab	embedded' 'newline
> +embedded'
> +"

Again, swap "" and '' around; that way you can lose the backslash.

Consider using $LF that is defined in t/test-lib.sh for exactly a
case like this one.

	git rm -f "space embedded" "tab	embedded" "newline${LF}embedded"

That may make the test body even easier to follow.

> @@ -218,22 +222,22 @@ test_expect_success 'Remove nonexistent file returns nonzero exit status' '
>  test_expect_success 'Call "rm" from outside the work tree' '
>  	mkdir repo &&
>  	(cd repo &&

Inspect the output from

	git grep 'cd ' 't/t[0-9][0-9][0-9][0-9]-*.sh'

and see which is prevalent; I think this line may want to become

	(
		cd repo &&

but I did not count.

> -	 git init &&
> -	 echo something >somefile &&
> -	 git add somefile &&
> -	 git commit -m "add a file" &&
> -	 (cd .. &&
> -	  git --git-dir=repo/.git --work-tree=repo rm somefile) &&
> -	test_must_fail git ls-files --error-unmatch somefile)
> +		git init &&
> +		echo something >somefile &&
> +		git add somefile &&
> +		git commit -m "add a file" &&
> +		(cd .. &&
> +			git --git-dir=repo/.git --work-tree=repo rm somefile
> +		) &&
> +		test_must_fail git ls-files --error-unmatch somefile
> +	)
>  '

Likewise.

>  test_expect_success 'refresh index before checking if it is up-to-date' '
> -
>  	git reset --hard &&
>  	test-tool chmtime -86400 frotz/nitfol &&
>  	git rm frotz/nitfol &&
>  	test ! -f frotz/nitfol
> -
>  '

Good.

Thanks for working on this.
