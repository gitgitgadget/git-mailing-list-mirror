Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943C81F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeBTWfv (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:35:51 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:38971 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbeBTWfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:35:50 -0500
Received: by mail-yw0-f170.google.com with SMTP id b20so2414492ywe.6
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 14:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UzSjlbF1JnQHANpgMAxXV9nsjugI3rtNnGWAQcOijYk=;
        b=OjJQRAYcsaYRrO6UD9Swad4DJ+Jb6DmanQcpYDO51/atrJPKZkcTVEbi379vWXeCIK
         Ve7TMFMiI2u7uVklwB5+orjbNrMiZsYxD9fjek1z0RR6NFGMMdql/rY+lGdh7IeXYnxg
         ftxLQ1F+697Yj8xn+NXYr5fbQrvCkfiPzYlIPpJOYziVse7hrBHT4yVmUiDaE+pmLgz3
         MnKg+FS2irWAj5L4PF8H6J3fQheGc+V+YE+gvCLz1vGyYhe+EXY/oxlhk9d2M8QDLh46
         tNOmP2JOYojSJsKPqu4aH1HdtJZR0L5KpEDv8/mME4J1oTBs0wiDgbWOIciQjzVGR2fQ
         B7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UzSjlbF1JnQHANpgMAxXV9nsjugI3rtNnGWAQcOijYk=;
        b=ffcVmuoonyp4W/3XpjXwZ5FV5sgEUlaFsXAXWTzYs0TNmfCQ62atRjsyOh7dKhP7vF
         XcP0XdtBbt5isUoYcT6PKK1YNipcukSQqBjYZtTK/n8cr8il0AVgLaT/DdYFdz4ceiae
         ss/9XcvArnxIp41Kmzg6mLegVMdK04cTePyQ6xyOcntAeq96KX3beQgb3AVAID+0ugaI
         5WpVnohmKwT5Q8dfQuQg4rHWAZoBG87gUZLyXDD7k9OrFE7U2XIP150NDOSKEuYex8Dk
         57jJ1tS89rdBSC4WJfqzRlSk9Xar8IXyBDYJUpIlV4iuZDF/p1R71p+L23lvkYeuqkpd
         pqIQ==
X-Gm-Message-State: APf1xPAT9DD91MSLOPddbt12gjcA2f6H1AHwSrDIXC8yzW9WVnxMl7cw
        epKhbaydPh02jjHRW4NCNeBqJJO/S9k6ES22eNFFvg==
X-Google-Smtp-Source: AH8x224xtpdF4gmTD/yuUc4RHJZv3kZIK90rVuo4mKX/NCK+AiGm7TRCRl7rpA6WVHS5nIrZgnmygSIPd3AyVJyv7Bo=
X-Received: by 10.129.25.214 with SMTP id 205mr966909ywz.340.1519166149617;
 Tue, 20 Feb 2018 14:35:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 20 Feb 2018 14:35:49
 -0800 (PST)
In-Reply-To: <20180219212130.4217-1-ungureanupaulsebastian@gmail.com>
References: <20180219212130.4217-1-ungureanupaulsebastian@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Feb 2018 14:35:49 -0800
Message-ID: <CAGZ79kbXXN_nxFZUorsbFHcg4-8H7ZnAOnaViUrnP4r4u6ThhQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH] tag: Make "git tag --contains <id>" less chatty if
 <id> is invalid
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Welcome to the Git mailing list!

On Mon, Feb 19, 2018 at 1:21 PM, Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
> git tag --contains <id> prints the whole help text if <id> is
> invalid. It should only show the error message instead.

Makes sense.

>
> This bug was a side effect of looking up the commit in option
> parser callback. When a error occurs in the option parser, the
> full usage is shown. To fix this bug, the part related to
> looking up the commit was moved outside of the option parser
> to the ref-filter module.
>
> Basically, the option parser only parses strings that represent
> commits and the ref-filter performs the commit look-up. If an
> error occurs during the option parsing, then it must be an invalid
> argument and the user should be informed of usage, but if a error
> occurs during ref-filtering, then it is a problem with the
> argument.
>
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---

> diff --git a/parse-options.h b/parse-options.h
> index af711227a..3aa8ddd46 100644
> --- a/parse-options.h
> +++ b/parse-options.h

parse-options.h is a very generic place in Gits source code,
so this would also fix 'git branch --contains=<id>' at the same time?
Would it make sense to say so in the commit message or have a
test for that?

> @@ -258,9 +258,20 @@ extern int parse_opt_passthru_argv(const struct option *, const char *, int);
>           PARSE_OPT_LASTARG_DEFAULT | flag, \
>           parse_opt_commits, (intptr_t) "HEAD" \
>         }
> +#define _OPT_CONTAINS_OR_WITH_STRS(name, variable, help, flag) \
> +       { OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
> +         PARSE_OPT_LASTARG_DEFAULT | flag, \
> +         parse_opt_string_list, (intptr_t) "HEAD" \
> +       }

This is the same as _OPT_CONTAINS_OR_WITH
except parse_opt_commits is substituted by parse_opt_string_list.

Do we need both? (As far as I understand this addresses a whole class
of errors that could be eliminated, we do not want to fix git-tag only,
we'd also want to fix git-branch as well as git-for-each-ref ?)
So instead convert all callers to the new behavior, or would that break
existing conventions? (Then there is no need to have 2 competing
defines that are nearly identical) Instead of double-defining, would it
be possible to turn it into a flag? OPT_DONT_HELP_ON_BAD_OBJECTID
or something?

> +
>  #define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PARSE_OPT_NONEG)
>  #define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, h, PARSE_OPT_NONEG)
>  #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
>  #define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
>
> +#define OPT_CONTAINS_STRS(v, h) _OPT_CONTAINS_OR_WITH_STRS("contains", v, h, PARSE_OPT_NONEG)
> +#define OPT_NO_CONTAINS_STRS(v, h) _OPT_CONTAINS_OR_WITH_STRS("no-contains", v, h, PARSE_OPT_NONEG)
> +#define OPT_WITH_STRS(v, h) _OPT_CONTAINS_OR_WITH_STRS("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
> +#define OPT_WITHOUT_STRS(v, h) _OPT_CONTAINS_OR_WITH_STRS("without", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
> +


> diff --git a/t/t7013-tag-contains.sh b/t/t7013-tag-contains.sh
> new file mode 100755
> index 000000000..65119dada
> --- /dev/null
> +++ b/t/t7013-tag-contains.sh

Thanks for adding the tests into a new file instead of putting it somewhere
where it is already convenient. (We have too many of those "just add it there
as it is easiest to fit in")

> +
> +test_expect_success 'tag --contains <existent_tag>' '
> +       ! (git tag --contains "v1.0" 2>&1 | grep -o "usage")

In the test suite we assume everything but Git flawless, but
Git *may* be faulty. What if Git crashes (segfault) ?
Then this test is still producing a valid "ok" as grep
doesn't find "usage". This pattern of piping output of
Git into other commands is around the test suite unfortunately,
but we'd want to not add this pattern in new code. So maybe:

    git tag --contains v1.0 2 >error &&
    grep "usage" err

Another thing on this: we'd want to check the return code of
git tag in this case.

In case of an error in parse-opt we error out with 129
just as git would without this patch:

 $ git tag --contains=a6d7eb2c7a6a402a938824bcf1c5f331dd1a06bc
error: no such commit a6d7eb2c7a6a402a938824bcf1c5f331dd1a06bc
usage: git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
<tagname> [<head>]
   or: git tag -d <tagname>...
   or: git tag -l [-n[<num>]] [--contains <commit>] [--no-contains
<commit>] [--points-at <object>]
[....]
 $ echo $?
129

But after applying this patch, we also do not want to have 129
as the return code as that indicates that parsing the options was
unsuccessful. Instead we want to see that the --contains operation was
unsucessful, maybe?

So I'd expect the return code to be 0 (if we don't care) or 1
(if we do care), in the case of 1, we shall write:

  test_must_fail git tag --contains ... &&
  grep ....

(A long way of hinting at the test_must_fail test function,
that lives in t/test-lib-functions.sh)

Thanks,
Stefan
