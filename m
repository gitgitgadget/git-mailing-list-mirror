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
	by dcvr.yhbt.net (Postfix) with ESMTP id B82F81F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 09:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJUJQ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 05:16:57 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33683 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfJUJQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 05:16:57 -0400
Received: by mail-ua1-f67.google.com with SMTP id u31so3586945uah.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0T7NQiq1BbVDvYeICgcf/flwiT2dsnhRDnlsvYC9u4=;
        b=fmV5JIEqfwB69cxIHsf/nOZhf5SoNhPFFmT1UgGljkIpwmXOf9ZGTwU/crFXazdWyF
         IBEtvf42UD308my884IpMHZSdnr03guwuknd96IUDeg9WiqgGRwqtPilHQZFQHzW5WVJ
         hTAGd7b21Vxrjf+9WqEo+K/EFmpFx3Q9eZSdTljSwm1eJ226Dbp/SSOgqG6ePkUvnVBP
         eQ7aewkVpbrvROwpCkMWnDyNT1QHjDC3tI38h/gtOLndKTxMk76W1OspACu32+veRoMs
         O4vHia55+h5Fs1/N5yBKV7RVTh3qf5dMG3O+3iyVDpYQ+iqcPcUY7ihaSCWNAycoHvJF
         qz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0T7NQiq1BbVDvYeICgcf/flwiT2dsnhRDnlsvYC9u4=;
        b=lSiBHWqCxbxjzJ0grEE6pfJke1UP0OXeTKDaFZtB9AyZnd3ZV0JlqY7NSyaLhVJw2q
         nJaQhznqV/ImBVUOiWmDD+q5Z+NNLeF+EUOs5EPneUmVQxsIKoWrEVKq3RGywY4kkFzJ
         bbc4xEsUP736asjO2J3R6afkmJX+fE8YKd4efYqgfNtVArKQbVyO13iR3YHQjjaZtJwl
         nusNqGdVZzIO4D8aSF4zmHJQPPJM3L6K+5MbOrjddGC0KtRpL1svkJzZhmevbQYbs0Wk
         1V7LzvhQephHOE1jCwvhyDqMPq34rsUwXv2Onci13f4pXjQLLDudoPP5nCTQZtKfrnW+
         oR/Q==
X-Gm-Message-State: APjAAAVlRNJAevHJZsE0ZurSqVDByMYkBZqtmr3WOcROlw//RpRyhWew
        ZtsLyTEnxkMtWeY8ISOlJR6oG23lKmulhjp6K2c=
X-Google-Smtp-Source: APXvYqwQNg0URGZ1wNe1J8NggvHzAiNJ2pq+/SZzy4jvpBdBJ9yoLWMMIBx4CF/VuCjnMhOfOsyc01IKgBI+pE301Rs=
X-Received: by 2002:ab0:6519:: with SMTP id w25mr11904507uam.76.1571649415432;
 Mon, 21 Oct 2019 02:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190819214110.26461-1-me@yadavpratyush.com> <20190828215725.13376-1-me@yadavpratyush.com>
 <20190828215725.13376-5-me@yadavpratyush.com>
In-Reply-To: <20190828215725.13376-5-me@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 21 Oct 2019 11:16:42 +0200
Message-ID: <CAKPyHN0Kh8eKjzXink3YtE6wRrOgpzTYyPmLnbpbxPt3LFsvig@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] git-gui: allow undoing last revert
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Pratyush,

I just noticed that the 'Revert Last Hunk' menu entry is enabled in
the stage-list. But I think it should be disabled, like the 'Revert
Hunk' and 'Revert Line' menu entry.

Can you confirm this?

Thanks.

Bert



On Wed, Aug 28, 2019 at 11:57 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Accidental clicks on the revert hunk/lines buttons can cause loss of
> work, and can be frustrating. So, allow undoing the last revert.
>
> Right now, a stack or deque are not being used for the sake of
> simplicity, so only one undo is possible. Any reverts before the
> previous one are lost.
>
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
>  git-gui.sh   | 18 +++++++++++++++++-
>  lib/diff.tcl | 53 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 1592544..e03a2d2 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1350,6 +1350,8 @@ set is_submodule_diff 0
>  set is_conflict_diff 0
>  set selected_commit_type new
>  set diff_empty_count 0
> +set last_revert {}
> +set last_revert_enc {}
>
>  set nullid "0000000000000000000000000000000000000000"
>  set nullid2 "0000000000000000000000000000000000000001"
> @@ -3601,6 +3603,11 @@ $ctxm add command \
>         -command {apply_or_revert_range_or_line $cursorX $cursorY 1; do_rescan}
>  set ui_diff_revertline [$ctxm index last]
>  lappend diff_actions [list $ctxm entryconf $ui_diff_revertline -state]
> +$ctxm add command \
> +       -label [mc "Undo Last Revert"] \
> +       -command {undo_last_revert; do_rescan}
> +set ui_diff_undorevert [$ctxm index last]
> +lappend diff_actions [list $ctxm entryconf $ui_diff_undorevert -state]
>  $ctxm add separator
>  $ctxm add command \
>         -label [mc "Show Less Context"] \
> @@ -3680,7 +3687,7 @@ proc has_textconv {path} {
>  }
>
>  proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
> -       global current_diff_path file_states
> +       global current_diff_path file_states last_revert
>         set ::cursorX $x
>         set ::cursorY $y
>         if {[info exists file_states($current_diff_path)]} {
> @@ -3694,6 +3701,7 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
>                 tk_popup $ctxmsm $X $Y
>         } else {
>                 set has_range [expr {[$::ui_diff tag nextrange sel 0.0] != {}}]
> +               set u [mc "Undo Last Revert"]
>                 if {$::ui_index eq $::current_diff_side} {
>                         set l [mc "Unstage Hunk From Commit"]
>                         set h [mc "Revert Hunk"]
> @@ -3739,12 +3747,20 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
>                         }
>                 }
>
> +               if {$last_revert eq {}} {
> +                       set undo_state disabled
> +               } else {
> +                       set undo_state normal
> +               }
> +
>                 $ctxm entryconf $::ui_diff_applyhunk -state $s -label $l
>                 $ctxm entryconf $::ui_diff_applyline -state $s -label $t
>                 $ctxm entryconf $::ui_diff_revertline -state $revert_state \
>                         -label $r
>                 $ctxm entryconf $::ui_diff_reverthunk -state $revert_state \
>                         -label $h
> +               $ctxm entryconf $::ui_diff_undorevert -state $undo_state \
> +                       -label $u
>
>                 tk_popup $ctxm $X $Y
>         }
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 0659029..96288fc 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -569,7 +569,7 @@ proc read_diff {fd conflict_size cont_info} {
>
>  proc apply_or_revert_hunk {x y revert} {
>         global current_diff_path current_diff_header current_diff_side
> -       global ui_diff ui_index file_states
> +       global ui_diff ui_index file_states last_revert last_revert_enc
>
>         if {$current_diff_path eq {} || $current_diff_header eq {}} return
>         if {![lock_index apply_hunk]} return
> @@ -610,18 +610,25 @@ proc apply_or_revert_hunk {x y revert} {
>                 set e_lno end
>         }
>
> +       set wholepatch "$current_diff_header[$ui_diff get $s_lno $e_lno]"
> +
>         if {[catch {
>                 set enc [get_path_encoding $current_diff_path]
>                 set p [eval git_write $apply_cmd]
>                 fconfigure $p -translation binary -encoding $enc
> -               puts -nonewline $p $current_diff_header
> -               puts -nonewline $p [$ui_diff get $s_lno $e_lno]
> +               puts -nonewline $p $wholepatch
>                 close $p} err]} {
>                 error_popup "$failed_msg\n\n$err"
>                 unlock_index
>                 return
>         }
>
> +       if {$revert} {
> +               # Save a copy of this patch for undoing reverts.
> +               set last_revert $wholepatch
> +               set last_revert_enc $enc
> +       }
> +
>         $ui_diff conf -state normal
>         $ui_diff delete $s_lno $e_lno
>         $ui_diff conf -state disabled
> @@ -653,7 +660,7 @@ proc apply_or_revert_hunk {x y revert} {
>
>  proc apply_or_revert_range_or_line {x y revert} {
>         global current_diff_path current_diff_header current_diff_side
> -       global ui_diff ui_index file_states
> +       global ui_diff ui_index file_states last_revert
>
>         set selected [$ui_diff tag nextrange sel 0.0]
>
> @@ -852,5 +859,43 @@ proc apply_or_revert_range_or_line {x y revert} {
>                 return
>         }
>
> +       if {$revert} {
> +               # Save a copy of this patch for undoing reverts.
> +               set last_revert $current_diff_header$wholepatch
> +               set last_revert_enc $enc
> +       }
> +
> +       unlock_index
> +}
> +
> +# Undo the last line/hunk reverted. When hunks and lines are reverted, a copy
> +# of the diff applied is saved. Re-apply that diff to undo the revert.
> +#
> +# Right now, we only use a single variable to hold the copy, and not a
> +# stack/deque for simplicity, so multiple undos are not possible. Maybe this
> +# can be added if the need for something like this is felt in the future.
> +proc undo_last_revert {} {
> +       global last_revert current_diff_path current_diff_header
> +       global last_revert_enc
> +
> +       if {$last_revert eq {}} return
> +       if {![lock_index apply_hunk]} return
> +
> +       set apply_cmd {apply --whitespace=nowarn}
> +       set failed_msg [mc "Failed to undo last revert."]
> +
> +       if {[catch {
> +               set enc $last_revert_enc
> +               set p [eval git_write $apply_cmd]
> +               fconfigure $p -translation binary -encoding $enc
> +               puts -nonewline $p $last_revert
> +               close $p} err]} {
> +               error_popup "$failed_msg\n\n$err"
> +               unlock_index
> +               return
> +       }
> +
> +       set last_revert {}
> +
>         unlock_index
>  }
> --
> 2.21.0
>
