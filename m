From: Junio C Hamano <junkio@cox.net>
Subject: Re: first impressions to git
Date: Sun, 18 Sep 2005 10:31:37 -0700
Message-ID: <7vr7bm470m.fsf@assigned-by-dhcp.cox.net>
References: <20050918111259.GA10882@schottelius.org>
	<Pine.LNX.4.63.0509181201220.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
	Christian Gierke <ch@gierke.de>,
	Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
X-From: git-owner@vger.kernel.org Sun Sep 18 19:33:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH312-0003fw-S8
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 19:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVIRRbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 13:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVIRRbk
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 13:31:40 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45705 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932130AbVIRRbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 13:31:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050918173139.HDDB23678.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Sep 2005 13:31:39 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509181201220.23242@iabervon.org> (Daniel
	Barkalow's message of "Sun, 18 Sep 2005 12:56:21 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8793>

Daniel Barkalow <barkalow@iabervon.org> writes:

> We need to fix the error for trying to add a directory, and we should 
> probably support it in "add".

Yup.

> Core git doesn't have a .git/info/excludes at all. (And, in general, 
> .gitignore makes more sense, I think, because you usually want this to be 
> version-controlled; but maybe there should be .git/info/excludes as a 
> default for new directories?)

We by default install info/excludes disabled in a new repository
and 'git status' looks at it.  What it _does_ not do is to use
any exclude patterns by default; if info/excludes is empty
(modulo '# comment' lines) it does not use .gitignore.

> ".git/remotes" is the current one; ".git/branches" is obsolete.

Perhaps deprecated but obsolete is too strong a word -- it still
is supported.
