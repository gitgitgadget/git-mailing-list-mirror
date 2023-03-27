Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B11C76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 09:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjC0Jid (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC0Jic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 05:38:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20DA4206
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679909900; i=johannes.schindelin@gmx.de;
        bh=NaUZTR9tqbOSg1Ie/TVoEr+W1K4+W5WfVjSc8s8FeM0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KYLpJOqzOA1EcJujmtEL6oz0uV6rgiSVL745xbiswndtvv+CszivBvaFXaOfExuNC
         sMlD4uKG66fH6cLk7vBWqSTHT8C6PYEvuTQrLWgSOOhSTzsbQDcgaj7B4bPSrh8Mtn
         05vCFe1hnPmHUsLzBvT0xcrPPcMNQ4v2cyuSjF2e1i0qv6HuW4CUpXjv1+OeDGuRrQ
         ucbH8M05kdIJcj4kURT3w7L72zKQOpg0sc3fz/fpqaAB7REzX8ARmrMCv+cNnxcOcQ
         oNMWQPr6h0OaBBZQysfW0gea0OaTCFcOskaHCRClV2KNloAgklmSwM284xXx1CTNux
         KGJDKVI89MwHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Db0-1pnM4y3MK0-006gWf; Mon, 27
 Mar 2023 11:38:20 +0200
Date:   Mon, 27 Mar 2023 11:38:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Jack Adrian Zappa <adrianh.bsc@gmail.com>,
        git-mailing-list <git@vger.kernel.org>
Subject: Re: Redirect isn't working:
In-Reply-To: <Y8nyi2QxQN0+kOOk@tapette.crustytoothpaste.net>
Message-ID: <77173c7d-095d-4d98-a54a-7b2d60ee103c@gmx.de>
References: <CAKepmaibtbRsKqmiZEtDNoLHWr=JyZ7Fhang4dnmw5ROGmBQTQ@mail.gmail.com> <Y8nyi2QxQN0+kOOk@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gCzHqwoAI9Rzuvi2w9Gu5anFoSc4FVoqVJ2Hjf7tauvXqDX7/Qt
 DBPWOys8UCQDyWaR7/VOd5ft7s+3mSLYrFprRW1NYoJSUeRsyIBW4HgAC0cDHRd1hwpQLM6
 EfYFGQuevAIuq7G7We1F2rSkPfy59+Rv5AylDdHcYV19jpnGCyWGVQ6VtU6kjdq6k0c3Q2w
 WQiCLEnZfKe3HdefebB5g==
UI-OutboundReport: notjunk:1;M01:P0:3KWB7AbaGq0=;JHC1U2tYBYIWjJJIECyw5UNOGh6
 OQCaakyqStJ9nYvkUBX2mlmbJP8md/v2tT3qFMJDmKK0OYB36afT8VvPAwmpTqLHeSambYAeh
 DLM8YuHWEY4araqqnzs49Hw3p9CC0cPSVvOmd9ujxQF0blOFovb/I57ObL3+q5YE4R9Bz7gBa
 ZuLgfCbYlENxfJlGRF63phc2/PFiSL+LT5CozM+kiGG+x5lNrp+75qN4zt9+CqwDe6p/V5cDy
 3shR2vpFHjNlQmsq19xwPTtH6V+TjmuXKT1bmOBtsXSOeSfEkERQhMyE1AGXqIZzHFUYUeoCU
 zMs+ahgZz0C0sXAx9McMhM/zT7hjEwBCzQDbEXLixyywvV9VYwgnkcUMcbrNBZEFQt2QSV9sR
 3TW3DxQuVtVFBCLyKLBCG5zHxtYHucnCfCSTF+Uth1KGYUjLYfcTsiLxCo9XvZG+Z097qc7GS
 Obm3f1+qsCz1hy2iwsmsg5Hh9mJfUzhbKAsopcoRTaYbXcoAR4RyaRQ15YLnCWZho+5ad3zGi
 OrXOT+j5OB304frgn9CtLGc2pihPHVoW/wkxusnXkJXGzikYe0NufBGQNv7w5FBKi1+om0TKO
 G1tgK93rmIvQdOb8JgvxDICNe7HqbbKH8koAeFFzI6Y7Z6KwazUIJI9STYF7JlgrXAcSL56gF
 AdRevxKLbExuqltPPNZBHAMJG2Mq+ZmwMsBsmvj4NocX+/OIcJIp+kmdxf/LslY5nbikdvPM7
 4UbrurghrMu09Bn8IRBYwfsbJDBntIcjN4jNwl0+YykfK9AbJYQp1qTxqCV6MVs+9wASmC4yT
 zpd4XRH0c0wNbkmSPWq0oxsqZ0A7m18p2Y8ed+FLHxLJf49aQEj3C9Sx05kC+GiqW7nTveSjr
 2Vyl3/uSeKsJo29FmPkHLOC7WTJMr0KH9B2VwaqCncGVCZqZa87GZiepHKoa6Vraekz1gz0+Y
 Gc+kZsbORQMc8GZOnBmEXmxQaRc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian & Jack,

On Fri, 20 Jan 2023, brian m. carlson wrote:

> On 2023-01-19 at 18:06:17, Jack Adrian Zappa wrote:
> > Here is the filled out form for submitting a bug report:
> >
> > What did you do before the bug happened? (Steps to reproduce your issu=
e)
> >
> >   At the command line, I typed the following command:
> >
> >   $ git diff --no-index --word-diff --color=3Dalways <(od -An -t x1
> > -w10000000000 file1.txt) <(od -An -t x1 -w10000000000 file2.txt)
> >
> > What did you expect to happen? (Expected behavior)
> >
> >   I expected to see the diff of the two files.
> >
> > What happened instead? (Actual behavior)
> >
> >   Instead I saw this:
> >
> >   error: Could not access '/proc/1961/fd/63'
> >
> > What's different between what you expected and what actually happened?
> >
> >   The difference is that I would get the difference between the two
> > files as opposed to a critical failure message.
>
> Thanks for the report.  This has come up before (and I attempted a
> patch), but the ultimate problem here is that the /proc/PID/fd/* files
> are symlinks on Linux, and instead of dereferencing symlinks, Git tries
> to read them and print where they point to.  That doesn't work in this
> case because the symlinks are symlinks to anonymous pipes, which can't
> be resolved.
>
> On other systems, the behaviour may be different because those files may
> be represented differently.
>
> My patch attempted to solve this by simply opening the contents instead
> of stat'ing them as normal, but I think we found some edge cases and it
> didn't get finished.  Note that this behaviour is what plain diff does
> because it doesn't handle symlinks at all.

Please note that this is not about a bug in Git itself, but in the MSYS2
Bash that Git for Windows includes in its distribution.

The technical details are quite involved, and I wrote up a ticket here, in
case somebody is up for a real good challenge:
https://github.com/git-for-windows/git/issues/4266

Ciao,
Johannes
