Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B7E020248
	for <e@80x24.org>; Sat,  9 Mar 2019 18:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfCISEv (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 13:04:51 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40002 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCISEu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 13:04:50 -0500
Received: by mail-ua1-f68.google.com with SMTP id c5so264338uaq.7
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F11cwACdBrJmdyOjPxSNxVpspAPQzu1pm1nSkaWjEXU=;
        b=Kibmw/lZDlG7a68Z8OBkkcxLTWa8hDJQvQvMLLX8Kdu7bPV+IxLQi7mx7hI3Ya6aYv
         W9WFgBKpYOzuL50nsUICB3ljQPcj43qj1ficPH6/bGuDa+KNgNUzmoXH5QUkHjTAC30Q
         kL882oH/JSz05S5BAtueRMDpTv9I/4qB5AtRbw9Ut/Q17AGccD/q6YFcbtgEEFuxqLd2
         6eUE1aLS2vq08wWmyZTnn+g9pmcUs/z+TOPaSyQUUShvqisGAAgzC5R5K6Arte3FnBFj
         ne98l3w690bjE1JEjDIqed9KPx6CjDZOO3uiVeZAQlSzhjbX4rvQWEc+JsABSac0P7K8
         /e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F11cwACdBrJmdyOjPxSNxVpspAPQzu1pm1nSkaWjEXU=;
        b=AsUueZSuDmbApl409+WyMKjwWEW+YsxXISrZv6kXqMDPMz+7A/D+dF0cLBWCn8TasK
         EvWdGSrGkPanx8AN6IfEL8X3jSZe2Jah0An+iG0wWAdqRGkVF1OkLgg4deDpok0U+T+z
         5ThEEwNOR/OUOK4ln7MRkPUAMUKiA9QyjEwJlXT/v2e3IRt61t1fRV01pKUT9wN+P8P2
         edYiqA/EttqfFsIGMmPWBrr8MlPzzsPKnBlhXnaO6OpzNq3XC28DsXYrMS9y3Y5e8z5Y
         IyWm3Mzmcay256UMFJ7ryq80y2pu5nAfu0I9XwtAb4/mxxUpzZ6w8Za2MZv9vHSwl7eU
         63oA==
X-Gm-Message-State: APjAAAXLgZJcUVzq/kVQwCBi8OplovASQPnhGX2TLMHZZJm5JtbeWx3C
        dZ+4S29T+G5+QP0bQtJAAyI08nb2DnABQ++T7CA=
X-Google-Smtp-Source: APXvYqxJlOnaQQMyH7hlYmMmEXKJl2Ou963DcwcvsrrVfgRgOBSCzVRyuOHWSjCyuU0BsEYmAMG/3OkYnbhjJuT1AqM=
X-Received: by 2002:a9f:3205:: with SMTP id x5mr12268655uad.104.1552154689065;
 Sat, 09 Mar 2019 10:04:49 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com> <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
 <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org> <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
 <20190309172733.GC31533@hank.intra.tgummerer.com>
In-Reply-To: <20190309172733.GC31533@hank.intra.tgummerer.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Mar 2019 10:04:37 -0800
Message-ID: <CABPp-BHtpb_EyNTNGcP+EbRbrrMJg1C=W4JenjE1AbnE1WrbNA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Mar 9, 2019 at 9:29 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 03/07, Duy Nguyen wrote:
> > On Thu, Mar 7, 2019 at 7:34 PM Philip Oakley <philipoakley@iee.org> wrote:
> > >
> > > On 06/03/2019 09:44, Duy Nguyen wrote:
> > > > On Wed, Mar 6, 2019 at 8:34 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > >> * tg/checkout-no-overlay (2019-02-04) 9 commits
> > > >>    (merged to 'next' on 2019-02-04 at 9968bcf4fb)
> > > >>   + revert "checkout: introduce checkout.overlayMode config"
> > > >>    (merged to 'next' on 2019-01-18 at 1e2a79ba5c)
> > > >>   + checkout: introduce checkout.overlayMode config
> > > >>   + checkout: introduce --{,no-}overlay option
> > > >>   + checkout: factor out mark_cache_entry_for_checkout function
> > > >>   + checkout: clarify comment
> > > >>   + read-cache: add invalidate parameter to remove_marked_cache_entries
> > > >>   + entry: support CE_WT_REMOVE flag in checkout_entry
> > > >>   + entry: factor out unlink_entry function
> > > >>   + move worktree tests to t24*
> > > >>
> > > >>   "git checkout --no-overlay" can be used to trigger a new mode of
> > > >>   checking out paths out of the tree-ish, that allows paths that
> > > >>   match the pathspec that are in the current index and working tree
> > > >>   and are not in the tree-ish.
> > > >>
> > > >>   Will hold.
> > > >>   Waiting for "restore-files" & "switch-branches" pair.
> > > >>   cf. <20190205204208.GC6085@hank.intra.tgummerer.com>
> > > > If it's ready for master, I'd love to see it merged. Either that or
> > > > topic is rebased on 'master'. There are separate checkout changes in
> > > > 'master' (mine, sadly), and because switch/restore moves lots of code
> > > > around, I need to create a merge of this topic and master as the base,
> > > > or you'll get horrible conflicts.
> > > >
> > > > I should send switch/restore again soon. There are still a few
> > > > unaddressed concerns for git-restore since last time. Probably time to
> > > > refresh those discussions.
> > >
> > > Just catching up on back emails:
> > >
> > > The one point I noted is that "Overlay" is a new magic term without any
> > > explanation within the _documentation_.
> > >
> > > It would appear worth it to also add something (follow up patch?) to the
> > > e.g. git glossary to clarify how overlay differs, or is similar to, the
> > > different merge and reset modes.
> >
> > I think Jonathan questions the name "overlay" too. Since this is
> > similar to "cp -R" mode, another suggestion is --copy-mode.
>
> That would leave the negative form as --no-copy-mode, which almost
> sounds like we wouldn't copy anything.  I think that would be more
> confusing that [no ]overlay mode.
>
> I'd be fine in general with changing the name, if there is a consensus
> for a different and better name, but I also think overlay is
> reasonable, so I'd rather leave pushing for a different name to
> someone else that has strong opinions about it.
>
> Philip, do you think something like this would help?  Not sure if it
> should be called overlay_mode in the glossary, rather than just
> overlay?
>
> --- >8 ---
> Subject: [PATCH] glossary: add definition for overlay
>
> Add a definition for what overlay means in the context of git, to
> clarify the recently introduced overlay-mode in git checkout.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  Documentation/glossary-content.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 023ca95e7c..70e6477a9f 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -287,6 +287,11 @@ This commit is referred to as a "merge commit", or sometimes just a
>         origin/name-of-upstream-branch, which you can see using
>         `git branch -r`.
>
> +[[def_overlay]]overlay::
> +       Only update and add files to the working directory, but don't
> +       delete them, similar to how 'cp -R' works.  This is the
> +       default in a <<def_checkout,checkout>>.

I think this is good, but maybe also add:
   In contrast, no-overlay mode will also delete files not present in
the source, similar to 'rsync --delete'
?

> +
>  [[def_pack]]pack::
>         A set of objects which have been compressed into one file (to save space
>         or to transmit them efficiently).
> --
> 2.20.1.495.gaa96b0ce6b
