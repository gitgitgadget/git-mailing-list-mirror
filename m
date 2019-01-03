Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E951F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 20:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfACU3j (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 15:29:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42076 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfACU3i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 15:29:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so34736309wrx.9
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 12:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/Mbzc6hr3Tqfa1CA6uvwRoHCFCvvMQ6pgiKLUyPnUYw=;
        b=SK12LC7wMmu22KgkZr/pP/b33ZZ6KcYH7ZenxRCObpGbwzKqaHHKOfCRqsWpps4kPl
         u0vOIjxVMje49x+M1T24WySzgGOc7fpw1jmB5nOluCOj08dw4ra+SCHTFiss6ugtvWI4
         LuPKN0KeU5PW5okKTIScFJR7o1IFo4UR6TWtgKmC8XW5smsIAbbLuEqlUhzA/z3OhKpg
         4U8w4C8McbAw3XT6RtHiL0Q4DXghmYJ3AvTZHvNd0TH4C/PzGnHEawmByuNSJqqX1+St
         SwB1kKG/gwR3ab41xvH8PZLsAzX+3rVGL7qgVTB2GGjczxlBx7waWRt6tOatr+BMCumq
         LsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/Mbzc6hr3Tqfa1CA6uvwRoHCFCvvMQ6pgiKLUyPnUYw=;
        b=bP+kxQitDFlaWiPaMwee837nxTOwngpOF2WTBaTd9qPxFNAuV6eVq/aBBg1HJTBrI5
         qXKvePw8tCmoqzEADlXOkOnRTzpXUPPAk3TLvPypuASTPLDjTHQf4tRdZLoqv6GhR0nv
         Ozcv1XGKCHcMDHLSi5D+7if3GSJHH4/MnFsK35j8mB6gydjMUrMNA/0EH6sxZ89F6riD
         DmtxCar/4DO/u1UN4TtTr2b1F2BzURoLMrowUkAd++qDa0jCV5Vo3W9kAhD/Vt6E0qn0
         cSNDc9kqq2LSH3/nwEmDxmuEkq+L64HONCWRd10C9yxijN1AEJoJ3vDQ5hVr2Pl51NdM
         S8KQ==
X-Gm-Message-State: AJcUukeo7vzAhOxV95i4z07+FKFcw7DmbW7SpmWKc3Zds8jyELpcJYv/
        E8GNWvoglkbH9UeTpJugj3D4sLIM
X-Google-Smtp-Source: ALg8bN6H7SsfCZvWKAJPqBnJvgDpDg46fikOLsJipmm1eejW5h06Xukq9l8HywSR7NgKJLXXOg6xAg==
X-Received: by 2002:adf:c505:: with SMTP id q5mr41655431wrf.84.1546547376334;
        Thu, 03 Jan 2019 12:29:36 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 3sm48036729wmw.46.2019.01.03.12.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 12:29:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Max Kirillov <max@max630.net>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] test-lib: check Bash version for '-x' without using shell arrays
References: <xmqqa7kjknwp.fsf@gitster-ct.c.googlers.com>
        <20190103114317.11523-1-szeder.dev@gmail.com>
Date:   Thu, 03 Jan 2019 12:29:35 -0800
In-Reply-To: <20190103114317.11523-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 3 Jan 2019 12:43:17 +0100")
Message-ID: <xmqqa7khh4cw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> One of our test scripts, 't1510-repo-setup.sh' [1], still can't be
> reliably run with '-x' tracing enabled, unless it's executed with a
> Bash version supporting BASH_XTRACEFD (since v4.1).  We have a lengthy
> condition to check the version of the shell running the test script,
> and disable tracing if it's not executed with a suitable Bash version
> [2].
>
> This condition uses non-portable shell array accesses to easily get
> Bash's major and minor version number.  This didn't seem to be
> problematic, because the simple commands expanding those array
> accesses are only executed when the test script is actually run with
> Bash.  When run with Dash, the only shell I have at hand that doesn't
> support shell arrays, there are no issues, as it apparently skips
> right over the non-executed simple commands without noticing the
> non-supported constructs.
>
> Alas, it has been reported that NetBSD's /bin/sh does complain about
> them:
>
>   ./test-lib.sh: 327: Syntax error: Bad substitution
>
> where line 327 contains the first ${BASH_VERSINFO[0]} array access.
>
> To my understanding both shells are right and conform to POSIX,
> because the standard allows both behaviors by stating the following
> under '2.8.1 Consequences of Shell Errors' [3]:
>
>   "An expansion error is one that occurs when the shell expansions
>   define in wordexp are carried out (for example, "${x!y}", because
>   '!' is not a valid operator); an implementation may treat these as
>   syntax errors if it is able to detect them during tokenization,
>   rather than during expansion."
>
> Avoid this issue with NetBSD's /bin/sh (and potentially with other,
> less common shells) by hiding the shell array syntax behind 'eval'
> that is only executed with Bash.
>
> [1] 5827506928 (t1510-repo-setup: mark as untraceable with '-x',
>     2018-02-24)
> [2] 5fc98e79fc (t: add means to disable '-x' tracing for individual
>     test scripts, 2018-02-24)
> [3] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_01
>
> Reported-by: Max Kirillov <max@max630.net>
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>
> Changes since v1:
>
>  - Hide the shell array syntax behind 'eval'.
>    (I'm fine with both versions, take your pick.)
>  - Corrected typo in commit message that Eric pointed out.
>  - Added a link to the relevant section in POSIX.

Let's treat this as an independent and more urgent fix-up.  I think
it is sufficient to apply it to 2.20.x track, even though we could
go back to 2.17.x and above.

And then let's tentatively kick the "stress test" series out of
'pu', and have that series rebuilt on top of 'master' and this
patch.

Thanks.

>
>  t/test-lib.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0f1faa24b2..c34831a4de 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -323,12 +323,12 @@ do
>  		# this test is marked as such, and ignore '-x' if it
>  		# isn't executed with a suitable Bash version.
>  		if test -z "$test_untraceable" || {
> -		     test -n "$BASH_VERSION" && {
> +		     test -n "$BASH_VERSION" && eval '
>  		       test ${BASH_VERSINFO[0]} -gt 4 || {
>  			 test ${BASH_VERSINFO[0]} -eq 4 &&
>  			 test ${BASH_VERSINFO[1]} -ge 1
>  		       }
> -		     }
> +		     '
>  		   }
>  		then
>  			trace=t
