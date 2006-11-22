X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: your mail
Date: Wed, 22 Nov 2006 12:16:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611221208430.27569@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.63.0611212316080.26827@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 22 Nov 2006 20:17:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-AuthUser: davidel@xmailserver.org
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <Pine.LNX.4.63.0611212316080.26827@wbgn013.biozentrum.uni-wuerzburg.de>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32098>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmyX3-0000yi-HM for gcvg-git@gmane.org; Wed, 22 Nov
 2006 21:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756990AbWKVURR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 15:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756992AbWKVURR
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 15:17:17 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:28115 "EHLO
 x35.xmailserver.org") by vger.kernel.org with ESMTP id S1756989AbWKVURQ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 15:17:16 -0500
Received: from alien.or.mcafeemobile.com by x35.xmailserver.org with [XMail
 1.23 ESMTP Server] id <S200309> for <git@vger.kernel.org> from
 <davidel@xmailserver.org>; Wed, 22 Nov 2006 12:16:59 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Tue, 21 Nov 2006, Johannes Schindelin wrote:

> [PATCH] xdiff: add xdl_merge()
> 
> This new function implements the functionality of RCS merge, but
> in-memory. It returns < 0 on error, otherwise the number of conflicts.
> 
> Finding the conflicting lines can be a very expensive task. You can
> control the eagerness of this algorithm:
> 
> - a level value of 0 means that all overlapping changes are treated
>   as conflicts,
> - a value of 1 means that if the overlapping changes are identical,
>   it is not treated as a conflict.
> - If you set level to 2, overlapping changes will be analyzed, so that
>   almost identical changes will not result in huge conflicts. Rather,
>   only the conflicting lines will be shown inside conflict markers.
> 
> With each increasing level, the algorithm gets slower, but more accurate.
> Note that the code for level 2 depends on the simple definition of
> mmfile_t specific to git, and therefore it will be harder to port that
> to LibXDiff.

Johannes, at the moment I'm chased by a huge storm of never ending emails, 
so I won't be able to follow up this one soon. A smart 3-way merge is in 
my plans for LibXDiff though.
There is quite some nice code around, that does pretty smart tricks and 
goes down to resolve sub-hunk non-trivial conflicts. You may want to take 
a look at that code too.



- Davide

