From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] ls-tree: add --abbrev[=<n>] option
Date: Tue, 7 Mar 2006 11:58:26 -0800
Message-ID: <20060307195826.GA26870@localdomain>
References: <20060307135202.GA17891@localdomain> <7vzmk2jfzr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 20:58:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGiKG-0003wU-By
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 20:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWCGT63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 14:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWCGT63
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 14:58:29 -0500
Received: from hand.yhbt.net ([66.150.188.102]:59566 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932150AbWCGT63 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 14:58:29 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E8E6D2DC033;
	Tue,  7 Mar 2006 11:58:26 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  7 Mar 2006 11:58:26 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmk2jfzr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17348>

Junio C Hamano <junkio@cox.net> wrote:
> Output from ls-tree and ls-files -s are primarily for script
> consumption.  diff-raw output which already has abbrev is also
> primarily for scripts, but we have an excuse there that human
> eyes can spot differences easier in abbreviated form and two
> values on the same row being different is the only information
> we are conveying in "git whatchanged" default output, and not
> abbreviating the object names makes pathnames pushed to far
> right of the display which will be chopped by "less -S".
> 
> So I am not quite sure if I should take this, and a subsequent
> one you would probably send for ls-files ;-).

I've never used ls-files with -s, but it's a simple patch on its way :>

> Care to point out a use case I might have missed that this is
> useful?  I've never done ls-tree to be read by _me_ (not by
> script) unless I am debugging ls-tree itself.

I'm a weirdo and I use vim as a repository browser:
(ref: http://www.gelato.unsw.edu.au/archives/git/0511/13088.html ,
I've since renamed my 'git-show' script to 'git-cat-any').

My usual buffer width is 80 columns.  So when I want to see a file from
a certain tree that's not checked out: I'll run git-ls-tree -r <tree>
and output it to my vim buffer, find the corresponding sha1 for the
file, and hit my ',G' macro with my cursor over the blob sha1 to display
its contents.  Abbreviating the sha1 is very useful for seeing longer
file paths on an 80 column buffer.

-- 
Eric Wong
