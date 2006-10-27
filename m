X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Restore a single file in the index back to HEAD
Date: Fri, 27 Oct 2006 04:15:45 -0400
Message-ID: <20061027081545.GF29057@spearce.org>
References: <200610261641.11239.andyparkins@gmail.com> <81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com> <200610270827.17659.andyparkins@gmail.com> <20061027073834.GC29057@spearce.org> <4541BE8E.5050605@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 08:16:09 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4541BE8E.5050605@op5.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30306>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdMsa-0000gX-MG for gcvg-git@gmane.org; Fri, 27 Oct
 2006 10:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946239AbWJ0IPt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 04:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946242AbWJ0IPt
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 04:15:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:187 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1946239AbWJ0IPt
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 04:15:49 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GdMsj-0002H2-8d; Fri, 27 Oct 2006 04:16:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 541E820E45B; Fri, 27 Oct 2006 04:15:45 -0400 (EDT)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> wrote:
> Shawn Pearce wrote:
> >Andy Parkins <andyparkins@gmail.com> wrote:
> >>However, it led me to wonder what the inverse of git-update-index is.
> >
> >git-update-index  :-)
> >
> >You can use something like:
> >
> >    git ls-tree HEAD oops/file1 | git update-index --index-info 
> >
> >to restore the index state of oops/file1.
> >
> >
> >Which leads us to the always interesting, fun and exciting:
> >
> >    git ls-tree -r HEAD | git update-index --index-info 
> >
> >which will undo everything except 'git add' from the index, as
> >ls-tree -r is listing everything in the last commit.
> >
> 
> ... and also shows The Power of the Pipe, which Daniel@google was 
> missing in recent versions of git. ;-)
> 
> Btw, this is most definitely not a documented thing and requires a bit 
> of core git knowledge, so perhaps the "shell-scripts were good for 
> hackers to learn what to pipe where" really *is* a very important point.

Agreed.

I learned that trick while studying the update-index source code
and tried to wrap my tiny little head around the various formats
--index-info accepts and how that code automatically guesses the
correct format.  :-)

Though I have to admit I wipped up a little test repository just
to make sure what I was writing in the email worked properly;
I can't say I've done it myself too many times in the past...

-- 
