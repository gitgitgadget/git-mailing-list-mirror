From: Theodore Tso <tytso@mit.edu>
Subject: Re: blame follows renames, but log doesn't
Date: Tue, 19 Jun 2007 03:19:16 -0400
Message-ID: <20070619071916.GC9177@thunk.org>
References: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 09:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Xzs-0001AN-02
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 09:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421AbXFSHT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 03:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbXFSHT0
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 03:19:26 -0400
Received: from THUNK.ORG ([69.25.196.29]:38771 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755156AbXFSHT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 03:19:26 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I0Y7P-0006CZ-1b; Tue, 19 Jun 2007 03:27:15 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I0Xzg-0003PW-KY; Tue, 19 Jun 2007 03:19:16 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50451>

On Tue, Jun 19, 2007 at 01:10:28PM +1200, Martin Langhoff wrote:
> 
> when I show git to newbies or demo it to people using other SCMs, and
> we get to the rename part of the conversation, I discuss and show how
> GIT's approach is significantly better than explicit recording of
> renames.
> 
> One great example is git-blame -- actually more spectacular with the
> recent git gui blame improvements. But git-log still doesn't do it.

Actually, the bigger missing gap is merges.  Suppose in the
development branch, you rename a whole bunch of files.  (For example,
foo_super.c got moved to foo/super.c, foo_inode.c got moved to
foo/inode.c, etc.)

Now suppose there are fixes made in the stable branch, in the original
foo_super.c and foo_inode.c files.  Ideally you would want to be able
to pull those changes into the development branch, where the files
have new names, and have the changes be applied to foo/super.c and
foo/inode.c in the development branch.

I was recently talking to someone who is still using BitKeeper, and he
cited this scenario as one of the reasons why his project is still
using BK; he'd like to move to git, but this is a critical piece of
functionality for him. 

						- Ted
