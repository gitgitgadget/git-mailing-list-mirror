From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Converting from svn to git
Date: Sun, 10 Aug 2008 17:32:34 +0200
Message-ID: <g7n1mk$67t$1@ger.gmane.org>
References: <e0b44a890808100611t27ddfcb6v21eecea89484c90b@mail.gmail.com>	 <20080810132409.GE18960@genesis.frugalware.org> <e0b44a890808100754l536bc4f3kfd953b52044f6e59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 17:34:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSCvi-0001JT-7m
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 17:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbYHJPcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 11:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYHJPcq
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 11:32:46 -0400
Received: from main.gmane.org ([80.91.229.2]:44923 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbYHJPcq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 11:32:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KSCuR-0004NG-Is
	for git@vger.kernel.org; Sun, 10 Aug 2008 15:32:43 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 15:32:43 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 15:32:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <e0b44a890808100754l536bc4f3kfd953b52044f6e59@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91848>

David Neu venit, vidit, dixit 10.08.2008 16:54:
> Thanks for the reply - this looks like what I'd need, but
> I can't see how to keep the contents of the base dir and
> lose the subdirs, e.g.
> 
> $ git-filter-branch --subdirectory-filter . HEAD
> 
> removes all subdirs and the contents of the base dir.
> 
> So, I figure I'd remove each subdir, using
> 
> $ git-filter-branch --tree-filter 'rm -rf subdir1/' HEAD
> 
> but this complains if subdir1 contains subdirectories, it
> says: Namespace refs/original/ not empty

It complains because filter-branch stores the original refs in that 
namespace, and on the second filter-branch run it wants to do this 
again. You can avoid this by using the "-f" option to filter-branch, or 
by removing all subsirs in one go ("rm -rf subdir1 subdir2..."). Also, 
you might want to rewrite all refs ("--all"), not just HEAD.

Michael
