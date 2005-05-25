From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Wed, 25 May 2005 14:51:43 +0200
Message-ID: <20050525125143.GB1481@vrfy.org>
References: <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org> <20050524202846.GC25606@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org> <20050524213102.GB19180@vrfy.org> <7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net> <20050525123544.GA1420@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 14:51:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DavKq-0004ZC-M9
	for gcvg-git@gmane.org; Wed, 25 May 2005 14:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVEYMvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 08:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVEYMvv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 08:51:51 -0400
Received: from soundwarez.org ([217.160.171.123]:44187 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262269AbVEYMvq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 08:51:46 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 85E0F39D33; Wed, 25 May 2005 14:51:43 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050525123544.GA1420@vrfy.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2005 at 02:35:44PM +0200, Kay Sievers wrote:
> On Tue, May 24, 2005 at 07:23:39PM -0700, Junio C Hamano wrote:
> > I was browsing www.kernel.org/git and noticed that it shows
> > only files that exist at the tip.  How do I get history of a
> > file that does not exist anymore at the tip?
> > 
> > For example, diff-helper.c history is (quite correctly)
> > truncated somewhere close to where diff-tree-helper.c was
> > renamed to it.  From the commit log, humans can easily tell that
> > it used to be called diff-tree-helper.c.  I could not find an
> > easy way to see the history of diff-tree-helper.c file.
> 
> If git-diff-tree is given the -M:
>   git-rev-list HEAD | git-diff-tree -r -M --stdin diff-helper.c
> 
> and it would print:
>   99665af5c0be0fe4319b39183e84917993153576 (from 13ab4462d2aefb252d7c916bd537151856b7c967)
>   :100644 100644 51bb658be4f73c00016b4ecb82f09d30941998a4 51bb658be4f73c00016b4ecb82f09d30941998a4 R10000 diff-tree-helper.c diff-helper.c
                                                                                                      ^^^^^
Btw:
Can we add a leading '0' to have 3-digit values every time? It's pretty
stupid to get the '100' out ot that field instead of '10'. :)

Kay
