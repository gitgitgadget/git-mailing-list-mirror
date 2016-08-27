Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0AD52018E
	for <e@80x24.org>; Sat, 27 Aug 2016 09:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754928AbcH0JfI (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 05:35:08 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35058 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbcH0JfH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 05:35:07 -0400
Received: by mail-yw0-f173.google.com with SMTP id j12so61867095ywb.2
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m9ai4xNC16USLpHMuZWuw+gWvofBhz1RFkiA/VBr+Do=;
        b=CPoFlrZ7gFdAUNVlq4Hw8TPThBUa5WzZkJrNygRt4u+dwn2jl1baxbPxNOzg6F3IMW
         C32mJ7g+b0X6jdCuHx1HAIVNlGijG2m4IYnCBb9VgcKABgXvZ+ieI8v7XVHt+LQid3Ra
         DInfBQ2JPVB5DN/RtWR8OV9QDg9+gYiHn0w1lqgGTjCRI4nPe46/kGiRjOu4J+JYYhgD
         UlfFoPCDpN5lhv3yFHY42o+9WseRy5qhO01s2Y9c0ibX2JqeIsf21r037QCCTa8Os00u
         avQtinVex4tSTlH8UOs2dVWTC13FtG+pF1MwZgIAQZFGOr/LJGwKis1wEWWKHZyna3zf
         CNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m9ai4xNC16USLpHMuZWuw+gWvofBhz1RFkiA/VBr+Do=;
        b=Bo9TvTH592WlPEqU7vEP0G6wRcvQS4NW1YAYW78GLRojrPutOyDKAtWJQzCFaJudMh
         aaqIdM8bgGFwc0IZRs8MdP2xwXWVr0Xj4krMWdcTY30cUKqYaiNrIt1BG+i6hhrf874c
         o6iitjXlIPhVK/BLbxgx4OnRgeLFf9ZWQqehG8X5DUZpi9Xr4wjzZX9YV9zA7OdAjV0i
         dprgAFQba3/duMvaVMm285SE2/aC835YYbidRrt+ew8iYBGuaFzOIqNazmoHvedlBm8r
         ZP1qF2CmN8YkCdQ7S5cY5fJEERcMIgwBqasYc/l+LlRHDNakfSi6ZiI3TneaLppXfq4B
         93lQ==
X-Gm-Message-State: AE9vXwPpSTd4BDgN5Cr1y0LFdDZURMtgP19UNpDLaVzfLnv6TboJqoJWQdTqaYMLaX4qE7bQvbLjMIZXmm5YJA==
X-Received: by 10.129.136.5 with SMTP id y5mr7357844ywf.30.1472290506889; Sat,
 27 Aug 2016 02:35:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Sat, 27 Aug 2016 02:35:06 -0700 (PDT)
In-Reply-To: <xmqqbn0hoko0.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe6ae-27df9d50-59b2-4ee2-8c5b-89e7e70a2dd0-000000@eu-west-1.amazonses.com>
 <xmqqbn0hoko0.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 27 Aug 2016 15:05:06 +0530
Message-ID: <CAFZEwPOf=UBo9iCAQ+DfFmZTjSJuQ+v8KayUKpb+G19bUC+pmQ@mail.gmail.com>
Subject: Re: [PATCH v14 11/27] bisect--helper: `bisect_next_check` &
 bisect_voc shell function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Thu, Aug 25, 2016 at 4:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int mark_good(const char *refname, const struct object_id *oid,
>> +                  int flag, void *cb_data)
>> +{
>> +     int *m_good = (int *)cb_data;
>> +     *m_good = 0;
>> +     return 1;
>> +}
>> +
>> +static char *bisect_voc(char *revision_type)
>> +{
>> +     if (!strcmp(revision_type, "bad"))
>> +             return "bad|new";
>> +     if (!strcmp(revision_type, "good"))
>> +             return "good|old";
>> +
>> +     return NULL;
>> +}
>> +
>> +static int bisect_next_check(const struct bisect_terms *terms,
>> +                          const char *current_term)
>> +{
>> +     int missing_good = 1, missing_bad = 1;
>> +     char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad.buf);
>> +     char *good_glob = xstrfmt("%s-*", terms->term_good.buf);
>> +     char *bad_syn, *good_syn;
>> +
>> +     if (ref_exists(bad_ref))
>> +             missing_bad = 0;
>> +     free(bad_ref);
>> +
>> +     for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
>> +                          (void *) &missing_good);
>> +     free(good_glob);
>> +
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
>> +             fprintf(stderr, _("Warning: bisecting only with a %s commit\n"),
>> +                     terms->term_bad.buf);
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
>> +
>> +             return 0;
>> +     }
>> +     bad_syn = xstrdup(bisect_voc("bad"));
>> +     good_syn = xstrdup(bisect_voc("good"));
>> +     if (!is_empty_or_missing_file(git_path_bisect_start())) {
>> +             error(_("You need to give me at least one %s and "
>> +                     "%s revision. You can use \"git bisect %s\" "
>> +                     "and \"git bisect %s\" for that. \n"),
>> +                     bad_syn, good_syn, bad_syn, good_syn);
>> +             free(bad_syn);
>> +             free(good_syn);
>> +             return -1;
>> +     }
>> +     else {
>> +             error(_("You need to start by \"git bisect start\". You "
>> +                     "then need to give me at least one %s and %s "
>> +                     "revision. You can use \"git bisect %s\" and "
>> +                     "\"git bisect %s\" for that.\n"),
>> +                     good_syn, bad_syn, bad_syn, good_syn);
>> +             free(bad_syn);
>> +             free(good_syn);
>> +             return -1;
>> +     }
>> +     free(bad_syn);
>> +     free(good_syn);
>> +
>> +     return 0;
>
> This one looks OK, but I think the same "Wouldn't it become cleaner
> to have a 'finish:' label at the end and jump there?" comment
> applies to this implementation, too.

For this goto can simply things. Will do!

Regards,
Pranit Bauva
