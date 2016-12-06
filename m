Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3CB1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 22:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbcLFWko (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 17:40:44 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:33357 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbcLFWko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 17:40:44 -0500
Received: by mail-io0-f195.google.com with SMTP id j92so9954720ioi.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 14:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SRily2SAcv9qcT5nNDSaaslwTsF4Nd6aBJT2n8JHujc=;
        b=QZ4GVktuA6o+jxvXdzZO/Ko534fpsdfxFuv7MtjObWWQGOqohGYjBRIPcwpohtX0qo
         3JOS5mqiEXqeQh5mUJdpNTMsBh7E6rBYMNd0+Q2oGCzIrHEq0+01OnVAY5tZJtcDNxT3
         mz8M15gCuOqy6/OrG7ycYnFodrVf7NwvOWeHsfZE4OAKypwwenGSInzoOP1XDVtNl9Jy
         qzo//BohbJTXYLQlFcpk3BzI2NvJdRocYITak1ZKbes3UjyeZT0DKsbq4vTM15iCQBRB
         c2Q1aLEcvBdS5aDUsRzKjYl7AiV53D6QIjVU9j9WU+HQK9FNUk+bfYP4006IpDWCw0fN
         dBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SRily2SAcv9qcT5nNDSaaslwTsF4Nd6aBJT2n8JHujc=;
        b=kpXQVgHY8ETpBXazyw0IOXt/xwKIMzog5RF2G/KNNiTHGWm9KT7+/F5NIYsbd6pLtT
         zRokEb5qhjgletGc87vybwEUMAOn4sepOpF68CtEI2+OoHdhEXi0QvMB0/HgvXhtjzAP
         v+vKpMMZ5OrX7vmb50w4Nnj5SU5cciZEbEe0oD39crecZHuUy4jXWi0RddXLTXtHq7db
         aBRgYTJ8mTIX0VhFJKe4AeMQrh4qhUw8sz/spbZn9zOeF7rdLflpmvDUeaFJxz31oNi6
         SrzkwkEzEvPF9l7beC685ncJ/JCATdsMeAP4WEL73U7AhxVShEdus1Rk5dU9CJjl2bPl
         Gzzw==
X-Gm-Message-State: AKaTC028JRwg1fHk6Ly4vzUGNpy6uM2CdzKxzFiih8LpXog5rBFkfKnWe9odWTl2dT7g9j1a0qRsEhxfOingRw==
X-Received: by 10.107.53.165 with SMTP id k37mr58547453ioo.74.1481064043109;
 Tue, 06 Dec 2016 14:40:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Tue, 6 Dec 2016 14:40:42 -0800 (PST)
In-Reply-To: <0cc22155-2b3f-b69c-9ed4-2b1c55e40eee@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b54-0ac61448-98b1-4c7d-bfdd-47af95f52153-000000@eu-west-1.amazonses.com>
 <0cc22155-2b3f-b69c-9ed4-2b1c55e40eee@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 7 Dec 2016 04:10:42 +0530
Message-ID: <CAFZEwPPTnfOYsL8OB5x5n9cm2s+chMwg=xo459kVnFV9bB+5Hw@mail.gmail.com>
Subject: Re: [PATCH v15 19/27] bisect--helper: `bisect_state` & `bisect_head`
 shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Tue, Nov 22, 2016 at 5:42 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> Reimplement the `bisect_state` shell function in C and also add a
>> subcommand `--bisect-state` to `git-bisect--helper` to call it from
>> git-bisect.sh .
>>
>> Using `--bisect-state` subcommand is a temporary measure to port shell
>> function to C so as to use the existing test suite. As more functions
>> are ported, this subcommand will be retired and will be called by some
>> other methods.
>>
>> `bisect_head` is called from `bisect_state` thus its not required to
>> introduce another subcommand.
>
> Missing comma before "thus", and "it is" (or "it's") instead of "its" :)

Sure, will fix.

>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 1767916..1481c6d 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -784,6 +786,79 @@ static int bisect_autostart(struct bisect_terms *terms)
>>       return 0;
>>  }
>>
>> +static char *bisect_head(void)
>> +{
>> +     if (is_empty_or_missing_file(git_path_bisect_head()))
>> +             return "HEAD";
>> +     else
>> +             return "BISECT_HEAD";
>> +}
>
> This is very shellish.
> In C I'd expect something like
>
> static int bisect_head_sha1(unsigned char *sha)
> {
>         int res;
>         if (is_empty_or_missing_file(git_path_bisect_head()))
>                 res = get_sha1("HEAD", sha);
>         else
>                 res = get_sha1("BISECT_HEAD", sha);
>
>         if (res)
>                 return error(_("Could not find BISECT_HEAD or HEAD."));
>
>         return 0;
> }
>
>> +
>> +static int bisect_state(struct bisect_terms *terms, const char **argv,
>> +                     int argc)
>> +{
>> +     const char *state = argv[0];
>> +
>> +     get_terms(terms);
>> +     if (check_and_set_terms(terms, state))
>> +             return -1;
>> +
>> +     if (!argc)
>> +             die(_("Please call `--bisect-state` with at least one argument"));
>
> I think this check should move to cmd_bisect__helper. There are also the
> other argument number checks.

Not really. After the whole conversion, the cmdmode will cease to
exists while bisect_state will be called directly, thus it is
important to check it here.

>> +
>> +     if (argc == 1 && one_of(state, terms->term_good,
>> +         terms->term_bad, "skip", NULL)) {
>> +             const char *bisected_head = xstrdup(bisect_head());
>> +             const char *hex[1];
>
> Maybe:
>                 const char *hex;
>
>> +             unsigned char sha1[20];
>> +
>> +             if (get_sha1(bisected_head, sha1))
>> +                     die(_("Bad rev input: %s"), bisected_head);
>
> And instead of...
>
>> +             if (bisect_write(state, sha1_to_hex(sha1), terms, 0))
>> +                     return -1;
>> +
>> +             *hex = xstrdup(sha1_to_hex(sha1));
>> +             if (check_expected_revs(hex, 1))
>> +                     return -1;
>
> ... simply:
>
>                 hex = xstrdup(sha1_to_hex(sha1));
>                 if (set_state(terms, state, hex)) {
>                         free(hex);
>                         return -1;
>                 }
>                 free(hex);
>
> where:

Yes I am planning to convert all places with hex rather than the sha1
but not yet, maybe in an another patch series because currently a lot
of things revolve around sha1 and changing its behaviour wouldn't
really be a part of a porting patch series.

> static int set_state(struct bisect_terms *terms, const char *state,
>                                                  const char *hex)
> {
>         if (bisect_write(state, hex, terms, 0))
>                 return -1;
>         if (check_expected_revs(&hex, 1))
>                 return -1;
>         return 0;
> }
>
>> +             return bisect_auto_next(terms, NULL);
>> +     }
>> +
>> +     if ((argc == 2 && !strcmp(state, terms->term_bad)) ||
>> +                     one_of(state, terms->term_good, "skip", NULL)) {
>> +             int i;
>> +             struct string_list hex = STRING_LIST_INIT_DUP;
>> +
>> +             for (i = 1; i < argc; i++) {
>> +                     unsigned char sha1[20];
>> +
>> +                     if (get_sha1(argv[i], sha1)) {
>> +                             string_list_clear(&hex, 0);
>> +                             die(_("Bad rev input: %s"), argv[i]);
>> +                     }
>> +                     string_list_append(&hex, sha1_to_hex(sha1));
>> +             }
>> +             for (i = 0; i < hex.nr; i++) {
>
> ... And replace this:
>
>> +                     const char **hex_string = (const char **) &hex.items[i].string;
>> +                     if(bisect_write(state, *hex_string, terms, 0)) {
>> +                             string_list_clear(&hex, 0);
>> +                             return -1;
>> +                     }
>> +                     if (check_expected_revs(hex_string, 1)) {
>> +                             string_list_clear(&hex, 0);
>> +                             return -1;
>> +                     }
>
> by:
>
>                         const char *hex_str = hex.items[i].string;
>                         if (set_state(terms, state, hex_string)) {
>                                 string_list_clear(&hex, 0);
>                                 return -1;
>                         }
>
>> +             }
>> +             string_list_clear(&hex, 0);
>> +             return bisect_auto_next(terms, NULL);
>> +     }
>> +
>> +     if (!strcmp(state, terms->term_bad))
>> +             die(_("'git bisect %s' can take only one argument."),
>> +                   terms->term_bad);
>> +
>> +     return -1;
>> +}
>> +
>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>  {
>>       enum {
>> @@ -823,6 +899,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>                        N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
>>               OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
>>                        N_("start the bisection if BISECT_START empty or missing"), BISECT_AUTOSTART),
>> +             OPT_CMDMODE(0, "bisect-state", &cmdmode,
>> +                      N_("mark the state of ref (or refs)"), BISECT_STATE),
>
> "mark the state of the given revs"
>
> Note that rev != ref

Might have been a typo. Will fix.

>> @@ -902,6 +980,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>               terms.term_bad = "bad";
>>               res = bisect_autostart(&terms);
>>               break;
>> +     case BISECT_STATE:
>> +             if (argc == 0)
>> +                     die(_("--bisect-state requires at least 1 argument"));
>
> "at least one revision"

Okay, that would make it more specific.

>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index cd56551..a9eebbb 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -61,44 +51,7 @@ bisect_skip() {
>>               esac
>>               all="$all $revs"
>>       done
>> -     eval bisect_state 'skip' $all
> [...deleted lines...]
>> +     eval git bisect--helper --bisect-state 'skip' $all
>
> I think you don't need "eval" here any longer.

Yes, I wouldn't

>> @@ -184,8 +137,8 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
>>                       state="$TERM_GOOD"
>>               fi
>>
>> -             # We have to use a subshell because "bisect_state" can exit.
>> -             ( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
>> +             # We have to use a subshell because "--bisect-state" can exit.
>> +             ( git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN" )

True, but right now I didn't want to modify that part of the source
code to remove the comment. I will remove the comment all together
when I port bisect_run()

Regards,
Pranit Bauva
