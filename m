From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] SVN import: Use one log call
Date: Tue, 29 Nov 2005 23:54:24 -0800
Message-ID: <7vwtiqwoy7.fsf@assigned-by-dhcp.cox.net>
References: <pan.2005.11.29.07.13.02.145977@smurf.noris.de>
	<7vhd9vdx1o.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511292247591.3122@localhost.localdomain>
	<20051130065241.GY20418@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 09:15:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhMnW-0005Z0-KF
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 08:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVK3Hy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 02:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVK3Hy0
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 02:54:26 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:12230 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751068AbVK3Hy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 02:54:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130075251.BNDH20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 02:52:51 -0500
To: Matthias Urlichs <smurf@smurf.noris.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12992>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> Nicolas Pitre:
>> Same here, with the following public repo: svn://mielke.cc/main/brltty
>> 
> Same thing -- should work with a "-T main/brltty" option.

So would the full command line be like this?

	$ rm -rf try1; mkdir try1; cd try1
        $ git-svnimport -T main/brltty svn://mielke.cc/main/brltty

I realize my first attempt was incorrectly using "-t" (tags)
instead of "-T" (trunk), which was obviously incorrect, but
replacing that lowercase -t with -T did not work well.  However,
as you told me:

	$ git svnimport -T main/sources \
	    http://127.0.0.1/svn/private/main/sources/photocat

seems to be doing something.  But I do not understand why.  How
did you decide "-T main/sources" is good for my case while "-T
main/brltty" is good for Nicolas?  I would have guessed you may
say "-T main" for Nicolas, dropping the last path component.
