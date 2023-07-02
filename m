Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FCAEB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 12:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGBMKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 08:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGBMKe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 08:10:34 -0400
Received: from outgoing.fripost.org (giraff.fripost.org [IPv6:2a00:1c20:4089:126c:300f:e2a1:9840:5351])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0917F120
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 05:10:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by outgoing.fripost.org (Postfix) with ESMTP id B806F2ABCF18;
        Sun,  2 Jul 2023 14:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=x.fripost.org; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :from:from:references:content-language:subject:subject
        :user-agent:mime-version:date:date:message-id; s=
        9df9cdc7e101629b5003b587945afa70; t=1688299831; x=1690114232;
         bh=dlXn0zVBmR7AnFanSDBCam9iOj7qxMpua7JxNurQIq4=; b=p5ZNluQfiG/S
        1aYxHr5G/Nm7y3WQ4NJzCvXWlFcwDbr2BkO3KqpI2b+CSEVXatqKNqKRzUXarQpc
        HeDxhW/ZTN6UzuMQ4zHIINj3M0cky6vnxeoyG+PqMc8xn7zchWhgZLIsNx5qqjxw
        DrKIzGae2ZSUDFyD6me/3UqOXTPy2/4zyFS8SVJmd5bB6H3UlCq9lyqkSoUQUIJa
        tUimThUu68xNy5mfi08V9qAGbcqdPfJXSbmxrkp9mTdN3alv4YyR0iDR7dUfr9yv
        jnw6geJgo4ONKx5Svr2L28GtjABFoRwNpP1iOS9xOmYzHsYpoj4BlwLdZBQdVOL2
        QyTpQrodMg==
X-Virus-Scanned: Debian amavisd-new at fripost.org
Received: from outgoing.fripost.org ([127.0.0.1])
        by localhost (giraff.fripost.org [127.0.0.1]) (amavisd-new, port 10040)
        with LMTP id h39sNtdxDWgB; Sun,  2 Jul 2023 14:10:31 +0200 (CEST)
Received: from smtp.fripost.org (unknown [172.16.0.6])
        by outgoing.fripost.org (Postfix) with ESMTP id 99C0A2ABCF13;
        Sun,  2 Jul 2023 14:10:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        by smtp.fripost.org (Postfix) with ESMTPSA id 7EE3D963BF55;
        Sun,  2 Jul 2023 14:10:31 +0200 (CEST)
Message-ID: <2fc7cef7-fa7d-5ee6-f2a0-6859ed06b716@lidestrom.se>
Date:   Sun, 2 Jul 2023 14:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/9] gitk: add keyboard bind for checkout
Content-Language: en-GB
To:     Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <53e5a2e40abbf81e5577b2f79588bd8b0be6e923.1687876885.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Jens_Lidestr=c3=b6m?= <jens@lidestrom.se>
In-Reply-To: <53e5a2e40abbf81e5577b2f79588bd8b0be6e923.1687876885.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I added a branch selection dialog to be be able to check out any branch on a selected commit, in the same way as for the remove branch command.

/Jens

On 2023-06-27 16:41, Jens Lidestrom via GitGitGadget wrote:
> From: Jens Lidestrom <jens@lidestrom.se>
> 
> This also introduces the ability to check out detatched heads. This
> shouldn't result any problems, because gitk already works with
> detatched heads if they are checked out using the terminal.
> 
> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
> ---
>  gitk-git/gitk | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index bfe912983f4..596977abe89 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2691,6 +2691,7 @@ proc makewindow {} {
>      bind $ctext <Button-1> {focus %W}
>      bind $ctext <<Selection>> rehighlight_search_results
>      bind . <$M1B-t> {resethead [selected_line_id]}
> +    bind . <$M1B-o> {checkout [selected_line_head] [selected_line_id]}
>      for {set i 1} {$i < 10} {incr i} {
>          bind . <$M1B-Key-$i> [list go_to_parent $i]
>      }
> @@ -2707,7 +2708,7 @@ proc makewindow {} {
>          {mc "Create tag" command mktag}
>          {mc "Copy commit reference" command copyreference}
>          {mc "Write commit to file" command writecommit}
> -        {mc "Create new branch" command mkbranch}
> +        {mc "Create new branch" command {mkbranch $rowmenuid}}
>          {mc "Cherry-pick this commit" command cherrypick}
>          {mc "Reset current branch to here" command {resethead $rowmenuid}}
>          {mc "Mark this commit" command markhere}
> @@ -2732,7 +2733,7 @@ proc makewindow {} {
>  
>      set headctxmenu .headctxmenu
>      makemenu $headctxmenu {
> -        {mc "Check out this branch" command cobranch}
> +        {mc "Check out this branch" command {checkout $headmenuhead $headmenuid}}
>          {mc "Rename this branch" command mvbranch}
>          {mc "Remove this branch" command rmbranch}
>          {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
> @@ -3183,6 +3184,7 @@ proc keys {} {
>  [mc "<%s-minus>	Decrease font size" $M1T]
>  [mc "<F5>		Update"]
>  [mc "<%s-T>		Reset current branch to selected commit" $M1T]
> +[mc "<%s-O>		Check out selected commit" $M1T]
>  " \
>              -justify left -bg $bgcolor -border 2 -relief groove
>      pack $w.m -side top -fill both -padx 2 -pady 2
> @@ -9978,25 +9980,26 @@ proc headmenu {x y id head} {
>      tk_popup $headctxmenu $x $y
>  }
>  
> -proc cobranch {} {
> -    global headmenuid headmenuhead headids
> +proc checkout {newhead newheadid} {
> +    global headids
>      global showlocalchanges
>  
>      # check the tree is clean first??
> -    set newhead $headmenuhead
> +
> +    # The ref is either the head, if it exists, or the ID
> +    set newheadref [expr {$newhead ne "" ? $newhead : $newheadid}]
> +
>      set command [list | git checkout]
>      if {[string match "remotes/*" $newhead]} {
>          set remote $newhead
>          set newhead [string range $newhead [expr [string last / $newhead] + 1] end]
> -        # The following check is redundant - the menu option should
> -        # be disabled to begin with...
>          if {[info exists headids($newhead)]} {
>              error_popup [mc "A local branch named %s exists already" $newhead]
>              return
>          }
>          lappend command -b $newhead --track $remote
>      } else {
> -        lappend command $newhead
> +        lappend command $newheadref
>      }
>      lappend command 2>@1
>      nowbusy checkout [mc "Checking out"]
> @@ -10011,11 +10014,11 @@ proc cobranch {} {
>              dodiffindex
>          }
>      } else {
> -        filerun $fd [list readcheckoutstat $fd $newhead $headmenuid]
> +        filerun $fd [list readcheckoutstat $fd $newhead $newheadref $newheadid]
>      }
>  }
>  
> -proc readcheckoutstat {fd newhead newheadid} {
> +proc readcheckoutstat {fd newhead newheadref newheadid} {
>      global mainhead mainheadid headids idheads showlocalchanges progresscoords
>      global viewmainheadid curview
>  
> @@ -10034,12 +10037,13 @@ proc readcheckoutstat {fd newhead newheadid} {
>          return
>      }
>      set oldmainid $mainheadid
> -    if {! [info exists headids($newhead)]} {
> +
> +    if {$newhead ne "" && ! [info exists headids($newhead)]} {
>          set headids($newhead) $newheadid
>          lappend idheads($newheadid) $newhead
>          addedhead $newheadid $newhead
>      }
> -    set mainhead $newhead
> +    set mainhead $newheadref
>      set mainheadid $newheadid
>      set viewmainheadid($curview) $newheadid
>      redrawtags $oldmainid
