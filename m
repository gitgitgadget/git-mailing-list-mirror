Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43D81F461
	for <e@80x24.org>; Fri, 23 Aug 2019 06:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404399AbfHWG3n (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 02:29:43 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36410 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404394AbfHWG3n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 02:29:43 -0400
Received: by mail-vs1-f67.google.com with SMTP id y16so5558526vsc.3
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 23:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSlHYbGVxkH1zlzBbZR2zWdNaDlwXyIxgT3Y/Yd8sdQ=;
        b=jfd69QLQba+VydyR04BZcuO0CaJMeKIi4GWXDWwDn2UVuNN74IOKsZJD82sR+A/vF5
         NHwf+l8ASrpZn+2sqDjlNOGe4CSnKInAN7Suq+wdXRnMOEAXtsbE8RM3jCDBfW+GeipO
         I36EWX/hhmx5NYGdBr0L3QIa/g30hoDAGNV0mB3ZbiMiNUoR8lF/OXa369mZhJmohILY
         my6Hyqg2XY/taAkRX7aCpH2+vdL5TGdOjLNntfObnP1ZnDoSyrH7P+CKHh23UDK6+L3K
         9A85o8H1xOm2RgdQgXjmsjA/5dumcoyjPH0pOVZWBlljiBDM0HQvPEtWR6QkY3CV3QWY
         plnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSlHYbGVxkH1zlzBbZR2zWdNaDlwXyIxgT3Y/Yd8sdQ=;
        b=r+VwsbsgRWaF/gex2GL3A90peFqkfu9Yp+7kBM5Iz87KIls9rJjiG1FSzzrdeTNFxT
         Di4k5HCDk2FhjZCC8JXkwm680mCV3ZM4ZpcZ9aqDBDin0X0QKGVq1xqJyOk5/64qomEM
         25YoxeST039UjxVD/Qn2DHvAYLoPAORY9x3Tzt6EMAr9zkqCzDyAy5dxXzj2FAz2snYi
         Ztx9igvXBHdoknE6O6D/kxvLdVCw2HsAOQOiApnlYsLT8slSxOAGtI+v/2fb7Q/j9tLs
         UkGVJOaRwrkpS/r5v69/gn3IKtzvocV+zs446KATHbpgeTAPmfRrxHUh7RwcKFHx1Xwf
         I0Ig==
X-Gm-Message-State: APjAAAVq5o9CrodXOeSCdGrqD9HRnbeHe1da6f2PRMHm02Krf7tMuGAE
        Zaiatam8PChBwW3by/IMnsINCBsQkoeFWxZbntY=
X-Google-Smtp-Source: APXvYqxTty3x/sNAKZqNaL7dpYGV636ORyOAHrG/uwFIHk9cvMfTUQTmxBO7OX0z0bWdfb1YV82DYZx9u9ad+6F9BgA=
X-Received: by 2002:a67:be0b:: with SMTP id x11mr691348vsq.75.1566541782235;
 Thu, 22 Aug 2019 23:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190819214110.26461-1-me@yadavpratyush.com> <20190822220107.4153-1-me@yadavpratyush.com>
 <20190822220107.4153-4-me@yadavpratyush.com>
In-Reply-To: <20190822220107.4153-4-me@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 23 Aug 2019 08:29:30 +0200
Message-ID: <CAKPyHN2GMV2n7rPO7NU7=wayNo3tYPNUhhwSuXK6EqAUbWEgng@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] git-gui: Add the ability to revert selected lines
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 12:01 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Just like the user can select lines to stage or unstage, add the
> ability to revert selected lines.
>
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
>  git-gui.sh   | 25 ++++++++++++++++++++++++-
>  lib/diff.tcl | 31 ++++++++++++++++++++++++++-----
>  2 files changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index b7811d8..9d84ba9 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3588,9 +3588,15 @@ set ui_diff_applyhunk [$ctxm index last]
>  lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
>  $ctxm add command \
>         -label [mc "Apply/Reverse Line"] \
> -       -command {apply_range_or_line $cursorX $cursorY; do_rescan}
> +       -command {apply_or_revert_range_or_line $cursorX $cursorY 0; do_rescan}
>  set ui_diff_applyline [$ctxm index last]
>  lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
> +$ctxm add command \
> +       -label [mc "Revert Line"] \
> +       -command {apply_or_revert_range_or_line $cursorX $cursorY 1; do_rescan}
> +set ui_diff_revertline [$ctxm index last]
> +lappend diff_actions [list $ctxm entryconf $ui_diff_revertline -state]
> +set ui_diff_revertline [$ctxm index last]
>  $ctxm add separator
>  $ctxm add command \
>         -label [mc "Show Less Context"] \
> @@ -3688,15 +3694,19 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
>                         set l [mc "Unstage Hunk From Commit"]
>                         if {$has_range} {
>                                 set t [mc "Unstage Lines From Commit"]
> +                               set r [mc "Revert Lines"]
>                         } else {
>                                 set t [mc "Unstage Line From Commit"]
> +                               set r [mc "Revert Line"]
>                         }
>                 } else {
>                         set l [mc "Stage Hunk For Commit"]
>                         if {$has_range} {
>                                 set t [mc "Stage Lines For Commit"]
> +                               set r [mc "Revert Lines"]
>                         } else {
>                                 set t [mc "Stage Line For Commit"]
> +                               set r [mc "Revert Line"]
>                         }
>                 }
>                 if {$::is_3way_diff
> @@ -3707,11 +3717,24 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
>                         || [string match {T?} $state]
>                         || [has_textconv $current_diff_path]} {
>                         set s disabled
> +                       set revert_state disabled
>                 } else {
>                         set s normal
> +
> +                       # Only allow reverting changes in the working tree. If
> +                       # the user wants to revert changes in the index, they
> +                       # need to unstage those first.
> +                       if {$::ui_workdir eq $::current_diff_side} {
> +                               set revert_state normal
> +                       } else {
> +                               set revert_state disabled
> +                       }
>                 }
> +
>                 $ctxm entryconf $::ui_diff_applyhunk -state $s -label $l
>                 $ctxm entryconf $::ui_diff_applyline -state $s -label $t
> +               $ctxm entryconf $::ui_diff_revertline -state $revert_state \
> +                       -label $r

so you have the 'Revert Line(s)'  menu entry always in the context
menu, also when the context menu was opened for an staged file (than
the menu entry is only disabled)? I think this is a step backwards
from my original patch (which isn't mentioned/referenced at all in
this patch anyway).

My orignal patch also had this hunk in lib/diff.tcl:

@@ -614,6 +619,8 @@ proc apply_hunk {x y} {

     if {$current_diff_side eq $ui_index} {
         set mi ${o}M
+    } elseif {$revert} {
+        set mi "[string index $mi 0]$o"
     } elseif {[string index $mi 0] eq {_}} {
         set mi M$o
     } else {

which is missing here. I cannot remember why I added this here. But
maybe you can?

Best,
Bert

>                 tk_popup $ctxm $X $Y
>         }
>  }
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 4cae10a..00b15f5 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -640,7 +640,7 @@ proc apply_hunk {x y} {
>         }
>  }
>
> -proc apply_range_or_line {x y} {
> +proc apply_or_revert_range_or_line {x y revert} {
>         global current_diff_path current_diff_header current_diff_side
>         global ui_diff ui_index file_states
>
> @@ -660,25 +660,46 @@ proc apply_range_or_line {x y} {
>         if {$current_diff_path eq {} || $current_diff_header eq {}} return
>         if {![lock_index apply_hunk]} return
>
> -       set apply_cmd {apply --cached --whitespace=nowarn}
> +       set apply_cmd {apply --whitespace=nowarn}
>         set mi [lindex $file_states($current_diff_path) 0]
>         if {$current_diff_side eq $ui_index} {
>                 set failed_msg [mc "Failed to unstage selected line."]
>                 set to_context {+}
> -               lappend apply_cmd --reverse
> +               lappend apply_cmd --reverse --cached
>                 if {[string index $mi 0] ne {M}} {
>                         unlock_index
>                         return
>                 }
>         } else {
> -               set failed_msg [mc "Failed to stage selected line."]
> -               set to_context {-}
> +               if {$revert} {
> +                       set failed_msg [mc "Failed to revert selected line."]
> +                       set to_context {+}
> +                       lappend apply_cmd --reverse
> +               } else {
> +                       set failed_msg [mc "Failed to stage selected line."]
> +                       set to_context {-}
> +                       lappend apply_cmd --cached
> +               }
> +
>                 if {[string index $mi 1] ne {M}} {
>                         unlock_index
>                         return
>                 }
>         }
>
> +       if {$revert} {
> +               set query "[mc "Revert changes in file %s?" \
> +                       [short_path $current_diff_path]]
> +
> +[mc "The selected lines will be permanently lost by the revert."]"
> +
> +               set reply [revert_dialog $query]
> +               if {$reply ne 1} {
> +                       unlock_index
> +                       return
> +               }
> +       }
> +
>         set wholepatch {}
>
>         while {$first_l < $last_l} {
> --
> 2.21.0
>
