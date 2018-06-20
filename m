Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1791F403
	for <e@80x24.org>; Wed, 20 Jun 2018 11:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbeFTLx3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 07:53:29 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:40775 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeFTLx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 07:53:28 -0400
Received: by mail-lf0-f43.google.com with SMTP id q11-v6so4507857lfc.7
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6j6Ugc+an9VB7i9ZkVy3PD0u+sq8MeT/xC4O342Nx4=;
        b=OVJP+Hy5wNCuPjUV/TYHikJawHUAUiJFaX31wIgfnh+0wfDvjLsitKnbmOosk2mVLO
         MDYunysbtu4Zb5vOrQhYjO8Fdsvh6jCeEH9bcDn8O84ZAvdUENR2zoSWmwQWImWlksyR
         B4NHSODFBrShSyAF13bcdkRacvq5IwpeuGwrigpIssJLGTa606WTIZ3iBRJ+S250pN4z
         OYOzs9rBUlGCZkVYxyGlZlfYJAacE0YSfUCMZ0pyCZDMurDCac2jGrZGrKY/SKEn/oUI
         pLgBZCDKtUi2Nt95nIZTW9XGNeGMDBX1Hw3a9HyEM7WysWmOp5nj6wADrYpSzTBgsW21
         F5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6j6Ugc+an9VB7i9ZkVy3PD0u+sq8MeT/xC4O342Nx4=;
        b=QT0AqryFepk+n1xXOtIFDBkypOH76Fh+VYkDqnF2JmW3HdRjsjlN9rqYjdTvr20jjB
         Wy+Y2fOfl4JbTeFX/7QK+4tvPjfCjFMp7iZLFywcj7/Xu0li1rccIV0916SoYPYzkpnJ
         KxDNMdVG5+YB2COoS/JFYqmhu3NzAR8DVyK0sqTGejP2MCaloR0D+KfTTxHbfWZMRerK
         WYETtVhzea9BNgtyJeagf682mazU7RaF9ng1C60niKVGn7wXXhb4JkvoY5oA6Yd/05GW
         S5+7DgRkt7Z8HSCLmRLAlf/QuuYxtfSjp1K2z1CYYYEukb7lVsW1qcwrSVlNKMKslLzD
         eaAA==
X-Gm-Message-State: APt69E2NKlGCIRUv9cioAt8aghFzLJcs5Pi5MEQsTNUf+7J2ZkOcX90y
        kL6x5DHWHMjp8dO2P9dFiJL/8lmQXs1NusKjScSi+47p
X-Google-Smtp-Source: ADUXVKI2aAZrs9clpBx5EDBWQ2q5XODY3AK8JRTCtck7ksDjVDU+TJYVAgdy3PBBn6uXyPur4aTDYGl/tCgincaVn08=
X-Received: by 2002:a2e:9b91:: with SMTP id z17-v6mr13660788lji.121.1529495606519;
 Wed, 20 Jun 2018 04:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180618111919.GA10085@book.hvoigt.net> <20180618155544.GB6958@alpha>
 <20180619102717.GB10085@book.hvoigt.net> <CACUQV5884fs2wp+R5a-99BbJGdEbujzu2iBny+PjPeL9JeOm8Q@mail.gmail.com>
 <20180620043956.GC6958@alpha>
In-Reply-To: <20180620043956.GC6958@alpha>
From:   =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Date:   Wed, 20 Jun 2018 12:52:49 +0100
Message-ID: <CACUQV5-ynAv0p9MCRt0Yv9E6x+UN5z4uuaPOt1GpsK6A6MF2wQ@mail.gmail.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
To:     Kevin Daudt <me@ikke.info>
Cc:     hvoigt@hvoigt.net, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 20, 2018 at 5:39 AM Kevin Daudt <me@ikke.info> wrote:
>
> What this is about that when doing `git add path/` (with trailing /),
>

This is what I was referring to. If you search for 'Fake Submodules',
you'll see that some people were/are intentionally using this instead of
subtrees or submodules. Unfortunately the original article [1] seems to
be dead, but searching url in the mailing list archives leads to some
additional discussion on the subject [2,3].


[1]:http://debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-967e-0e48cbdd56cb
[2]:https://public-inbox.org/git/xmqqy47o6q71.fsf@gitster.mtv.corp.google.com/
[3]:https://public-inbox.org/git/CAGZ79kZofg3jS+g0weTdco+PGo_p-_Hd-NScZ=q2UfB7tF2GPA@mail.gmail.com/
