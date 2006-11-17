X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface warts)
Date: Fri, 17 Nov 2006 11:26:05 -0500
Message-ID: <20061117162605.GA32597@spearce.org>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org> <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org> <Pine.LNX.4.64.0611161039160.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 16:27:00 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611161039160.3349@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31703>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl6Xh-0000U6-72 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 17:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933705AbWKQQ0N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 11:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933706AbWKQQ0N
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 11:26:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56716 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S933705AbWKQQ0M
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 11:26:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gl6XS-0008Lz-C9; Fri, 17 Nov 2006 11:26:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 164A720E469; Fri, 17 Nov 2006 11:26:06 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>  - "ORIG_HEAD" is very useful indeed, and it's the head _before_ a merge 
>    (or some other operations, like "git rebase" and "git reset": think of 
>    it as a "original head before we did some uncontrolled operation 
>    where we otherwise can't use HEAD^ or similar")
> 
>    I use "gitk ORIG_HEAD.." a lot, and if I don't like something I see 
>    when I do it, I end up doing "git reset --hard ORIG_HEAD" to undo a 
>    pull I've done. This is important exactly because ORIG_HEAD is _not_ 
>    the same as the first parent of a merge, since a merge could have been 
>    just a fast-forward.

Although if you have reflog enabled on your current branch there
is a 1 character shorter syntax:

	gitk HEAD@{1}..

as recent Git understands that to mean the value that HEAD just had,
which is also what is in ORIG_HEAD.  Except that unlike ORIG_HEAD
it can also show even older values (e.g. HEAD@{3}, 3 ops back)
and it works very, very well on tracking branches.  "What did I
just fetch in next?" `git log next@{1}..next`

-- 
