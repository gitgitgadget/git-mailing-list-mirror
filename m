From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Wed, 25 May 2005 14:35:44 +0200
Message-ID: <20050525123544.GA1420@vrfy.org>
References: <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org> <20050524202846.GC25606@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org> <20050524213102.GB19180@vrfy.org> <7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 14:35:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dav5S-0002hQ-0v
	for gcvg-git@gmane.org; Wed, 25 May 2005 14:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVEYMfx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 08:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVEYMfx
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 08:35:53 -0400
Received: from soundwarez.org ([217.160.171.123]:12187 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262324AbVEYMfs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 08:35:48 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 0189139D2B; Wed, 25 May 2005 14:35:44 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2005 at 07:23:39PM -0700, Junio C Hamano wrote:
> I was browsing www.kernel.org/git and noticed that it shows
> only files that exist at the tip.  How do I get history of a
> file that does not exist anymore at the tip?
> 
> For example, diff-helper.c history is (quite correctly)
> truncated somewhere close to where diff-tree-helper.c was
> renamed to it.  From the commit log, humans can easily tell that
> it used to be called diff-tree-helper.c.  I could not find an
> easy way to see the history of diff-tree-helper.c file.

If git-diff-tree is given the -M:
  git-rev-list HEAD | git-diff-tree -r -M --stdin diff-helper.c

and it would print:
  99665af5c0be0fe4319b39183e84917993153576 (from 13ab4462d2aefb252d7c916bd537151856b7c967)
  :100644 100644 51bb658be4f73c00016b4ecb82f09d30941998a4 51bb658be4f73c00016b4ecb82f09d30941998a4 R10000 diff-tree-helper.c diff-helper.c

instead of:
  99665af5c0be0fe4319b39183e84917993153576 (from 13ab4462d2aefb252d7c916bd537151856b7c967)
  :000000 100644 0000000000000000000000000000000000000000 51bb658be4f73c00016b4ecb82f09d30941998a4 N      diff-helper.c

gitweb could follow the old filename and show the whole history. :)

Thanks,
Kay
