Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6F3320450
	for <e@80x24.org>; Fri,  3 Nov 2017 12:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbdKCMFj (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 08:05:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:61769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750857AbdKCMFi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 08:05:38 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPE7E-1e6Ask0w8u-004Rid; Fri, 03
 Nov 2017 13:05:30 +0100
Date:   Fri, 3 Nov 2017 13:05:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
In-Reply-To: <CAGZ79kZXLpwCyWs3_mfj7kL1qmM965V7vZZ2UH4-hqrfF5f+8g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711031300010.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com> <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711011329300.6482@virtualbox>
 <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com> <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com> <alpine.DEB.2.21.1.1711012310250.6482@virtualbox> <CAGZ79kbOEM_W65Rym4yiDNHpFGTNWMYdh=aVPjThNWjEHPQong@mail.gmail.com>
 <alpine.DEB.2.21.1.1711012340290.6482@virtualbox> <871slhm9dm.fsf@linux-m68k.org> <CAGZ79kZXLpwCyWs3_mfj7kL1qmM965V7vZZ2UH4-hqrfF5f+8g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CMtmRLvsvj/Mk7fAZJ35Dxokr1RpIWmtEjVLt1+UJYD9+CBADgc
 rh1OUVny1IsNEVv9Oo8vpmr69zvHQEFK7RsGrk4/X9iAiewgGGZSPh/MCqjxwgsqMn4xyXR
 OMZfJBSxcUqmTrqJrEfGSvfXAbJah6gdk6YCmNU2zwdWIEc59pCz0log3bzhw8otc/Bw6xo
 vrkElWikGPnegGk+PiSjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GGuOLoOAjjw=:GSADwbb1d6c9cITFyDSaiH
 pfybQVb43WlkW0qLLEKgqu3o2QrsbZ8Z2sv1xPxPpZri/smRM0yn7Cwin2MGAJM/lXl/PMGYF
 YGi7qCd+sxtX2o7P53iD9bqcARl0VT/VFYlxDBT0L8XaRlQ+ViOWPHSXiuT3Huo9yVKsfa4zi
 diaiYxLaynilBKjlOjS4/YMNxRliTr6Z//I34+3275yLNQ/zPCq2i5pJtcAa56fcMr6rnq66x
 I+qPlwTuYAbEgUa46wboL9QxKHkZ1LqbMACF4SdUyVlKyi8Rxg/8Op8ha4cnVNwXKYbXgQ2+x
 0eY4M9YAvLUhlEIGWIhNv4uR485lLnnTD+0KpTAakVHhXQhSVcvis4/Y16IJQ6m/8qr2amJti
 uvxi2iKA7hg9mMTgxRO3nxtlnLtu2KMo4rDsmfji4lcYGBfhA2Sw4ucedeljbTikMCB0CU1Tj
 Iq1/RdhuFaDMHPkpk43Gr6QPL7CsCwbAbf5Sxzi7xfIf46bSXOsWyZCKNXTM25jI/pcg/DKVM
 zLdhP5cvYcRPRq+ycVUZMW6xX597+fOHNjE3rJ13hLNKQFipVzRDUvSndR8VVz6u3JKB7/aH3
 UcWrV4qv1Kbunz7F8QB5bCfIwkZJai5cvN8zaquzafZ2wa20VSnxC101cKO8nYPuwIXD+bUNu
 Qz/sslKhKqhmGI4DQ8mBhapNnh8XAizci5XwqwucNwLfoVXEbdMswvuUNbGBmI36BTL/5JnjZ
 5vg5N/qSGsXJznZeTel9uNCThV4kNgfkZa4vjIA77U702vqkIsJMJalMTo9Qpa4vmslDSwpvV
 FSAcGVIMtZD8J1b9+jkE4wjL2VPwc9I9pkbwbABbt8fpXGaUTI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 2 Nov 2017, Stefan Beller wrote:

> On Thu, Nov 2, 2017 at 12:23 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> > On Nov 01 2017, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> >> Sure, but it is still a tricky thing. Imagine
> >>
> >> - A1 - B1 - A2 - B2 - B3
> >>
> >> where all the B* commits have the blob. Do you really want to report B1
> >> rather than B2 as the commit introducing the blob? (I would prefer B2...)
> >
> > What if B3 renames or copies the blob?
> >
> > Andreas.
> 
> With the current proposed patch you'd find B3, and then use the diff machinery
> to digg deeper from there (renames/copies ought to be easy to detect already?)
> 
> So with a copy B3 might be a better start than B1, as starting from B1 you
> would not find B3 easily.
> 
> For a rename, I would think a reverse log/blame on B1:path may help.
> 
> With that said, I think I'll just reroll the series with the current logic
> fixing the other minor issues that were brought up as B3 seems to
> be the most versatile (though not optimal) answer for many use cases.

I know this is a bit of semantics, but I disagree that B3 is the most
versatile. For my use cases, `git describe` comes in handy relatively
rarely, and usually only when I want to know what version some work was
based on. In that respect, B2 would be the most versatile answer.

However, if you say that B3 is the easiest answer to explain, I
whole-heartedly agree. Any other answer would be necessarily more
complicated to reason about, given that we're operating on a DAG, i.e. not
always on a linear history.

Ciao,
Dscho
