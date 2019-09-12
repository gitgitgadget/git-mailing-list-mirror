Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26CBF1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfILTjs (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:39:48 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45983 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfILTjs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:39:48 -0400
Received: by mail-vk1-f195.google.com with SMTP id u192so5416428vkb.12
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sU4r+9BP/bDR+WSJV8e9bFh1EnYR4pMMMQQqvakXs/4=;
        b=rYiUfhfw53kMwFPyFdpCdUXxfekF/T61cgsAx/mr7T0YZp775UEx+6uTy+haf5+gT0
         Nmgh4BZyFuI21w0bAvSXz5Rk1afugL80/IAPQsLYzZvFlsb7J0Dun4oQfJZVIsfCUhWV
         eaKFtjVMOneN8HzsNfFnR0wSCp9gL2uXjLc2hesHZBme7YOlvymDvw8WiFsr3DgRckOT
         z3WmiCXc1+1Jux7Ti221hw1/q3kgqjBeEzV+MC4Y9Eu+AOMigPELbTPOFqxFRVCaHqqv
         iFC7NkRQ5uXSMRr8PvkYIfeC8J7Ft+MzZmXPz1oZwDb4F+qOxVVqRCfDNP5a+WpRCoTJ
         Hx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sU4r+9BP/bDR+WSJV8e9bFh1EnYR4pMMMQQqvakXs/4=;
        b=fTlbd3imUe1wQcNpg3oWA1Gk+w524Xf5+AORp80rkkoyqFfS8dkA+U/mPNWcRluwLX
         06JSqwiJTa2cTzSpN5H84nlj7eccFZFrYTAAoTX/A9LIJtNGbHzJxrf2fCwcLQRpUw9D
         3y5PziUhzf0vSEis0u+PUa5/WOx84NytQnEX/0veRZqgns2vuaWl/fA/XKdTeGvqcyp2
         VYYk/CVw6S3VRgKCKX4n4HTPpiqr+q0eXEng91gzLsKK+V1hfVuppO1Pxbew/6VFQnnc
         Ln1UDKFTBLTy25NqlBS2bZdYQ+lIaEnjovXDa/YL8GfjIejLMlj+hPuC5XoZRNQP5v64
         YOhw==
X-Gm-Message-State: APjAAAUjQkdH6ronoEwOFRWALwBvIXILjmSlTrsl/e5wgk/h+rFSCBpG
        kZ0lMi1WvWflePD9ZlBOyJIV5AuzZpxqmPHfzRI=
X-Google-Smtp-Source: APXvYqxxxWiPsQNBja/YMAnfuNVmnBzdVVgcjzVN02DrqIp7syMPEDT70rp2uojNcxcCTJfoNFle5kJC0WHB9uTV/2w=
X-Received: by 2002:a1f:a24b:: with SMTP id l72mr627765vke.21.1568317186563;
 Thu, 12 Sep 2019 12:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
 <20190911201500.6utotzdrwsp6qoe3@yadavpratyush.com>
In-Reply-To: <20190911201500.6utotzdrwsp6qoe3@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 12 Sep 2019 21:39:35 +0200
Message-ID: <CAKPyHN1FWPuvpwGxe5V79+VcaPzV8CpPu1pyQ1fekswuBrR6Cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: convert new/amend commit radiobutton to checketton
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 10:15 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Typo in the subject. s/checketton/checkbutton/\

Will re-roll and drop the actual keybinding patch, so that Birger can
resend his part,

Bert

>
> On 05/09/19 10:09PM, Bert Wesarg wrote:
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> > ---
> >  git-gui.sh          | 36 +++++++++---------------------------
> >  lib/checkout_op.tcl |  6 +++---
> >  lib/commit.tcl      |  4 ++--
> >  lib/index.tcl       |  8 ++++----
> >  4 files changed, 18 insertions(+), 36 deletions(-)
> >
> > diff --git a/git-gui.sh b/git-gui.sh
> > index 5bc21b8..80a07d5 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -1341,6 +1341,7 @@ set HEAD {}
> >  set PARENT {}
> >  set MERGE_HEAD [list]
> >  set commit_type {}
> > +set commit_type_is_amend 0
> >  set empty_tree {}
> >  set current_branch {}
> >  set is_detached 0
> > @@ -1348,7 +1349,6 @@ set current_diff_path {}
> >  set is_3way_diff 0
> >  set is_submodule_diff 0
> >  set is_conflict_diff 0
> > -set selected_commit_type new
> >  set diff_empty_count 0
> >
> >  set nullid "0000000000000000000000000000000000000000"
> > @@ -1435,7 +1435,7 @@ proc PARENT {} {
> >  }
> >
> >  proc force_amend {} {
> > -     global selected_commit_type
> > +     global commit_type_is_amend
> >       global HEAD PARENT MERGE_HEAD commit_type
> >
> >       repository_state newType newHEAD newMERGE_HEAD
> > @@ -1444,7 +1444,7 @@ proc force_amend {} {
> >       set MERGE_HEAD $newMERGE_HEAD
> >       set commit_type $newType
> >
> > -     set selected_commit_type amend
> > +     set commit_type_is_amend 1
>
> Why do we need a separate variable for this? Why not just check
> commit_type to know whether it is an amend or not? My guess after
> reading the patch is that we need to associate a variable with the
> checkbutton to decide its state, and since there are multiple types of
> amend that commit_type can be (amend, amend-initial, amend-merge), it is
> not easy to use it directly. Am I guessing correctly?
>
> >       do_select_commit_type
> >  }
> >
> > @@ -2828,19 +2828,10 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
> >       menu .mbar.commit
> >
> >       if {![is_enabled nocommit]} {
> > -             .mbar.commit add radiobutton \
> > -                     -label [mc "New Commit"] \
> > -                     -command do_select_commit_type \
> > -                     -variable selected_commit_type \
> > -                     -value new
> > -             lappend disable_on_lock \
> > -                     [list .mbar.commit entryconf [.mbar.commit index last] -state]
> > -
> > -             .mbar.commit add radiobutton \
> > +             .mbar.commit add checkbutton \
> >                       -label [mc "Amend Last Commit"] \
> > -                     -command do_select_commit_type \
> > -                     -variable selected_commit_type \
> > -                     -value amend
> > +                     -variable commit_type_is_amend \
> > +                     -command do_select_commit_type
> >               lappend disable_on_lock \
> >                       [list .mbar.commit entryconf [.mbar.commit index last] -state]
> >
> > @@ -3313,18 +3304,10 @@ set ui_comm .vpane.lower.commarea.buffer.frame.t
> >  set ui_coml .vpane.lower.commarea.buffer.header.l
> >
> >  if {![is_enabled nocommit]} {
> > -     ${NS}::radiobutton .vpane.lower.commarea.buffer.header.new \
> > -             -text [mc "New Commit"] \
> > -             -command do_select_commit_type \
> > -             -variable selected_commit_type \
> > -             -value new
> > -     lappend disable_on_lock \
> > -             [list .vpane.lower.commarea.buffer.header.new conf -state]
> > -     ${NS}::radiobutton .vpane.lower.commarea.buffer.header.amend \
> > +     ${NS}::checkbutton .vpane.lower.commarea.buffer.header.amend \
> >               -text [mc "Amend Last Commit"] \
> > -             -command do_select_commit_type \
> > -             -variable selected_commit_type \
> > -             -value amend
> > +             -variable commit_type_is_amend \
> > +             -command do_select_commit_type
> >       lappend disable_on_lock \
> >               [list .vpane.lower.commarea.buffer.header.amend conf -state]
> >  }
> > @@ -3349,7 +3332,6 @@ pack $ui_coml -side left -fill x
> >
> >  if {![is_enabled nocommit]} {
> >       pack .vpane.lower.commarea.buffer.header.amend -side right
> > -     pack .vpane.lower.commarea.buffer.header.new -side right
> >  }
> >
> >  textframe .vpane.lower.commarea.buffer.frame
> > diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
> > index 9e7412c..a522829 100644
> > --- a/lib/checkout_op.tcl
> > +++ b/lib/checkout_op.tcl
> > @@ -389,7 +389,7 @@ $err
> >  }
> >
> >  method _after_readtree {} {
> > -     global selected_commit_type commit_type HEAD MERGE_HEAD PARENT
> > +     global commit_type HEAD MERGE_HEAD PARENT
>
> This cleans up an unused variable declaration. Nice.
>
> >       global current_branch is_detached
> >       global ui_comm
> >
> > @@ -490,12 +490,12 @@ method _update_repo_state {} {
> >       #    amend mode our file lists are accurate and we can avoid
> >       #    the rescan.
> >       #
> > -     global selected_commit_type commit_type HEAD MERGE_HEAD PARENT
> > +     global commit_type_is_amend commit_type HEAD MERGE_HEAD PARENT
> >       global ui_comm
> >
> >       unlock_index
> >       set name [_name $this]
> > -     set selected_commit_type new
> > +     set commit_type_is_amend 0
> >       if {[string match amend* $commit_type]} {
> >               $ui_comm delete 0.0 end
> >               $ui_comm edit reset
> > diff --git a/lib/commit.tcl b/lib/commit.tcl
> > index 83620b7..384f18f 100644
> > --- a/lib/commit.tcl
> > +++ b/lib/commit.tcl
> > @@ -327,7 +327,7 @@ proc commit_writetree {curHEAD msg_p} {
> >  proc commit_committree {fd_wt curHEAD msg_p} {
> >       global HEAD PARENT MERGE_HEAD commit_type commit_author
> >       global current_branch
> > -     global ui_comm selected_commit_type
> > +     global ui_comm commit_type_is_amend
> >       global file_states selected_paths rescan_active
> >       global repo_config
> >       global env
> > @@ -461,8 +461,8 @@ A rescan will be automatically started now.
> >
> >       # -- Update in memory status
> >       #
> > -     set selected_commit_type new
> >       set commit_type normal
> > +     set commit_type_is_amend 0
> >       set HEAD $cmt_id
> >       set PARENT $cmt_id
> >       set MERGE_HEAD [list]
> > diff --git a/lib/index.tcl b/lib/index.tcl
> > index b588db1..e07b7a3 100644
> > --- a/lib/index.tcl
> > +++ b/lib/index.tcl
> > @@ -466,19 +466,19 @@ proc do_revert_selection {} {
> >  }
> >
> >  proc do_select_commit_type {} {
> > -     global commit_type selected_commit_type
> > +     global commit_type commit_type_is_amend
> >
> > -     if {$selected_commit_type eq {new}
> > +     if {$commit_type_is_amend == 0
> >               && [string match amend* $commit_type]} {
> >               create_new_commit
> > -     } elseif {$selected_commit_type eq {amend}
> > +     } elseif {$commit_type_is_amend == 1
> >               && ![string match amend* $commit_type]} {
>
> Not exactly related to your change, but shouldn't these "string match
> amend*" in the two ifs be assertions instead of checks? If
> $commit_type_is_amend == 0, then $commit_type should _always_ be amend*,
> and if $commit_type_is_amend == 1, then $commit_type should _never_ be
> amend*.
>
> I don't see assertions being used anywhere, but I suppose we should look
> into them in the future. It would be great if you can start using
> something like that here, but I'm fine with keeping this like it is
> right now too.
>
> >               load_last_commit
> >
> >               # The amend request was rejected...
> >               #
> >               if {![string match amend* $commit_type]} {
> > -                     set selected_commit_type new
> > +                     set commit_type_is_amend 0
> >               }
> >       }
> >  }
>
> I tested it on my setup and it works fine. Thanks.
>
> --
> Regards,
> Pratyush Yadav
