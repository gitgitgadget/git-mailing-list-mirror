Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECD91F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 14:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbdCBOib (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 09:38:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:59499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753910AbdCBOht (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 09:37:49 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MV6EP-1cn3yd3vZt-00YRZp; Thu, 02
 Mar 2017 15:37:03 +0100
Date:   Thu, 2 Mar 2017 15:37:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
In-Reply-To: <CA+55aFy9=jBJT36FC2HiAeabJBssY=jE=zLxwrXWzhpiFkMUXg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703021530380.3767@virtualbox>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com> <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com> <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703012227010.3767@virtualbox>
 <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com> <alpine.DEB.2.20.1703012334400.3767@virtualbox> <CA+55aFy9=jBJT36FC2HiAeabJBssY=jE=zLxwrXWzhpiFkMUXg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ROzXT/Qs11ZrEJS8vFHeY3A9U9y4VhseGV0Ecsy2uyW+Iy4G0NF
 AD4gNrLI6elNZlttqx/LR8/FlihST4Bnos4njL4MPsstRA07MjT1MKVjwUMLef7ZQ9pGl5b
 eblicXAMM/FaRcxxppl3aZCff3mJCRZ8TVikvAGnImDJdti1gdbE1LvEKI6iLwU4L0u/dvW
 A/mfQTjVg0gLA8XxAftrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D4PN7qck9fo=:WwYUCQ6pW4miaOfu5l66lm
 2X/iRoSvbqWvIwY3j2rufvM9fT5fZbEwvDZnLU03rkmLeaCKT08txAxv5lwhMwCtS459TkL1L
 oQfMuf0l5i6KVijUpk2MGxv0ssmQwqfqKzV2lGqZMzOX2mEGdATloE1uZgFRf/+gzCncd9wVx
 6GPFI5VomdWS267E5Ron5gG8HwT6/aML0NCXgP1IwLK0TBbjNu/gaNusHYskVoyBXt2yMCkkj
 a+MtqsqOZZFkhz8ogRjksARUuYu2/RSrYK16ImxWg4HKXLoczgeLwpp7Dt5I9OQLJ0ug0dRwQ
 WbCz9fgNW+U5/t98PyUdg6n7X5ZiC4YcfTh8Krm6J3+64TGQ6zaQxWNkMiUdgMZVPjqWhkDAo
 cUI0kJWJ0AmusRAhjX1tMB0B01/BNZ0DbgiJgjro5IZ8NfPVgEBvvq5cAKaUkhmEmncxZmntx
 rEu6C0DmHVGSeOBCLjv8FmpeLI2Z2Qh4FrPh9JFskTVryj5uoDfYzUlD2FzPSOH3Kw6RpKGoX
 IfN1jgjiXAlak7u8n052086e5sjYZ44SEkCl380NRGEI9EVVXuYydBWORYEFeGnqnR6mr80Tv
 bayWczx0Hb1Q9DrfFBs3FRyTbkItarmr/wIBjQqWuUHRsDtS10Ey1azZ2qm6fOAGVhrNsAtfg
 g5Kh5JNAZbaVqfYN2LbEnINAJ1+IrwK9NKlCYOoS0WPC1ihxxvvNZCOXjPtQ+yXYQ4fQ+bk5F
 JpsVlNDYyGJjHM2zGt7zi5QPydWcrKu7zcQPIsBXLq4kMzn1RbujpP/zpnoVMgjkJdMZvq8/w
 xHOSc81GSdH2ggI+MAPoKncquO8VQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Linus,

On Wed, 1 Mar 2017, Linus Torvalds wrote:

> On Wed, Mar 1, 2017 at 2:51 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > But I think bigger than just developers on Windows OS. There are many
> > developers out there working on large repositories (yes, much larger
> > than Linux). Also using Macs and Linux. I am not at all sure that we
> > want to give them an updated Git they cannot fail to notice to be much
> > slower than before.
> 
> Johannes, have you *tried* the patches?
> 
> I really don't think you have. It is completely unnoticeable in any
> normal situation. The two cases that it's noticeable is:
> 
>  - a full fsck is noticeable slower
> 
>  - a full non-local clone is slower (but not really noticeably so
> since the network traffic dominates).
> 
> In other words, I think you're making shit up. I don't think you
> understand how little the SHA1 performance actually matters. It's
> noticeable in benchmarks. It's not noticeable in any normal operation.
> 
> .. and yes, I've actually been running the patches locally since I
> posted my first version (which apparently didn't go out to the list
> because of list size limits) and now running the version in 'pu'.

If you think that the Linux repository is a big one, then your reaction is
understandable.

I have zero interest in potty language, therefore my reply is very terse:
yes, I have been looking ad SHA-1 performance, and yes, it matters. Think
an index file of 300-400MB.

Ciao,
Johannes
