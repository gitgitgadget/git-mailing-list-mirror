From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: let 'dcommit $rev' work on $rev instead of
	HEAD
Date: Wed, 3 Jun 2009 19:45:27 -0700
Message-ID: <20090604024527.GA19622@dcvr.yhbt.net>
References: <64a802c5249465dc9e39faa480133f501e5d1b59.1243609198.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.or, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 04:54:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC35x-00066w-N0
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 04:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbZFDCyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 22:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbZFDCyH
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 22:54:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55943 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbZFDCyG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 22:54:06 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21CC1F7D1
	for <git@vger.kernel.org>; Thu,  4 Jun 2009 02:54:07 +0000 (UTC)
X-Spam-ASN: 
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	shortcircuit=no autolearn=ham version=3.2.5
X-Original-To: normalperson@yhbt.net
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5651F7D1;
	Thu,  4 Jun 2009 02:45:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <64a802c5249465dc9e39faa480133f501e5d1b59.1243609198.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120675>

Thomas Rast <trast@student.ethz.ch> wrote:
> 'git svn dcommit' takes an optional revision argument, but the meaning
> of it was rather scary.  It completely ignored the current state of
> the HEAD, only looking at the revisions between SVN and $rev.  If HEAD
> was attached to $branch, the branch lost all commits $rev..$branch in
> the process.
> 
> Considering that 'git svn dcommit HEAD^' has the intuitive meaning
> "dcommit all changes on my branch except the last one", we change the
> meaning of the revision argument.  git-svn temporarily checks out $rev
> for its work, meaning that
> 
> * if a branch is specified, that branch (_not_ the HEAD) is rebased as
>   part of the dcommit,
> 
> * if some other revision is specified, as in the example, all work
>   happens on a detached HEAD and no branch is affected.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Thanks.  Took me a while to remember why dcommit was was the way it
originally was and I couldn't remember for the life of me.

Acked and pushed out to git://git.bogomips.org/git-svn

-- 
Eric Wong
