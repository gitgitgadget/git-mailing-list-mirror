Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1594B1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbdKJS1e (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:27:34 -0500
Received: from mail-ua0-f176.google.com ([209.85.217.176]:48788 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbdKJS1d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 13:27:33 -0500
Received: by mail-ua0-f176.google.com with SMTP id z4so7436724uaz.5
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 10:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nJP+V2tJdub6SVjy9qUcu4vpkrv56QndF7KlIRKHDnk=;
        b=ggpsW8V7qu82HT8k2c5rk1c53n4K44XOBCyyDpeKNeGBjZKWCiQAcTN7mPRPOM0ctl
         8eSg0YR3ZwyYj+bLVPuWS4rcvMREyPRFaXjuX9drYU8Q0yjXV0nio++u8U3hVz/SpiDH
         FhsfbtUGcfgIuZFbTsCMrEHIgt480xGhh6x5sklDPJj5dDnBFYRZ+ogfvRsBupUgi44z
         GsCzT1la1+ru2XKtMrQX17U8FYW1ugRMHTp8dMQX5CEKDmyNCtKl3twyR2Bv1W+uCU1K
         NNWjEEj9+9RozntM8mE63kyqPHMOXl9K+tPVB/t+xZmrydk4GWs0bZsmwMyeN9gcBR/J
         dV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nJP+V2tJdub6SVjy9qUcu4vpkrv56QndF7KlIRKHDnk=;
        b=PDdk2slZFvAKmXbgzpoR3IHmX0bVTXFihHBs10jHps9WlODZnpnJjGuONk708zPDVp
         86ZhbL2cczQKAZL1T/8MGhj3lk8qJA+cKWqokMOtLR9v1P0mTb0U5N1Mf2HOT26IPdqP
         bYMAAsfr5xA2m/cX8qdbAGYjuk1MaEswHLbDi2WeEYfoOEhi8L6JQQYFu9X2kd3l4wMM
         9/4BnGyQ4hnaSqMpnB4wlKOqgEYI96MQVBrCw1eR6RrPY5aPcnPRqd0UGhkxXCHvsbkw
         bo4pjaEZIbGz5gTieXEntd6RcF/KcHQqZspj7ze53AVLPjmlDI9A155prhmeelszxAgb
         Wdfg==
X-Gm-Message-State: AJaThX74R1HrNUxsvrvQ3vPbIJNf0/wZk7qEY9+BOgCs/lp7Zr0Wilct
        0j34wJMnLIXFcky7q+xjM9tSB9lE2l2l54A7g+Yf+g==
X-Google-Smtp-Source: AGs4zMahAC1GMY3oySZu173SZUI8qqvUX2xiO0LjdsYFvHEo8e35noBweBe6O3xEfd3HxwGyNUskL8m9Xk5nz1mSLU0=
X-Received: by 10.159.61.90 with SMTP id m26mr1115281uai.40.1510338452132;
 Fri, 10 Nov 2017 10:27:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Fri, 10 Nov 2017 10:27:31 -0800 (PST)
In-Reply-To: <20171110181304.26236-1-newren@gmail.com>
References: <20171110181304.26236-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Nov 2017 10:27:31 -0800
Message-ID: <CABPp-BF8WbB=hAAXg2pPLi4X1kyJYamTmm9faU-OiP7YnJn-xg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix issues with rename detection limits
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 10:13 AM, Elijah Newren <newren@gmail.com> wrote:
> In a repo with around 60k files with deep directory hierarchies (due to
<snip>
> Elijah Newren (4):
>   sequencer: Warn when internal merge may be suboptimal due to
>     renameLimit
>   Remove silent clamp of renameLimit
>   progress: Fix progress meters when dealing with lots of work
>   sequencer: Show rename progress during cherry picks

Sorry for the duplicate send.

I noticed the cover letter didn't appear on in the email list,
double-checked https://public-inbox.org/git/, waited over half an hour
and double checked both email and public-inbox again and still didn't
see it, so I re-sent.  Just as soon as I did, it seems that the
original and the new cover letter emails suddenly showed up right
then.  *shrug*.
