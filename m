Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C9C1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 18:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbcH3SZn (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 14:25:43 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:36520 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbcH3SZm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 14:25:42 -0400
Received: by mail-yb0-f170.google.com with SMTP id 125so9341247ybe.3
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PTsisXeBYiNj0aPZBYskWL+BpgjS4ev3LMOJf0bRUSQ=;
        b=jkfFA6Y4g1sTX6trz1aMv0xyOEKDg7j36sgXE8Uo1DNR50C9SgoUsT0QNs3z2WqWMg
         OOQfb1t4Cxj+2fVk2bdnYh2Un/emjn1MfTXu3ohvho473pjRbqhJQPruinljBjrlyFGI
         yutaYxEoIbNftGazKBNbbHVCea4bNY1IuiXjFDQyA51/nKaNPQ/vpCLmMNkKvYskXlHU
         u6e6ZnTqHY6iHd/orsVMxExQIZioR+yMiIAaRPyHyj1uNvvFGCLHOsmwS9X3v5Y4ZINs
         pJm6Mknw1aMfkinirYy1d7OFwiCjubAvyhB7wYitJtWKse9eBobv1u3Bg7lAeoghi92b
         ch6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PTsisXeBYiNj0aPZBYskWL+BpgjS4ev3LMOJf0bRUSQ=;
        b=QhM1YMKvIVUKZeo3zo9GWoPLAFNAkP92OHZ8JeFF9shnwbEEQEIBb4wLBGBF6R+D4W
         okOWzGTfMC9E636HsiuliADyFwIX2864UfE2Tg+vyMMQMe3VP7UqZBH85uuBieug84wt
         uVeVjqHR0MfxCqCEBQeDAVpNuV1H5XUriyTD4Pq2kzY5cxZnB4mOeIsD+UXxVza0LdAC
         jgDgyVLjE/9EPADTNZ87pPa3tn4Lo7zvO4/5Imle1WmuAT6U8nczm17cbintTTrVgpYS
         LTLIVHtKZxjr9kbxOHliZICiD5+S0obQsfXcwtDIUGUDguZm8cvD39cryzZam6MmYWZ9
         KLuQ==
X-Gm-Message-State: AE9vXwNLXXArxOmPV1mftc/CDer47VwYoWAt6uVFzp4mDAuKGW/0P8YhMVhjBFbK2MRVvBT+3v4K7ulKKTadOA==
X-Received: by 10.37.96.69 with SMTP id u66mr4429356ybb.7.1472581540968; Tue,
 30 Aug 2016 11:25:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Tue, 30 Aug 2016 11:25:40 -0700 (PDT)
In-Reply-To: <xmqq37lsmw15.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe6ce-3b204354-849b-40fd-93ff-2ebcf77df91c-000000@eu-west-1.amazonses.com>
 <xmqq37lsmw15.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Tue, 30 Aug 2016 23:55:40 +0530
Message-ID: <CAFZEwPP-c00aNvDKoQFiCf_-tqrP3tAwwU6KAnswfMkjyoP3QQ@mail.gmail.com>
Subject: Re: [PATCH v14 14/27] bisect--helper: `bisect_next` and
 `bisect_auto_next` shell function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a1143ebcca77efb053b4e1b36
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a1143ebcca77efb053b4e1b36
Content-Type: text/plain; charset=UTF-8

Hey Junio,

Sorry for a late replay.

On Fri, Aug 26, 2016 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> A lot of parts of bisect.c uses exit() and these signals are then
>> trapped in the `bisect_start` function. Since the shell script ceases
>> its existence it would be necessary to convert those exit() calls to
>> return statements so that errors can be reported efficiently in C code.
>
> Is efficiency really an issue?  I think the real reason is that it
> would make it impossible for the callers to handle errors, if you do
> not convert and let the error codepaths exit().

I think I put the word "efficiently" wrongly over here. Will omit it.

>> @@ -729,7 +735,7 @@ static struct commit **get_bad_and_good_commits(int *rev_nr)
>>       return rev;
>>  }
>>
>> -static void handle_bad_merge_base(void)
>> +static int handle_bad_merge_base(void)
>>  {
>>       if (is_expected_rev(current_bad_oid)) {
>>               char *bad_hex = oid_to_hex(current_bad_oid);
>> @@ -750,17 +756,18 @@ static void handle_bad_merge_base(void)
>>                               "between %s and [%s].\n"),
>>                               bad_hex, term_bad, term_good, bad_hex, good_hex);
>>               }
>> -             exit(3);
>> +             return 3;
>>       }
>>
>>       fprintf(stderr, _("Some %s revs are not ancestor of the %s rev.\n"
>>               "git bisect cannot work properly in this case.\n"
>>               "Maybe you mistook %s and %s revs?\n"),
>>               term_good, term_bad, term_good, term_bad);
>> -     exit(1);
>> +     bisect_clean_state();
>> +     return 1;
>
> What is the logic behind this function sometimes clean the state,
> and some other times do not, when it makes an error-return?  We see
> above that "return 3" codepath leaves the state behind.
>
> Either you forgot a necessary clean_state in "return 3" codepath,
> or you forgot to document why the distinction exists in the in-code
> comment for the function.  I cannot tell which, but I am leaning
> towards guessing that it is the former.

This is a very tricky one. I have purposely not included this after a
lot of testing. I have hand tested with the original git and with this
branch. The reason why anyone wouldn't be able to catch this is
because its not covered in the test suite. I am including a patch with
this as an attachment (because I am behind a proxy right now but don't
worry I will include this as a commit in the next series). The
original behaviour of git does not clean the bisect state when this
situation occurs. On another note which you might have missed that
bisect_clean_state() is purposely put before return 1 which is covered
by the test suite. You can try removing it and see that there is a
broken tes. tI was thinking of including the tests after the whole
conversion but now I think including this before will make the
conversion more easier for review.

>> -static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
>> +static int check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
>>  {
>>       char *filename = git_pathdup("BISECT_ANCESTORS_OK");
>>       struct stat st;
>> -     int fd;
>> +     int fd, res = 0;
>>
>>       if (!current_bad_oid)
>>               die(_("a %s revision is needed"), term_bad);
>
> Can you let it die yere?

Not really. I should change it to return error().

>> @@ -873,8 +890,11 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
>>                             filename);
>>       else
>>               close(fd);
>> +
>> +     return 0;
>>   done:
>>       free(filename);
>> +     return 0;
>>  }
>
> Who owns "filename"?  The first "return 0" leaves it unfreed, and
> when "goto done" is done, it is freed.
>
> The above two may indicate that "perhaps 'retval + goto finish'
> pattern?" is a really relevant suggestion for the earlier steps in
> this series.

Yes.

>>       if (!all) {
>>               fprintf(stderr, _("No testable commit found.\n"
>>                       "Maybe you started with bad path parameters?\n"));
>> -             exit(4);
>> +             return 4;
>>       }
>>
>>       bisect_rev = revs.commits->item->object.oid.hash;
>>
>>       if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
>> -             exit_if_skipped_commits(tried, current_bad_oid);
>> +             res = exit_if_skipped_commits(tried, current_bad_oid);
>> +             if (res)
>> +                     return res;
>> +
>>               printf("%s is the first %s commit\n", sha1_to_hex(bisect_rev),
>>                       term_bad);
>>               show_diff_tree(prefix, revs.commits->item);
>>               /* This means the bisection process succeeded. */
>> -             exit(10);
>> +             return 10;
>>       }
>>
>>       nr = all - reaches - 1;
>> @@ -1005,7 +1033,11 @@ int bisect_next_all(const char *prefix, int no_checkout)
>>                 "Bisecting: %d revisions left to test after this %s\n",
>>                 nr), nr, steps_msg);
>>
>> -     return bisect_checkout(bisect_rev, no_checkout);
>> +     res = bisect_checkout(bisect_rev, no_checkout);
>> +     if (res)
>> +             bisect_clean_state();
>> +
>> +     return res;
>>  }
>
> There were tons of "exit_if" that was converted to "if (res) return
> res" above, instead of jumping here to cause clean_state to be
> called.  I cannot tell if this new call to clean_state() is wrong,
> or all the earlier "return res" should come here.  I am guessing the
> latter.

No I don't think its wrong. It is advised in the comment
    In case of mistaken revs or checkout error, or signals received,
    "bisect_auto_next" below may exit or misbehave.
    We have to trap this to be able to clean up using
    "bisect_clean_state".

to clean the bisection state *iff checkout fails* otherwise not.
Luckily this is already covered by the test suite. I think what you
meant is that bisect_clean_state() might be covered elsewhere too then
why perform cleanup here, right? bisect_clean_state() have been
carefully put where ever required only.

>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index c64996a..ef7b3a1 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -8,6 +8,7 @@
>>  #include "run-command.h"
>>  #include "prompt.h"
>>  #include "quote.h"
>> +#include "revision.h"
>>
>>  static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
>>  static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
>> @@ -29,6 +30,8 @@ static const char * const git_bisect_helper_usage[] = {
>>       N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
>>       N_("git bisect--helper --bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
>>                                             "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
>> +     N_("git bisect--helper --bisect-next"),
>> +     N_("git bisect--helper --bisect-auto-next"),
>>       NULL
>>  };
>>
>> @@ -396,6 +399,129 @@ static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
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
>> +     /* In case of mistaken revs or checkout error, or signals received,
>
> That's an unbalanced comment.  You end the block with "*/" on its
> own line, so you should start the block with "/*" on its own line.
> There seems to be at least one more such comment in this patch but I
> won't repeat.

I shall change this.

>> +      * "bisect_auto_next" below may exit or misbehave.
>> +      * We have to trap this to be able to clean up using
>> +      * "bisect_clean_state".
>> +      */
>
> "exit" meaning "call exit() to terminate the process", or something
> else?  If the latter, don't say "exit", but say "return error".

Yes I think its necessary to change "exit" in comments to "return".
There are other places too in which I will have to change.

>> +     if (bisect_next_check(terms, terms->term_good.buf))
>> +             return -1;
>
> Mental note.  The "autostart" in the original is gone.  Perhaps it
> is done by next_check in this code, but we haven't seen that yet.

This will be added back again in a coming patch[1].

>> +     no_checkout = !is_empty_or_missing_file(git_path_bisect_head());
>> +
>> +     /* Perform all bisection computation, display and checkout */
>> +     res = bisect_next_all(prefix , no_checkout);
>> +
>> +     if (res == 10) {
>> +             FILE *fp;
>> +             unsigned char sha1[20];
>> +             struct commit *commit;
>> +             struct pretty_print_context pp = {0};
>> +             struct strbuf commit_name = STRBUF_INIT;
>> +             char *bad_ref = xstrfmt("refs/bisect/%s",
>> +                                           terms->term_bad.buf);
>> +             read_ref(bad_ref, sha1);
>> +             commit = lookup_commit_reference(sha1);
>> +             format_commit_message(commit, "%s", &commit_name, &pp);
>> +             fp = fopen(git_path_bisect_log(), "a");
>> +             if (!fp) {
>> +                     free(bad_ref);
>> +                     strbuf_release(&commit_name);
>> +                     return -1;
>> +             }
>> +             if (fprintf(fp, "# first %s commit: [%s] %s\n",
>> +                         terms->term_bad.buf, sha1_to_hex(sha1),
>> +                         commit_name.buf) < 1){
>> +                     free(bad_ref);
>> +                     strbuf_release(&commit_name);
>> +                     fclose(fp);
>> +                     return -1;
>> +             }
>> +             free(bad_ref);
>> +             strbuf_release(&commit_name);
>> +             fclose(fp);
>> +             return 0;
>
> Doesn't it bother you that you have to write free(bad_ref)...fclose(fp)
> repeatedly?

My mind was more involved in the actual conversion and that was the
main part bothering me. I did all the "clean up" stuff after I did the
actual conversion. And since I was extremely happy after the porting
happened, the "cleanup stuff" didn't bother me much.

>> +     }
>> +     else if (res == 2) {
>> +             FILE *fp;
>> +             struct rev_info revs;
>> +             struct argv_array rev_argv = ARGV_ARRAY_INIT;
>> +             struct string_list good_revs = STRING_LIST_INIT_DUP;
>> +             struct pretty_print_context pp = {0};
>> +             struct commit *commit;
>> +             char *term_good = xstrfmt("%s-*", terms->term_good.buf);
>> +             int i;
>> +
>> +             fp = fopen(git_path_bisect_log(), "a");
>> +             if (!fp) {
>> +                     free(term_good);
>> +                     return -1;
>> +             }
>> +             if (fprintf(fp, "# only skipped commits left to test\n") < 1) {
>> +                     free(term_good);
>> +                     fclose(fp);
>> +                     return -1;
>> +             }
>> +             for_each_glob_ref_in(register_good_ref, term_good,
>> +                                  "refs/bisect/", (void *) &good_revs);
>> +
>> +             free(term_good);
>
> Doesn't it bother you that you have to write free(term_good) repeatedly?
>
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
>
> Are you sure that the revision walking machinery is prepared to see
> the argv[] and elements in it you have given to setup_revisions()
> gets cleared before it starts doing the real work in
> prepare_revision_walk()?  I am reasonably sure that the machinery
> borrows strings like pathspec elements from the caller and expects
> them to stay during revision traversal.

I have extremely little understanding of revision walking. All what I
know about revision walking is what's covered in
Documentation/technical/api-revision-walking.txt . There it is
mentioned that for multiple revision walking its necessary to reset.
What's happening is that there are multiple calls for revision
walking. Now bisect_next() in itself calls for revision walking two
times (the first one being with bisect_next_all and the next one
conditionally with skip).  This is also the reason why I included a
reset_revision_walk() in bisect.c too in this patch. Before what used
to happen is that when git plumbing commands were called there was no
previous need for resetting the revision walk.  Now that only a C code
exists after bisect_replay() conversion (I faced a problem in a
futuristic patch and thought it would be better to cover it up here),
there would be multiple calls to bisect_next(). Previously it wasn't a
problem because bisect_next_all() was a subcommand called from shell
script and for "skip" it was git-rev-list which did revision walking
as a separate thing. I didn't do reset previously and because of this
I used to get a NULL value in the revs.commits . It would be really
helpful if you could look more into it.

> You seem to have acquired a habit of freeing and clearing things
> early, which is bad.  Instead, make it a habit of free/clear at the
> end, and make sure all error paths go through that central freeing
> site.  That tends to future-proof your code better from leaking even
> when later other people change it.

Sure!

>> +             if (prepare_revision_walk(&revs)) {
>> +                     die(_("revision walk setup failed\n"));
>> +             }
>
> This one is still allowed to die, without clean_state?

I couldn't really test this part of code because I don't know how to
make this call fail. And this isn't covered by the test suite either.
BTW, here also it should be return error().

>> +             while ((commit = get_revision(&revs)) != NULL) {
>> +                     struct strbuf commit_name = STRBUF_INIT;
>> +                     format_commit_message(commit, "%s",
>> +                                           &commit_name, &pp);
>> +                     fprintf(fp, "# possible first %s commit: "
>> +                                 "[%s] %s\n", terms->term_bad.buf,
>> +                                 oid_to_hex(&commit->object.oid),
>> +                                 commit_name.buf);
>> +                     strbuf_release(&commit_name);
>> +             }
>> +
>> +             fclose(fp);
>> +             return res;
>> +     }
>> +
>> +     return res;
>> +}
>
>> @@ -415,47 +541,67 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
>>               no_checkout = 1;
>>
>>       for (i = 0; i < argc; i++) {
>> -             if (!strcmp(argv[i], "--")) {
>> +             const char *arg;
>> +             if (starts_with(argv[i], "'"))
>> +                     arg = sq_dequote(xstrdup(argv[i]));
>> +             else
>> +                     arg = argv[i];
>> +             if (!strcmp(arg, "--")) {
>>                       has_double_dash = 1;
>>                       break;
>>               }
>>       }
>
> This is really bad; you are blindly assuming that anything that
> begins with " ' " begins with " ' " because "git-bisect.sh" sq-quoted
> and it never directly came from the command line that _wanted_ to
> give you something that begins with a " ' ".
>
> I suspect that you should be able to dequote on the calling script
> side.  Then all these ugliness would disappear.

I had an unsuccessful attempt at it. Though this ugliness is removed
in the patch[2]. This is specifically because of the line in
bisect_replay() shell function which calls bisect_start().

>>       for (i = 0; i < argc; i++) {
>> -             const char *commit_id = xstrfmt("%s^{commit}", argv[i]);
>> +             const char *arg, *commit_id;
>> +             if (starts_with(argv[i], "'"))
>> +                     arg = sq_dequote(xstrdup(argv[i]));
>> +             else
>> +                     arg = argv[i];
>
> Likewise.
>
>> +             commit_id = xstrfmt("%s^{commit}", arg);
>
> In any case, I think a separate "const char *arg" that is an alias
> to argv[i] in the loop is a very good idea to do from the very
> beginning (i.e. should be done in a much much earlier patch in this
> series).

I will do it in the earlier patch.

[1]: http://public-inbox.org/git/01020156b73fe6d7-8b80c663-7c77-469e-811f-40200ec6dbb1-000000@eu-west-1.amazonses.com/
[2]: https://public-inbox.org/git/01020156b73fe6e4-d45cf1f7-03a3-4566-95d1-73788c5ab2f9-000000@eu-west-1.amazonses.com/

Regards,
Pranit Bauva

--001a1143ebcca77efb053b4e1b36
Content-Type: application/octet-stream; name=out2
Content-Disposition: attachment; filename=out2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ishstbdt0

ZGlmZiAtLWdpdCBhL3QvdDYwMzAtYmlzZWN0LXBvcmNlbGFpbi5zaCBiL3QvdDYwMzAtYmlzZWN0
LXBvcmNlbGFpbi5zaAppbmRleCAxOGU3OTk4Li5mZmQ2NmIxIDEwMDc1NQotLS0gYS90L3Q2MDMw
LWJpc2VjdC1wb3JjZWxhaW4uc2gKKysrIGIvdC90NjAzMC1iaXNlY3QtcG9yY2VsYWluLnNoCkBA
IC05MTEsNCArOTExLDEyIEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2dpdCBiaXNlY3QgcmVzZXQg
Y2xlYW5zIGJpc2VjdGlvbiBzdGF0ZSBwcm9wZXJseScgJwogCXRlc3RfcGF0aF9pc19taXNzaW5n
ICIkR0lUX0RJUi9CSVNFQ1RfU1RBUlQiCiAnCiAKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2NoZWNr
IHdoZXRoZXIgYmlzZWN0aW9uIGNsZWFudXAgaXMgbm90IGRvbmUgd2l0aCBiYWQgbWVyZ2UgYmFz
ZXMnICcKKwlIRUFEPSQoZ2l0IHJldi1wYXJzZSAtLXZlcmlmeSBIRUFEKSAmJgorCWdpdCBiaXNl
Y3Qgc3RhcnQgJEhBU0g3ICRTSURFX0hBU0g3ICYmCisJdGVzdF9leHBlY3RfY29kZSAzIGdpdCBi
aXNlY3QgYmFkID5vdXQgMj5vdXQgJiYKKwl0ZXN0X2kxOG5ncmVwICJUaGUgbWVyZ2UgYmFzZSAi
IG91dCAmJgorCXRlc3QgLWUgLmdpdC9CSVNFQ1RfU1RBUlQgJiYKKycKKwogdGVzdF9kb25lCg==
--001a1143ebcca77efb053b4e1b36--
