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
	by dcvr.yhbt.net (Postfix) with ESMTP id A095C1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfILTgB (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:36:01 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39305 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfILTgB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:36:01 -0400
Received: by mail-vs1-f68.google.com with SMTP id y62so17005613vsb.6
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmUa4r9mcXefPxqIzDIvUpA2ZWYGTV0R0b6Q78RmVn8=;
        b=q24KQKLRfX5LnJDRWowjZHUxpBQqWN/gFcusEpCSbctoZh837WlQSMXMO+HzTmf9vg
         e740jgPPNE7TUj5S3a1DIi6iDxSZw5YIsBzqKBr+/mVqvDtWWZNGPNx9qRt4jQ2+eesr
         EQHTBS4iH8ndpeH5NvmRwlXfHWM1zk0DXJPrt3+qNcko3zE3679d+Hx7LF/Z0uiWRnfU
         HsGMBLxiDhd4wgQb1iVH0uLm0NCc8GRU4S6p5BxB9HQU2awBQCRmLBNL8q0XnLxNrMsU
         HcydW9LXEQ/4eSFrZqFnZ/82m5WDs6sVurHAHMye0kWdBd+2KBEjOpgSayHOv4vb+CeE
         CCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmUa4r9mcXefPxqIzDIvUpA2ZWYGTV0R0b6Q78RmVn8=;
        b=AMvt9Jf6Brwo5HaUqNx80nyQH9LDPHdOxnQrtkwjPSCNENNRs/Mx1enpjotFFNFOk3
         T7o1PG0FBfkkV8ndcHCLCnM+RPPoWriErfIA044K8fZ6a6GBUR3bqIhcbBtPzISHFvI9
         lI3q//w9nxkoI4EiIpNZrWsiorim+akfZ2xR9x+QtMgMU7Lyq8jT+TrU6pE87+VRAJEw
         cb/eflWdCi68ZJUeXA6MMLedIV1yL0xRPc/KVFhHYh0PyvAnYOJgGDUHepuLps4YTvVs
         Y9fE7hQCjV8OpjI48s5ptrVQun6ccwXj6shsTAr9VAPuSBjYhbRKZtDZSAWiEWYoMeyK
         l+Uw==
X-Gm-Message-State: APjAAAWA2nWZIFN208jcd5E20ToksNJs26TjYkhuzwNmYoMQeaNHQJ9O
        Dqdv8yJQL9jSbnTqM7rzuZ7W7fr/GI+t+sJOTHfVYkEeeMI=
X-Google-Smtp-Source: APXvYqyRUF/F7PRBaGrcfSVb3A15ms/Jtchi+zp1iX2fpwC3nRO8NNNjzVhSt0NPExDK3pyHd/mmpy2kR0rv4YRet14=
X-Received: by 2002:a67:c408:: with SMTP id c8mr19490160vsk.63.1568316958765;
 Thu, 12 Sep 2019 12:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
 <20190911201500.6utotzdrwsp6qoe3@yadavpratyush.com>
In-Reply-To: <20190911201500.6utotzdrwsp6qoe3@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 12 Sep 2019 21:35:47 +0200
Message-ID: <CAKPyHN1YNWbZoJNTnGN4_Du+3Scf0bEpAYJyR_mB8X2fkfAwLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: convert new/amend commit radiobutton to checketton
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 10:15 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Typo in the subject. s/checketton/checkbutton/
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

AFAIU this now is, that the former 'selected_commit_type' was also
used as a request for the commit type, you set it to the desired one,
than call do_select_commit_type, it will than check if a state change
actually happen, and if it was to request an amend, which may also
fail, it goes back to !amend.

Thus its not an assert.

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
