Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4132EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 12:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGHMJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjGHMJq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 08:09:46 -0400
Received: from outgoing.fripost.org (giraff.fripost.org [193.234.15.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772211BDB
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 05:09:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by outgoing.fripost.org (Postfix) with ESMTP id 445002ACD88C;
        Sat,  8 Jul 2023 14:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=x.fripost.org; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :content-language:references:subject:subject:from:from
        :user-agent:mime-version:date:date:message-id; s=
        9df9cdc7e101629b5003b587945afa70; t=1688818184; x=1690632585;
         bh=vVZ2BGEW7J2Sce9Z5sO1qRV8veaLLf+uJo61CCXhHnM=; b=eUkLmmOgWJa8
        TtLCQCpHZnUWWP/oYtnIdKORmyvHwXj//ymcvk7hvbJ6AmsyBUM5gkzbCK+Z06SW
        II/kkLSCAxKBsehMCzCjeuyf3DlBZUpzityPA0Q3NEoXHyWhEGeoFv7eORd2UUFI
        BZg97fR3glSSXrGiLSKBQNNMWLpxwJRJYdA1JDq/amPxmVD6RxOQDl71ERe68MjN
        id0DQpc3myOB6460u0b5El4MjXMzIaI/sDmm0SLDXfTfSUrIL3gQR8tD4Rxt772X
        g6u+YI/0HGUmPrPXXqOnd7qyy5FcyXhJSOb4ca2J6ixdcZ5M2p8B0eWsQ3HSqkLo
        V1wYKL729Q==
X-Virus-Scanned: Debian amavisd-new at fripost.org
Received: from outgoing.fripost.org ([127.0.0.1])
        by localhost (giraff.fripost.org [127.0.0.1]) (amavisd-new, port 10040)
        with LMTP id E4gdU8hIrvFs; Sat,  8 Jul 2023 14:09:44 +0200 (CEST)
Received: from smtp.fripost.org (unknown [172.16.0.6])
        by outgoing.fripost.org (Postfix) with ESMTP id 2511C2ACD887;
        Sat,  8 Jul 2023 14:09:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        by smtp.fripost.org (Postfix) with ESMTPSA id 02DE3965C262;
        Sat,  8 Jul 2023 14:09:43 +0200 (CEST)
Message-ID: <ea0208be-836d-1290-148f-675aaa5a9416@lidestrom.se>
Date:   Sat, 8 Jul 2023 14:09:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   =?UTF-8?Q?Jens_Lidestr=c3=b6m?= <jens@lidestrom.se>
Subject: Re: [PATCH v2 06/10] gitk: add keyboard bind for remove branch
 command
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
 <ad6617a7badfe1d3ac252d9faabbe21b2b0f65f8.1688409958.git.gitgitgadget@gmail.com>
 <bed39dd8-3520-b509-40cf-22390566951e@kdbg.org>
Content-Language: en-GB
In-Reply-To: <bed39dd8-3520-b509-40cf-22390566951e@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This second line should not be in this commit, should it?

Damn, those adjacent lines where commands are listed always conflict when I reorder commits. I have fixed them several times and I seem to have forgot to fix them after the last reorder.

> The same comment as in the earlier commit about the checkout command
> applies here: I don't think that radio buttons are the correct UI for a
> branch selection.

I discuss this in the tread about the checkout command.

> In general, such duplication of code should not happen. The dialog only
> differs in the title and help text and should be factored into a helper
> function.

I will extract a procedure for this and use in the implementation of both the commands, possibly something similar to the List references dialog.

/Jens

On 2023-07-05 22:00, Johannes Sixt wrote:
> Am 03.07.23 um 20:45 schrieb Jens Lidestrom via GitGitGadget:
>> From: Jens Lidestrom <jens@lidestrom.se>
>>
>> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
>> ---
>>  gitk-git/gitk | 104 ++++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 89 insertions(+), 15 deletions(-)
>>
>> diff --git a/gitk-git/gitk b/gitk-git/gitk
>> index 8364033ad58..65ca11becca 100755
>> --- a/gitk-git/gitk
>> +++ b/gitk-git/gitk
>> @@ -2692,6 +2692,8 @@ proc makewindow {} {
>>      bind $ctext <<Selection>> rehighlight_search_results
>>      bind . <$M1B-t> {resethead [selected_line_id]}
>>      bind . <$M1B-o> {checkout [selected_line_heads] [selected_line_id]}
>> +    bind . <$M1B-m> {rmbranch [selected_line_heads] [selected_line_id] 1}
>> +    bind . <$M1B-b> {mkbranch [selected_line_id]}
> 
> This second line should not be in this commit, should it?
> 
>>      for {set i 1} {$i < 10} {incr i} {
>>          bind . <$M1B-Key-$i> [list go_to_parent $i]
>>      }
>> @@ -2735,7 +2737,7 @@ proc makewindow {} {
>>      makemenu $headctxmenu {
>>          {mc "Check out this branch" command {checkout [list $headmenuhead] $headmenuid}}
>>          {mc "Rename this branch" command mvbranch}
>> -        {mc "Remove this branch" command rmbranch}
>> +        {mc "Remove this branch" command {rmbranch [list $headmenuhead] $headmenuid 0}}
>>          {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
>>      }
>>      $headctxmenu configure -tearoff 0
>> @@ -3185,6 +3187,8 @@ proc keys {} {
>>  [mc "<F5>		Update"]
>>  [mc "<%s-T>		Reset current branch to selected commit" $M1T]
>>  [mc "<%s-O>		Check out selected commit" $M1T]
>> +[mc "<%s-B>		Create branch on selected commit" $M1T]
>> +[mc "<%s-M>		Remove selected branch" $M1T]
> 
> Same here.
> 
>>  " \
>>              -justify left -bg $bgcolor -border 2 -relief groove
>>      pack $w.m -side top -fill both -padx 2 -pady 2
>> @@ -10121,32 +10125,102 @@ proc readcheckoutstat {fd head_to_checkout ref_to_checkout id_to_checkout} {
>>      }
>>  }
>>  
>> -proc rmbranch {} {
>> -    global headmenuid headmenuhead mainhead
>> +proc rmbranch {heads_on_commit id shouldComfirm} {
>> +    global mainhead
>>      global idheads
>> +    global confirm_ok sel_ix NS
>>  
>> -    set head $headmenuhead
>> -    set id $headmenuid
>> -    # this check shouldn't be needed any more...
>> -    if {$head eq $mainhead} {
>> +    if {[llength $heads_on_commit] == 0} {
>> +        error_popup [mc "Cannot delete a detached head"]
>> +        return
>> +    }
>> +
>> +    if {[llength $heads_on_commit] == 1 && [lindex $heads_on_commit 0] eq $mainhead} {
>>          error_popup [mc "Cannot delete the currently checked-out branch"]
>>          return
>>      }
>> -    set dheads [descheads $id]
>> -    if {[llength $dheads] == 1 && $idheads($dheads) eq $head} {
>> -        # the stuff on this branch isn't on any other branch
>> -        if {![confirm_popup [mc "The commits on branch %s aren't on any other\
>> -                        branch.\nReally delete branch %s?" $head $head]]} return
>> +
>> +    # Filter out mainhead
>> +    set mainhead_ix [lsearch $heads_on_commit $mainhead]
>> +    if {$mainhead_ix != -1} {
>> +        set heads_on_commit [lreplace $heads_on_commit $mainhead_ix $mainhead_ix]
>> +    }
>> +
>> +    # Filter out remote branches
>> +    foreach head_ix [lsearch -all $heads_on_commit "remotes/*"] {
>> +        set heads_on_commit [lreplace $heads_on_commit $head_ix $head_ix]
>> +    }
>> +
>> +    if {[llength $heads_on_commit] == 0} {
>> +        # Probably only current branch and its remote branch on commit
>> +        error_popup [mc "Cannot delete branch"]
>> +        return
>>      }
>> +
>> +    set nr_heads_on_commit [llength $heads_on_commit]
>> +    set first_head [lindex $heads_on_commit 0]
>> +
>> +    if {$nr_heads_on_commit == 1} {
>> +        # Only a single head, simple comfirm dialogs
>> +
>> +        set head_to_remove $first_head
>> +        set dheads [descheads $id]
>> +
>> +        if {[llength $dheads] == 1 && $idheads($dheads) eq $head_to_remove} {
>> +            # the stuff on this branch isn't on any other branch
>> +            if {![confirm_popup [mc "The commits on branch %s aren't on any other\
>> +                            branch.\nReally delete branch %s?" $head_to_remove $head_to_remove]]} return
>> +        } elseif {$shouldComfirm} {
>> +            if {![confirm_popup [mc "Really delete branch %s?" $head_to_remove]]} return
>> +        }
>> +    } else {
>> +        # Select branch dialog
>> +
>> +        set confirm_ok 0
>> +
>> +        set w ".selectbranch"
>> +        ttk_toplevel $w
>> +        make_transient $w .
>> +        wm title $w [mc "Delete branch"]
>> +        ${NS}::label $w.m -text [mc "Which branch to delete?"]
>> +        pack $w.m -side top -fill x -padx 20 -pady 20
>> +        ${NS}::frame $w.f
>> +
>> +        set sel_ix 0
>> +        for {set i 0} {$i < $nr_heads_on_commit} {incr i} {
>> +            ${NS}::radiobutton $w.f.id_$i -value $i -variable sel_ix \
>> +                -text [lindex $heads_on_commit $i]
> 
> The same comment as in the earlier commit about the checkout command
> applies here: I don't think that radio buttons are the correct UI for a
> branch selection.
> 
> In general, such duplication of code should not happen. The dialog only
> differs in the title and help text and should be factored into a helper
> function.
> 
>> +            bind $w.f.id_$i <Key-Up> "set sel_ix [expr ($i - 1) % $nr_heads_on_commit]"
>> +            bind $w.f.id_$i <Key-Down> "set sel_ix [expr ($i + 1) % $nr_heads_on_commit]"
>> +            grid $w.f.id_$i -sticky w -padx 20
>> +        }
>> +
>> +        pack $w.f -side top -fill x -padx 4
>> +        ${NS}::button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
>> +        bind $w <Key-Return> "set confirm_ok 1; destroy $w"
>> +        pack $w.ok -side left -fill x -padx 20 -pady 20
>> +        ${NS}::button $w.cancel -text [mc Cancel] -command "destroy $w"
>> +        bind $w <Key-Escape> [list destroy $w]
>> +        pack $w.cancel -side right -fill x -padx 20 -pady 20
>> +        bind $w <Visibility> "grab $w; focus $w.f.id_$sel_ix"
>> +
>> +        tkwait window $w
>> +        if {!$confirm_ok} return
>> +
>> +        set head_to_remove [lindex $heads_on_commit $sel_ix]
>> +    }
>> +
>> +    # Perform the command
>> +
>>      nowbusy rmbranch
>>      update
>> -    if {[catch {exec git branch -D $head} err]} {
>> +    if {[catch {exec git branch -D $head_to_remove} err]} {
>>          notbusy rmbranch
>>          error_popup $err
>>          return
>>      }
>> -    removehead $id $head
>> -    removedhead $id $head
>> +    removehead $id $head_to_remove
>> +    removedhead $id $head_to_remove
>>      redrawtags $id
>>      notbusy rmbranch
>>      dispneartags 0
> 





