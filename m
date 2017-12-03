Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2F120C11
	for <e@80x24.org>; Sun,  3 Dec 2017 15:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbdLCPGG (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 10:06:06 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:38624 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbdLCPGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 10:06:04 -0500
Received: by mail-it0-f65.google.com with SMTP id r6so1111759itr.3
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 07:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d5mv68UpeLEme4n1gkVxLDSV59wvEwV+r5FexOsToCU=;
        b=bk3zqsj6DzSB6ZdCXWbjaE1MuFNYWa1LDOv2MudOOy9ntCBR+ZczzhucDdAU3Sfrbk
         UFJMNu7o9X/GxPH8mTx3JpPbdVuaLDYSLZJ3s6w547UUiLK0sdRKWra5JLoFV+hfxIfR
         MJ4CyIN2nhEj+gaH/wkm1IFk790rzDEumGYEYRotp6EiGICYPf3KlTz6t1ob3nCbpf9o
         5wHmPcd8ad/cR+pJlmqQySvpkPBYS2wcTMMqwrFvLnNLrTjftf2biYvC1/aa/sEMfIWL
         ZC6W5orD0dz045mmf2sBqS361t7LVP2bA53kbsnW+hLBogchVKhiooawkWxFMW0w21QN
         fdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d5mv68UpeLEme4n1gkVxLDSV59wvEwV+r5FexOsToCU=;
        b=kvDXG9c2MGMhTKORdHBfit0d+1mP4Xi2PRPNjzmQa3QyMjcVGqNvyCauotc5SS7DtQ
         vgfbghRwPRll+4wBN5nVVrk/PEDNW32TCRScrotsjILCiaooCUsz6O6IP0lQ/w/TlBQ6
         3tfxTlT7X6mvubLh8VSBT4lPg9YyJzYFuCKYEuGU5WfnzSivC7dFQP85WJ7kfo+18in1
         v5sMOOqU5lumGmW7sdkoZpoEsOMJIcjlBgUB9G1bt9w0/Tlt0roXkqMcGo2u/xss/g++
         ynv3yRm5JC2yq5vYEQHQjOM/DvouRXu5WySWHcvxqn6781Epc2tCAk+K8l3QJ2IcKT2a
         PiIg==
X-Gm-Message-State: AKGB3mKYRKaL55LS7R4jjePBtRzptkLCfyl8nyJv0LSZ0+t6IbMXt4JN
        IVB92G/cGs5+FghjGNalqtwzrmVDcoLvD3k4VWs=
X-Google-Smtp-Source: AGs4zMYcfha5Ag/U1Moe7AoitswiLVryixhtmDZ4hG65mPLw7bBKLgj1bchkZyyXvOH16Cs5T8aFU+Nbh5z8cDdMgu0=
X-Received: by 10.36.20.68 with SMTP id 65mr1108410itg.147.1512313563097; Sun,
 03 Dec 2017 07:06:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.26.207 with HTTP; Sun, 3 Dec 2017 07:06:02 -0800 (PST)
In-Reply-To: <20171201234556.GE18220@aiede.mtv.corp.google.com>
References: <CANtxn9J9O+PADxpWa0JCcgwwk_tC5DuJGUruULN2fGP3knZ-Sw@mail.gmail.com>
 <20161204204057.32dnkjx6ixv3swez@gmail.com> <CANtxn9K9tzmbea1Dx9Z37GNfA9QfCX0gm-XHjJxieJN6bc6D-A@mail.gmail.com>
 <CANtxn9KjTToqXKeO1mM8c6kD+jLf8QcAVXF46tX61uQB7YdKYA@mail.gmail.com>
 <20171201234013.GD18220@aiede.mtv.corp.google.com> <20171201234556.GE18220@aiede.mtv.corp.google.com>
From:   Timon <timon37@gmail.com>
Date:   Sun, 3 Dec 2017 16:06:02 +0100
Message-ID: <CANtxn9+Ey8RpmcYojEp0Drf0b6Thb-6GxsKZSRmQEniFsE+k_g@mail.gmail.com>
Subject: Re: [PATCH] git-gui: allow Ctrl+T to toggle multiple paths (Re: [BUG]
 git gui can't commit multiple files)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/2/17, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jonathan Nieder wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Subject: git-gui: allow Ctrl+T to toggle multiple paths
>>
>> In the Unstaged Changes panel, selecting multiple lines (using
>> shift+click) and pressing ctrl+t to stage them causes one file to be
>> staged instead of all of the selected files.  The same also happens
>> when unstaging files.
>>
>> This regression appears to have been introduced by gitgui-0.21.0~7^2~1
>> (Allow keyboard control to work in the staging widgets, 2016-10-01).
>>
>> Also reported by zosrothko as a Git-for-Windows issue:
>> https://github.com/git-for-windows/git/issues/1012
>>
>> [jn: fleshed out commit message]
>>
>> Reported-by: Timon <timon37@gmail.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Jonathan Nieder <jrn@google.com>
>
> Gah, this should say:
>
> Signed-off-by; Jonathan Nieder <jrnieder@gmail.com>
>
> [...]
>>> I applied it locally to git-2.15.0 and can confirm it fixed the problem
>>> for me.
>>> If you need any more info/help from me, or would like me to test
>>> anything, feel free to ask.
>>
>> Thanks for this pointer.  I'm including the patch here so the project
>> can consider applying it (it doesn't appear to have been sent upstream
>> before).  I have not tested it or verified the claim it makes about
>> what change introduced this regression --- if you're able to help with
>> that, that would be welcome.
>
> Can you bisect?  That is:
>
>  git clone git://repo.or.cz/git-gui
>  cd git-gui
>  git bisect start
>  git bisect good gitgui-0.20.0
>  git bisect bad gitgui-0.21.0
>
> Then cut to the chase:
>
>  git checkout gitgui-0.21.0~7^2~1
>  ... test test test ...
>  git bisect (good|bad)
>
>  git checkout gitgui-0.21.0~7^2~1^
>  ... test test test ...
>  git bisect (good|bad)
>
> and follow the instructions if it suggests testing additional versions.
>
> Then I'll be happy to re-send the patch with the results from your
> testing.
>
> Thanks again,
> Jonathan
>

Did the testing and it went smoothly with the outcome:

088ad75dc279614849f92e5ae0a2b579b26719eb is the first bad commit
commit 088ad75dc279614849f92e5ae0a2b579b26719eb
Author: Pat Thoyts <patthoyts@users.sourceforge.net>
Date:   Sat Oct 1 22:04:39 2016 +0100

    Allow keyboard control to work in the staging widgets.

    Keyboard focus was restricted to the commit message widget and users were
    forced to use the mouse to select files in the workdir widget and only then
    could use a key combination to stage the file.
    It is now possible to use key navigation (Ctrl-Tab, arrow keys and Ctrl-T
    or Ctrl-U) to stage and unstage files.
    Suggested by @koppor in git-for-window/git issue #859

    Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

:100755 100755 11048c7a0e94f598b168de98d18fda9aea420c7d
ec1cc43e8f73acd3d52047ece4dfab5edeb6ffb4 M	git-gui.sh
