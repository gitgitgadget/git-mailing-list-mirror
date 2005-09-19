From: Junio C Hamano <junkio@cox.net>
Subject: Re: Garbage in .git directories???
Date: Sun, 18 Sep 2005 22:21:45 -0700
Message-ID: <7vzmq9y6mu.fsf@assigned-by-dhcp.cox.net>
References: <200509172141.31591.dtor_core@ameritech.net>
	<Pine.LNX.4.58.0509181009160.26803@g5.osdl.org>
	<200509181254.14646.dtor_core@ameritech.net>
	<200509182333.58227.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 19 07:22:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHE6B-0004ex-51
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 07:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVISFVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 01:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVISFVs
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 01:21:48 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:1500 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932309AbVISFVs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 01:21:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919052145.TBNO3875.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 01:21:45 -0400
To: git@vger.kernel.org
In-Reply-To: <200509182333.58227.dtor_core@ameritech.net> (Dmitry Torokhov's
	message of "Sun, 18 Sep 2005 23:33:57 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8837>

Dmitry Torokhov <dtor_core@ameritech.net> writes:

> Btw, after doing a pull from git repository git cone now produces the
> following:
>
> sent 403 bytes  received 2164 bytes  570.44 bytes/sec
> total size is 533  speedup is 0.21
> rsync: link_stat "/scm/git/git.git/objects/info/alternates" (in pub) failed: No such file or directory (2)
> rsync error: some files could not be transferred (code 23) at main.c(1173)

The garbage directory does ont reproduce for me, but I know what
this is.  It is an harmless error message -- I'll hide it in the
next update.  It is checking to see if the remote repository
uses alternates just in case -- since git.git does not use it,
it just does not find one (and needlessly complains).
