From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT] Push to GitHub caused corruption
Date: Fri, 14 Aug 2009 11:19:49 +0200
Message-ID: <200908141119.49798.robin.rosenberg.lists@dewire.com>
References: <3ae83b000908101446q2d4f1101we4bbd7023f78b03@mail.gmail.com> <200908110810.45369.robin.rosenberg@gmail.com> <3ae83b000908111552o53189a44h45fc44f124850483@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 11:20:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbsx8-0005tB-4B
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 11:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbZHNJTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 05:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbZHNJTw
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 05:19:52 -0400
Received: from mail.dewire.com ([83.140.172.130]:28565 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958AbZHNJTv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 05:19:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5A4B31434E8F;
	Fri, 14 Aug 2009 11:19:51 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xYKrnsVjnAgp; Fri, 14 Aug 2009 11:19:50 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id C3C86802861;
	Fri, 14 Aug 2009 11:19:50 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <3ae83b000908111552o53189a44h45fc44f124850483@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125920>

onsdag 12 augusti 2009 00:52:29 skrev John Bito <jwbito@gmail.com>:
> Running git fsck -full on the repo that I pushed from is clean.
> Here's the git fsck -full from GitHub
>        <mojombo>       git fsck --full
>        <mojombo>       broken link from tree
> f4f9ecd1875938baa42467dfd6a8134d75fe5de4 to tree
> 57548924f1eca854dc8db00844f95d3de2c82957
>        <mojombo>       broken link from tree
> f4f9ecd1875938baa42467dfd6a8134d75fe5de4 to tree
> 3d1f74522c3e7c3c03390fae376446fda6eed306
>        <mojombo>       missing tree 3d1f74522c3e7c3c03390fae376446fda6eed306
>        <mojombo>       missing tree 57548924f1eca854dc8db00844f95d3de2c82957
>        <mojombo>       dangling commit ab6ce47159c1eaff0e4bae19291679267de9f669
> 
> The repo on GitHub is back where it was before the push.  I have a
> copy of the corrupt one from GitHub (358MB tar.gz).  If there's
> something I can do that would help to improve JGit/EGit, please let me
> know.

I guess we'd like to try to recreate the problem, unless we see some obvious clue. What
does the tres with missing links look like, i.e. f4f9ecd1875938baa42467dfd6a8134d75fe5de4.

On the recreation side we'd probably need to recreate a repo that looks somewhat like the
github repo before the crash. We can do that by taking a copy of your existing (good) repo,
reset branches and  clone it. Then push from yet another copy and hopefully it will blow up
again.

Can we be sure it wasn't corrupt before the jgit push? 
Did f4f9ecd1875938baa42467dfd6a8134d75fe5de4 exist before the push or was it new?

-- robin
