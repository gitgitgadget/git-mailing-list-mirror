Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA731F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 06:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfJGGNM (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 02:13:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34897 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfJGGNM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 02:13:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so7966790pfw.2
        for <git@vger.kernel.org>; Sun, 06 Oct 2019 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=k9wHgUhPV7hUm9TUX547E/y85LU5wGMEbEjL2zuI53w=;
        b=eUGKKgL5pwmurz77P1aU0evyuXqXW5omxyJG1OKCcMx8q+HzhYnF6katHisnTMXYSY
         CwpDaUD3tUh58H1hz3yj3H0hU21L2D9Ln55GVP2GQ+ZNBFBguhAdkrO3viCLVLDNd3BY
         IqLT0m9/nmSjNaA9r1SZzGk1bM5fWmVUzRZrT4PnC7jU/+JBz5j1cJ19zk3s3KlKMjJm
         WcvLn0v2+Nsj1YHoHFXwM2dncILskn7mUH4JX5TR2taIJgrnZpPvrDelfkQfzuAJqyl0
         AbU2/x4VJgtBuDoSB0YZ3tT+WvvtxLNTgboErHWfgb+leqMBcrhk03tpwmtmwhwQmH23
         G6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=k9wHgUhPV7hUm9TUX547E/y85LU5wGMEbEjL2zuI53w=;
        b=bL+tFdlW6hsUh1PxW46qz9tsqVHg9ykFP7jyj822RslDaWDqOzhjYEQtTXRPGmoH/s
         BjaiepLx1Z2kGyr8tkc1+kLbMRhMEYrHzS1Uy7fvcd6WRxpKLvY/cdww3r0lMbw1kUhv
         5qGiZmaSRVXhJ+euer8+GUpEo34lruSXxA5eRdnvyBZaodeomYO+TY3IjberdjCWBBw3
         UKQ8C8G0HzgYaAWje+Zx24rnSaC3NzZfyJf3E8x+CcR6as1INP9uWESJI6mi045kz3A3
         01iw6herIrF0E2V/DBdiw+/WXaj7CJRC2UZ2LWZgKtOagQKyHXCVC3eyvWW7XRGbqovb
         TIUw==
X-Gm-Message-State: APjAAAX/J9E49t5xcUz4sfQgw3KNqsSrsZwUdtiDstmMZjUA0/1xr2eU
        KlONEQv+k4MMWsuGCKqSVlg=
X-Google-Smtp-Source: APXvYqwvt35nNvSA8FngYx3lznF39uDpxUs9Dtjmf7VRCso49aU64Artf7tNfObQTpFNERuLtA7pAQ==
X-Received: by 2002:a17:90a:9d86:: with SMTP id k6mr31019359pjp.105.1570428791332;
        Sun, 06 Oct 2019 23:13:11 -0700 (PDT)
Received: from ?IPv6:2409:4073:2018:8b24:a6db:30ff:fee2:b535? ([2409:4073:2018:8b24:a6db:30ff:fee2:b535])
        by smtp.gmail.com with ESMTPSA id r185sm16101351pfr.68.2019.10.06.23.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 23:13:10 -0700 (PDT)
Message-ID: <1dbb69d96229fa9400d7eae0b4fd467ab9706815.camel@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
From:   Harish Karumuthil <harish2704@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Date:   Mon, 07 Oct 2019 11:43:06 +0530
In-Reply-To: <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
         <20160331164137.GA11150@gmail.com>
         <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
         <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
         <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
         <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
         <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
         <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
         <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush, Regarding your messages,

>On Sun, 2019-10-06 at 02:31 +0530, Pratyush Yadav wrote:
> You don't need to "set up" an email client with git-send-email. 
> git-send-email is an email client itself. Well, one which can only send 
> emails.

For now, I am sticking with a mail client ( evolution ) which does minimal
( or atleast transparent ) preprocessing  ( Tab => space conversion , line
wrapping  etc ).
Now I can send patches using the output of `git diff --patch-with-stat`
command and I hope is it enough for now.
Personaly I dont' like any solution which requires storing our mail password
as a plain text file.


> You haven't sent '/submit' over there, so those emails aren't in the 
> list (and my inbox) yet. You need to comment with '/submit' (without the 
> quotes) to tell GitGitGadget to send your PR as email.

I thought, lets finalize discussion about all the changes here in mail
thread   it self before submitting the patch. Otherwise, That is why I didn't
submitted the patch.


> One point I forgot to mention earlier was that I'm honestly not a big 
> fan of separating the binding and accelerator label. I understand that 
> you might not have the time to do this, but I think it is still worth 
> mentioning. Maybe I will implement something like that over your patch. 
> But it would certainly be nice if you can figure it out :).

I think there is a small missunderstanind in that point.

I agree that, in the initial implementation ( which I did @ 2016 ) menu
labels were separated from binding keys. But in the last update, it is not
like that.

Currently, user only need to specify single config value which is
`guitool.<name>.gitgui-shortcut` and don't have to specify accel-lable
separatly.
Label is generated from the shortcut.


> Either ways, detecting an existing shortcut is pretty easy. The `bind` 
> man page [1] says:
> 
>   If sequence is specified without a script, then the script currently 
>   bound to sequence is returned, or an empty string is returned if there 
>   is no binding for sequence.
> 
> So you can use this to find out if there is a binding conflict, and warn 
> the user.

Will try this. Thanks!



