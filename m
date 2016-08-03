Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D081F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758371AbcHCUt6 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:49:58 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34349 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcHCUt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:49:56 -0400
Received: by mail-yw0-f174.google.com with SMTP id z8so239088380ywa.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:49:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X5SUKzdIWEtIODtp+wplIaOJTZtnjx+HIQGryPr2MS4=;
        b=Auq8baQ44XXZ5zw0YShYgWtKbC6Q0l/S5qgYkgA2qvEIHRcpUQP6c41LvvIUjRsamV
         uVvXsDOmkTzzHExQgftCzGE88wJn7IysyN5E3hrjnxev+vvZ3lT3VA/oQ4nMOCOXZsiM
         8/rXKPjdYksaSIa474Bo/S0QefBa1mpFeRbs17Y9EuIMOUtEokP3vCoI280ejNnCpAN5
         jtLSSv4quLeuz/kO1ezjWeZ/kXwQWi2rktnDnKICPOZBWuiOrsmhsgQjDyNdCFrogF8T
         gQEH0aEdkqQpOl4uNke8tMIwsDGLe2wPHImGFsNfYyyBT7Z/Lk5+ZgJHY2SwcJGmbIKB
         6GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X5SUKzdIWEtIODtp+wplIaOJTZtnjx+HIQGryPr2MS4=;
        b=EEeUHaIprWjXBQmATuovXLJl502X3syMRqiAWDueGuQPAmvQtl3a338n3s1DThyijG
         KyMaXovlatlubcoFw7XSP2Xy86I3GM7rIVlDaB9XIiAEYIHe9takxsE4zafJ4H12qdxq
         jpLBu8/Gp80bS5sp0CaFS2CkrYLqsT8XjtVolem1Cgzvr4TN8lMphF2PxXJ6C4mmYW0t
         WcZh36/WmxPD/S0mI8xRExEKCaqk7NRRZcrD85uLyamEIruoxLBsWC8DrFOcM3APGEd3
         F7AUN+M7dZWp5rbv5oaSTcu5tJkHMyyUsbRMHcRpaEb9M6aVXh+rFQlbGVDAGVET5CwU
         MPLw==
X-Gm-Message-State: AEkoouv7xcRG4EzPEZ7XmysbS4h3j5eFHIa31YX3a8hwVoxEnmtFxATKX3jfQKZPlEoqtZ6o6oRM8y1oTOVrRA==
X-Received: by 10.129.154.76 with SMTP id r73mr56691559ywg.164.1470257342285;
 Wed, 03 Aug 2016 13:49:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 3 Aug 2016 13:49:01 -0700 (PDT)
In-Reply-To: <xmqqr3a6divf.fsf@gitster.mtv.corp.google.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <0102015640423d18-86d50542-5e5d-40ff-860e-caf56146982d-000000@eu-west-1.amazonses.com>
 <xmqqr3a6divf.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 4 Aug 2016 02:19:01 +0530
Message-ID: <CAFZEwPOv4VHmTKUOunCnri6WsXzyM-8gPLHgbW-LoxqVD1k2-g@mail.gmail.com>
Subject: Re: [RFC/PATCH v11 13/13] bisect--helper: `bisect_start` shell
 function partially in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Wed, Aug 3, 2016 at 1:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int bisect_start(struct bisect_terms *terms, int no_checkout,
>> +                     const char **argv, int argc)
>> +{
>> +     int i, j, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
>> +     int flag;
>> +     struct string_list revs = STRING_LIST_INIT_DUP;
>> +     struct string_list states = STRING_LIST_INIT_DUP;
>> +     struct strbuf start_head = STRBUF_INIT;
>> +     const char *head;
>> +     unsigned char sha1[20];
>> +     FILE *fp;
>> +     struct object_id oid;
>> +
>> +     if (is_bare_repository())
>> +             no_checkout = 1;
>> +
>> +     for(i = 0; i < argc; i++) {
>
> SP after for.

Sure!

>> +             if (!strcmp(argv[i], "--")) {
>> +                     has_double_dash = 1;
>> +                     break;
>> +             }
>> +             if (!strcmp(argv[i], "--term-good")) {
>> +                     must_write_terms = 1;
>> +                     strbuf_reset(&terms->term_good);
>> +                     strbuf_addstr(&terms->term_good, argv[++i]);
>> +                     break;
>> +             }
>> +             if (!strcmp(argv[i], "--term-bad")) {
>> +                     must_write_terms = 1;
>> +                     strbuf_reset(&terms->term_bad);
>> +                     strbuf_addstr(&terms->term_bad, argv[++i]);
>> +                     break;
>> +             }
>
> The original was not careful, either, but what if the user ends the
> command line with "--term-good", without anything after it?

> Also the original is prepared to handle --term-good=boa; because
> this function can be be called directly from the UI (i.e. "git
> bisect start --term-good=boa"), not supporting that form would be
> seen as a regression.


I wanted to discuss this precisely by this RFC. I was initially
thinking of using OPT_ARGUMENT() for bisect_terms() which would in
turn cover up for bisect_start() too. Currently the code does not
support --term-good=boa because it treats --term-good as a boolean Do
you have any other thing in mind?

>> +             if (starts_with(argv[i], "--") &&
>> +                 !one_of(argv[i], "--term-good", "--term-bad", NULL)) {
>> +                     string_list_clear(&revs, 0);
>> +                     string_list_clear(&states, 0);
>> +                     die(_("unrecognised option: '%s'"), argv[i]);
>> +             }
>> +             if (get_oid(argv[i], &oid) || has_double_dash) {
>
> Calling get_oid() alone is insufficient to make sure argv[i] refers
> to an existing object that is a committish.  The "^{commit}" suffix
> in the original is there for a reason.

Yes sure!

>> +                     string_list_clear(&revs, 0);
>> +                     string_list_clear(&revs, 0);
>
> You seem to want the revs list really really clean ;-)

Haha! ;) My bad. Will remove the extra line!

>> +                     die(_("'%s' does not appear to be a valid revision"), argv[i]);
>> +             }
>> +             else
>> +                     string_list_append(&revs, oid_to_hex(&oid));
>> +     }
>> +
>> +     for (j = 0; j < revs.nr; j++) {
>
> Why "j", not "i", as clearly the previous loop has finished at this
> point?  The only reason why replacing "j" with "i" would make this
> function buggy would be if a later part of this function depended on
> the value of "i" when the control left the above loop, but if that
> were the case (I didn't check carefully), such a precious value that
> has long term effect throughout the remainder of the function must
> not be kept in an otherwise throw-away loop counter variable "i".
>
> Introduce a new "int pathspec_pos" and set it to "i" immediately
> after the "for (i = 0; i < argc; i++) { ... }" loop above, perhaps.

I am using i afterwards for writing the arguments to BISECT_NAMES. But
I think it would be better to use pathspec_pos and discard j
altogether. Thanks!
>
>> +             struct strbuf state = STRBUF_INIT;
>> +             /*
>> +              * The user ran "git bisect start <sha1> <sha1>", hence
>> +              * did not explicitly specify the terms, but we are already
>> +              * starting to set references named with the default terms,
>> +              * and won't be able to change afterwards.
>> +              */
>> +             must_write_terms = 1;
>> +
>> +             if (bad_seen)
>> +                     strbuf_addstr(&state, terms->term_good.buf);
>> +             else {
>> +                     bad_seen = 1;
>> +                     strbuf_addstr(&state, terms->term_bad.buf);
>> +             }
>> +             string_list_append(&states, state.buf);
>> +             strbuf_release(&state);
>> +     }
>
> How about this instead?
>
>         /*
>          * that comment block goes here
>          */
>         must_write_terms = !!revs.nr;
>         for (i = 0; i < revs.nr; i++) {
>                 if (bad_seen)
>                         string_list_append(&states, terms->term_good.buf);
>                 else
>                         string_list_append(&states, terms->term_bad.buf);
>         }

Seems better. Thanks!

>> +
>> +     /*
>> +      * Verify HEAD
>> +      */
>> +     head = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
>
> The last parameter is a set of flag bits, so call it flags.

Sure!

>> +     if (!head) {
>> +             if (get_sha1("HEAD", sha1)) {
>> +                     string_list_clear(&revs, 0);
>> +                     string_list_clear(&states, 0);
>> +                     die(_("Bad HEAD - I need a HEAD"));
>
> We see many repeated calls to clear these two string lists before
> exiting with failure, either by dying or return -1.
>
> I wonder how bad the resulting code would look like if we employed
> the standard pattern of having a "fail_return:" label at the end of
> the function (after the "return" for the usual control flow) to
> clear them.  If the result becomes less readable (and I suspect that
> you would end up making it less readable), leaving the current code
> structure is OK.

Its becoming really bad. I tried it once. Different things are being
cleaned up at different times which makes it all the more tedious to
maintain.

>> +             }
>> +     }
>> +     if (!is_empty_or_missing_file(git_path_bisect_start())) {
>> +             /* Reset to the rev from where we started */
>> +             strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>> +             strbuf_trim(&start_head);
>> +             if (!no_checkout) {
>> +                     struct argv_array argv = ARGV_ARRAY_INIT;
>> +                     argv_array_pushl(&argv, "checkout", start_head.buf,
>> +                                      "--", NULL);
>> +                     if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
>> +                             error(_("checking out '%s' failed. Try again."),
>> +                                   start_head.buf);
>
> The original suggests to try "git bisect reset" here to recover.

Will include it.

>> +                             strbuf_release(&start_head);
>> +                             string_list_clear(&revs, 0);
>> +                             string_list_clear(&states, 0);
>> +                             return -1;
>> +                     }
>> +             }
>> +     } else {
>> +             if (starts_with(head, "refs/head/") || !get_oid(head, &oid)) {
>
> get_oid() is insufficient to ensure what you have in $head is
> 40-hex.  I think you meant get_oid_hex() here.

Yes definitely. Might have been missed.

>> +                     /*
>> +                      * This error message should only be triggered by
>> +                      * cogito usage, and cogito users should understand
>> +                      * it relates to cg-seek.
>> +                      */
>> +                     if (!is_empty_or_missing_file(git_path_head_name())) {
>> +                             strbuf_release(&start_head);
>> +                             string_list_clear(&revs, 0);
>> +                             string_list_clear(&states, 0);
>> +                             die(_("won't bisect on cg-seek'ed tree"));
>> +                     }
>> +                     if (starts_with(head, "refs/heads/")) {
>
> skip_prefix(), perhaps, if "head" is no longer used from here on?

Sure!

>> +     /*
>> +      * Write new start state
>> +      */
>> +     fp = fopen(git_path_bisect_start(), "w");
>> +     if (!fp) {
>> +             bisect_clean_state();
>> +             strbuf_release(&start_head);
>> +             string_list_clear(&revs, 0);
>> +             string_list_clear(&states, 0);
>> +             return -1;
>> +     }
>> +     if (!fprintf(fp, "%s\n", start_head.buf)) {
>
> man 3 fprintf and look for "Return Value"?

I should have been more careful about fprintf's return value.

>> +             fclose(fp);
>> +             bisect_clean_state();
>> +             strbuf_release(&start_head);
>> +             string_list_clear(&revs, 0);
>> +             string_list_clear(&states, 0);
>> +             return -1;
>> +     }
>> +     fclose(fp);
>
> Perhaps use write_file() instead of the above block of text?

Yes, that seems better. Thanks!

>> +     if (no_checkout) {
>> +             get_oid(start_head.buf, &oid);
>> +             if (update_ref(NULL, "BISECT_HEAD", oid.hash, NULL, 0,
>> +                            UPDATE_REFS_MSG_ON_ERR)) {
>
> Doesn't the original use --no-deref for this update-ref call?

Yes, will change.

>> +                     bisect_clean_state();
>> +                     strbuf_release(&start_head);
>> +                     string_list_clear(&revs, 0);
>> +                     string_list_clear(&states, 0);
>> +                     return -1;
>> +             }
>> +     }
>> +     strbuf_release(&start_head);
>> +     fp = fopen(git_path_bisect_names(), "w");
>> +
>> +     for (; i < argc; i++) {
>> +             if (!fprintf(fp, "%s ", argv[i])) {
>
> man 3 fprintf and look for "Return Value"?
>
> More importantly, the original does --sq-quote so that BISECT_NAMES
> file can be read back by a shell.  This is important as argv[i] can
> have whitespace in it, and you are concatenating them with SP in
> between here.  Also you are not terminating that line.

Yes its a good idea to retain its --sq-quote nature.

>> +                     fclose(fp);
>> +                     bisect_clean_state();
>> +                     string_list_clear(&revs, 0);
>> +                     string_list_clear(&states, 0);
>> +                     return -1;
>> +             }
>> +     }
>> +     fclose(fp);
>
> Perhaps
>
>         strbuf_reset(&bisect_names);
>         if (pathspec_pos < argc)
>                 sq_quote_argv(&bisect_names, argv + pathspec_pos, 0);
>         write_file(git_path_bisect_names(), "%s\n", bisect_names.buf);
>
> or something like that?

Yes! Thanks! Looks pretty good to me.

>> +     for (j = 0; j < states.nr; j ++) {
>
> Again, is "i" still precious here?  Style: drop SP between j and ++.

After BISECT_NAMES, "i" ceases to be precious.

>> +     fp = fopen(git_path_bisect_log(), "a");
>> +     if (!fp) {
>> +             bisect_clean_state();
>> +             return -1;
>> +     }
>> +     if (!fprintf(fp, "git bisect start")) {
>> +             bisect_clean_state();
>> +             return -1;
>> +     }
>> +     for (i = 0; i < argc; i++) {
>> +             if (!fprintf(fp, " '%s'", argv[i])) {
>> +                     fclose(fp);
>> +                     bisect_clean_state();
>> +                     return -1;
>> +             }
>> +     }
>> +     if (!fprintf(fp, "\n")) {
>> +             fclose(fp);
>> +             bisect_clean_state();
>> +             return -1;
>> +     }
>
> Again, the original writes orig_args which was protected with --sq-quote.

Yes. Will take care of it.

>> +     fclose(fp);
>> +
>> +     return 0;
>> +}
>> +

Regards,
Pranit Bauva
