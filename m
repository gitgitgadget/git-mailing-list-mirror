From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 26 Jun 2007 15:35:48 +0200
Message-ID: <20070626133548.GB11504@moooo.ath.cx>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net> <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net> <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net> <7vodkb1adr.fsf@assigned-by-dhcp.cox.net> <7virac547s.fsf@assigned-by-dhcp.cox.net> <7v6466oygl.fsf@assigned-by-dhcp.cox.net> <7vfy54tt3l.fsf@assigned-by-dhcp.cox.net> <7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com> <7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com> <7v645cz7vm.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 15:35:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3BCz-0006wF-Rm
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 15:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbXFZNfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 09:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754575AbXFZNfv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 09:35:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:41963 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750827AbXFZNfv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 09:35:51 -0400
Received: (qmail invoked by alias); 26 Jun 2007 13:35:49 -0000
Received: from pD9EBB580.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.128]
  by mail.gmx.net (mp036) with SMTP; 26 Jun 2007 15:35:49 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1940IY7WMd4pC5u5iY7T+T9J6UO9bQjF4S02dFY5E
	PHsh7mzmtRl3JT
Content-Disposition: inline
In-Reply-To: <7v645cz7vm.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50961>

Junio C Hamano <gitster@pobox.com> wrote:
> * ml/worktree (Fri Jun 8 22:57:55 2007 +0200) 9 commits
>  + make git barf when an alias changes environment variables
>  + setup_git_directory: fix segfault if repository is found in cwd
>  + test GIT_WORK_TREE
>  + extend rev-parse test for --is-inside-work-tree
>  + Use new semantics of is_bare/inside_git_dir/inside_work_tree
>  + introduce GIT_WORK_TREE to specify the work tree
>  + test git rev-parse
>  + rev-parse: introduce --is-bare-repository
>  + rev-parse: document --is-inside-git-dir
> * ei/worktree+filter (Wed Jun 6 09:16:56 2007 +0200) 9 commits
>  + filter-branch: always export GIT_DIR if it is set
> 
> I've been resisting these due to the size of the series, but I
> think the definition of is-bare is a bit saner than what we have
> in 'master', and I think it is the right direction in the longer
> term.  HOWEVER, I am not sure about the implementation and
> corner cases, e.g. what should it do in receive-pack?  You
> cannot rely on user setting GIT_WORK_TREE environment -- rather,
> receive-pack is responsible for setting up a sane environment
> for other commands to work in.

Thanks.  I'll have a look at receive-pack this week.  Is there
anything in receive-pack yet which helps to use a working tree in the
hooks?  Or is this something for which the behaviour of git still has
to be defined?
