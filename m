Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822321F462
	for <e@80x24.org>; Thu, 13 Jun 2019 19:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfFMTVk (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 15:21:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38080 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfFMTVk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 15:21:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so70172pgl.5
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Q9NGE/7jb0qVJTq2q0ALalVYl0fKrV6+bvu+BG1/h0=;
        b=G0vGaeQPG2YWvLLvxpRuynOvY1aY6fKFcbkMSCOYL0lXtaARfZ7VkSxQkV5nI2LUUj
         aGzZfz79BbiHOkiPUnn2PHdu5cL4DqS4+5DaxQqNbsK2JG/j4yz21ET79L2rDdZJTQL3
         0vd376Mbu/LwUQUqDyfqS/jOicFf0SHqyuJRLaaRmMGfgX4j2JfhoxkWXYJMyi3YSE2H
         CJCjJ332L28Ov/4il8GQpfz0vSMx5ATBNABrLfBqboX2mkDdG7NTfXZCjCox6Nm498QA
         eKWQ6vuIPkXDdo/J0BYKGILYOGiynbNG6wfwYYFDJUX3C64USFpMhbzB2yMwhg1UDDH4
         sQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Q9NGE/7jb0qVJTq2q0ALalVYl0fKrV6+bvu+BG1/h0=;
        b=HjvMIbSoXRbxuravm3SXYLCtMFzXqMKdRrSAwA6pmJUuRNe73WOmPgjTGygq57smiW
         zN3n4iC5RybLOqiVAhjbuQAeA6rJ5YnFpysI5hYKgumO506xBaMlHQ1thE4ka7y0LzeX
         /NBZJmNJwcApbS33P4XU2u0iE8sWvMlSyTZMTXhF/srOdCCiPkYsn8/mG6w5Mv56OOuO
         efvJaLcci6ubXnMB6oVCLbzlS+yeHgEpEtwG7BkWSLRxbXKz0uyohH53CbF6ZX32Bvdt
         u2qEaR0XMwxrizlHUrF/2RTrajFmVi+rd755aLlJ5B4AJ8eKa3t1MhN/COOdCEXVnvfo
         ZjcA==
X-Gm-Message-State: APjAAAXyaomGqpoZ9iuvOBHW4ImQFPVYF1DXIdPSHBXXNtLa6NgRnvXX
        pyJE1Wf1mLmBmrooxa3ZHTcWhrKL9y0k+wYTA14k2g==
X-Google-Smtp-Source: APXvYqx7upWZ4eLIHJh2it7v1jiKChhI/XKTD4T08d4UMOr7ebiZmw+k8+u2+kmSMMO09ixLzwia7FPbCGCueOkYbkE=
X-Received: by 2002:a65:6495:: with SMTP id e21mr17793553pgv.383.1560453699600;
 Thu, 13 Jun 2019 12:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190613040504.32317-1-rohit.ashiwal265@gmail.com> <20190613040504.32317-2-rohit.ashiwal265@gmail.com>
 <0333fe2f-d68a-4536-c736-ca2a356df34b@gmail.com>
In-Reply-To: <0333fe2f-d68a-4536-c736-ca2a356df34b@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 13 Jun 2019 21:21:27 +0200
Message-ID: <CAN0heSp_XDZTviwGDpOuXhuh+8k-BA7Ld6z9gSHA9My+16BnbQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 1/3] sequencer: add advice for revert
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit,

On Thu, 13 Jun 2019 at 19:46, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 13/06/2019 05:05, Rohit Ashiwal wrote:
> > -static int create_seq_dir(void)
> > +static int create_seq_dir(struct repository *r)
> >  {
> > -     if (file_exists(git_path_seq_dir())) {
> > -             error(_("a cherry-pick or revert is already in progress"));
> > -             advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
> > +     enum replay_action action;
> > +     const char *in_progress_advice;
> > +     const char *in_progress_error = NULL;

The assigning vs not assigning is a bit inconsistent, but that's a very
minor nit, and not why I started replying. Only noticed it just now. :-)

> > +     if (!sequencer_get_last_command(r, &action)) {
> > +             switch (action) {
> > +             case REPLAY_REVERT:
> > +                     in_progress_error = _("revert is already in progress");
> > +                     in_progress_advice =
> > +                     _("try \"git revert (--continue | --abort | --quit)\"");
> > +                     break;
> > +             case REPLAY_PICK:
> > +                     in_progress_error = _("cherry-pick is already in progress");
> > +                     in_progress_advice =
> > +                     _("try \"git cherry-pick (--continue | --abort | --quit)\"");
> > +                     break;
> > +             default:
> > +                     BUG(_("the control must not reach here"));
>
> This does not need to be translated as BUG() messages are not really for
> users. Everything else looks fine to be now

I agree 100% with Phillip, but I'll also note that "the control must not
reach here" doesn't tell me anything that BUG() doesn't already. That
is, the point of BUG() is to document that, indeed, we shouldn't get
here and to alert if we do anyway.

An obvious alternative would be

        BUG("action is neither revert nor pick");

but that doesn't say much more than the code already says quite clearly,
plus it risks getting outdated. I'd probably settle on something like

        BUG("unexpected action in create_seq_dir");

which should give us a good clue even if all we have is this message (so
no file, no line number), but I am sure there are other good choices
here. :-)

Thanks Rohit for your work on this. I'm impressed by how you've polished
this series.


Martin
