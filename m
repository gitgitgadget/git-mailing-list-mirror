Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B051F461
	for <e@80x24.org>; Tue,  3 Sep 2019 16:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfICQUe (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 12:20:34 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44675 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbfICQUe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 12:20:34 -0400
Received: by mail-vs1-f67.google.com with SMTP id w195so9035020vsw.11
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/rkfzoAzG209KPUsPxYQIv9kf8PsR/LhPPDcDzCdTU=;
        b=VEM4vJSup43oa6tzuGTagzlXDwQ0NXqIrr5MwoLNXY1M0OSNpVj1we3nfTr2f1ilN7
         Tq7rcHKwzXD7IIF3nxnbrd7ksaDxEwsaFBX1XGLsy8f6baxRrtfjettOitSGDD+Rogeq
         l5FuLqrNejm86xvR/ylnDmlutEtyW+YBLI/Bd40XGT0Ym7gJXjIqF7aXH5iSSDNYVzDE
         0hQNtua0fNG1yyFL8CC8D+xi2QCIQv54t3KF1R2wXrSwkn7Pxr7B3+6ADkxHttHFEj9A
         qPxhKQtdvzlYfK5SjB0FaWd99ejkwlwMBkDMC5skDIHpEDP8arZ424dsFA9my3RaWK0l
         zX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/rkfzoAzG209KPUsPxYQIv9kf8PsR/LhPPDcDzCdTU=;
        b=HXgKC5e5mlVbWpPGiVk3U4hjMJjG4Ud2qinkWVzMYHaxAQ9CmegHinL0BoL7auAKf3
         bvAuODHHmU40xgv0YVhexT4wIOI8e87FkqYVBiDVS90cpeyDT1+8ZbJL/mW0EZyh3FVw
         L/F/EKDS49z6kmaHCN6Hp0k2sgJkfy/27tUbolX9CIrvAxeFvY5dBhFO+5iAUklRstYw
         qe02iTaFo+bpnPrmjIIjbEEVX94us5BMqVXa6SUX1e5wqcur2QUip8KzkQaHOdBPEzuH
         xJr3nH0nS8x1tPuYdZDbo2VXwEqyHnE1YyVq5ajODQvErrBCqBrWBHMAg7o271fMmKQB
         xWDg==
X-Gm-Message-State: APjAAAXzuOVwafLvvb1BMqzzh7lqMba6OYCv1aZKIw/MC+MTFBspQoUv
        iVziPgBSyeD+z/VxKxCRFj748/EvQIIeDPcWcznfs7O/Lyg=
X-Google-Smtp-Source: APXvYqxbJt2Cjy5wANI2ku/pqXBgt1nK5XAXL4b9VKLr4nAX2L/ZvJAN+rujOmXA+ED/lKuTrtNn1eVUgh/+JMds8Co=
X-Received: by 2002:a67:fd11:: with SMTP id f17mr6162690vsr.31.1567527633133;
 Tue, 03 Sep 2019 09:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <20190902195618.3820-1-birger.sp@gmail.com> <CAKPyHN0tFzRDYFkjwTDi6MvN3DmzDRNH6V0Y5Ay1U6K2T-H6sA@mail.gmail.com>
In-Reply-To: <CAKPyHN0tFzRDYFkjwTDi6MvN3DmzDRNH6V0Y5Ay1U6K2T-H6sA@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 3 Sep 2019 18:20:22 +0200
Message-ID: <CAKPyHN0AYcdxA5n3856Dk6toJbV_yQ9aXkZ2r_Ytn6mdUK5sbw@mail.gmail.com>
Subject: Re: [PATCH] Add hotkey to toggle "Amend Last Commit" radio selector
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        David <bouncingcats@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Birger,

On Tue, Sep 3, 2019 at 10:52 AM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>
> Birger,
>
> On Mon, Sep 2, 2019 at 9:56 PM Birger Skogeng Pedersen
> <birger.sp@gmail.com> wrote:
> >
> > Selecting whether to do a "New Commit" or "Amend Last Commit" does not have
> > a hotkey.
> >
> > With this patch, the user may toggle between the two options with
> > CTRL/CMD+e.
>
> David A. (in Cc from git-cola) suggested, that we try to re-use
> existing key bindings in Git GUIs. Here is Git-Cola hotkeys:
>
> http://git-cola.github.io/share/doc/git-cola/hotkeys.html
>
> and this indicates, that it already uses CTRL+m for "amend". Though
> I'm unsure if this is a toggle like in git-gui or a one-shot. David
> A., can you please clarify?
>
> >
> > Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> > ---
> >  git-gui.sh | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/git-gui.sh b/git-gui.sh
> > index 5bc21b8..14be1e0 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -2640,6 +2640,16 @@ proc show_less_context {} {
> >         }
> >  }
> >
> > +proc toggle_commit_type {} {
> > +       global selected_commit_type
> > +       if {[string match amend* $selected_commit_type]} {
> > +               set selected_commit_type new
> > +       } else {
> > +               set selected_commit_type amend
> > +       }
> > +       do_select_commit_type
> > +}
> > +
> >  ######################################################################
> >  ##
> >  ## ui construction
> > @@ -3843,6 +3853,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
> >  bind .   <$M1B-Key-plus> {show_more_context;break}
> >  bind .   <$M1B-Key-KP_Add> {show_more_context;break}
> >  bind .   <$M1B-Key-Return> do_commit
> > +bind .   <$M1B-Key-e> toggle_commit_type
>
> The commit type has also a two toggle menu entries (under "Commit")
> they should now also indicate the key binding.
> disable
>
> Though how to express a toggle keybinding in the menu? I don't know if
> you can assign the same keybinding to the same menu entry. Maybe we
> need to add/remove the keybinding depending on the current mode.

that works. I squashed this into your commit and pushed to GitHub
(sorry, still no path-per-mail)

https://github.com/bertwesarg/git-gui/commit/245bb9944e3d1c6b266c58b56d316f283ed3516b

Bert

>
> Bert
>
> >  foreach i [list $ui_index $ui_workdir] {
> >         bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
> >         bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }
> > --
> > 2.21.0.windows.1
> >
