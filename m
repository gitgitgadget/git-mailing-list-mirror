X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Restore a single file in the index back to HEAD
Date: Fri, 27 Oct 2006 03:38:34 -0400
Message-ID: <20061027073834.GC29057@spearce.org>
References: <200610261641.11239.andyparkins@gmail.com> <81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com> <200610270827.17659.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 07:39:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200610270827.17659.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30298>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdMIg-0001LP-4M for gcvg-git@gmane.org; Fri, 27 Oct
 2006 09:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946216AbWJ0Him (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 03:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946218AbWJ0Him
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 03:38:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49078 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1946216AbWJ0Him
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 03:38:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GdMIn-0000Kc-V7; Fri, 27 Oct 2006 03:38:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 AAC9A20E45B; Fri, 27 Oct 2006 03:38:34 -0400 (EDT)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> However, it led me to wonder what the inverse of git-update-index is.

git-update-index  :-)

You can use something like:

    git ls-tree HEAD oops/file1 | git update-index --index-info 

to restore the index state of oops/file1.


Which leads us to the always interesting, fun and exciting:

    git ls-tree -r HEAD | git update-index --index-info 

which will undo everything except 'git add' from the index, as
ls-tree -r is listing everything in the last commit.

-- 
