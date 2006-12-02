X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Resolving conflicts
Date: Fri, 1 Dec 2006 20:30:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
 <456FDF24.1070001@saville.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 04:31:00 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456FDF24.1070001@saville.com>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqMWT-0005Kk-UX for gcvg-git@gmane.org; Sat, 02 Dec
 2006 05:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162769AbWLBEam (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 23:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162770AbWLBEam
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 23:30:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:63182 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162769AbWLBEam (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 23:30:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB24UajQ010942
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 1
 Dec 2006 20:30:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB24UZAa007287; Fri, 1 Dec
 2006 20:30:35 -0800
To: Junio C Hamano <junkio@cox.net>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org


[ Tangentially related.. ]

On Thu, 30 Nov 2006, Wink Saville wrote:
> 
> Earlier had a problem with git wanting merge but didn't have it and
> couldn't figure out which package it was in Ubuntu:( So I symlinked merge
> to kdiff3 which worked at the time:

Btw, what's the status of the xdl_merge() thing in "pu"?

It would be lovely if this could be one less thing we ever need to worry 
about, just because we just do it ourselves. But quite frankly, I've never 
looked at the RCS merge logic, so while I peeked at the xdl_merge patch 
itself, I have absolutely zero way of judging it.

But the patch in "pu" to make merge-recursive use it looks pretty, and 
removes more lines than it adds, and the xdl_merge() code itself _looked_ 
sane even if I can't judge the algorithm, so... 

Anyway, here's one vote for trying to move this thing into "next" (first
asking whether all of Dscho's fixup patches got merged too?). 

I realize that git-cvsserver (and my toy merge-file.c that isn't used by 
anything real) also use the external merge program, so we can't remove the 
dependency entirely (both in git.spec.in and documentation) without fixing 
those too, but at least we would _practically_ be able to ignore it for 
all normal users. And cvsserver would probably be quite fixable too..

