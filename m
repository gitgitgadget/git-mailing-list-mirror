From: Chris Mason <mason@suse.com>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 12:59:05 -0500
Message-ID: <20051101175905.GC26847@watt.suse.com>
References: <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com> <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com> <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz> <20051101141149.GA26847@watt.suse.com> <b0943d9e0511010929u22b33e4el@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 19:00:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX0Pi-0005cj-GM
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 18:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVKAR7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 12:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVKAR7L
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 12:59:11 -0500
Received: from cantor2.suse.de ([195.135.220.15]:230 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751062AbVKAR7K (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 12:59:10 -0500
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2646C7FC;
	Tue,  1 Nov 2005 18:59:09 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0511010929u22b33e4el@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10946>

On Tue, Nov 01, 2005 at 05:29:19PM +0000, Catalin Marinas wrote:
> On 01/11/05, Chris Mason <mason@suse.com> wrote:
> > mq is closer to quilt.  The patches are stored as patches, and hg qpush
> > is very similar to importing a patch.  This means metadata must be
> > stored at the top of the patch in some form the import code can
> > understand (it tries to be smart about this).
> 
> The problem with this is allowing people to modify the patch directly
> (with vi). This would make it difficult to do a three-way merge
> without either losing the direct changes or simply failing to apply a
> modified patch to its old base (I thought about using patches as an
> optimisation but after some benchmarking found that "git-diff-tree |
> git-apply" is fast enough and most of the time when pushing is
> calculating the sha1 hash of the resulting index file).

The three way merge is still possible even if someone hand edits the
patch.  For a three way merge, you just need to know the parent revision
of the change you want to merge.  parent can mean the revision in the
repository that precedes this patch (mq stores this information, just
not in the patch), or it can mean any revision where the patch applies
cleanly.

Both approaches (mq vs stgit) have advantages...you can get roughly the same
functionality either way.

-chris
