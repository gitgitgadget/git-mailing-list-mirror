Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D25B1F4C0
	for <e@80x24.org>; Wed,  6 Nov 2019 19:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbfKFTsa (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 14:48:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:45443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbfKFTsa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 14:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573069702;
        bh=4ADn0JRrTpgmvuDQsPEqvCB09DxTyB8/MO1sbcDXzQk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject;
        b=dA0u1kxWb/JQHqMrzjH18bBGckYjerHHDHPUgNZcVto2yDSNexMPw226SjvvQSdvm
         65CnBhC9gNxHZDm+PFtbqOZysMt9mg8bq8BF+ErJReFX1k31ki0f57BD0Tt6MI2TEp
         6EEWp+X1JQ/sCGgibP8QtM0fJyxhFbPBU05N7oU0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1i6pvd0CMp-00oZiu; Wed, 06
 Nov 2019 20:48:22 +0100
Date:   Wed, 6 Nov 2019 20:48:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: [BUG] "fatal: bad object .alternate" during fetch with alternates
Message-ID: <nycvar.QRO.7.76.6.1911041053190.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kM6gfunZZeptCK04IiprNpjb3Z/WrlKeqLUphfTJnvQe1yR8kWd
 brGhD6WUn/vejVxPDBpTLad+U6D8K7pyPM2/M32si/OtNsa+x2X2qfo2jIQiGUzf039MkGP
 x2PeP39tI/f9H5uWMoaLJCJYd16BAvHUngkABBByzzu4tJw4M4UWzB52tgQ5HFrUs5t6NjP
 ylxu0R9VSodXKy1heM0cA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M1R17cjo+n4=:CDj+5CrvH9vslqUfjcGF63
 z9OdhD/EbeF8FHP9IdK+Dqkoc7l2WYFLyisuJKsyMfDj5CrHQrz89owO0xjj+VkmSlLAvwYme
 MCDq0RAqbdOkzO527S43ksqN8QvL5NdGSk/wofApIUnJGz9/3862YOxFIOj4/ONvkFHSujzkw
 9jfYL4wXd4TuVL3glSQac5PwcjpwdYRnGiTUqW93gTfphZF4xpTVUN1JdppgoWVVQjkrPC6Ic
 eitmwSnVPvFwWMDpOU7iNr7u1dsycoxGk1SfSkP3Aia2BlKo1QvBd6KFMbdKW64tWcSK6mSpH
 MTFOLLZOpydXPx6cUlnT8SiHjgqliFZtAxcIwVhZ677bWt5rAMsFzuVvg+DJTLz9taX7pnYzU
 8I3qpVcicMZSNd8YHP3BddL/hdnvJcfWMdCISwQJk+PUpm0Zc26JniNhbs8WEzw5OgL7RIgfy
 PT3zjh8g5rFO0fdzmLKDloEP8bD5knSWVNKneUUnSH7w54lVOkcFuq3UhsLRVHjR+lYamWuCQ
 aT1EoQiU5/ZmNSfrYshmrFJjRy0EfZFJweWoS5VH9YTOjpqp3tGTXN8UpMP7hBybWCfsPpl1r
 vWIPYI+b+nn9GIDUXA8H5bII8JHarx2Pgl2qQeyA1/SUYH493EtG6obEeJoyZ4Hl9CBqu2FiR
 /W9EtiyH99pQuSf7RVVyqFVGhWXFWKs8yEpA2akNUAnOppSgbP/Txyv2RklEBm3cPS1yWOGZD
 x/wPuNoWcttkxaMFMfVN3x+O06XP0u6oi8FKUNK9LBG8g/dbj/uhxp21H77Z7FKRKxm9r/ckz
 hFOcx1fgOz6v5n1OHFmqa2i5K4D+rNUeimUOfOO0a1ZLJCGCX11HFxCQHTRbBv7K4awRPFitj
 nG7qWOHRQW6BTwjhKbYiorphOX9f/S4dGV0K8UfDVg9IwAHX4VLmZ8ZpYOJIj+/LPlhKdMr07
 ISx45/0U4aYuVrO/ABakpg6LidRuG7TJjy/6w7mu+Hi6gDloHBtlke/9d5BmfL3PCRhlFkML1
 HAVWsMamR+N09pJ7ptmCpcqLsMBl3L0l292vwNHHC6yg7Hef6YagZMTi+1+a6DTdS2kcmHPQE
 EVioJs2F3E6PX9MIBhNeknYj7Yr8EpdBRTsfBvb5SDOSw4t9+rGhaLo5qL7Qhm33LTJF72G3x
 Q/jz1KvyCCSXpu3IWXRCfx1qXm53tN1cu5T8cUrhiqYWh+LvL14GhchZ4IOeKRMZEUg3cMB2N
 JOVRYU7SjGaP/sg/GHF8TFH5LChxDb7s7jjKy8HoupsPWnMTcKFedxL/xQA0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

I only saw this problem arise on Sunday and wrote it off as a fluke
while fetching in parallel, but it persisted today, under more
controlled circumstances. I wanted to fast-forward a local branch:

$ git fetch origin master:master
fatal: bad object .alternate
error: https://github.com/git-for-windows/git did not send all necessary objects

`git grep`ing around, I saw that you added the code producing that error
message, in 39b44ba771a (check_everything_connected: assume alternate
ref tips are valid, 2019-07-01) and I verified manually through a
combination of debugging and instrumenting that
`add_one_alternate_ref()` is indeed responsible for that `.alternate`.

Now, I think the two factors that trigger this bug over here are:

- I had all the objects locally already, as I had pushed from a topic
  branch to `master` [*1*].

- My worktree's `.git/objects` is connected to an alternate that is
  connected to the current Git repository (yes, it is circular, long
  story...) and has refs pointing to commits its alternate that have
  been gc'ed away.

So I see two problems with this error message:

- It is not helpful. It should not say `.alternate`, it should mention
  the ref itself, and ideally even the path of the alternate.

- Shouldn't the code be made smart enough to simply ignore (maybe with a
  warning) refs that point to gc'ed commits?

Ciao,
Dscho

Footnote *1*: No, I do not usually push directly to `master`. The
scenario here is that I had rebased Git for Windows' patches on top of
v2.24.0, opened a PR for the PR build, everything checked out all right,
and then I wanted to "merge" the PR, _without_ an extra merge commit on
top.
