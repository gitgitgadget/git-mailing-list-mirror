Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41341FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbcLFVc4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:32:56 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35387 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbcLFVcz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:32:55 -0500
Received: by mail-io0-f193.google.com with SMTP id h133so24090078ioe.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/HRiMZaITyALrkYKFak7NtlVuLwIU+cGMSacokTNwuU=;
        b=dcchVFAohd9F9iuoGtau/ZJx2JDHrE/df2VuNct0djrQsUvIYjn6B3v88jxJwDgf4J
         GtwcrhvmPa6NKgR4AHC0p9h4DJu55evgaubakQVNoK3r7JlXbfdf0zy1tjH4C/GUFMMV
         2lAGbDCEZwmFrZ1GUO3odE06NmczN8P+V0H4+VnVGFHubbIwhOed3Z61nP6cAWTsIxFa
         RXkXKOBnyuY/attkSEwFaQRM+IvpQhxTF+0C/NRUJnR4sFhzoyp916UyTaCsuIefZcK/
         i38lGlEyWo1rZNlHaE7+hAX3hOmYvxXxO1r4KL3kouELvGFydRSUffKqQaWpAMfXCAn5
         W91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/HRiMZaITyALrkYKFak7NtlVuLwIU+cGMSacokTNwuU=;
        b=IwiI/QnxixRuNVB1EhuHiJMZcLbtGt47Tyw84owbdi9VdqEDZEYTq/hByCveW4M+Zb
         /oPAVkKY+A2qLMtzyUEr9wsMkKMYwlr26ZZe149YFQQ0RtRwRu2fBhXsqwi5bQGqDBzQ
         +MOdao+tgzW+F7IlzDaMU6HxoTvOsoeGISY9mgMH4lCCqfxcpMrv1l4GvGtNNnanHOMa
         Mjg0lNiUdhURCcGzoJowooyS8wk2RBNEKzPeOMMhU3/o+QV2o5nxYvL5P9bw1yZNTA6q
         rDWqFCl6P8pPW3EANRrVGOanR+HiNvujc0YrjLvmM7w9mXmjBAUs/nhLzN86sK9JKKHE
         0iYQ==
X-Gm-Message-State: AKaTC03hmrBf/FhNrgR4xd5MbHBb1DPpnfkNoXl3+EAzfoqU7PRZ56dTTlex1nFa1uJer5CatmucGQC109nF1g==
X-Received: by 10.107.141.211 with SMTP id p202mr53030874iod.47.1481059974662;
 Tue, 06 Dec 2016 13:32:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Tue, 6 Dec 2016 13:32:54 -0800 (PST)
In-Reply-To: <ceb2c50b-0ca7-115d-eb0e-316389569e36@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ad1-f3a59b1f-9cdb-4d91-b28e-2501facdcb45-000000@eu-west-1.amazonses.com>
 <ceb2c50b-0ca7-115d-eb0e-316389569e36@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 7 Dec 2016 03:02:54 +0530
Message-ID: <CAFZEwPN_6HVWzdk46kKyU7vOzd1rhxzCo7JR45ucsVrhwDWEGw@mail.gmail.com>
Subject: Re: [PATCH v15 09/27] bisect--helper: `bisect_write` shell function
 in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Thu, Nov 17, 2016 at 3:10 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> I've only got some minors to mention here ;)
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index c542e8b..3f19b68 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -19,9 +19,15 @@ static const char * const git_bisect_helper_usage[] = {
>>       N_("git bisect--helper --write-terms <bad_term> <good_term>"),
>>       N_("git bisect--helper --bisect-clean-state"),
>>       N_("git bisect--helper --bisect-reset [<commit>]"),
>> +     N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
>>       NULL
>>  };
>
> I wouldn't write "<TERM_GOOD <TERM_BAD>" in capital letters. I'd use
> something like "<good_term> <bad_term>" as you have used for
> --write-terms. Note that "git bisect --help" uses "<term-old>
> <term-new>" in that context.

Keeping it in small does give less strain to the eye ;)

>> @@ -149,6 +155,63 @@ static int check_expected_revs(const char **revs, int rev_nr)
>>       return 0;
>>  }
>>
>> +static int bisect_write(const char *state, const char *rev,
>> +                     const struct bisect_terms *terms, int nolog)
>> +{
>> +     struct strbuf tag = STRBUF_INIT;
>> +     struct strbuf commit_name = STRBUF_INIT;
>> +     struct object_id oid;
>> +     struct commit *commit;
>> +     struct pretty_print_context pp = {0};
>> +     FILE *fp = NULL;
>> +     int retval = 0;
>> +
>> +     if (!strcmp(state, terms->term_bad))
>> +             strbuf_addf(&tag, "refs/bisect/%s", state);
>> +     else if (one_of(state, terms->term_good, "skip", NULL))
>> +             strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
>> +     else {
>> +             error(_("Bad bisect_write argument: %s"), state);
>> +             retval = -1;
>> +             goto finish;
>> +     }
>> +
>> +     if (get_oid(rev, &oid)) {
>> +             error(_("couldn't get the oid of the rev '%s'"), rev);
>> +             retval = -1;
>> +             goto finish;
>> +     }
>> +
>> +     if (update_ref(NULL, tag.buf, oid.hash, NULL, 0,
>> +                    UPDATE_REFS_MSG_ON_ERR)) {
>> +             retval = -1;
>> +             goto finish;
>> +     }
>
> I'd like to mention that the "goto fail;" trick could apply in this
> function, too.

Sure!

>> @@ -156,9 +219,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>               WRITE_TERMS,
>>               BISECT_CLEAN_STATE,
>>               BISECT_RESET,
>> -             CHECK_EXPECTED_REVS
>> +             CHECK_EXPECTED_REVS,
>> +             BISECT_WRITE
>>       } cmdmode = 0;
>> -     int no_checkout = 0;
>> +     int no_checkout = 0, res = 0;
>
> Why do you do this "direct return" -> "set res and return res" transition?
> You don't need it in this patch, you do not need it in the subsequent
> patches (you always set "res" exactly once after the initialization),
> and you don't need cleanup code in this function.

Initially I was using strbuf but then I switched to const char *
according to Junio's suggestion. It seems that in this version I have
forgot to free the terms.

>>       struct option options[] = {
>>               OPT_CMDMODE(0, "next-all", &cmdmode,
>>                        N_("perform 'git bisect next'"), NEXT_ALL),
>> @@ -170,10 +234,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>                        N_("reset the bisection state"), BISECT_RESET),
>>               OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
>>                        N_("check for expected revs"), CHECK_EXPECTED_REVS),
>> +             OPT_CMDMODE(0, "bisect-write", &cmdmode,
>> +                      N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
>
> That info text is confusing, especially considering that there is a
> "nolog" option. I think the action of bisect-write is two-fold: (1)
> update the refs, (2) log.

I agree that it is confusing. I couldn't find a better way to describe
it and since this would be gone after the whole conversion, I didn't
bother putting more efforts there.

Regards,
Pranit Bauva
