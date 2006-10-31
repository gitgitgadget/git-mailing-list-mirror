X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Introduce git-mirror, a tool for exactly mirroring another repository.
Date: Tue, 31 Oct 2006 09:55:55 -0500
Message-ID: <20061031145554.GA23007@spearce.org>
References: <20060925044641.GB15757@spearce.org> <20061031174225.3c7c1e77.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 14:56:54 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061031174225.3c7c1e77.vsu@altlinux.ru>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30586>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gev2V-0005Ug-W9 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 15:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423459AbWJaO4F (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 09:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423458AbWJaO4E
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 09:56:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:16799 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1423459AbWJaO4C
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 09:56:02 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gev1s-0006Rt-4G; Tue, 31 Oct 2006 09:55:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 2CF8A20FB0C; Tue, 31 Oct 2006 09:55:55 -0500 (EST)
To: Sergey Vlasov <vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org

Sergey Vlasov <vsu@altlinux.ru> wrote:
> On Mon, 25 Sep 2006 00:46:41 -0400 Shawn Pearce wrote:
> 
> > Sometimes its handy to be able to efficiently backup or mirror one
> > Git repository to another Git repository by employing the native
> > Git object transfer protocol.  But when mirroring or backing up a
> > repository you really want:
> >
> >   1) Every object in the source to go to the mirror.
> >   2) Every ref in the source to go to the mirror.
> >   3) Any ref removed from the source to be removed from the mirror.
> >   4) Automatically repack and prune the mirror when necessary.
> >
> > and since git-fetch doesn't do 2, 3, and 4 here's a tool that does.
> 
> Is this patch forgotten, abandoned or what?

Its waiting around for someone to clean it up.  :-)

Junio didn't accept it as there were a number of issues that he
identified in the patch.  I still have them in my inbox but have
not had time to go back and fix them.  Since I haven't actually had
a real need for git-mirror it has been low on my priority list of
"git things to do".

Your message pointed out a number of issues with the current version
that would be worth fixing before accepting it into git.git.  I agree
with many of them, especially about the direct ref manipulation.
git-mirror was written before the Linus packed ref stuff came
along, so git-update-ref didn't have a -d option at the time...
otherwise I would have used it.

-- 
