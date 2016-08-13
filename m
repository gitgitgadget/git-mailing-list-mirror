Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B83420193
	for <e@80x24.org>; Sat, 13 Aug 2016 06:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbcHMGe0 (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 02:34:26 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34405 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbcHMGeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 02:34:25 -0400
Received: by mail-yw0-f195.google.com with SMTP id j12so313960ywb.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 23:32:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8+/saxdP0V3GfafgSKe374VNmTONp/x2pWLHSq1MZGg=;
        b=JTcM16OXRx4yb3C23zgXnodsMQ5hma9Qqm0w0XWoPoHcKvVFurwyPGvq0lKMi21hqc
         ZFsNZR4O9NQCGc5p7EflAt5c3QSq9sfRQCDmVZ98ad73TRBmuvKFAhOP5akjU66bvuHh
         eoLnlroTD5vqVIT2jMS8JBvcXi4GvoFoRi59c85cPGFzHPknYscOrxYVb4NZWb5zLjYO
         izh23DicOO33WhzjMlUbhgqL5OfW1YU4/k3CRIvl7hC2fK0cWqQzgF3KeOS0U2EPApfb
         1UD3cHHCdn+ajSwXS33ABkV9ESZN4PuUyquAc6Q77mBJnXBw8QFAT5/RteVspob0/50v
         w4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8+/saxdP0V3GfafgSKe374VNmTONp/x2pWLHSq1MZGg=;
        b=diX4U8ZqwJ87ASebbOyeJW72tRpFf5OwMVt9hrOUDRukF4gA4KuWXK6BfQrzz4im3R
         pFyfC/DXySNsOyHN6phfLTqcABV5SBgGFKMSyk4fIVy9aVYE55bEmlWjH6cQl5wBEd67
         laXAIBYBfWt6metb4Sq/drk91KSDmdTJB8DWwrmfj8bXCytx+Mz9A5Mc6KpBkNGMezn1
         Hw9ckcWDbvVUG7jK/xAU0lr/s4e6BrtOI2HA+h2OBPllvFJ8DVLgp48qMWLmtyaw3ADY
         AExkdD2tANOGMAIBVvRNCvWjf2Obfg8zD8z0WLGWDSdEgye7+aAFSFYigj/0GP8qVgLh
         9ONg==
X-Gm-Message-State: AEkoouvpP84wa3R3+KDRQC/bHgWeZ7o8eLlrEEy3+YpK07QWltP3w9XoGknql2AYept5w8//20g9Ng4FCykygA==
X-Received: by 10.129.136.5 with SMTP id y5mr14183259ywf.30.1471069969883;
 Fri, 12 Aug 2016 23:32:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Fri, 12 Aug 2016 23:32:49 -0700 (PDT)
In-Reply-To: <xmqqpopdx1on.fsf@gitster.mtv.corp.google.com>
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
 <010201567675ae68-15d79b9a-83fc-44ee-8607-07c2d0191c59-000000@eu-west-1.amazonses.com>
 <xmqq1t1tyi0z.fsf@gitster.mtv.corp.google.com> <xmqqpopdx1on.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Sat, 13 Aug 2016 12:02:49 +0530
Message-ID: <CAFZEwPMw-cWnHnHGLgCkD8LKshc-irV9p2PV9s9Nk61QWKdrfQ@mail.gmail.com>
Subject: Re: [PATCH v12 11/13] bisect--helper: `bisect_next_check` &
 bisect_voc shell function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Sat, Aug 13, 2016 at 12:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>
>>> +static int bisect_next_check(const struct bisect_terms *terms,
>>> +                         const char *current_term)
>>> +{
>>> + ....
>>> +            fprintf(stderr, N_("Warning: bisecting only with a %s commit\n"),
>>> +                    terms->term_bad.buf);
>>
>> Hmph, is this N_() and not _()?
>
> I recall you saying that you are not familiar with i18n.  As it is a
> good skill to have outside the context of this project, let's do a
> quick primer. GSoC is a learning experience ;-).

True! :)

> There is a runtime function "gettext()" that takes a string, which
> is typically a printf format string, and gives another string.  You
> feed your message in the original language, meant to be used in the
> C locale, and the function gives it translated into the end-user's
> language, specified by environment variables like $LC_MESSAGES.
>
> Since it is too cumbersome to write gettext() all the time, _()
> exists as a short-hand for it.  So running this
>
>         printf(_("Hello, world\n"));
>
> would look up "Hello world\n" in database for the end-user's
> language, and shows the translated message instead.
>
> By scanning the source text, you can extract these constant strings
> passed to gettext() or _().  This is done by the i18n coordinator
> with the "msgmerge" program.  By doing so, we learn "Hello, world\n"
> must be translated, and then ask i18n team to translate it to their
> language.  The result is what we have in the l10n database.  They
> are in po/*.po files in our source tree.
>
> Sometimes, the message you want to be translated may be in a
> variable, e.g.
>
>         void greeting(const char *message)
>         {
>                 printf(_(message));
>         }
>
>         int main(int ac, char **av)
>         {
>                 int i;
>                 const char *message[] = {
>                         "Hello, world\n",
>                         "Goodbye, everybody\n",
>                 };
>                 for (i = 0; i < ARRAY_SIZE(message); i++)
>                         greeting(message[i]);
>         }
>
> And scanning the source would not find "Hello, world\n" or "Goodby,
> everybody\n" must be translated.  We do not want to do this:
>
>                 ...
>                 const char *message[] = {
> *BAD*                   _("Hello, world\n"),
> *BAD*                   _("Goodbye, everybody\n"),
>                 };
>                 ...
>
> because we do *NOT* want to call gettext() there (we call the
> function at runtime inside greeting() instead).  We use N_()
> to mark such messages, like so:
>
>                 ...
>                 const char *message[] = {
> *GOOD*                  N_("Hello, world\n"),
> *GOOD*                  N_("Goodbye, everybody\n"),
>                 };
>                 ...
>
> The N_() macro is a no-op at runtime.  It just is there so that
> "msgmerge" can notice that the constant string there is something
> that needs to be thrown into the l10n database.
>
> As a concrete example:
>
>> @@ -24,6 +25,7 @@ static const char * const git_bisect_helper_usage[] = {
>>       N_("git bisect--helper --bisect-reset [<commit>]"),
>>       N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
>>       N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
>> +     N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
>>       NULL
>>  };
>
> this is such a use of N_().  You want to keep untranslated message
> in the git_bisect_helper_usage[] array, to be given to gettext(), or
> more likely its short-hand _(), when these usage strings are used,
> and make sure these strings will be in the l10n database so that
> translators will give you translations to them to be used at
> runtime.
>
>> +             /*
>> +              * have bad (or new) but not good (or old). We could bisect
>> +              * although this is less optimum.
>> +              */
>> +             fprintf(stderr, N_("Warning: bisecting only with a %s commit\n"),
>> +                     terms->term_bad.buf);
>
> This one wants to call gettext() function to give fprintf() the
> translated warning message.  It should be _().
>
>> +             /*
>> +              * TRANSLATORS: Make sure to include [Y] and [n] in your
>> +              * translation. The program will only accept English input
>> +              * at this point.
>> +              */
>> +             yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
>
> Just like this one.

Thanks a lot for taking time to explain this. I had searched a bit but
couldn't find the difference between _() and N_()!

Regards,
Pranit Bauva
