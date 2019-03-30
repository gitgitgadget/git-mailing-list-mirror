Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C45320248
	for <e@80x24.org>; Sat, 30 Mar 2019 17:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfC3RSB (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 13:18:01 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33836 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbfC3RSB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 13:18:01 -0400
Received: by mail-ua1-f68.google.com with SMTP id c6so1743363uan.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeaAF5xwdCNw53d1pf7bbMsvaUnzAC84JuupZwNIniw=;
        b=NDkIvueEDQKNxayi1JFw0yFAb+MEpe5mTmovOEBQ+tmLc/Owoj4LO1QNHQha/uwTZe
         GTyr+6A/RUq4Kj+7EaOewRE6LWBj3jBsum0+pYYn+v/UXm+IjnLOre1RLjW5RML9mdnt
         YGKXmuqfiL35Td9zmVxNLodpzCDNvO5g2ob8R/odlXMhkrhTsmsYAFXIQAd2nmRoMwF+
         yDY9/tSQQQl4kegjntkaKz7JXHDIaqOxDHbmLAh3rMgDhdb7IBsFqegegkX4URvXiedc
         575RPVMzir5BgC2VhRnm509rQ1mxsK76kcL4xZu13TVBK/fxmFtOxqpjChk7/j/mKKyL
         QYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeaAF5xwdCNw53d1pf7bbMsvaUnzAC84JuupZwNIniw=;
        b=OxktNWaBh9zn/tq9poGbwlXvMEOi1oSH2sUkfIzLfZMBwx5k7Vf2F1tWGpaObS0L7b
         lkm5T3/trIbIo6GDhG4/yTm2UGesSEPIzclgiu/KhVV7JoWtO4XPHK1zikKh/yVwFCaM
         7sImjg1jycy4tq7FqKrG5dUjKoIb/6M20qO/qZx7435l3kSx40gpVVDleN1g0VIHkA4k
         /5MGs5rVtF8Cm4PMj9mKZcvbqN3fYfyTWM/YvyX4vMMO4fHPGPDLAjQsFnHUTVD9xUK+
         /rkn+yRhVg50TQi3AOsGfEpBc6TvH1Fek52OM8nczE+AwYYAvoqw/dCzETta+f7z6GNJ
         0oFA==
X-Gm-Message-State: APjAAAWLGMO4HeiHlrRSjJyEPoALG03wLIAk7OR4LKN3lvYXQn1zy25u
        VeeFvzXhA3mijUONIr8bs9/jq52IMqvRXoTuL9Q=
X-Google-Smtp-Source: APXvYqxSD4dl4ZfykGtamgJz3yqR+GvFhG+rq0+N9Sbr8npEdpu62k4TnQFHX51Z93JZWDvcCAjUYSAEIqva37Ptd0Q=
X-Received: by 2002:a9f:24ee:: with SMTP id 101mr25102787uar.87.1553966280319;
 Sat, 30 Mar 2019 10:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEsqW61f4SWehTpFzMF97AzTUB_StOS83GAmZOC7QohSg@mail.gmail.com>
 <20190330084822.11285-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190330084822.11285-1-rohit.ashiwal265@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 Mar 2019 10:13:56 -0700
Message-ID: <CABPp-BFdg8M17YuhKOrtTS3Xeyf2TQB1+vBzDVTo5EzMebyLEA@mail.gmail.com>
Subject: Re: [GSoC][RFC v2] Improve consistency of sequencer commands
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>, artagnon@gmail.com,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 30, 2019 at 1:49 AM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
>
> Hi Elijah
>
> On 2019-03-30  0:38 UTC Elijah Newren <newren@gmail.com> wrote:
>
> > I'm curious if you're looking at an old version of the documentation
> > (...or maybe the documentation just isn't that clear?).  Interactive
> > rebases have supported --signoff since commit a852ec7f273c ("rebase:
> > extend --signoff support", 2018-03-20)
>
> Oh~ after having a quick look at my currently installed version of git,
> it was 2.17.1, which has outdated man pages :sweat_smile:. Yes, you are
> correct, I'm sorry.
>
> Feeling dumb
> Rohit

Don't feel dumb.  I like the initiative.  Also, since you highlighted
it, there might be an issue with picking merge commits; either they
aren't affected by --signoff and should be, or the documentation
should be updated to mention they are handled too.  So there is
actually something here, I think.
