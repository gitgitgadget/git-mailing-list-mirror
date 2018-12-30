Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C4A1F770
	for <e@80x24.org>; Sun, 30 Dec 2018 21:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeL3Vea (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 16:34:30 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:37809 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeL3Vea (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 16:34:30 -0500
Received: by mail-ed1-f51.google.com with SMTP id h15so21457752edb.4
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 13:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=eUanMCdybEWwGoRKewjpCAblQzFpF5dO3emjUAxpyZo=;
        b=SiROgjYtnd7MrJPOxuQCTenoIpP3CzDY94gAnSaF7AEpTKRPoSLvs//zkJfKtqhMPq
         euUfSdedXh2Iw89UBKqdZP0Z5XPeUBniGWcr2d+N+Ke7CzTKl+LkaAp1mzI18vnI5MOG
         onfQWb4cpncfUCljDvm614w853stnjFPKwc3UK6vzQT6BBKvPfk8SwpWSjj989lpiYEt
         siXyRosD0ZsW2txepZLQPUfL+mCFXrkKOXquh3AOncJxCQ3gmOq1sx8LpTmSr+XGxLC0
         sHbC5TMxzbkk1jUOHGgZN1it2ZcHoQHcuZkf9lf7Z3kqy+Z9FGN4IHeP/L0ovGbytb7z
         E4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=eUanMCdybEWwGoRKewjpCAblQzFpF5dO3emjUAxpyZo=;
        b=s7GS/rfbLmyVf6vPnFIEAn7m/R4HvXgqO4r/qcS9V7rksiisLQru+bfH16lCqURJcT
         zt7IEHeiCwaeUc9tkzB268IXGsRC4Zqqz5sGDAtDFf6NLnk4Cg3nsvYZKu6d+a6J4kvo
         Qa9/qDeakKqT0H7GsmiaujKzacl/VCHOXE8ydTwuVYy4H+tl8XHnE12VI+SoN0Wop0Qc
         SNAuUYzOBvr/zfedjYnVg0OJ/AfTrlpTZJ3jYZbPyVhnIc5V7V/U+0+7XHLzcpT5ZWOU
         Tr6YALIalpJv83NevrPn0IJa2MhU5/cj9EzmWjOvc3g1ph25mDW0Q5J6npHaSI/iUwNz
         sOXw==
X-Gm-Message-State: AA+aEWbjL1pbfSFrkj41TgP8uD/WQ1Kd3yM6Ab3GHpsZUw5/FrylAzKP
        kLwfEthjUT4Hl+5E4uMEsdQ=
X-Google-Smtp-Source: AFSGD/VkiA4Yyz24wm/ug7BvWxU/7UIY/eWP1gbr5djXAnoeamQdd6JhFL1Q5ulJAKQJSlAKFiHdPA==
X-Received: by 2002:a50:ca86:: with SMTP id x6mr29113281edh.287.1546205668318;
        Sun, 30 Dec 2018 13:34:28 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id r18-v6sm9134259eja.19.2018.12.30.13.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Dec 2018 13:34:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Xheroz 128 <kenneth.951218@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git extra hook, pre-upload
References: <754B8F69-BD83-4EBB-9E86-6DF845624B1B@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <754B8F69-BD83-4EBB-9E86-6DF845624B1B@gmail.com>
Date:   Sun, 30 Dec 2018 22:34:26 +0100
Message-ID: <87k1jqem1p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 30 2018, Xheroz 128 wrote:

> Currently, I’m doing my Final Year Project that requires a hook that executes automatically on the server side of the repository, before the objects been pulled to the client side, and after the objects have been pushed to the server side, which is "post-receive" hook. The post-receive hook work well for me, but I couldn’t find any hook to be executed immediately before an upload-operation is performed, i.e. before data is sent to the client.
>
> Why Git doesn't have a hook that executed immediately before the data is sent to the client? Any advice on getting this hook or any similar function of the hook?

We do not have such a pre-upload hook, but could have one. There's an
old thread from 2011 detailing some potential downsides:

https://public-inbox.org/git/CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com/

FWIW I think most servers who find themselves needing such a hook use it
to e.g. log how many fetches a given repository might serve, and end up
instead wrapping git commands in some custom shell.

It's also possible to imagine a much deeper integration for such a hook,
e.g. something that would allow you to implement the functionality of
the uploadpack.* variables and more in your own code, but I don't know
if that's the sort of thing you're imagining.
