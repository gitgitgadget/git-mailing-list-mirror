From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] rev-list: honor --abbrev=<n> when doing --pretty=oneline
Date: Thu, 6 Apr 2006 20:13:56 -0700
Message-ID: <20060407031356.GA25525@hand.yhbt.net>
References: <20060407004455.GF15743@hand.yhbt.net> <7v64lmuqa5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 07 05:14:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRhQ7-0002Zr-Ow
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 05:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWDGDN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 23:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWDGDN5
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 23:13:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:13469 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932305AbWDGDN4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 23:13:56 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 446192DC034; Thu,  6 Apr 2006 20:13:56 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64lmuqa5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18491>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Note that --abbrev=DEFAULT_ABBREV was on by default before, but
> > it only affected the printing of the Merge: header).  Let me
> > know if anybody doesn't want the default behavior to change.
> 
> I've never felt need for abbreviating commit object names, so I
> only had the abbrev variable to determine how the merge parents
> are shown.  If you want to abbreviate the commit object names as
> well, you _could_ do independent precision for parents and
> commits, but that would be overkil.  So I'd rather see a switch
> to turn abbreviation for commits on, perhaps like this:
> 
>         $ git-rev-list --pretty=oneline --abbrev-commit -n 3 master
>         454a35b Add documentation for git-imap-send.
>         ba3c937 blame.c: fix completely broken ancestry traversal.
>         6cbd5d7 Tweaks to make asciidoc play nice.
> 
>         $ git-rev-list --pretty=oneline --abbrev=4 --abbrev-commit -n 3 master
>         454a Add documentation for git-imap-send.
>         ba3c9 blame.c: fix completely broken ancestry traversal.
>         6cbd5 Tweaks to make asciidoc play nice.
> 
> Otherwise you might break Porcelains and people's scripts that
> read from --pretty or --header output.
> 
> -- >8 --

Sounds good, I like your patch.  I'm not thrilled with the length of the
'--abbrev-commit' switch, but I guess that's what aliases are for :>

-- 
Eric Wong
