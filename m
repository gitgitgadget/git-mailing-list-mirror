Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C510C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD097611C1
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhDGV5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 17:57:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:33679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhDGV5q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 17:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617832655;
        bh=UC2ve6kmdQQyqlLruL6mAobai9LexHcyKHkI1QXDt2o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ei/KLZpoN/dYIyXPvWBqipdk0D166K5deOU47Z7dys9D9mc+Usl57qj5CrqEAxGFW
         UYSuPgCZABR8JULM675gOk5LIaCWIJaaQpnMxDupIi1wO3r0Y2pRu3YPZjHixcf6IG
         FMcurODK3HIyEMo0sg8NpBNAPjO9tmjd9NL+eCzU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.233.45] ([213.196.212.198]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTqg-1l6fIO38h4-00WUCb; Wed, 07
 Apr 2021 23:57:34 +0200
Date:   Wed, 7 Apr 2021 21:43:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul Mackerras <paulus@samba.org>,
        Vladimir Chigarev via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Vladimir Chigarev <chiga17@mail.ru>,
        Vladimir Chigarev <chiga17@mail.ru>
Subject: Re: [PATCH] gitk: add option to perform 'git fetch' command
In-Reply-To: <pull.872.git.git.1611328595003.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2104072142001.54@tvgsbejvaqbjf.bet>
References: <pull.872.git.git.1611328595003.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Im/2TRDecy7COoG7xrPQT4OIMSbonmrr8GQ/emAJ6FS0c3FQzGF
 Q48pa/kNasckhB0AvW1PnlWEgJQL+EvpLRDlWKjsjlG5JcER8S5Zy/a/JnV+kpmpQYYDn/b
 kbj2Lg4v7Qi+gU54qokBOLIBsDWHoV9q6ije7sIsVZY9SoeKPCytxgg11Hfe563UlU2Lvfo
 piZXCmLaW1Q96YjnI7sPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/yWszybA4hM=:iFGDAYgRe+YBFTSGLHvDRq
 lWt4/Qy/stl6ieSbJisKc+aY03X52WEC/hbSMuZeZvPTFk+ketfP7ZYNUkMfST7BX8cn+ysxS
 eQm3+KzNyDKPRZGyMPGJ09jah9nUbd2Is126DdAXnQkRRyohaktw6Cb0vtzI4hlMYGzkdPANd
 7Wo6Vo/R/jTmAF0pUSqNEV+Ly0bXuxNS81ZkYMHU37ES7yV0YkkkwMCsDGwioqv4x+xizK/GZ
 XnjKfhYRXGqLBqr/qWobikM9qX7wPpDA/0hUoUAX66S0XM0Zr8XL7XAqbyrK9y9+BsiLKMRfa
 qx2bzeOCMez3t44sJGnX/7sC130yAF5REwomS3Eu5cAgCvEA9C/9Rl+N5Q0CIO370tlNS8jcG
 GjLIhk6C3VFs8mu4JL++lgnCkEWVAvQRA4JOdDaxpfgKcC2yk7iUuQ86e8T+FoCivV1J9CN9Q
 Dj/+AXx2UBfO2lB3P+XFSfgl2EMEbon2AviEImhp3e7uBBIZ5xdtqCSTHkTHvKxb9G6v4/Qep
 Z3eeL7PRHJC31mgSdbCIxirU4ylFHPh7hmQzm3q3NX2kFaTh187f7zwz7l/6lKMzfEKgGgoDr
 3rqj2J9qXQatU4qTlReVSqakn5mSyI4ljxVfAamySsu9fo3n6aWVgtqkL8asDcCsTXHM6kzAl
 p2JVAw2xjLf2Ppx5BPYK45oeFkcZBEaCzXN+6NezNzIgcpVSL6sguwwntFQU7PSShKYoCrGoS
 yPf2DVinw5xuH3MOam4ajQuFF7wZqy5FDjofOAMTXYu+LW9fJEZOdYaIknBURBIUiTjgy+K0O
 4OdVzA0On/88cmCpWn92xNH0QA8QihTu3TWbiWbqGoV3Lp6dxxG8hR8exfsrxDMUve+Wd5eQt
 U14ULm8GPv9gugoCp41XkZumUqbP+OgIm0uM1pLxksAvRQCguThoQqZnSkMvj99YwjP8/GHHb
 FeJ2ItYAUEeNissh+mM6YfSsrY+9iflX2xBHLmFHFFUHbutrymbiPWYzH228UQn7ZMno/5j+K
 ppLi+I+gbTYCziyC7WBFv9y9aN9/o7Y+gETIv00ngUGFxFAnZC8NPGPK53/9MsiEiCX6n6855
 7/zeA1OstUE+0Vu3dVP3cxuhGmzlYxvcABQzmYEo7kGqQBHLSR9YlxfvQ3E8AI395WCowmviY
 EtqB/CNwH9TvHmxWEYA4NbAsP/yV8oAIhsv6n/pDeTvQNAi6rEbU1eVg4LIUMciE6pF5AAhcp
 RHwusyxZR0zKOshhE
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Cc:ing Paul, the gitk maintainer]

Paul, this patch has been stuck on the Git mailing list for a few months.
Could I ask you whether there is a chance that you could review it?

Thanks,
Johannes


On Fri, 22 Jan 2021, Vladimir Chigarev via GitGitGadget wrote:

> From: Vladimir Chigarev <chiga17@mail.ru>
>
> There wasn't ability to perform 'git fetch' from gitk tool.
> Add 'Fetch' option to 'File' menu.
> Bind it to 'F7' key.
>
> Signed-off-by: Vladimir Chigarev <chiga17@mail.ru>
> ---
>     gitk: add option to perform 'git fetch' command
>
>     There wasn't ability to perform 'git fetch' from gitk tool. Add 'Fet=
ch'
>     option to 'File' menu. Bind it to 'F7' key.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-87=
2%2Fchiga17%2Fgitk-fetch-option-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-872/c=
higa17/gitk-fetch-option-v1
> Pull-Request: https://github.com/git/git/pull/872
>
>  gitk-git/gitk | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 23d9dd1fe0d..1756385886f 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -499,6 +499,34 @@ proc getcommits {selid} {
>      }
>  }
>
> +proc fetch {} {
> +    global bgcolor NS fetch_output
> +
> +    set fetch_output {}
> +    if {[catch {exec sh -c "git fetch -v 2>&1"} fetch_output]} {
> +    }
> +
> +    set w .about
> +    if {[winfo exists $w]} {
> +	raise $w
> +	return
> +    }
> +    ttk_toplevel $w
> +    wm title $w [mc "Fetch"]
> +    make_transient $w .
> +    message $w.m -text [mc " $fetch_output "] \
> +	    -justify left -aspect 600 -border 2 -bg $bgcolor -relief groove
> +    pack $w.m -side top -fill x -padx 2 -pady 2
> +    ${NS}::button $w.ok -text [mc "Close"] -command "destroy $w" -defau=
lt active
> +    pack $w.ok -side bottom
> +    bind $w <Visibility> "focus $w.ok"
> +    bind $w <Key-Escape> "destroy $w"
> +    bind $w <Key-Return> "destroy $w"
> +    tk::PlaceWindow $w widget .
> +
> +    reloadcommits
> +}
> +
>  proc updatecommits {} {
>      global curview vcanopt vorigargs vfilelimit viewinstances
>      global viewactive viewcomplete tclencoding
> @@ -2089,6 +2117,7 @@ proc makewindow {} {
>          mc "&File" cascade {
>              {mc "&Update" command updatecommits -accelerator F5}
>              {mc "&Reload" command reloadcommits -accelerator Shift-F5}
> +            {mc "&Fetch" command fetch -accelerator F7}
>              {mc "Reread re&ferences" command rereadrefs}
>              {mc "&List references" command showrefs -accelerator F2}
>              {xx "" separator}
> @@ -2609,6 +2638,7 @@ proc makewindow {} {
>      bindkey f nextfile
>      bind . <F5> updatecommits
>      bindmodfunctionkey Shift 5 reloadcommits
> +    bind . <F7> fetch
>      bind . <F2> showrefs
>      bindmodfunctionkey Shift 4 {newview 0}
>      bind . <F4> edit_or_newview
> @@ -3125,6 +3155,7 @@ proc keys {} {
>  [mc "<%s-KP->	Decrease font size" $M1T]
>  [mc "<%s-minus>	Decrease font size" $M1T]
>  [mc "<F5>		Update"]
> +[mc "<F7>		Fetch"]
>  " \
>              -justify left -bg $bgcolor -border 2 -relief groove
>      pack $w.m -side top -fill both -padx 2 -pady 2
>
> base-commit: 72c4083ddf91b489b7b7b812df67ee8842177d98
> --
> gitgitgadget
>
>
