From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn error "Not a valid object name"
Date: Sat, 16 Mar 2013 01:45:48 +0000
Message-ID: <20130316014548.GA16253@dcvr.yhbt.net>
References: <CAJKLP9ZQBXf5ZZY9FccOAL5QU+q1b5SnAfvP9BpARdqvzPuWeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dannes Wessels <dannes@exist-db.org>,
	Wolfgang Meier <wolfgang@exist-db.org>,
	=?utf-8?Q?Leif-J=C3=B6ran?= Olsson <ljo@exist-db.org>
To: Adam Retter <adam@exist-db.org>
X-From: git-owner@vger.kernel.org Sat Mar 16 02:46:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgCX-0001Aq-F4
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 02:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389Ab3CPBpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 21:45:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39734 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785Ab3CPBps (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 21:45:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2558B1F442;
	Sat, 16 Mar 2013 01:45:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJKLP9ZQBXf5ZZY9FccOAL5QU+q1b5SnAfvP9BpARdqvzPuWeg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218270>

Adam Retter <adam@exist-db.org> wrote:
> Our public SourceForge Subversion repository is here:
> http://svn.code.sf.net/p/exist/code/trunk/eXist

It's asking me for a username/password...

> We cloned that to the local server using rsync and are attempting to
> migrate to git using the following commands:
> 
> $ git svn init -t tags -b stable -T trunk
> file:///home/ec2-user/svn-rsync/code new-git-repo
> $ cd new-git-repo
> $ git config svn-remote.svn.preserve-empty-dirs true
> $ git config svn-remote.svn.rewriteRoot https://svn.code.sf.net/p/exist/code
> $ git svn fetch -A /home/ec2-user/.svn2git/authors.txt
> 
> It all started well and was running away for quite some hours, when
> the following error occurred:
> 
> fatal: Not a valid object name
> ls-tree -z  ./webapp/api/: command returned error: 128
> 
> I have no idea what this means, or how to fix this.
> We are using Git version 1.8.1.GIT on Amazon EC2 Linux.
> 
> Any suggestions please?

You might've hit a bug in branch detection, but I'd have to look at the
repo to be certain and fix it if neded.
--no-follow-parent should work, but you'd lose branch/tag history.
