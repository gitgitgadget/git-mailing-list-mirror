From: Junio C Hamano <junkio@cox.net>
Subject: Re: HTTP repo referencing stale heads (can't clone)
Date: Mon, 03 Apr 2006 10:23:22 -0700
Message-ID: <7virpqefp1.fsf@assigned-by-dhcp.cox.net>
References: <443146EC.7060704@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 19:24:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQSmY-0001mZ-EY
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 19:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWDCRXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 13:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWDCRXp
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 13:23:45 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:9192 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751769AbWDCRX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 13:23:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060403172323.SPUF20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Apr 2006 13:23:23 -0400
To: Daniel Drake <dsd@gentoo.org>
In-Reply-To: <443146EC.7060704@gentoo.org> (Daniel Drake's message of "Mon, 03
	Apr 2006 17:01:48 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18344>

Daniel Drake <dsd@gentoo.org> writes:

> I maintain a small git repo. I upload it over ssh (with git-push) to a
> machine where it is distributed over http:
>
> http://dsd.object4.net/git/zd1211.git/
>...
> I have tried running git-prune and git-update-server-info, but that
> doesn't help.
>
> Any ideas?

My standard answer would be

http-server$ cd /var/www/git/zd1211.git/ ;# or whereever
http-server$ GIT_DIR=. git-update-server-info

but you said you have run it already...  Can you try to see if
there is some caching proxy involved that still serves stale
info/refs file?

client$ wget http://dsd.object4.net/git/zd1211.git/info/refs
