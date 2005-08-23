From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: cg-update/cg-merge refuse to update if state is dirty?
Date: Tue, 23 Aug 2005 08:22:21 -0600
Organization: Hewlett Packard
Message-ID: <20050823142221.GA21663@hpsvcnb.fc.hp.com>
References: <46a038f905082301096285a3cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 23 16:26:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7Zfd-0005PY-Ka
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 16:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVHWOW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 10:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVHWOW2
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 10:22:28 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:45776 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932148AbVHWOW2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 10:22:28 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel6.hp.com (Postfix) with ESMTP id 574D511BF3;
	Tue, 23 Aug 2005 10:22:27 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id DAE6341E19A; Tue, 23 Aug 2005 14:22:21 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id C544127ECC; Tue, 23 Aug 2005 08:22:21 -0600 (MDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f905082301096285a3cb@mail.gmail.com>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

Here's a thought.  It might be nice, in this situation, to have
something like a git-undo-script that can undo the changes in the index
storing them in a tree object but not wrapping them into a commit.  A
ref to the tree can be stored in an 'undo' file somewhere under .git.
When the merge is done then a git-redo-script can retrieve and merge
that tree back into the index.  This way, cg-{merge,update} could refuse
--- which I tend to think it should --- to merge into a dirty tree but
it wouldn't be so inconvenient.

cogito would handle synchronization with the working copy like normal.

Carl

On Tue, Aug 23, 2005 at 08:09:04PM +1200, Martin Langhoff wrote:
> Should cg-update or cg-merge be refusing to merge if the tree is
> dirty? If there are uncommitted files, and the merge fails, a lot of
> unrelated changes will be dumped on the working tree, which ends up
> with a mix of things.
> 
> cheers,
> 
> 
> martin
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
