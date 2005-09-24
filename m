From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Fri, 23 Sep 2005 19:00:04 -0700
Message-ID: <7vvf0r6x97.fsf@assigned-by-dhcp.cox.net>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 04:00:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIzKv-0000Zy-96
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 04:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVIXCAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 22:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVIXCAL
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 22:00:11 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:59025 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751126AbVIXCAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 22:00:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050924020006.ZFTV26651.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 22:00:06 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050924011833.GJ10255@pasky.or.cz> (Petr Baudis's message of
	"Sat, 24 Sep 2005 03:18:33 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9223>

Petr Baudis <pasky@suse.cz> writes:

> It takes loooong time, unfortunately - scp -r takes its time itself on
> many small files, and then we have to make a separate call to
> git-ssh-fetch for each tag. Isn't that braindamaged... :/

I think you could run git-peek-remote to find all the refs and
then run git-fetch-pack to slurp all the tags (and heads for
that matter) at once.  Is there a particular reason you would
prefer the commit walker?
