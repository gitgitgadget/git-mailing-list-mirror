Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60DA21FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 10:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbcLaKnM (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 05:43:12 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34165 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbcLaKnL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 05:43:11 -0500
Received: by mail-io0-f195.google.com with SMTP id n85so23892998ioi.1
        for <git@vger.kernel.org>; Sat, 31 Dec 2016 02:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gvtilny1H2bgOLwYQ8NagQOpahufGb0KdtbukokJVUw=;
        b=cb1CWMK4cw2sONNxih1iv4jQTigim7a+dQdjOGkFjXdBTBh/XS2DkCyuiOus77Baoe
         6DBOvlFse2IzWnAZLE/eYM7MDKOqxO42sD55Zbzo2FR0NfhanGbHcpH0n1uiFmtaBnEL
         ePL9ZKbV4krajv5xkT2ReTKEOcpP+6Cm+SbysgXtfz3mkp1W92+yFhWSBUcVrmzFIdqh
         p4NMoNsqLAodl4G8QPSyR48gnAI6c0vc105FnJX085bBG3DmUZHHgNATI7yUtZ00DyFU
         zrTpJ7jpYtaXWE1b6lqlGDQOBIfntC/sp7nRwDZIhOsEQKYBIvR+YB4WpIXYVmV7Lee2
         W9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gvtilny1H2bgOLwYQ8NagQOpahufGb0KdtbukokJVUw=;
        b=enJWVXF6D31qUICPFBkOEvbkcmMa3MlLF7BqFIa+4J32g3USD+7uNEBGS6WdKHzYA0
         7qpbt30zhm0oTnmsTzSCGuQ0hN68Ri3PBw4uMZO7UY/SgPjlfnNL+CpeHdR2yiNDJijq
         e2IY8pelSxDN77lUIUhPN1dzJt/jmTlP68HkxW4b9sIIjz93uQJZCPKgLBKUOCdWsU+O
         1MD5H7z/jmdmOwFU/rvPJAVnZFuhwZEZVUJfuSFKfaRrobdofC1gMD9Xwmzw0vvx139P
         C1R2Yt+Q+y/7FONGtK/B5cOHYaKFr50bIcimyi2igwQSMVgd9VrH85D8jPi6/TMnOHB5
         yf/w==
X-Gm-Message-State: AIkVDXJ4b6/zS+KwLCmg32YUqE09OmHYqu2jOkHk0rtIo/3dDVNnlnChPTxX3oGlglvAhVBMwuDOe3eIYl2wBQ==
X-Received: by 10.107.141.211 with SMTP id p202mr35877077iod.47.1483180990618;
 Sat, 31 Dec 2016 02:43:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Sat, 31 Dec 2016 02:43:10 -0800 (PST)
In-Reply-To: <06402c8a-14a4-3d70-8d98-659cfe9f1aa2@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1af0-5d688c2e-868d-4d8c-a8fd-9a675f7f01da-000000@eu-west-1.amazonses.com>
 <06402c8a-14a4-3d70-8d98-659cfe9f1aa2@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 31 Dec 2016 16:13:10 +0530
Message-ID: <CAFZEwPPtF5P5nGp+=btHtwNm1unTJ7qo1khJHCqLvNn1=RYAUQ@mail.gmail.com>
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

On Tue, Nov 22, 2016 at 3:05 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi Pranit,
>
> in this mail I review the "second part" of your patch: the transition of
> bisect_next and bisect_auto_next to C.
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 1d3e17f..fcd7574 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -408,6 +411,136 @@ static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
>>       return 0;
>>  }
>>
>> +static int register_good_ref(const char *refname,
>> +                          const struct object_id *oid, int flags,
>> +                          void *cb_data)
>> +{
>> +     struct string_list *good_refs = cb_data;
>> +     string_list_append(good_refs, oid_to_hex(oid));
>> +     return 0;
>> +}
>> +
>> +static int bisect_next(struct bisect_terms *terms, const char *prefix)
>> +{
>> +     int res, no_checkout;
>> +
>> +     /*
>> +      * In case of mistaken revs or checkout error, or signals received,
>> +      * "bisect_auto_next" below may exit or misbehave.
>> +      * We have to trap this to be able to clean up using
>> +      * "bisect_clean_state".
>> +      */
>
> The comment above makes no sense here, or does it?

No it doesn't right now. I had this initally because I was trying to
keep bisect_clean_state() call inside this function but then I
realized it should be placed elsewhere. I will remove this.

>> +     if (bisect_next_check(terms, terms->term_good))
>> +             return -1;
>> +
>> +     no_checkout = !is_empty_or_missing_file(git_path_bisect_head());
>> +
>> +     /* Perform all bisection computation, display and checkout */
>> +     res = bisect_next_all(prefix , no_checkout);
>
> Style: there is a space left of the comma.

Nice catch! ;) I have gone through this patch so many times, yet I
have forgot to notice this.

>> +
>> +     if (res == 10) {
>> +             FILE *fp = NULL;
>> +             unsigned char sha1[20];
>> +             struct commit *commit;
>> +             struct pretty_print_context pp = {0};
>> +             struct strbuf commit_name = STRBUF_INIT;
>> +             char *bad_ref = xstrfmt("refs/bisect/%s",
>> +                                           terms->term_bad);
>> +             int retval = 0;
>> +
>> +             read_ref(bad_ref, sha1);
>> +             commit = lookup_commit_reference(sha1);
>> +             format_commit_message(commit, "%s", &commit_name, &pp);
>> +             fp = fopen(git_path_bisect_log(), "a");
>> +             if (!fp) {
>> +                     retval = -1;
>> +                     goto finish_10;
>> +             }
>> +             if (fprintf(fp, "# first %s commit: [%s] %s\n",
>> +                         terms->term_bad, sha1_to_hex(sha1),
>> +                         commit_name.buf) < 1){
>> +                     retval = -1;
>> +                     goto finish_10;
>> +             }
>> +             goto finish_10;
>> +     finish_10:
>> +             if (fp)
>> +                     fclose(fp);
>> +             strbuf_release(&commit_name);
>> +             free(bad_ref);
>> +             return retval;
>> +     }
>> +     else if (res == 2) {
>> +             FILE *fp = NULL;
>> +             struct rev_info revs;
>> +             struct argv_array rev_argv = ARGV_ARRAY_INIT;
>> +             struct string_list good_revs = STRING_LIST_INIT_DUP;
>> +             struct pretty_print_context pp = {0};
>> +             struct commit *commit;
>> +             char *term_good = xstrfmt("%s-*", terms->term_good);
>> +             int i, retval = 0;
>> +
>> +             fp = fopen(git_path_bisect_log(), "a");
>> +             if (!fp) {
>> +                     retval = -1;
>> +                     goto finish_2;
>> +             }
>> +             if (fprintf(fp, "# only skipped commits left to test\n") < 1) {
>> +                     retval = -1;
>> +                     goto finish_2;
>> +             }
>> +             for_each_glob_ref_in(register_good_ref, term_good,
>> +                                  "refs/bisect/", (void *) &good_revs);
>> +
>> +             argv_array_pushl(&rev_argv, "skipped_commits", "refs/bisect/bad", "--not", NULL);
>> +             for (i = 0; i < good_revs.nr; i++)
>> +                     argv_array_push(&rev_argv, good_revs.items[i].string);
>> +
>> +             /* It is important to reset the flags used by revision walks
>> +              * as the previous call to bisect_next_all() in turn
>> +              * setups a revision walk.
>> +              */
>> +             reset_revision_walk();
>> +             init_revisions(&revs, NULL);
>> +             rev_argv.argc = setup_revisions(rev_argv.argc, rev_argv.argv, &revs, NULL);
>> +             argv_array_clear(&rev_argv);
>> +             string_list_clear(&good_revs, 0);
>> +             if (prepare_revision_walk(&revs))
>> +                     die(_("revision walk setup failed\n"));
>> +
>> +             while ((commit = get_revision(&revs)) != NULL) {
>> +                     struct strbuf commit_name = STRBUF_INIT;
>> +                     format_commit_message(commit, "%s",
>> +                                           &commit_name, &pp);
>> +                     fprintf(fp, "# possible first %s commit: "
>> +                                 "[%s] %s\n", terms->term_bad,
>> +                                 oid_to_hex(&commit->object.oid),
>> +                                 commit_name.buf);
>> +                     strbuf_release(&commit_name);
>> +             }
>> +             goto finish_2;
>> +     finish_2:
>> +             if (fp)
>> +                     fclose(fp);
>> +             string_list_clear(&good_revs, 0);
>> +             argv_array_clear(&rev_argv);
>> +             free(term_good);
>> +             if (retval)
>> +                     return retval;
>> +             else
>> +                     return res;
>> +     }
>> +     return res;
>> +}
>
> It would be much nicer if you put the (res == 10) branch and the
> (res == 2) branch into separate functions and just call them.
> Then you also won't need ugly label naming like finish_10 or finish_2.
> I'd also (again) recommend to use goto fail instead of setting retval to
> -1 separately each time.

Yes, that seems a better way to go! Thanks! :)

> I'd also recommend to use a separate function to append to the bisect
> log file. There is a lot of duplicated opening, checking, closing code;
> IIRC such a function would also already be handy for some of the
> previous patches.

True. I have made that function. Will reuse it here. Thanks! :)

>> +
>> +static int bisect_auto_next(struct bisect_terms *terms, const char *prefix)
>> +{
>> +     if (!bisect_next_check(terms, NULL))
>> +             return bisect_next(terms, prefix);
>> +
>> +     return 0;
>> +}
>
> Hmm, the handling of the return values is a little confusing. However,
> if I understand the sh source correctly, it always returns success, no
> matter if bisect_next failed or not. I do not know if you had something
> special in mind here.

Umm. Shell code used to die() and thus exit with an error code. Thus
it is important to return the exit code. Handling return values was
*very confusing* for me too while writing this commit ;) A lot of
behaviour is changed in this commit regarding return values.

>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>> @@ -643,6 +794,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>                        N_("print out the bisect terms"), BISECT_TERMS),
>>               OPT_CMDMODE(0, "bisect-start", &cmdmode,
>>                        N_("start the bisect session"), BISECT_START),
>> +             OPT_CMDMODE(0, "bisect-next", &cmdmode,
>> +                      N_("find the next bisection commit"), BISECT_NEXT),
>> +             OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
>> +                      N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
>
> The next bisection *state* is found?

checkout is more appropriate. I don't remember why I used "find".

>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index f0896b3..d574c44 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -139,45 +119,7 @@ bisect_state() {
>>       *)
>>               usage ;;
>>       esac
>> -     bisect_auto_next
> [...deleted lines...]
>> +     git bisect--helper --bisect-auto-next || exit
>
> Why is the "|| exit" necessary?

Since it returning exit code, we need to quit, see earlier comment.
Earlier in shell script we used die() but now we are using return
error() thus we need to make it exit here too.

>> @@ -319,14 +260,15 @@ case "$#" in
>>       help)
>>               git bisect -h ;;
>>       start)
>> -             bisect_start "$@" ;;
>> +             git bisect--helper --bisect-start "$@" ;;
>>       bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
>>               bisect_state "$cmd" "$@" ;;
>>       skip)
>>               bisect_skip "$@" ;;
>>       next)
>>               # Not sure we want "next" at the UI level anymore.
>> -             bisect_next "$@" ;;
>> +             get_terms
>> +             git bisect--helper --bisect-next "$@" || exit ;;
>
> Why is the "|| exit" necessary? ;)

Same as before.

>
> Furthermore:
> Where is the bisect_autostart call from bisect_next() sh source gone?
> Was it not necessary?

It is necessary, but I couldn't just incorporate it in one commit. The
functions are called in a circular fashion. Thus I skipped
bisect_autostart() as for now but then when I managed to port
bisect_autostart(), I called that function from this.

Regards,
Pranit Bauva
