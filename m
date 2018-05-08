Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A95200B9
	for <e@80x24.org>; Tue,  8 May 2018 13:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755005AbeEHNRF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 09:17:05 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:44243 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754991AbeEHNRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 09:17:04 -0400
Received: by mail-vk0-f67.google.com with SMTP id x66-v6so15053632vka.11
        for <git@vger.kernel.org>; Tue, 08 May 2018 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rPoWpFvnwNx1pvy0FvHRCODNfLlBTlZBtXxtEdvJs5I=;
        b=Dbg5lnHKPjacUyfOUQe7Ey/dZ36u3YrLMRkv6a1H8A2efeGqE03EuaBJ2uN72Mn65n
         AnQVPi4OoY5xAndNs2aC33aM0NiLslgMZutFzpav+Z2LS4iycABuPSx6H6Wa2XxsuvC1
         PHEb+lSyv/rElWwr/mK9ppIFrUrf5Z72iQNo7lY2HG5bsRSY/nmhDVX0/0OcUx3tEc9K
         eZXv0ALBGsSj+PKIkB9EYQFI/NBGjMNwrXQALzk6dPHIOAAJGDKrc1jqRXG8zvfVtTMY
         Dms5jleFnV2GllMVDyt0rhp3IOdg0gpyQkYDxNDAfRo54yRi5SpiYL8W6dCBUUpOL+bm
         2aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rPoWpFvnwNx1pvy0FvHRCODNfLlBTlZBtXxtEdvJs5I=;
        b=imWfBRKXz5YLvN28Y2Cow/Xvn2Xhqwd9ZV+MTHCME/9EpR8ypSxT7Fy3pOj4BaIJiy
         BaEmHoJorv8j8yVpzJ1LcW2PMf9Pd586v2Hl4N0TDYmZSmGEtphQXZ17XFHT+880h26u
         lUFnwEJn0famRVax3eyR4icTo3RULNbq6act+cDC8X16imqHF5BydZrKtNnDKT5d2IFb
         +KCgfqGOeW4Z2Xwwun/xStIrYC0R0q/U/D3zboR3dPpMDEaSPhwBNn0zHeg5Znu34DNO
         cYO7N7vEs9JX5/TWZrqqjMWDY8jpohez8sQmdqMFGJ4x97p1ac+FU5hYNM0uGPhJI/2h
         hyyA==
X-Gm-Message-State: ALQs6tDXMeiD/GKIHxUrC1FvuuE20MreNd7YDbCT0P99c/ylHJUdNJVz
        YykSfTyUztJUUu36MnscklGDGdvRVJtFVPy8w2w=
X-Google-Smtp-Source: AB8JxZp8IEtYqEqVgMRq4I+wES0yOdQxyR8Y9GaqVTVBX/5ZGDOH2MdH85l0aqKSOpwogQ8pzWmwofhwzUZtuZtTyZk=
X-Received: by 2002:a1f:701:: with SMTP id 1-v6mr35850827vkh.113.1525785423658;
 Tue, 08 May 2018 06:17:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.100.7 with HTTP; Tue, 8 May 2018 06:17:03 -0700 (PDT)
In-Reply-To: <20180508122256.nyv6ddcoifygfpk4@pflmari>
References: <20180508121104.rtsrektxiihvpqtx@pflmari> <20180508122256.nyv6ddcoifygfpk4@pflmari>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 8 May 2018 15:17:03 +0200
Message-ID: <CAKPyHN3YMU3oZaW-wR2ZMV6aMwoeFGMmiJBQXtvipVvkWPLZVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gitk: add an option to run gitk on an item in the
 file list
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 2:22 PM, Alex Riesen
<alexander.riesen@cetitec.com> wrote:
> From: Alex Riesen <raa.lkml@gmail.com>
>
> Similar to a git gui feature which visualizes history in a submodule,
> the submodules cause the gitk be started inside the submodule.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>  gitk | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/gitk b/gitk
> index d34833f..1ec545e 100755
> --- a/gitk
> +++ b/gitk
> @@ -2682,6 +2682,7 @@ proc makewindow {} {
>         {mc "External diff" command {external_diff}}
>         {mc "Blame parent commit" command {external_blame 1}}
>         {mc "Copy path" command {clipboard clear; clipboard append $flist_menu_file}}
> +       {mc "Run gitk on this" command {flist_gitk}}
>      }
>      $flist_menu configure -tearoff 0
>
> @@ -3555,6 +3556,17 @@ proc flist_hl {only} {
>      set gdttype [mc "touching paths:"]
>  }
>
> +proc flist_gitk {} {
> +    global flist_menu_file findstring gdttype
> +
> +    set x [shellquote $flist_menu_file]

this needs to handle cdup, i.e., if gitk is run from a subdirectory,
all paths needs to be prefixed with $cdup, like: [file join $cdup
$flist_menu_file]

Bert

> +    if {[file isdirectory $flist_menu_file]} {
> +       exec sh -c "cd $x&&gitk" &
> +    } else {
> +       exec gitk -- $x &
> +    }
> +}
> +
>  proc gitknewtmpdir {} {
>      global diffnum gitktmpdir gitdir env
>
