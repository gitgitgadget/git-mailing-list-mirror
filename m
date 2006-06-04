From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support for configurable git command aliases (v2)
Date: Sun, 04 Jun 2006 15:38:54 -0700
Message-ID: <7v8xoc8s1t.fsf@assigned-by-dhcp.cox.net>
References: <20060604211931.10117.82695.stgit@machine.or.cz>
	<20060604212050.GV10488@pasky.or.cz>
	<mj+md-20060604.221036.15619.albireo@ucw.cz>
	<20060604221930.GW10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 00:39:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn1FM-0002dT-UL
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 00:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWFDWi4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 18:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWFDWi4
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 18:38:56 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:12778 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932298AbWFDWi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 18:38:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604223855.ITTV27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 18:38:55 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20060604221930.GW10488@pasky.or.cz> (Petr Baudis's message of
	"Mon, 5 Jun 2006 00:19:30 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21291>

Petr Baudis <pasky@ucw.cz> writes:

>
>   Then again, as pointed out on IRC you might get very confused as well
> if you do git log | less. Besides, this is not going to help you with
> aliases like commit = commit -a.
>
>   So, some other possibilities are to:
>
>   (i) Test stdin. Even in scripts, stdin is frequently terminal, but you
> might add </dev/null after each git invocation and get a serious case of
> RSI.
>
>   (ii) Add a --no-alias git argument. This way lies madness, too.
>
>   (iii) Check a $GIT_NO_ALIAS environment variable. This might work
> best, after all. Opinions? Or some other clever idea?

Perhaps the simplest:

    (iv) Refuse/ignore an alias that hides existing command, and
         train users to write portable scripts by not using
         aliases.  E.g. "alias.log = log --pretty=raw" is
         ignored, and you would do "alias.l = log --pretty=raw"
         instead.
