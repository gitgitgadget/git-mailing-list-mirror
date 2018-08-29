Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7794C1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 23:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeH3DAL (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 23:00:11 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34865 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeH3DAL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 23:00:11 -0400
Received: by mail-ua1-f68.google.com with SMTP id m26-v6so4332453uap.2
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSk7kEKXMq3+xvnoIhWLnV/JocH8icHs+TA4bviIGrs=;
        b=G02zDaJoJe3ZdDZ17B40gTXIViigOXMa6S98eb+O8R9G8lr49kxZCkhhi4i3uFc6ii
         Hpu5oaeXMyaZIOAFTEBW2o4Rfu5J2H/POOhgN9nT+Ul0xA3Z6LWA0KLoTeLvDRaVy9WS
         TmPEitU8dNY35uCoblbpbsfqM2Ve4EnExw7MOM+B8DD0Z5vJHV/TyeNlF1sz0CGKmgEB
         wntn8Cu9ce76LeKX9IR2tH0O5Pvxkzow0ABcoeJ2Vnzqs1EKx8wsDRvpPYjQrYdasGda
         1p17SiU2dDIthsTPDtlKn2CsIFt/RVyLG1PgZG+xEWCN5V1aD/ecGxg0of8G7rpyGS22
         bEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSk7kEKXMq3+xvnoIhWLnV/JocH8icHs+TA4bviIGrs=;
        b=LjfonHPbiFYNzd5qgMSJzgh3pbRozACdrOqwbAKWADBP/vw0iyZ6/ipnG3/thnF1Wx
         FsqkkZx63vPklWhe8RRCX/+4San4kXxvMOrkRfOkvIoMkCqbd5oAeaxsz7Xe0FbaH3qD
         pC8hWsu5rwhk6GAhg6Qj9VEhY7JTDjZbTJSXHvhSDhQBLtXOisyMJYdJmuz2OEGdXgs9
         WjpvChu8Hf0tLWTDAcoH4XlagLealR7s7FBtHycL8oaZC79wkt0Qc8QT4D12vrtj+chN
         9tVYo0/chEg/9EFkBHd/7BJqF+bvQmazSXm+hhEjjZLn0wfLbNd8GaWWlh/UoewjEQ4O
         myrQ==
X-Gm-Message-State: APzg51BRnbYXZossCjAn79u7sYlKIdjeZd49eeHYeXiRMuvukPFgAjLB
        MzdFIywDKr7S/3Rw1QQ7jYFFR6FzigBgsllwomA=
X-Google-Smtp-Source: ANB0VdZ59UC7+la+qHXwbmClBwi47zQu9IUNrDHOUNqsNNs1d5Evk/MaVIMXdFhK4JcKvanpu4LpjmNyb2o0/P4qWwI=
X-Received: by 2002:ab0:5507:: with SMTP id t7-v6mr5697648uaa.100.1535583660557;
 Wed, 29 Aug 2018 16:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com> <20180829070613.11793-1-newren@gmail.com>
 <20180829070613.11793-3-newren@gmail.com> <nycvar.QRO.7.76.6.1808291452070.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808291452070.71@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Aug 2018 16:00:48 -0700
Message-ID: <CABPp-BHFrk026R5VZLGwVvRYq_d82GTFqAyAeyTD=iQX4df2Bw@mail.gmail.com>
Subject: Re: [PATCH 2/3] merge-recursive: add ability to turn off directory
 rename detection
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, corrmage@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 5:54 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Wed, 29 Aug 2018, Elijah Newren wrote:
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-recursive.c | 18 +++++++++++++-----
> >  merge-recursive.h |  1 +
> >  2 files changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index f110e1c5ec..bf3cb03d3a 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -2843,12 +2843,19 @@ static int handle_renames(struct merge_options *o,
> >       head_pairs = get_diffpairs(o, common, head);
> >       merge_pairs = get_diffpairs(o, common, merge);
> >
> > -     dir_re_head = get_directory_renames(head_pairs, head);
> > -     dir_re_merge = get_directory_renames(merge_pairs, merge);
> > +     if (o->detect_directory_renames) {
> > +             dir_re_head = get_directory_renames(head_pairs, head);
> > +             dir_re_merge = get_directory_renames(merge_pairs, merge);
> >
> > -     handle_directory_level_conflicts(o,
> > -                                      dir_re_head, head,
> > -                                      dir_re_merge, merge);
> > +             handle_directory_level_conflicts(o,
> > +                                              dir_re_head, head,
> > +                                              dir_re_merge, merge);
> > +     } else {
> > +             dir_re_head  = xmalloc(sizeof(*dir_re_head));
> > +             dir_re_merge = xmalloc(sizeof(*dir_re_merge));
>
> This is not a suggestion to change anything, but a genuine question out of
> curiosity: would it make sense to put the `dir_re_head` and `dir_re_merge`
> structures into `struct merge_options` to avoid these extra `malloc()`s?
> Or would that cause issues with the recursive nature of the recursive
> merge?

That would work to avoid the extra `malloc()`s, and be inline with the
current usage of merge_options.  However, I'm not sure I like the
current usage of merge_options. That struct is supposed to be public
API, but it's got a lot of private internal-only use stuff (and
putting dir_re_head and dir_re_merge there would add more).  I'm
tempted to go the other way and eject some of the other internal-only
stuff from merge_options (or wrap it inside an opaque struct
merge_options_internal* internal field, or something like that).
