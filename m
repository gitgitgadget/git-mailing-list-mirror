Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228F81FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 14:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbdJHOcq (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 10:32:46 -0400
Received: from gproxy9-pub.mail.unifiedlayer.com ([69.89.20.122]:51491 "EHLO
        gproxy9-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751639AbdJHOcp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Oct 2017 10:32:45 -0400
Received: from CMOut01 (unknown [10.0.90.82])
        by gproxy9.mail.unifiedlayer.com (Postfix) with ESMTP id B218D1E0851
        for <git@vger.kernel.org>; Sun,  8 Oct 2017 08:32:44 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by CMOut01 with 
        id K2Yh1w00P0QvKlu012YkMt; Sun, 08 Oct 2017 08:32:44 -0600
X-Authority-Analysis: v=2.2 cv=K4VSJ2eI c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=02M-m0pO-4AA:10 a=IRuUpcLC2PKLKUVD5UcA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fkCbumIpyyS5v9xAl19OLz4uygRM67a3rMPiptXXCjY=; b=aPqvn8SDn50TYWy/+G3KxH0u2S
        UfFSfojfHhstiGGX9Qc/1eA8lcS26whiU8WFZrV/690Id7GqYauSpbeoijbY4QmGzGQE4/Dq0Xg+s
        z7xOrO74PuWPudxQZ8zKuELE2;
Received: from pool-74-104-137-100.bstnma.fios.verizon.net ([74.104.137.100]:46410 helo=homebase)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.87)
        (envelope-from <paul@mad-scientist.net>)
        id 1e1CdF-002H1N-5q; Sun, 08 Oct 2017 08:32:41 -0600
Message-ID: <1507473160.8322.12.camel@mad-scientist.net>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Date:   Sun, 08 Oct 2017 10:32:40 -0400
In-Reply-To: <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>
          <20171007190402.GH3382@zaya.teonanacatl.net>
          <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
          <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
          <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
          <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
          <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
         <1507412674.8322.4.camel@mad-scientist.net>
         <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
Organization: Please remain calm!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 74.104.137.100
X-Exim-ID: 1e1CdF-002H1N-5q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-74-104-137-100.bstnma.fios.verizon.net (homebase) [74.104.137.100]:46410
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-10-07 at 17:55 -0400, Robert P. J. Day wrote:
> On Sat, 7 Oct 2017, Paul Smith wrote:
> > On Sat, 2017-10-07 at 15:43 -0400, Robert P. J. Day wrote:
> > > it's been a long week, so take this in the spirit in which it is
> > > intended ... i think the "git rm" command and its man page should be
> > > printed out, run through a paper shredder, then set on fire. i can't
> > > remember the last time i saw such a thoroughly badly-designed,
> > > badly-documented and non-intuitive utility.
> >
> > "git rm" works the same way that the UNIX rm command has worked, for
> > 40+ years now.  Very simple, very well designed, and very intuitive
> > (IMO).
> >
> > The major difference is the ability to handle globbing patterns,
> > which UNIX rm doesn't do.  Maybe the way this is implemented is a
> > little confusing, although I just read the man page and it seemed
> > pretty clear to me.
> 
>   um, wrong.

I don't know what part of my comment here you consider "wrong".  I've
re-read it and I believe everything I said is correct.

> > If you don't use glob patterns (or more specifically if you let the
> > shell handle glob patterns, which is how I always do it) then there
> > is really nothing bizarre about "git rm".  Maybe you could be more
> > precise in your criticism.
> 
> ok, fine, let me explain why this command is a nightmarish
> monstrosity. as i now understand, if i use an escaped wildcard
> pattern, "git rm" will *automatically* (with no further guidance from
> me, and no warning), operate recursively. so if, in the kernel source
> tree, i ran:
> 
>   $ git rm \*.c

Yes, this is what I said: "IF YOU DON'T USE GLOB PATTERNS (or more
specifically if you let the shell handle glob patterns ...) then there
is nothing bizarre about "git rm"" (emphasis added).

In this example you ARE sending glob patterns to Git, because you're
escaping them from the shell.  Hence, you might consider the behavior
bizarre, at least until you grok it fully.

If you want to avoid this, simply use normal shell globbing and don't
ask Git to do the globbing for you.  Then it behaves exactly as normal
UNIX rm, including with the '-r' option, and is very simple.

> so if i wanted git to remove, say, all files named "Makefile*" from
> everywhere in the linux kernel source tree, the (dry run) command
> would be:
> 
>   $ git rm -n Makefile\*
> 
> is that it? let's try that:
> 
>   $ git rm -n Makefile\*
>   rm 'Makefile'
>   $
> 
> oops.

Globbing in "git rm" matches on the FULL PATH, not just the file name. 
So, if you have a list of Makefiles in your repository like:

  Makefile
  foo/Makefile
  bar/Makefile

Then 'Makefile*' only matches the first one, since 'Makefile*' doesn't
match 'foo/Makefile' or 'bar/Makefile'.

If you you worry that '*Makefile' will match things you don't want to
match, you'll have to use:

  git rm -n Makefile '*/Makefile'

Personally I don't use Git's magical globbing capabilities, and use "git
rm" as if it were UNIX rm.  So in your request above I'd use:

   git rm $(find . -name Makefile)

which I find simpler.
