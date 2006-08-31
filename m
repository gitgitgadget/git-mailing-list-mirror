From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 0/4] gitweb: ViewVC-like "tree_blame" view
Date: Wed, 30 Aug 2006 17:00:03 -0700
Message-ID: <7vfyfdg4fw.fsf@assigned-by-dhcp.cox.net>
References: <200608310043.12606.jnareb@gmail.com> <ed55nu$62k$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 01:59:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIZxh-0004Kj-1A
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 01:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWH3X7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 19:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWH3X7I
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 19:59:08 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:24979 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750777AbWH3X7F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 19:59:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060830235905.UCNA18458.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Wed, 30 Aug 2006 19:59:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GPz11V00B1kojtg0000000
	Wed, 30 Aug 2006 19:59:01 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ed55nu$62k$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	31 Aug 2006 01:08:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26239>

Jakub Narebski <jnareb@gmail.com> writes:

> At the below URL (links of course _won't_ work)
>   http://front.fuw.edu.pl/jnareb/tree_blame.html
> is output of  "tree_blame" view. One can sort by Date (age), Author, Mode
> and Filename. The date view was modelled after 'ls -l' view; the order of
> columns probably should be changed to match it more closely.

Just a quick impression.

 - "Mode" looks too wide for the information it conveys.  Path
   being a link already tells whether it is a tree, so the only
   information you would need is a bit and half (regular file,
   executable regular file, or symbolic link).

 - Spelling out Date in human readable form is fine but I suspect
   it would be nicer if it used YYYY-MM-DD / MM-DD HH:MM

 - I personally do not like blaming the last person who touched
   the file, but that is probably just me so it is fine.

 - "Commit" column does not seem to convey much useful
   information; I would suggest perhaps making Date and/or
   Author clickable to take the browser to the commit, but I do
   not understand what the strike-through is about...

 - Since the rightmost links have quite a lot of information
   these days, it _might_ be reasonable to make the main part
   2 lines, like so:

	date    author   mode    path
        short-commit-log-message

	date    author   mode    path
        short-commit-log-message

        ...

 - I wonder how expensive it is to generate this.
