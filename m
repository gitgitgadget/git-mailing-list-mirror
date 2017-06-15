Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FF7420401
	for <e@80x24.org>; Thu, 15 Jun 2017 17:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbdFORgU (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 13:36:20 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35534 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdFORgT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 13:36:19 -0400
Received: by mail-pg0-f44.google.com with SMTP id k71so9531949pgd.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cCqzmxbabzqtuKsxakqUcpeJzgHqtHDurdtE2rdaGUI=;
        b=vmaUKIK/glSYBAncUJVme+dTESoKLP5q6uerhsaSvVRBYeYhaQAM1Kdr2LAG8f1GAT
         54q0+vLs4i3mXFdenGEf5r8TLfb8LFPThyUL+Rb+mXmOO398tqG0laxYiwBTn4M1L+Vu
         28SqOGmsExIFbFnWIBLeyBGboJHblZuKtXiwz6xcEq0mICQk203k7zFSx/qSmfkLbuQR
         2Z6em29zWB9aNJY9Vc89DdnFZ8I+MxdnUwJBrtvVLl5YtgK6y8aRsFVMQwy8oEpSNkbm
         RwR6jIc3ux54UzaaZaQOEulams6osx7ZOwSozMkto+3NlZ2SajyBV80KIoZ25rSmQxz1
         T62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCqzmxbabzqtuKsxakqUcpeJzgHqtHDurdtE2rdaGUI=;
        b=fkIA3d/o7snwXteGmMaHpeKx+th67GNcBNj08tp3sGb+N2iQzVt7e93BslHWlCDRtl
         XoS4STGCPTcXffZh3c0+eG3w5iTR6RvDi3Pk7wZkdI1ZL2P3IuK6M1cR0Fhe2YkOzcvz
         FYgPlVNAd0sZHbXt14oTbrc7wa8ET0ddtkvaDjEPq5azF5i7FJR62awKZ+EJVqxzE5hp
         CYVpspEimZDrOr6I9BMwjEiNsmtPDzU5LfaZqotXPqrAgBYPb7u3v0Gvp+1bd3Mh8CoZ
         dKfcmVZEfmoPKFVL+irsF2S7f2f/nhHvAN7DazFEhm5A8T18ArIm/XWriMP7q6YuGVhe
         Oh/Q==
X-Gm-Message-State: AKS2vOwCHyeyfBxUMaH2uK7KL0dFD1vbJVy9z2DYx5pYcp98CWgoG8tp
        vMvEk7EBFTKXIHHm
X-Received: by 10.99.152.25 with SMTP id q25mr6428604pgd.93.1497548178806;
        Thu, 15 Jun 2017 10:36:18 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:2d7f:7526:8947:80f4])
        by smtp.gmail.com with ESMTPSA id v186sm1262651pgd.9.2017.06.15.10.36.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 10:36:17 -0700 (PDT)
Date:   Thu, 15 Jun 2017 10:36:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
Message-ID: <20170615173616.GA176947@google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
 <20170306182423.GB183239@google.com>
 <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/15, Johannes Schindelin wrote:
> Hi,
> 
> I thought it better to revive this old thread rather than start a new
> thread, so as to automatically reach everybody who chimed in originally.
> 
> On Mon, 6 Mar 2017, Brandon Williams wrote:
> 
> > On 03/06, brian m. carlson wrote:
> >
> > > On Sat, Mar 04, 2017 at 06:35:38PM -0800, Linus Torvalds wrote:
> > >
> > > > Btw, I do think the particular choice of hash should still be on the
> > > > table. sha-256 may be the obvious first choice, but there are
> > > > definitely a few reasons to consider alternatives, especially if
> > > > it's a complete switch-over like this.
> > > > 
> > > > One is large-file behavior - a parallel (or tree) mode could improve
> > > > on that noticeably. BLAKE2 does have special support for that, for
> > > > example. And SHA-256 does have known attacks compared to SHA-3-256
> > > > or BLAKE2 - whether that is due to age or due to more effort, I
> > > > can't really judge. But if we're switching away from SHA1 due to
> > > > known attacks, it does feel like we should be careful.
> > > 
> > > I agree with Linus on this.  SHA-256 is the slowest option, and it's
> > > the one with the most advanced cryptanalysis.  SHA-3-256 is faster on
> > > 64-bit machines (which, as we've seen on the list, is the overwhelming
> > > majority of machines using Git), and even BLAKE2b-256 is stronger.
> > > 
> > > Doing this all over again in another couple years should also be a
> > > non-goal.
> > 
> > I agree that when we decide to move to a new algorithm that we should
> > select one which we plan on using for as long as possible (much longer
> > than a couple years).  While writing the document we simply used
> > "sha256" because it was more tangible and easier to reference.
> 
> The SHA-1 transition *requires* a knob telling Git that the current
> repository uses a hash function different from SHA-1.
> 
> It would make *a whole of a lot of sense* to make that knob *not* Boolean,
> but to specify *which* hash function is in use.

100% agree on this point.  I believe the current plan is to have the
hashing function used for a repository be a repository format extension
which would be a value (most likely a string like 'sha1', 'sha256',
'black2', etc) stored in a repository's .git/config.  This way, upon
startup git will die or ignore a repository which uses a hashing
function which it does not recognize or does not compiled to handle.

I hope (and expect) that the end produce of this transition is a nice,
clean hashing API and interface with sufficient abstractions such that
if I wanted to switch to a different hashing function I would just need
to implement the interface with the new hashing function and ensure that
'verify_repository_format' allows the new function.

> 
> That way, it will be easier to switch another time when it becomes
> necessary.
> 
> And it will also make it easier for interested parties to use a different
> hash function in their infrastructure if they want.
> 
> And it lifts part of that burden that we have to consider *very carefully*
> which function to pick. We still should be more careful than in 2005, when
> Git was born, and when, incidentally, when the first attacks on SHA-1
> became known, of course. We were just lucky for almost 12 years.
> 
> Now, with Dunning-Kruger in mind, I feel that my degree in mathematics
> equips me with *just enough* competence to know just how little *even I*
> know about cryptography.
> 
> The smart thing to do, hence, was to get involved in this discussion and
> act as Lt Tawney Madison between us Git developers and experts in
> cryptography.
> 
> It just so happens that I work at a company with access to excellent
> cryptographers, and as we own the largest Git repository on the planet, we
> have a vested interest in ensuring Git's continued success.
> 
> After a couple of conversations with a couple of experts who I cannot
> thank enough for their time and patience, let alone their knowledge about
> this matter, it would appear that we may not have had a complete enough
> picture yet to even start to make the decision on the hash function to
> use.
> 

-- 
Brandon Williams
