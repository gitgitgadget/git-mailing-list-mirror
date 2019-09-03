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
	by dcvr.yhbt.net (Postfix) with ESMTP id 35AE41F461
	for <e@80x24.org>; Tue,  3 Sep 2019 16:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfICQHJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 12:07:09 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34200 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfICQHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 12:07:09 -0400
Received: by mail-vk1-f193.google.com with SMTP id h192so3689952vka.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtSHIl5W9qPzF5BLIKCg+RCMCd9P7LhCvtr8Td4U55M=;
        b=RfaLkGRsncOK0ymRWnknlryvz8rO63CoPNDHliTDX1XqahbpKsAtgVDSNzHoedzkbV
         lQKyUKnIqKSAMlOPMsH4igXi3iwrMlWxwYJ77rlhBWeiDmFs3VeHOhyeeq7OpMYZnoMM
         RAZOTFJ+bFqxSy4zqxE1Y97yzqaBfvo1Si96PqEoUwH37zd2S2nyScWcYD3z4+T7Uwzb
         V/qV4SNVZ8Cf80e41+1XmKOJ83jHEameilWJnRcxcr1s+n+iP4KiuHdjkwMq5uoSCzdG
         moVBrAsaexTj8Jm40j7/qMHanpGkedTKTVlLXqHb4SAB/dcCls81RnyFZNu1kZXQ2Nh7
         BFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtSHIl5W9qPzF5BLIKCg+RCMCd9P7LhCvtr8Td4U55M=;
        b=nJqLM9FbI/87wyDItj8Bcx/3ENeHpwld9ApefTtKYVn4j5mrs0aucaMR3TnnW00eVa
         pxC7sSzFRVrkQ6eZM1paF3GTmIuVC0QhpGCRHJuJcQUujfnAzebKEB6t/RLRv+aCNWfA
         RDVsYmimxP6jnGxFvzZIKV8GIsTM/BU+Kjr895yFbSD63emoHnvhmqzex/b6djF9di+F
         Fp6RQ7liMXpDpaEBFGNWDicee6SUHoY/DzazV32Yo4Ar4UoirlzTJGs3WtxrF3oGn+L5
         pkqSb1++UrEJpDTfufqjScjs8hIcfFajT9pKhMupOQLCC2KEmKtVg+WentYnZ3X6bW6C
         66+Q==
X-Gm-Message-State: APjAAAXaks49a8LehddCuPH6pm6lTO21HvIhSCzxaGtBrbFgjWTi0vTT
        05t9OnO3NPBGof2TAb7CjYGsBb2jQskK3MxzW+w=
X-Google-Smtp-Source: APXvYqy3dZVBhyxKdwYCW5DPDcu1Zdt/d81PC/9EAmLoFmY0ks4nEmVv6wOtNXU8Yu7gk75vl7O1Vx7a6OU35aWvxok=
X-Received: by 2002:a1f:3cc9:: with SMTP id j192mr7623529vka.58.1567526828086;
 Tue, 03 Sep 2019 09:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPyHN2_CpaJahKo2Ju2SWvU=Y79k2ArKVkkxPTbeW1t2TYRZQ@mail.gmail.com>
 <20190901193652.21086-1-birger.sp@gmail.com> <CAKPyHN0LtOG9mFQ6qxc-w-EdpJ3HGJmHAGdrGp2FKkq4uCf55A@mail.gmail.com>
 <20190903142252.oovvxslvvzteaqlc@yadavpratyush.com>
In-Reply-To: <20190903142252.oovvxslvvzteaqlc@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 3 Sep 2019 18:06:56 +0200
Message-ID: <CAKPyHN3LFheRGR1Hdh7rzbEsuOdumzphaZB2e1_gPshgsk18Tg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] git-gui: Add hotkeys to set widget focus
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 3, 2019 at 4:22 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 02/09/19 09:42PM, Bert Wesarg wrote:
> > On Sun, Sep 1, 2019 at 9:37 PM Birger Skogeng Pedersen
> > <birger.sp@gmail.com> wrote:
> > >
> > > The user cannot change focus between the list of files, the diff view and
> > > the commit message widgets without using the mouse (clicking either of
> > > the four widgets).
> > >
> > > With this patch, the user may set ui focus to the previously selected path
> > > in either the "Unstaged Changes" or "Staged Changes" widgets, using
> > > CTRL/CMD+1 or CTRL/CMD+2.
> > >
> > > The user may also set the ui focus to the diff view widget with
> > > CTRL/CMD+3, or to the commit message widget with CTRL/CMD+4.
> > >
> > > This enables the user to select/unselect files, view the diff and create a
> > > commit in git-gui using keyboard-only.
> > >
> > > Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> > > ---
> > >  git-gui.sh | 35 ++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 34 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/git-gui.sh b/git-gui.sh
> > > index 5bc21b8..ce620f1 100755
> > > --- a/git-gui.sh
> > > +++ b/git-gui.sh
> > > @@ -2495,7 +2495,7 @@ proc force_first_diff {after} {
> > >
> > >  proc toggle_or_diff {mode w args} {
> > >         global file_states file_lists current_diff_path ui_index ui_workdir
> > > -       global last_clicked selected_paths
> > > +       global last_clicked selected_paths file_lists_last_clicked
> > >
> > >         if {$mode eq "click"} {
> > >                 foreach {x y} $args break
> > > @@ -2527,6 +2527,8 @@ proc toggle_or_diff {mode w args} {
> > >         $ui_index tag remove in_sel 0.0 end
> > >         $ui_workdir tag remove in_sel 0.0 end
> > >
> > > +       set file_lists_last_clicked($w) $lno
> >
> > So we only remember the lno in the widget, that could mean, that we
> > select the wrong file after a rescan, which shifted the previous path
> > one down. Can we remember the pathname instead, and try to find this
> > again in the file list?
>
> I raised a similar concern. Birger's response was that it is not a
> trivial change for him, and he needs help with it. So I decided to keep
> it like it is.
>
> But now I thought about it a bit more, and I don't think it should be
> too difficult. A quick look tells me that $file_lists should be a sorted
> list with unique entries (git-gui.sh::display_file_helper{}), so it
> shouldn't be too difficult to find a given path. display_file_helper
> does:
>
>   set lno [lsearch -sorted -exact $file_lists($w) $path]
>
> which should also be what we want.
>
> I have a quick-and-dirty fix for it. Haven't tested it too well, but it
> seems to work for some basic things like removing a file and refreshing,
> and then selecting focus again. Do give it a spin. I'll send the patch
> in reply to this email.
>
> > > +
> > >         # Determine the state of the file
> > >         if {[info exists file_states($path)]} {
> > >                 set state [lindex $file_states($path) 0]
> > > @@ -2640,6 +2642,29 @@ proc show_less_context {} {
> > >         }
> > >  }
> > >
> > > +proc select_path_in {widget} {
> >
> > can we name it 'focus_and_select_path_in', as the main job ob this
> > function is to focus the widget. It makes also the 'bind' command
> > below more readily, because than all bind commands start with 'focus'.
>
> Ah, I was kind of uneasy with the function name, but couldn't come up
> with a good one. This sounds all right. Another suggestion that I'd put
> out: "focus_widget". As you said, focusing a widget is the main job of
> this function. Selecting paths is secondary. IMO it should be fine to
> not have "select_path_in" in the function name because you select the
> path in the process of focusing on widget.
>
> > > +       global file_lists last_clicked selected_paths ui_workdir
> >
> > ui_workdir not referenced in this function
>
> Nice catch.
>
> > > +       global file_lists_last_clicked
> > > +
> > > +       set _list_length [llength $file_lists($widget)]
> > > +       if {$_list_length > 0} {
> > > +
> > > +               set _index $file_lists_last_clicked($widget)
> >
> > I have the impression that variables starting with '_' are mainly used
> > as read-only global variables, see the list at line 158, and not that
> > often as temporal local variables.
> >
> > > +               if {$_index eq {}} {
> > > +                       set _index 1
> > > +               } elseif {$_index > $_list_length} {
> > > +                       set _index $_list_length
> > > +               }
> > > +
> > > +               focus $widget
> > > +               set last_clicked [list $widget $_index]
> > > +               set path [lindex $file_lists($widget) [expr $_index - 1]]
> > > +               array unset selected_paths
> > > +               set selected_paths($path) 1
> > > +               show_diff $path $widget
> > > +       }
> > > +}
> > > +
> > >  ######################################################################
> > >  ##
> > >  ## ui construction
> > > @@ -3852,6 +3877,14 @@ foreach i [list $ui_index $ui_workdir] {
> > >  }
> > >  unset i
> > >
> > > +bind . <$M1B-Key-1> {select_path_in $::ui_workdir}
> > > +bind . <$M1B-Key-2> {select_path_in $::ui_index}
> > > +bind . <$M1B-Key-3> {focus $::ui_diff}
> > > +bind . <$M1B-Key-4> {focus $::ui_comm}
> >
> > I would like to bring up a proposal: AFAICS, more or less all CTRL
> > bindings have a menu entry. But it does not make sense to have a menu
> > entry for these bindings. And I think we could add more bindings for
> > keyboard-afine users. Thus I would like to propose to use ALT as the
> > modifier for these bindings, which would give us a nice binding
> > classification.
> >
> > How about that?
>
> FWIW, I agree with this. To add to this, it would also somewhat match
> with bindings in other programs. For example, in Firefox you can choose
> tabs 0-9 with Alt+0-9. In gnome-terminal, you can also choose tabs with
> Alt+0-9. AFAIK Chrome does this too.

ttk::notebook only provides Ctrl+Tab, Ctrl+Shift+Tab, and
Alt+<mnemonic> keybindings as default tab traversal, thus this should
not conflict with Alt+1-4 to begin with.

>
> My one concern is, does an Alt key exist on Mac (AFAIK it does, but I
> want to be sure)? I don't think we have any existing bindings with Alt,
> so will they work well with Macs?

they should ;-)

https://www.macworld.co.uk/how-to/mac/mac-keyboard-shortcuts-3504584/

Bert

>
> --
> Regards,
> Pratyush Yadav
