From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list: make --dense the default (and introduce "--sparse")
Date: Wed, 26 Oct 2005 02:17:22 -0700
Message-ID: <7vwtk08wnx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510251459070.10477@g5.osdl.org>
	<Pine.LNX.4.64.0510251525540.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 11:19:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUhPp-0000xg-L9
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 11:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbVJZJRZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 05:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVJZJRZ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 05:17:25 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:15327 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932600AbVJZJRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 05:17:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026091646.MAJQ11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Oct 2005 05:16:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510251525540.10477@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 25 Oct 2005 15:29:42 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10660>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 25 Oct 2005, Linus Torvalds wrote:
>> 
>> This actually does three things:
>> 
>>  - make "--dense" the default for git-rev-list...

Heads up.

I have not looked closely into what exactly, but the fourth
thing this does might be to break git-send-pack.

I usually use the tip of "pu" myself, but for tonight, I am
excluding the fetch-pack/upload-pack changes from Johannes when
building git for my own use, and using somewhere in the middle
of "pu" branch.  With this "--dense default" patch,
git-send-pack seems to send too few objects.  With this patch
reverted, git-send-pack seems to work again.

 +  [build] Revert "git-rev-list: make --dense the default (and introduce "--sparse")"
 ++ [pu^] Merge branch 'js-fat'
 ++ [pu^^2] Test in git-init-db if the filemode can be trusted
 ++ [pu~2] Merge branches 'cache-pack', 'lazy-subdir' and 'lt-dense'
 ++ [pu~2^4] git-rev-list: make --dense the default (and introduce "--sparse")
 ++ [pu~2^3] Create object subdirectories on demand (phase II)
 ++ [pu~2^2] Allow caching of generated pack for full cloning.
+++ [master] upload-pack: tighten request validation.

I'll take a look at the issue in the morning unless somebody
else beats me to it.
