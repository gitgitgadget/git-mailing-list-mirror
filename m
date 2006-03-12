From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sun, 12 Mar 2006 11:34:01 -0800
Message-ID: <7vk6azcv9y.fsf@assigned-by-dhcp.cox.net>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
	<7voe0bdeyr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 12 20:41:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIWKU-00042V-MT
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 20:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWCLTeE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 14:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbWCLTeE
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 14:34:04 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:8337 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751523AbWCLTeD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 14:34:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060312193048.HNHG26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Mar 2006 14:30:48 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603120858230.3618@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 12 Mar 2006 09:00:13 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17525>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 12 Mar 2006, Junio C Hamano wrote:
>> 
>> master  : 130m virtual, 40m resident, (0major+12510minor)
>>           66.06user 0.07system 1:10.95elapsed
>> "next"  : 150m virtual, 65m resident, (0major+49858minor)
>>           51.41user 0.45system 0.57.55elapsed
>
> Any way to fix that "4 times as many page misses, and 70% bigger rss?" 
> thing? It looks like you're not very careful about your memory use.

I started from "80 times as many page misses and 5 times bigger
rss", shrunk it down to the above after doing more careful
memory use, running out of ideas to shrink it more, and pushed
it out.  So...
