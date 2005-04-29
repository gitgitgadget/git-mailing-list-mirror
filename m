From: Noel Maddy <noel@zhtwn.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 15:47:53 -0400
Message-ID: <20050429194753.GA14222@uglybox.localnet>
References: <2944.10.10.10.24.1114802002.squirrel@linux1> <200504291928.MAA27145@emf.net>
Reply-To: Noel Maddy <noel@zhtwn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: seanlkml@sympatico.ca, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 21:46:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRbQv-0002Wx-CP
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 21:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbVD2TvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 15:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVD2TvA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 15:51:00 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:47247 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262910AbVD2Tus (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 15:50:48 -0400
Received: from uglybox (pcp04038668pcs.wbrmfd01.mi.comcast.net[68.43.211.146])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20050429194925015004rjove>; Fri, 29 Apr 2005 19:50:41 +0000
Received: from noel by uglybox with local (Exim 4.50)
	id 1DRbSr-0003rj-JB; Fri, 29 Apr 2005 15:47:53 -0400
To: Tom Lord <lord@emf.net>
Content-Disposition: inline
In-Reply-To: <200504291928.MAA27145@emf.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 12:28:41PM -0700, Tom Lord wrote:
> 
> Think of it this way:
> 
>   (a) Joe, the mainline maintainer, gets a trusted message containing
>       a diff.
> 
>   (b) Joe reads the diff, it makes great sense, he wants to merge.
> 
>   (c) Joe downloads a tree.  Supposedly that tree is the result of
>       applying this diff.   The tree, not the diff, is used for
>       merging.

Call me a naive git, but seems to me the "git way" is a little
different. It's tree-based rather than diff-based, and doesn't involve
passing diffs around, right?

This is the process I'd expect:

    (a)' Joe is notified of an update made to an external git tree

    (b)' Joe pulls tree from the external git tree (signed by external
         developer)

    (c)' Joe reviews the (git-generated) diffs from his current
	     (trusted) tree to the new (signed) tree. If they pass
         review, he merges the new versions into his tree, commits,
         and signs his tree.

The logical hole that you point out is assuming that the diff is passed
separately from the tree rather than being directly generated from the
current maintainer tree and the signed remote tree.

If the diff is generated from the two signed trees, I don't see a hole.

Or am I missing something?


-- 
The world's largest Internet database in the country.
					      -- Trading Times radio ad
+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
Noel Maddy <noel@zhtwn.com>
