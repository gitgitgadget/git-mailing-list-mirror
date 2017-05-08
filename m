Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41771FC44
	for <e@80x24.org>; Mon,  8 May 2017 16:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbdEHQsZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 12:48:25 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34224 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdEHQsY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 12:48:24 -0400
Received: by mail-pf0-f178.google.com with SMTP id e64so35831487pfd.1
        for <git@vger.kernel.org>; Mon, 08 May 2017 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jcHJBo7ZShZXfo45ntdwj8LSUSQ6GcHPN3OrHsgDgB4=;
        b=bZtHHwHwBzGwKz4D3LjFlGiXEZO7QhHYRP8R+Qmszlgmh9NyC77cHmzlyw3L05Yb+H
         5O0b4f8J/s38t6XYYYX153UDqh4KFAp4EP8XbExvyXsxN6IzI5n4+/PdgapZQ4F/deQG
         Sz/PQFqf3kJzlzhYNgwq+9GQrmQNfiYj3XMSo+VDPFGD1jJn2h0CfsSqT61ruAX8WRVx
         BziI+a1wVGvpBo3Etf6VNDXI/7ZcsYZ2O4JboV11avxsgGy7xvJjVSaylC9H/42kcUED
         z5qrWpBNN0YoZYWV2Y2Ks2EWGU3YB2KxrXswihC2S+rYJGMuL7Ba2e/w6ZPppB9oYkcT
         Y1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jcHJBo7ZShZXfo45ntdwj8LSUSQ6GcHPN3OrHsgDgB4=;
        b=Ycanyrsi/crkr72YlDFTcB+HtjeC3y0uh76vUgwwjS9GTe5PQ8z1Optt54m9/GlO+a
         BMZyXcYEv+wUuMsIbyC+hmOz9jxSee0ABBhrbE8eC/LP5G+6a6YL3KyvDO3DUAEDFbpO
         VTQ+wNLfjXmEEo3f6wcqZnBHdk0gXevJwMMRAG3yB4rHaJ61g1msgmRJwy4HhniTr7vU
         OLvvI6Arob9lSiTgGEMSU+MzXmR4w/WuU0jmijeOaNdKGAI/j8vvqr3r4zmH+FlMUgQt
         /KZTkZp951dRSEiVsugdxUIUG9KfpL8RDPIS03l5i2txvPS67niRDqERoc8dhVM5Tpx5
         frrw==
X-Gm-Message-State: AN3rC/48J8HBXPgd+DFm68a2Xc+lV8gEPOjk7XoNBFBw0TR19juREHXe
        2cF2HKSzhfcCDBzd
X-Received: by 10.99.140.14 with SMTP id m14mr19882839pgd.174.1494262104021;
        Mon, 08 May 2017 09:48:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:998e:2b7a:726f:b074])
        by smtp.gmail.com with ESMTPSA id h7sm3394768pfc.97.2017.05.08.09.48.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 09:48:23 -0700 (PDT)
Date:   Mon, 8 May 2017 09:48:21 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Ciro Santilli <ciro.santilli@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Add an option to automatically submodule update on checkout
Message-ID: <20170508164821.GA179149@google.com>
References: <CAFXrp_do8Jn-k18_FSRNeHQrWNydwdj2y3y5gw+XoZPGAzPL-w@mail.gmail.com>
 <001b01d2c809$62ac8520$28058f60$@nexbridge.com>
 <CAGZ79kaES-3ftadorYnx2wMDc-q7qsG376E1zy-C67Ldt2BO5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaES-3ftadorYnx2wMDc-q7qsG376E1zy-C67Ldt2BO5g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/08, Stefan Beller wrote:
> On Mon, May 8, 2017 at 7:42 AM, Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> > On May 6, 2017 4:38 AM Ciro Santilli wrote:
> >> This is a must if you are working with submodules, otherwise every
> >> git checkout requires a git submodule update, and you forget it,
> >> and things break, and you understand, and you go to stack overflow
> >> questions
> >> http://stackoverflow.com/questions/22328053/why-doesnt-git-checkout-automatically-do-git-submodule-update-recursive
> >> http://stackoverflow.com/questions/4611512/is-there-a-way-to-make-git-pull-automatically-update-submodules
> >> and you give up and create aliases :-)
> 
> The upcoming release (2.13) will have "git checkout
> --recurse-submodules", which will checkout the submodules at the
> commit as recorded in the superproject.
> 
> I plan to add an option "submodule.recurse" (name is subject to
> bikeshedding), which would make the --recurse-submodules flag given by
> default for all commands that support the flag. (Currently cooking we
> have reset --recurse-submodules, already existing there is push/pull).

Well pull not so much...it'll do a recursive fetch but not a recursive
merge/rebase.  That is something on the docket to get done in the next
couple months though.

> 
> > I rather like the concept of supporting --recurse-submodules. The
> > complexity is that the branches in all submodules all have to have
> > compatible semantics when doing the checkout, which is by no means
> > guaranteed. In the scenario where you are including a submodule from
> > a third-party (very common - see gnulib), the branches likely won't
> > be there, so you have a high probability of having the command fail
> > or produce the same results as currently exists if you allow the
> > checkout even with problems (another option?). If you have control
> > of everything, then this makes sense.
> 
> I am trying to give the use case of having control over everything (or
> rather mixed) more thought as well, e.g. "checkout
> --recurse-submodules -b <name>" may want to create the branches in a
> subset of submodules as well.
> 
> Thanks, Stefan
> 
> >
> > Cheers, Randall
> >

-- 
Brandon Williams
