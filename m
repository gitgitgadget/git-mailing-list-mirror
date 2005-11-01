From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 17:13:26 +0000
Message-ID: <b0943d9e0511010913p2914ae85k@mail.gmail.com>
References: <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
	 <20051031195010.GM11488@ca-server1.us.oracle.com>
	 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
	 <20051031213616.GO11488@ca-server1.us.oracle.com>
	 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
	 <20051031224246.GP11488@ca-server1.us.oracle.com>
	 <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz>
	 <20051101141149.GA26847@watt.suse.com>
	 <Pine.LNX.4.64.0511010757040.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Mason <mason@suse.com>, Petr Baudis <pasky@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 18:16:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWzhZ-0006g6-DZ
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 18:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVKARN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 12:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVKARN2
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 12:13:28 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:19722 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750966AbVKARN1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 12:13:27 -0500
Received: by xproxy.gmail.com with SMTP id i30so1363276wxd
        for <git@vger.kernel.org>; Tue, 01 Nov 2005 09:13:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RzPLd29vaGbPmjHxWi1dzof5dkOruLKjwGi4vXK50H1cIZllc32DKZ72/99zhPIaJYSkbSwxGAMFnuNFCIB8L/YugAN1jNzGJcBSJF0inepD1arQwvmuyaGXplRdNLDzKpvfR3AiHyQMLrRxIefdVPTZ/DqsF/dfaqvQX4y0H1c=
Received: by 10.70.118.9 with SMTP id q9mr2642734wxc;
        Tue, 01 Nov 2005 09:13:26 -0800 (PST)
Received: by 10.70.31.3 with HTTP; Tue, 1 Nov 2005 09:13:26 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511010757040.27915@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10940>

On 01/11/05, Linus Torvalds <torvalds@osdl.org> wrote:
> On Tue, 1 Nov 2005, Chris Mason wrote:
> > StGIT has the ability to rebase patches via three-way merge.  This is
> > still on my todo list for mq.
>
> So I'm _neither_ a StGIT not mq user, but I can definitely say that
> rebasing with a three-way merge instead of just trying to apply the patch
> (whether in reverse like in a merge, or just re-apply it straigt) is
> really really nice.

StGIT first tries a "git-diff-tree | git-apply" since it is faster but
when this fails it falls back to a three-way merge. A 'stg status'
command would show the conflicted files and they should be marked as
resolved before refreshing the patch.

One of the good parts of the three-way merge is that it detects when a
patch you sent was fully merged upstream, the local patch becoming
empty after the merge. If not, you either get a conflict or the merge
leaves the patch with only the unmerged parts.

--
Catalin
