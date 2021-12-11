Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8E8C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 10:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhLKKtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhLKKto (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 05:49:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB21C061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 02:49:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so37738371eda.11
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 02:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G71pwDZJ68gW78KQ6lpF525QCfKZxtWKXvUsD1agZL0=;
        b=kYSZ18KCppJ8FwaS+pFpbtCzY2LwMURFswnWvQHoRIBfkJpynUD5xgLzgOlFJC7aop
         G9rGmfeVsEwLUnt1TcFjifLTtIoM517wIMaAisvTrENI5LSsEdl9/WJNxWXG1xaslzKP
         vjy3YQUbvd8PfMkMvQ8XvGsyvIdHCow9KXBRrbZfZTeNFM48Tva9HN6r33X0fkuJxJVz
         hxd0Mh6NkATWcVdF6d0+UWRReSi7uJD0/RJs9mKqthbKl+5Lc7Smy+sIIHpa7wha1mdE
         uyZ2TBSMI2PUYZYZoUjd/VhnfuuCy/jkIDHTlrESf+ydGl9gqq1AFP3WF5crr/wFeIt8
         Nlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G71pwDZJ68gW78KQ6lpF525QCfKZxtWKXvUsD1agZL0=;
        b=ymRbFFp+/yReM7H/Wp0X2jFSQV61D+0yDUO8tkK2lsNT7RIthiX9eWgA3xY4W820+l
         DexXEP3W3RnQjk/6X+8oDWudL9zp2HkGYnkPMUDS+NsFx+lWHZEoN6LbVwkilqLpT0dE
         cIxGxAYWfl9u7d5iYpgdIPPkSzvedF1Nau/oeHRbdg5Qp+IFYI9MqCRNCzFUSXBgU9aR
         IosYwRmGxUB5yk8NWj7WzhO9oRJ+wIeb2vOmBT91ja1FIE40ydmpI9Cbv35Hpq6u+jjr
         jdX4oz+70mMskonIM/m3vGcQ4gxnf+NYDYHyA0UPsckQ6u+ReaiNomal2RwJ/L+ZCcJ8
         W/zg==
X-Gm-Message-State: AOAM5323+LCzsBVTlvp6QQBcnDSBtYgQLgCtIg4TNAa6jHMUog+Tj6rj
        GTR8IzRrdgn+rhV40zG1392aZFFWQKh7lTOFIsnER1wuWJw=
X-Google-Smtp-Source: ABdhPJz09a7mKTyfa0ycfPzEibY+aqirk1hA2qXXLq6E0HH00f7Y2Tsqb6szR4gZHBNHJgQY4yhX2T5tw5j8phhw/IU=
X-Received: by 2002:a05:6402:5cb:: with SMTP id n11mr46754740edx.279.1639219782932;
 Sat, 11 Dec 2021 02:49:42 -0800 (PST)
MIME-Version: 1.0
References: <xmqqilvvluoa.fsf@gitster.g>
In-Reply-To: <xmqqilvvluoa.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Dec 2021 02:49:31 -0800
Message-ID: <CABPp-BEpcmxyRVzC4afRTCdV1W=RQxfzUPESbR_pFGmvTXqTtg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2021, #03; Fri, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Dec 10, 2021 at 10:31 PM Junio C Hamano <gitster@pobox.com> wrote:

> * en/sparse-checkout-set (2021-12-08) 10 commits
...
>  Need to check the reroll.
>  cf. <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
>  source: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>

I'm confused by the status here; en/sparse-checkout-set already
represents v3, not v2, so you've already picked up the reroll.  (v3 is
the one containing both Stolee & Victoria's Reviewed-by.)  I think
that also means your cf. should be labeled as the source, yes?



> * es/test-chain-lint (2021-12-09) 19 commits
...
>
>  Broken &&-chains in the test scripts have been corrected.
>
>  Will merge to 'next'?

Eric sent a reroll of just patch 2 with some working clarifications.
It's a small thing, but I think it'd be great if that re-rolled patch
could be picked up and inserted into the series.  Other than that,
yeah the series is good to merge down.  (Peff and Fabian seemed to
think so too.)



> * ds/fetch-pull-with-sparse-index (2021-12-08) 6 commits
...
>  Ejected from 'seen', as it seems to fail its self-test.
>  source: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>

I _think_ Stolee addressed this in his v3 cover letter with his
comment that he also needed to merge with master[1].  However, there
are two more things pointed out by =C3=86var that need fixing[2]; maybe by
the time those two items are fixed, ld/sparse-diff-blame will merge to
master and he can rebase on master?

[1] https://lore.kernel.org/git/pull.1080.v3.git.1639149192.gitgitgadget@gm=
ail.com/
[2] https://lore.kernel.org/git/CABPp-BEs5gnX+HfPNMRBqtMdhVfkk5oKDT8sN4fJiP=
G87JDjcw@mail.gmail.com/


> * pw/diff-color-moved-fix (2021-12-09) 15 commits
...
>  Will merge to 'next'?
>  source: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>

Dscho seemed to suggest that course of action[2].  (I also looked at
the series, though much more lightly -- I couldn't spot any problems.)

[2] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2112081329030.90@tvgsbejv=
aqbjf.bet/.
