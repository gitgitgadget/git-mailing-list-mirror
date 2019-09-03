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
	by dcvr.yhbt.net (Postfix) with ESMTP id B21281F461
	for <e@80x24.org>; Tue,  3 Sep 2019 10:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfICKZp (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 06:25:45 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44115 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfICKZp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 06:25:45 -0400
Received: by mail-vs1-f65.google.com with SMTP id w195so8254391vsw.11
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/0GIIm8GNbGhzwRixi0AO3Bwo+X/xHc8APH6H6Zuwm0=;
        b=JNpDuN9lSNp1oXzOjSgHqp6DJCvqyrJqsw50nBSgb+imhqKRnz+rJWmLwIYQNxg6eB
         4cksLkk9C6eBFexh70JorhGGDZrp0cq34JCVw6OlNV7j10jgqO6Ayp1iMZdRIgibDQHE
         Vb4KjzIirIRJ1CJdfWXvvzD+SBsa5x98ZwHImh74DpUFG7UGgzBK8PZS+TQF+8ISY1X1
         5du2Li1rxCkracSBik2mlDQIHNpdRwDo25dUiQQfQl4snmONT+eg92wzyAcEkFexsjcy
         5IEMkaA3AXC8l9F6lFR/GYtxuH1YtzDOH1xoeoWNohHWyVQ8JDaIAyvMlaXuZm/CMY1k
         01GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/0GIIm8GNbGhzwRixi0AO3Bwo+X/xHc8APH6H6Zuwm0=;
        b=R6QcnDo83lWtWOcB3uEj18S3S/ZYDkYnMozo0dMseQop+7yK/OMYemJA6mAvekZni1
         ipJ1z4JKhdsG89GYVcmJuvKpuQhbV/3AjKSJCdJK66QHRrLupCVU0HHYRzBZgVIg7oKT
         T287KTs7I1jOM34frujDNLWDw2LRh2b9P5FsJdKgrjREwSRdw69w6Cj8qChWT6Snl733
         nNwD1p52YUtbrlCKD1E7F5g9xY8478K9aUV4gmG4YCd7muf1BwYkZUR+6vQzB3udcpT4
         o8V1hbTvDsy/bqdUB+stjHNrfYkZ64YV6n5CToYlGRfldLIJEQXGy9JBQjjCwlet68hw
         bFRQ==
X-Gm-Message-State: APjAAAX5YXhKykxLnGYvVdRymM07qODZp+D37bMHcqLOKe3Vwy52CBah
        c1gibpd9oKQoLNZH4ce3uqeG8mNwj+ngqsR9rAg=
X-Google-Smtp-Source: APXvYqxD+EFzgT7EZGhMhWGn9/z6rXVdKIE8iM4HJflvYbAgXuaLKRoI7t31Tk9MIf75izWt4NIZE+i3pSVGfa4AP1M=
X-Received: by 2002:a67:e45:: with SMTP id 66mr18447238vso.197.1567506344224;
 Tue, 03 Sep 2019 03:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <20190902195618.3820-1-birger.sp@gmail.com> <CAKPyHN0tFzRDYFkjwTDi6MvN3DmzDRNH6V0Y5Ay1U6K2T-H6sA@mail.gmail.com>
In-Reply-To: <CAKPyHN0tFzRDYFkjwTDi6MvN3DmzDRNH6V0Y5Ay1U6K2T-H6sA@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 3 Sep 2019 12:25:32 +0200
Message-ID: <CAKPyHN1psZyj1MsMkJ-7ZMm8YX9AoBSHx1+qwBTfSeBKu5xURw@mail.gmail.com>
Subject: Re: [PATCH] Add hotkey to toggle "Amend Last Commit" radio selector
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        David <bouncingcats@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David,

On Tue, Sep 3, 2019 at 10:52 AM Bert Wesarg <bert.wesarg@googlemail.com> wr=
ote:
>
> Birger,
>
> On Mon, Sep 2, 2019 at 9:56 PM Birger Skogeng Pedersen
> <birger.sp@gmail.com> wrote:
> >
> > Selecting whether to do a "New Commit" or "Amend Last Commit" does not =
have
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

git-gui already assigns CTRL+m to "Local merge=E2=80=A6"

sorry. I think trying to synchronize the keybindings seems impossible.

Bert

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
> > @@ -3843,6 +3853,7 @@ bind .   <$M1B-Key-equal> {show_more_context;brea=
k}
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
>
> Bert
>
> >  foreach i [list $ui_index $ui_workdir] {
> >         bind $i <Button-1>       { toggle_or_diff click %W %x %y; break=
 }
> >         bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break=
 }
> > --
> > 2.21.0.windows.1
> >
