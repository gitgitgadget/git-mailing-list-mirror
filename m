Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E592B20133
	for <e@80x24.org>; Fri,  3 Mar 2017 21:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbdCCVef (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 16:34:35 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdCCVee (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 16:34:34 -0500
Received: from [192.168.1.50] ([94.219.230.230]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0LkPdb-1c8dfI432Z-00cPln; Fri, 03 Mar 2017 22:03:20 +0100
From:   Carsten Fuchs <carsten.fuchs@cafu.de>
Subject: Re: git status --> Out of memory, realloc failed
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <84c02ca1-269e-2f26-c625-476d7f087f5c@cafu.de>
 <ea0722e2-c2bd-bd80-a233-50676efcafda@web.de>
 <cbd281fc-3a4b-b4dc-5dff-145c97cd68d6@cafu.de>
 <6ba86c1a-87a9-f886-273b-7f94c30c4a95@web.de>
Cc:     git@vger.kernel.org
Message-ID: <f0787f93-5bba-f79c-2211-1558b3886c09@cafu.de>
Date:   Fri, 3 Mar 2017 22:03:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <6ba86c1a-87a9-f886-273b-7f94c30c4a95@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/rSvLSZ0xSIm5bAAq2v/2vpY8+IaWy+NluyYSn03j3iFPyB0SeM
 6jvbmlDxXncDRA/Z432CjEMnMur8Lq0j0lGJp1WGGWKJCUYhVMm6/L1l2hBeXQEdd9wYLVq
 ISNeL9Tjc20vUhxTi6jqKY2iTMSj32VVT/lCnazihHbEHxiHCk+L8mLnoaOxpdAZpfPBAt9
 d16u0iUqKCWk2kRhiQ5NA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BZzluVNPPMM=:IuPnX48zVt6E4iA9swdNyy
 JP4QE+zR+EfF0HReRMUKydjkDFyw3TDKIGJZ+pLwZdH4ENB2KX/oA+RFs4OxgKzZUxAJ4BBAo
 OjC9vHXT89AFPdKV4EguV4YBXhZ6ZgRofJq9Fofo24ye/Akr2Ut+qT/qKW9LNeuxz1ae+VREz
 Ave1sAz7o3SAcqlx7+v2qYcj5oTG9SeKsURCYKnTUTA1H2vF9TzBy1D4XRMlUQo14vVpwzTdo
 QgGP8dKFd4zH9ffWCfTKan8/4RdOkDGhrZaOJfyV8gsT2J8ZM3q6xv68dC84OgoJLH2wgB71y
 gRmhlTLLBpYVJ13aFrcqN/6K7Ij1bZ18DzByRnPXkP6nJ42t44Hx/xhJNbTlBNLgeH8wWDygn
 DSehzZPsbOOxeDT8JfUcaBppTAqSsVX2Xws/nwu9GJVxSvI7LrVzCQl+2X5pWxuuezXErdhIQ
 RMo4ZmOrzPRgFcRbye5K6q8u2YOARFrvldEcHrBJJe4jltitRsBkOmD7ilnnFXgET6VNrg+YN
 H2sPhe7th0uacndzox7YYw2A+hI1OkUmAuipxqWEirzRnwJpnxwdiWDW4g8dsFoVPkJsUycot
 yhSD0f7mnhFyShJDbJyuwOqFw9tLCKYQ5uFqLyifmIfBQfvibKI63hQUg6w88gr2NVB3wzCZA
 SBZD14+EptX9RdENEdoTWIYjRnkDB5FGih3b3JDiowPl+LPdX+hWl9J7BzoX+9Qc2E9M41N+a
 L+9G5EK1/5uy2xTZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

Am 02.03.2017 um 21:04 schrieb René Scharfe:
> When I use ulimit -v with lower and lower numbers I can provoke mmap failures on
> bigger pack files, but not the realloc failures that you're seeing.  And your
> packs should be only up to 20MB anyway (you can check that with "ls -l
> .git/objects/pack/*.pack").

Yes, there are 9 of them, all about 20 MB in size.

> So a shot in the dark: Do you have a lot of untracked files?  You could check by
> cloning your repository locally (which copies only tracked contents).  Does "git
> status" work on the clone?

I had about 40 modified or untracked files with a combined file size of 
about 5 MB.

Before I got your latest mail, I tried something else: Instead of 
connecting to the system with the repository via SSH as usual, I 
accessed the repository by mounting its file system via gvfs-mount onto 
my local desktop machine. Then I used my local, normally working Git to 
commit all modified and some untracked files (and deleted those that 
were left). Running `git status` and other commands took a very long 
time over a network connection of only 6 MBit/s, but eventually I got 
everything committed and pushed.

Quite in the spirit of your above words, getting rid of untracked files 
helped: Logging normally via SSH into the remote machine again, `git 
status` ran normally.

Only then did I see your mail and got another clone, where `git status` 
worked equally well – but then `git diff` failed in a similar manner, 
continuing the problems of `git status`:

(uiserver):p7715773:~/__TEST__$ git clone 
https://CarstenF@bitbucket.org/CarstenF/website-cafu.git
Cloning into 'website-cafu'...
Password for 'https://CarstenF@bitbucket.org':
remote: Counting objects: 44359, done.
remote: Compressing objects: 100% (28777/28777), done.
remote: Total 44359 (delta 19201), reused 38661 (delta 14143)
Receiving objects: 100% (44359/44359), 168.28 MiB | 20.95 MiB/s, done.
Resolving deltas: 100% (19201/19201), done.
Checking connectivity... done.
Checking out files: 100% (18524/18524), done.

(uiserver):p7715773:~/__TEST__$ cd website-cafu/

(uiserver):p7715773:~/__TEST__/website-cafu$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean

(uiserver):p7715773:~/__TEST__/website-cafu$ git diff
fatal: unable to create threaded lstat

(uiserver):p7715773:~/__TEST__/website-cafu$ git diff
fatal: Out of memory, realloc failed
fatal: Out of memory, realloc failed
fatal: Out of memory, realloc failed
fatal: recursion detected in die handler

> Another one, darker yet: Does "git config core.preloadIndex 0" help?

That's it!  :-)

Once that was set, both `git status` and `git diff` worked normally again!

I cannot test `git status` right now in the same situation as before, as 
I no longer have a working directory that is "as dirty" as before, but 
the above setting seems to fix the problem promptly and thoroughly!

Many thanks for your help!   :-)

Best regards,
Carsten
