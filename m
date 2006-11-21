X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 23:31:30 +0100
Message-ID: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 22:33:15 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32048>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmeAL-0001Yk-5O for gcvg-git@gmane.org; Tue, 21 Nov
 2006 23:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031172AbWKUWca (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966584AbWKUWca
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 17:32:30 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:45701 "EHLO
 smtp1-g19.free.fr") by vger.kernel.org with ESMTP id S966478AbWKUWc3 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 17:32:29 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp1-g19.free.fr (Postfix) with ESMTP id 406D39B3E1;
 Tue, 21 Nov 2006 23:32:24 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 9F0D61F06E;
 Tue, 21 Nov 2006 23:31:30 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Mon, Nov 20, 2006 at 03:05:47PM -0800, Linus Torvalds wrote:
> On Mon, 20 Nov 2006, Junio C Hamano wrote:
> > 
> > That was shot down by Linus and I agree with him.  "bind" was a
> > bad idea because binding of a particular subproject commit into
> > a tree is a property of the tree, not one of the commits that
> > happen to have that tree.
> 
> Yes. I think it would be a _fine_ idea to have a new tree-entry type that 
> points to a sub-commit, but it really does need to be on a "tree level", 
> not a commit level.

I'm not sure I get the reason why the submodule should not be recorded
on "commit level".

What I'm thinking of would be that the submodule tree would just be a
standard antry of a tree in the supermodule, and we could record the
submodule commit (pointing to the submodule tree) in the supermodule
commit.

This idea came when thinking about implementing partial merges.  That
is, when different people are responsible for different parts of the
tree, and thus when merging a given branch, each dev has to make only
a partial merge of the full tree.
Having submodule commits referenced directly from the supercommit would
make it much easier to finalize the merge (ie. merging the full project
while taking into account that some subtrees have been merged already).

Best regards,
-- 
