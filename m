Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431371FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 10:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbcLaKXP (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 05:23:15 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36668 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754101AbcLaKXO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 05:23:14 -0500
Received: by mail-it0-f68.google.com with SMTP id n68so43596105itn.3
        for <git@vger.kernel.org>; Sat, 31 Dec 2016 02:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z8jERBeC4atCvq8xTDErJIdL3ksKvwCo+3N/yJz1/fw=;
        b=hKaB0/ZUGXz3T7Gax0W238/MLpUHcLghuT1cZ4PadDbr0R9TX3a/ylULWfnRWbd0FE
         qsSuwSlD19zEjL604w4+3yay6fx22GvsZ7MIIurx8MJvyhbjZJzqHSweXeJUoS7tUAvN
         ZxGKErK1l7RbBVRdie34n8wWKjVHoZOFQj83xDP4J4dYUt1wabG25DkLfmtaFnvgY8+p
         qqKOkN/Oy8FGiC/XygKQNJymqa4jzgo32UGlNZFtkYoVmhHrWXnqGC3IJWZOa64AmNEJ
         dpCJPIjLnODMujiVlGL+jpmPxoP6QmlY3cH2+CMe2VFoU8IuUyGLP1IADg3/gFUfZG7L
         oxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z8jERBeC4atCvq8xTDErJIdL3ksKvwCo+3N/yJz1/fw=;
        b=A8Hcw7ecjDzZyIemMLIGt4sWj3Xe9xptbFfzJtX30Stc+wyCvwfO9npK5r5fBNuHub
         mxwWerVeE2p9QP/mOnKL5vJwGmYriPbyCVg2w6h4gacjDN3BIUiL7JpDvVU0cD9zFcJi
         u+jriA/YjIOis0O3xrXisGAAOsSyWgFMcVEpjlRWiX+MlFcA7To/ZxahGtK6/Sotnr0K
         Se5G7UfGbFZJ+8+qQSgiimZToSz3BMFHS2U9wxWfp0BPmGJq6F+3+PS9smrOeu7WawkZ
         wcU2YMSBIf4agngUnW9ndLXzArpYY6jAlrtNXbfOh4/Vq9/UEmsZFKX8efUg1Ufi7j4U
         N3Gg==
X-Gm-Message-State: AIkVDXL6V29k9Y9gm4P1DpQmf1B06FdpDblZjaY5km8gYvvtarkvYkooePtvrngDbncacX+sFZzaVbopbGKxZA==
X-Received: by 10.36.216.132 with SMTP id b126mr44197974itg.45.1483179793249;
 Sat, 31 Dec 2016 02:23:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Sat, 31 Dec 2016 02:23:12 -0800 (PST)
In-Reply-To: <8bd0682f-e35e-a50e-24a9-fd3a53454ed4@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1af0-5d688c2e-868d-4d8c-a8fd-9a675f7f01da-000000@eu-west-1.amazonses.com>
 <8bd0682f-e35e-a50e-24a9-fd3a53454ed4@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 31 Dec 2016 15:53:12 +0530
Message-ID: <CAFZEwPMbT+BZ=eDxW1xkgH-Nrd=AMm1vGejLKmQ5wdM84TVnmQ@mail.gmail.com>
Subject: Re: [PATCH v15 15/27] bisect--helper: `bisect_next` and
 `bisect_auto_next` shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

Extremely sorry I just forgot to reply to this email before. I was
preparing from the next iteration when I saw this.

On Mon, Nov 21, 2016 at 1:31 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi Pranit,
>
> this one is hard to review because you do two or three commits in one here.
> I think the first commit should be the exit()->return conversion, the
> second commit is next and autonext, and the third commit is the pretty
> trivial bisect_start commit ;) However, you did it this way and it's
> always a hassle to split commit, so I don't really care...

I had confusion about how to split the commits, but then I then
decided to dump it all together so that it compiles (I was finding it
difficult to split into meaningful parts which also compiled).

> However, I was reviewing this superficially, to be honest. This mail
> skips the next and autonext part.
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/bisect.c b/bisect.c
>> index 45d598d..7c97e85 100644
>> --- a/bisect.c
>> +++ b/bisect.c
>> @@ -843,16 +878,21 @@ static int check_ancestors(const char *prefix)
>>   *
>>   * If that's not the case, we need to check the merge bases.
>>   * If a merge base must be tested by the user, its source code will be
>> - * checked out to be tested by the user and we will exit.
>> + * checked out to be tested by the user and we will return.
>>   */
>> -static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
>> +static int check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
>>  {
>>       char *filename = git_pathdup("BISECT_ANCESTORS_OK");
>>       struct stat st;
>> -     int fd;
>> +     int fd, res = 0;
>>
>> +     /*
>> +      * We don't want to clean the bisection state
>> +      * as we need to get back to where we started
>> +      * by using `git bisect reset`.
>> +      */
>>       if (!current_bad_oid)
>> -             die(_("a %s revision is needed"), term_bad);
>> +             error(_("a %s revision is needed"), term_bad);
>
> Only error() or return error()?

It should be return error(). Thanks for pointing it out! :)

>> @@ -873,8 +916,11 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
>>                             filename);
>>       else
>>               close(fd);
>> +
>> +     goto done;
>>   done:
>
> I never understand why you do this. In case of adding a "fail" label
> (and fail code like "res = -1;") between "goto done" and "done:", it's
> fine... but without one this is just a nop.

I will just remove that line.

>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 1d3e17f..fcd7574 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -427,15 +560,24 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
>>               no_checkout = 1;
>>
>>       for (i = 0; i < argc; i++) {
>> -             if (!strcmp(argv[i], "--")) {
>> +             const char *arg;
>> +             if (starts_with(argv[i], "'"))
>> +                     arg = sq_dequote(xstrdup(argv[i]));
>> +             else
>> +                     arg = argv[i];
>
> One is xstrdup'ed, one is not, so there'll be a leak somewhere, and it's
> an inconsistent leak... I guess it's a bad idea to do it this way ;)
> (Also below.)

Yes. I will use xstrdup() and it does leak.

>> @@ -443,24 +585,31 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
>>                       no_checkout = 1;
>>               } else if (!strcmp(arg, "--term-good") ||
>>                        !strcmp(arg, "--term-old")) {
>> +                     if (starts_with(argv[++i], "'"))
>> +                             terms->term_good = sq_dequote(xstrdup(argv[i]));
>> +                     else
>> +                             terms->term_good = xstrdup(argv[i]);
>>                       must_write_terms = 1;
>> -                     terms->term_good = xstrdup(argv[++i]);
>>               } else if (skip_prefix(arg, "--term-good=", &arg)) {
>>                       must_write_terms = 1;
>> -                     terms->term_good = xstrdup(arg);
>> +                     terms->term_good = arg;
>
> No ;) (See my other comments (to other patches) for the "terms" leaks.)

Yes I have addressed this issue.

> [This repeats several times below.]
>
>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index f0896b3..d574c44 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -109,6 +88,7 @@ bisect_skip() {
>>  bisect_state() {
>>       bisect_autostart
>>       state=$1
>> +     get_terms
>>       git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
>>       get_terms
>>       case "$#,$state" in
>
> I can't say if this change is right or wrong. It looks right, but: How
> does this relate to the other changes? Is this the right patch for it?

This line is because of the following:

 * TERM_BAD and TERM_GOOD are global but in the coming patch they
would be removed as global variables.

 * To compensate for that, I will write out the state of TERM_BAD and
TERM_GOOD every time it is updated in the file BISECT_TERMS.

 * So we will be reading it from there.

 * It is quite possible that this is completely redundant as for now
but I really don't care to check for each case because I have removed
the shell function bisect_state() afterwards and then this line won't
create a problem there because we are using `struct bisect_terms`
there.
