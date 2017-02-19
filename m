Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5061201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 19:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdBSTFI (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 14:05:08 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36372 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdBSTFI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 14:05:08 -0500
Received: by mail-wr0-f181.google.com with SMTP id 89so48843755wrr.3
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 11:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DvV896/Izi2nszUUhm1yj9hMKDOoGH9+YhhOhADYWkw=;
        b=dEjkieeLYNFaFBN64xY0vNGqsKY84NS6EX22Ft9+XrgUujmYeL5hKCHNWjFT8gWmyA
         OnUXjnA/3IZq3ipnjxnUg5VjlgPktn5mS3ZKk8k+Fk0LWlPjqLlez47kC70Nj/e/CMDe
         wmfqQ5sMHfYx4Ifu/vnaoZX/Cp591DiKyK1HU7mhJ3P+DK2tDbRL0B1MpWoWMsOq/T/V
         j/MvEfcWJaLil8eLuIJyFteOr3n7n75lExE6JV7EVPCD/qZj1x8Vy89mLplm/fCUAR6v
         De7jYG6ZjBMj7VDcQ6DTNtRPumXmDd8nChK7ZRU5VZN8aN5EDGSOFfbOsvCjW4bE0RPl
         cbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DvV896/Izi2nszUUhm1yj9hMKDOoGH9+YhhOhADYWkw=;
        b=DnRxKFSkZLgFVaNiTIlMow1UtA4CJofP0E2rxE3RBmMeL3b+S5yAqxJ8EB8CG5aXmh
         F+6pBeoQjNshW1kMX2c0oPZOgSwMkDWcmOpAwgjXFe861nXPmBsXLT48nHcCXg88roF9
         JpIlb0TopHXrPNoD9Cet/Dgli1/eBAJq6qjaddbt4o28xtif6QIFW/j5d5rYVsSdxX2D
         RbYcehtRgmzm+GzUHnL1ZBPnYCXxWXXSdePW6zXajdei9KIegeilaID2dFEnx6NbQETN
         E51q00J5/bqpaxr3l97xlgOqUcD8gHVaJQWMMKnmYF8iV/0nNFgE9qtPbLUoYZuiYu9B
         q8Qw==
X-Gm-Message-State: AMke39mNYPX+Ah6g+J5URaVLW54tvsJpPw9/PWns1h36Kakpi7AuGDnoP9iXYbjtyj4uLovaH6dOSMlMq1r2uw==
X-Received: by 10.223.174.183 with SMTP id y52mr14247759wrc.112.1487531101145;
 Sun, 19 Feb 2017 11:05:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.226.6 with HTTP; Sun, 19 Feb 2017 11:05:00 -0800 (PST)
X-Originating-IP: [77.178.200.206]
In-Reply-To: <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
 <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com> <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org>
From:   Alex Hoffman <spec@gal.ro>
Date:   Sun, 19 Feb 2017 20:05:00 +0100
X-Google-Sender-Auth: p-5YgyJQ5kDpz1jBIcy0n5cIQgI
Message-ID: <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Then you must adjust your definition of "good": All commits that do not have
> the feature, yet, are "good": since they do not have the feature in the
> first place, they cannot have the breakage that you found in the feature.
>
> That is exactly the situation in your original example! But you constructed
> the condition of goodness in such a simplistic way (depending on the
> presence of a string), that it was impossible to distinguish between "does
> not have the feature at all" and "has the feature, but it is broken".

Johannes, thank you for correctly identifying the error in my logic.
Indeed I was using the term 'bad' also for the commit without the
feature. In order to find the commit introducing the bug in my example
a new state is needed, which would make 'git bisect' a bit more
complicated than the user 'most of the time' probably needs. Or do you
think, it would make sense to ask the user for this state (if e.g 'git
bisect' would be started with a new parameter)?
