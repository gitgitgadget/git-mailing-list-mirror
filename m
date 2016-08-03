Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE67C1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758315AbcHCUrb (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:47:31 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35112 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758326AbcHCUr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:47:29 -0400
Received: by mail-yw0-f196.google.com with SMTP id r9so17609065ywg.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:46:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lY16Vv164sQLfQ5WvBsUkvK/eN6hquc9zsY8yK/bdQA=;
        b=l4kBo9mImgc+G45mehJWHQTiZWUYEGvl2uZS4Z71mZsYo/CnUcgF9MvZeHHd5A45vt
         2ikXGx3cSUYWfJtG/KGZQbE8Igzkw7vDTzzcFKoxTM/h4/EltQrd7JXx/JoBLIjGxdJK
         pD006krwEdM+/TTOJNjEKQzJFcVjUtLUcQBjz+NmpqwTxP/pN80YttZ5MIMMxYMIZ402
         zAj15OtRdMDq+F3JLoJjZvWG7qARNbDuKPsYd4a+jYJwIC7y+sNHgoWmC0cCAwkQMgW5
         KrrqSrmCiuuBoZpGyJnmKn+amAEm0Bh2QDv8u9TVyVHgga13w1Xi+vA1Bgdoypf6t/ja
         Qoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lY16Vv164sQLfQ5WvBsUkvK/eN6hquc9zsY8yK/bdQA=;
        b=OFD+tlD1W19MH7m3auACyu2mZzGyNr01+xn13OJxFB+bh30ZBd9V+HS/8W0vcJX4tF
         upKEEkPZfUWh+lT4rUpE/Gpoo5P4Rp3H/h26A32MOo9YHTAwe0VHVMLUb98eb8T7WnXL
         62QWbg0bXA5qBrzHyd3JScL3U/UYpGFvk5jtPr9UISRPMVOyJGq55XAyvViGDvKce/DY
         LxJdYZSS/PTNOfHsraREd6IHZtO4KGFplqBzP4fPifxWV0r6rqEIXeMNyF8LwWthlh2o
         bA1eX1m3eB0p+LKWCsPHwNtgHJN2L7j1tZ6B1vKWrUQ3n4aYAncjzJh6Qn+m7agxSwMM
         zBtw==
X-Gm-Message-State: AEkoouvlbFWvjjgwb8K/PKeNI3GyS+fVZDnx3Ou9AUVdStbpGvog7jLds2tuepL+wOHvSoNdiwHHgIgsEKOQog==
X-Received: by 10.37.216.80 with SMTP id p77mr47750733ybg.21.1470256413278;
 Wed, 03 Aug 2016 13:33:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 3 Aug 2016 13:33:32 -0700 (PDT)
In-Reply-To: <xmqq60rjdlq4.fsf@gitster.mtv.corp.google.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <0102015640423d08-3af7e66f-4104-4b0c-a3c7-dff29b843b2d-000000@eu-west-1.amazonses.com>
 <xmqq60rjdlq4.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 4 Aug 2016 02:03:32 +0530
Message-ID: <CAFZEwPPOn5tRk1MWaGJ5NHakNvtv7W0QfDAYDh+hzn8xLPA1NA@mail.gmail.com>
Subject: Re: [RFC/PATCH v11 11/13] bisect--helper: `bisect_next_check` shell
 function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Wed, Aug 3, 2016 at 12:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int mark_good(const char *refname, const struct object_id *oid,
>> +                  int flag, void *cb_data)
>> +{
>> +     int *m_good = (int *)cb_data;
>> +     *m_good = 0;
>> +     return 0;
>> +}
>
> See below.
>
>> +static int bisect_next_check(const struct bisect_terms *terms,
>> +                          const char *current_term)
>> +{
>> +     int missing_good = 1, missing_bad = 1;
>
> It is somewhat unusual to start with "assume we are OK" and then
> "it turns out that we are not".
>
>> +     char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad.buf);
>> +     char *good_glob = xstrfmt("%s*", terms->term_good.buf);
>
> The original runs
>
>     git for-each-ref "refs/bisect/$TERM_GOOD-*
>
> but this one lacks the final dash.

My bad. Will include it.

>> +     if (ref_exists(bad_ref))
>> +             missing_bad = 0;
>> +     free(bad_ref);
>> +
>> +     for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
>> +                          (void *) &missing_good);
>> +     free(good_glob);
>
> The for-each helper does not return until it iterates over all the
> matching refs, but you are only interested in seeing if at least one
> exists.  It may make sense to return 1 from mark_good() to terminate
> the traversal early.

Seems a better way. Thanks!

>> +     if (!missing_good && !missing_bad)
>> +             return 0;
>> +
>> +     if (!current_term)
>> +             return -1;
>> +
>> +     if (missing_good && !missing_bad && current_term &&
>> +         !strcmp(current_term, terms->term_good.buf)) {
>> +             char *yesno;
>> +             /*
>> +              * have bad (or new) but not good (or old). We could bisect
>> +              * although this is less optimum.
>> +              */
>> +             fprintf(stderr, "Warning: bisecting only with a %s commit\n",
>> +                     terms->term_bad.buf);
>
> In the original, this message goes through gettext.

Will do.

>> +             if (!isatty(0))
>> +                     return 0;
>> +             /*
>> +              * TRANSLATORS: Make sure to include [Y] and [n] in your
>> +              * translation. The program will only accept English input
>> +              * at this point.
>> +              */
>> +             yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
>> +             if (starts_with(yesno, "N") || starts_with(yesno, "n"))
>> +                     return -1;
>> +             return 0;
>> +     }
>
> When the control falls into the above if(){} block, the function
> will always return.  It will clarify that this is the end of such a
> logical block to have a blank line here.

Will do.

>> +     if (!is_empty_or_missing_file(git_path_bisect_start()))
>> +             return error(_("You need to give me at least one good|old and "
>> +                             "bad|new revision. You can use \"git bisect "
>> +                             "bad|new\" and \"git bisect good|old\" for "
>> +                             "that. \n"));
>> +     else
>> +             return error(_("You need to start by \"git bisect start\". "
>> +                             "You then need to give me at least one good|"
>> +                             "old and bad|new revision. You can use \"git "
>> +                             "bisect bad|new\" and \"git bisect good|old\" "
>> +                             " for that.\n"));
>
> The i18n on these two messages seem to be different from the
> original, which asks bisect_voc to learn what 'bad' and 'good' are
> called and attempts to use these words from the vocabulary.

I have little idea about i18n. Will look more into it.

Regards,
Pranit Bauva
