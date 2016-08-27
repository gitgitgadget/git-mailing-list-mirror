Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82271F859
	for <e@80x24.org>; Sat, 27 Aug 2016 09:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755135AbcH0JeA (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 05:34:00 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36733 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754966AbcH0Jd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 05:33:58 -0400
Received: by mail-yw0-f175.google.com with SMTP id u134so61852402ywg.3
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 02:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nhMWCi9KCItcnE12CBIrDeBep+FAduraBKhbdgKzQUc=;
        b=lfJSyOZ1HA5SwVvi2aj/yfG9fPbJKfVVBHN7pVOO5xpxleFEZ0/47PyQMf4bAIIrhG
         NIzCC0TWXNRPpElou7xAerbtnA4O41vYeU3VoLX1xjC9KNPfLxzCr96gLWfHFg4LlGKu
         VZQhu9X1ZFYsaF5ZA4fE7JFPXIDiS4aRhrCJAhhYyLWkdMuUOv2gyybX5+NhmzCTiVTl
         J6AS+ioXSaZcqpZ3tXPIOFn+wnJY3wOF8RarTMTwzcQv7UmheeuiG3qua67A5yCi4Xkk
         KzGlsI3pW36ymIbrvjrI302PYdrlLFBH3OFxdHZdrgyc5ckl6NbR/nP8Rs1u0ndLiyOr
         uHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nhMWCi9KCItcnE12CBIrDeBep+FAduraBKhbdgKzQUc=;
        b=UF0sYJkj9gAfchphfxf/DhnoDCc1DIWs0bXw2rv23vkritVLB7xnNhm6fm+D2zl3S9
         BKn33HRT+fVYc2nITUuDg5icKgivsiZbwo0EnTqTfJJKP1mOi4AXXdS3rRMDtNTAA6JT
         sn5m/a558y6ktF9Nv0ftTrzaIBvkfv9/LKD301WygOKV9WVkxQJNptRca78EGij54nlL
         MA4sfuYtl4XJMzO2WE9EWhTexETzcBIXyHL0Cd3QQa8ET1lmLuYdjibbu2aIqPlymB6c
         kGwRYHS5z4czr/wvNri9BlisJYpEwgYNyuQ89uRkuhzEJuHIT0YYI5TB/e0cjFCFvK9f
         2AlQ==
X-Gm-Message-State: AE9vXwPydwjePKiovl2tN1EFTHY/41gi5YRl9AI0UfxuAKD2QBJQB9BzCevdtjSxqj+bLwNucKJPEnQY7eKJCg==
X-Received: by 10.129.76.79 with SMTP id z76mr6994202ywa.33.1472290437722;
 Sat, 27 Aug 2016 02:33:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Sat, 27 Aug 2016 02:33:57 -0700 (PDT)
In-Reply-To: <xmqqfuptol4h.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe6a7-2e9df745-e3f4-4830-a1af-4acae7964c11-000000@eu-west-1.amazonses.com>
 <xmqqfuptol4h.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 27 Aug 2016 15:03:57 +0530
Message-ID: <CAFZEwPMcUf-Tm_ijJbEG1Bh7F+7ML2fw6Vw2Gt94B9gyoGL1FQ@mail.gmail.com>
Subject: Re: [PATCH v14 09/27] bisect--helper: `bisect_write` shell function
 in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Thu, Aug 25, 2016 at 4:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +struct bisect_terms {
>> +     struct strbuf term_good;
>> +     struct strbuf term_bad;
>> +};
>
> I think "struct strbuf" is overrated.  For things like this, where
> these fields will never change once it is set (and setting it is
> done atomically, not incrementally), there is no good reason to use
> define the fields as strbuf.
>
> Only because you chose to use strbuf for these two fields, you have
> to make unnecessarily copies of argv[] in the command parser, and
> you have to remember to discard these copies later.
>
> I think you can just say "const char *" in this case.

Using struct strbuf is not really overrated but in fact required. But
yes, for this patch it might seem as overrated. In the shell code
initally TERM_GOOD is set to "good" while TERM_BAD is set to "bad".
Now there are a lot of instances (one of which is bisect_start()
function) where this can change. So if we keep it as "const char *",
it would be right to change the value of it after wards. And we cannot
keep it as "char []" because we don't know its size before hand.

>> +static int bisect_write(const char *state, const char *rev,
>> +                     const struct bisect_terms *terms, int nolog)
>> +{
>> +     struct strbuf tag = STRBUF_INIT;
>> +     struct strbuf commit_name = STRBUF_INIT;
>> +     struct object_id oid;
>> +     struct commit *commit;
>> +     struct pretty_print_context pp = {0};
>> +     FILE *fp;
>> +
>> +     if (!strcmp(state, terms->term_bad.buf))
>> +             strbuf_addf(&tag, "refs/bisect/%s", state);
>> +     else if (one_of(state, terms->term_good.buf, "skip", NULL))
>> +             strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
>> +     else
>> +             return error(_("Bad bisect_write argument: %s"), state);
>
> OK.
>
>> +     if (get_oid(rev, &oid)) {
>> +             strbuf_release(&tag);
>> +             return error(_("couldn't get the oid of the rev '%s'"), rev);
>> +     }
>> +
>> +     if (update_ref(NULL, tag.buf, oid.hash, NULL, 0,
>> +                    UPDATE_REFS_MSG_ON_ERR)) {
>> +             strbuf_release(&tag);
>> +             return -1;
>> +     }
>> +     strbuf_release(&tag);
>> +
>> +     fp = fopen(git_path_bisect_log(), "a");
>> +     if (!fp)
>> +             return error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
>> +
>> +     commit = lookup_commit_reference(oid.hash);
>> +     format_commit_message(commit, "%s", &commit_name, &pp);
>> +     fprintf(fp, "# %s: [%s] %s\n", state, sha1_to_hex(oid.hash),
>> +             commit_name.buf);
>> +     strbuf_release(&commit_name);
>> +
>> +     if (!nolog)
>> +             fprintf(fp, "git bisect %s %s\n", state, rev);
>> +
>> +     fclose(fp);
>> +     return 0;
>
> You seem to be _release()ing tag all over the place.
>
> Would it make sense to have a single clean-up label at the end of
> function, introduce a "int retval" variable and set it to -1 (or
> whatever) when an error is detected and "goto" to the label?  It may
> make it harder to make such a leak.  That is, to end the function
> more like:

I think I could use goto for this function.

>         finish:
>                 if (fp)
>                         fclose(fp);
>                 strbuf_release(&tag);
>                 strbuf_release(&commit_name);
>                 return retval;
>         }
>
> and have sites with potential errors do something like this:
>
>         if (update_ref(...)) {
>                 retval = -1;
>                 goto finish;
>         }
>
>> +     struct bisect_terms terms;
>> +     bisect_terms_init(&terms);
>
> With the type of "struct bisect_terms" members corrected, you do not
> even need the _init() function.

Discussed above.

>> @@ -182,24 +251,38 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>               usage_with_options(git_bisect_helper_usage, options);
>>
>>       switch (cmdmode) {
>> +     int nolog;
>>       case NEXT_ALL:
>>               return bisect_next_all(prefix, no_checkout);
>>       case WRITE_TERMS:
>>               if (argc != 2)
>>                       die(_("--write-terms requires two arguments"));
>> -             return write_terms(argv[0], argv[1]);
>> +             res = write_terms(argv[0], argv[1]);
>> +             break;
>>       case BISECT_CLEAN_STATE:
>>               if (argc != 0)
>>                       die(_("--bisect-clean-state requires no arguments"));
>> -             return bisect_clean_state();
>> +             res = bisect_clean_state();
>> +             break;
>>       case BISECT_RESET:
>>               if (argc > 1)
>>                       die(_("--bisect-reset requires either zero or one arguments"));
>> -             return bisect_reset(argc ? argv[0] : NULL);
>> +             res = bisect_reset(argc ? argv[0] : NULL);
>> +             break;
>>       case CHECK_EXPECTED_REVS:
>> -             return check_expected_revs(argv, argc);
>> +             res = check_expected_revs(argv, argc);
>> +             break;
>> +     case BISECT_WRITE:
>> +             if (argc != 4 && argc != 5)
>> +                     die(_("--bisect-write requires either 4 or 5 arguments"));
>> +             nolog = (argc == 5) && !strcmp(argv[4], "nolog");
>> +             strbuf_addstr(&terms.term_good, argv[2]);
>> +             strbuf_addstr(&terms.term_bad, argv[3]);
>
> Here,
>
>         terms.term_good = argv[2];
>         terms.term_bad = argv[3];
>
> and then you do not need bisect_terms_release() at all.

Discussed above.

>> +             res = bisect_write(argv[0], argv[1], &terms, nolog);
>> +             break;
>>       default:
>>               die("BUG: unknown subcommand '%d'", cmdmode);
>>       }
>> -     return 0;
>> +     bisect_terms_release(&terms);
>> +     return res;
>>  }
