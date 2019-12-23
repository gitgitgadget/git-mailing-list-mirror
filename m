Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87196C2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 21:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625EF206CB
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 21:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLWVJH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 23 Dec 2019 16:09:07 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.218]:42830 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbfLWVJH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Dec 2019 16:09:07 -0500
X-Greylist: delayed 1367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Dec 2019 16:09:06 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 2D3EA22D359C
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 14:46:19 -0600 (CST)
Received: from gator4087.hostgator.com ([192.185.4.99])
        by cmsmtp with SMTP
        id jUapiKA9p3Qi0jUapiAdA0; Mon, 23 Dec 2019 14:46:19 -0600
X-Authority-Reason: nr=8
Received: from mail-qk1-f180.google.com ([209.85.222.180]:34522)
        by gator4087.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <xda@abalgo.com>)
        id 1ijUao-003YO8-VF
        for git@vger.kernel.org; Mon, 23 Dec 2019 14:46:19 -0600
Received: by mail-qk1-f180.google.com with SMTP id j9so14903527qkk.1
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 12:46:18 -0800 (PST)
X-Gm-Message-State: APjAAAUdizUd1+QY4OpF3iZILJmthMstzZz2RVlDpQMfVJfmrWJYUaF1
        cx7vnIu15Y1217sLTnG3IsT94ZbHHMB6JHbblYk=
X-Google-Smtp-Source: APXvYqxI4Ta+SAMwG/a4YLYMvECQC8JkY33Jj1NpnCGvM1/JO2wkTLobbfgAHV6lLtgAFtnPUDiAivNyE39vBI23sFw=
X-Received: by 2002:a05:620a:91c:: with SMTP id v28mr27415419qkv.248.1577133978432;
 Mon, 23 Dec 2019 12:46:18 -0800 (PST)
MIME-Version: 1.0
References: <CAEW0o+gwbNyDqmiouFzO16LsRUfcAnSwj9K77oGe5hi=EVMB=w@mail.gmail.com>
 <20191223190950.GA6240@camp.crustytoothpaste.net>
In-Reply-To: <20191223190950.GA6240@camp.crustytoothpaste.net>
From:   Arnaud Bertrand <xda@abalgo.com>
Date:   Mon, 23 Dec 2019 21:46:06 +0100
X-Gmail-Original-Message-ID: <CAEW0o+jRW8LJqfjsDVtUiSNxwM9yBkj0c=Ddy3kEGUdsYM8myQ@mail.gmail.com>
Message-ID: <CAEW0o+jRW8LJqfjsDVtUiSNxwM9yBkj0c=Ddy3kEGUdsYM8myQ@mail.gmail.com>
Subject: Re: Possible improvement in DB structure
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arnaud Bertrand <xda@abalgo.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4087.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - abalgo.com
X-BWhitelist: no
X-Source-IP: 209.85.222.180
X-Source-L: No
X-Exim-ID: 1ijUao-003YO8-VF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: mail-qk1-f180.google.com [209.85.222.180]:34522
X-Source-Auth: abalgo
X-Email-Count: 11
X-Source-Cap: YWJhbGdvO2FiYWxnbztnYXRvcjQwODcuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Brian,

Today, I think that tags are not located in objects directory but in
refs/tags which is a good idea.;-)

The origin of my reflection was that I wanted to find an old file.

I knew that in the past of my project, we had started to write a
driver for a device and it was abandoned. I wanted to find this file.
I knew a "key line" to search for and I knew the file was a .c file
but I didn't know the exact name.

So, the goal was to parse all the database, find all the different .c
files and grep it to find the the driver.

And there began the problems.... I had a huge database and I've
written a script that had to:
1. Identify all the trees (straight forward if all trees are in objects/trees)
2. In each trees, identify all different *.c files
3. grep "key line" in them

Well, as I said, I had a huge database and I took a long time to get
the information.

If the objects had been separated directly, it would have been much simpler.

It is just an example, finally, I've written a cron job that unpacks
everything and saves all the trees sha in a file that can be parsed by
scripts.

So, a small change in the db structure could be very helpful for this
kind of needs.

About the fact that searching for an arbitrary object will consume
more time... It's very rare to look for an object without knowing it's
type, and parsing 3 subdirs instead of one is not so time consuming by
comparison of the operation described above.

Arnaud Bertrand, Belgium



Le lun. 23 déc. 2019 à 20:10, brian m. carlson
<sandals@crustytoothpaste.net> a écrit :
>
> On 2019-12-23 at 13:00:46, Arnaud Bertrand wrote:
> > Hello,
> >
> > According to my understanding, git has only 3 kinds of objects:
> > (excluding the packed version)
> > - the blobs
> > - the trees
> > - the commits
>
> There are also tags.
>
> > Today to parse all objects of the same type, it is necessary to parse
> > all the objects and test them one by one.
>
> This isn't a behavior we often want.  Can you say more about why you
> want to do this?
>
> > May be due to my limited knowledge of git, I don't see any advantage
> > to put everything together.
> > By splitting the objects directory, the gain in performance could be
> > important, the scripts simplified, the representation more clear.
>
> Oftentimes, we want to look up an item that we would refer to as a
> tree-ish.  That means that any tag, commit, or tree can be used in this
> case and it will automatically be resolved to the appropriate tree.
>
> Currently, we can look for any loose object, and then look for any
> packed object, which is a limited number of lookups (at most, the number
> of packs plus one).  Your proposal would have us look up at most the
> number of packs plus six.
>
> In addition, we sometimes know that we need to look up an object, but
> don't know its type.  We would incur additional costs in this case as
> well.
>
> I'm not sure that we would gain a lot other than conceptual tidiness,
> but we would incur additional performance costs.  We can currently
> distinguish between the type of all of these objects by simply reading
> the object header, which on a 64-bit system cannot exceed 28 bytes,
> which we do in some cases, such as `git cat-file --batch`.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
