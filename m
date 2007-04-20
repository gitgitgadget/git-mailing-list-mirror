From: Junio C Hamano <junkio@cox.net>
Subject: Re: git clone problem through HTTP
Date: Fri, 20 Apr 2007 14:09:35 -0700
Message-ID: <7vk5w6ycq8.fsf@assigned-by-dhcp.cox.net>
References: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com>
	<7vodliyd1j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Aubrey Li" <aubreylee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 23:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf0MO-0005ve-Od
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 23:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767189AbXDTVJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 17:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767224AbXDTVJh
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 17:09:37 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39624 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767189AbXDTVJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 17:09:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420210937.NNJI1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 17:09:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pZ9b1W0101kojtg0000000; Fri, 20 Apr 2007 17:09:36 -0400
In-Reply-To: <7vodliyd1j.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 20 Apr 2007 14:02:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45132>

Junio C Hamano <junkio@cox.net> writes:

> "Aubrey Li" <aubreylee@gmail.com> writes:
>
>> I'm behind of a firewall on which the git port is not permitted, so I
>> can only use http protocol. Unfortunately, I can't clone linus' git
>> tree at all. I've tried
>>
>> git version 1.4.4.2
>> git version 1.4.4.4
>> git version 1.5.0.1
>> git version 1.5.0.4
>> git version 1.5.0.6
>> git version 1.5.1.1,
>>
>> none of them work. The following is the error.
>
>         $ git init
>         $ git remote add origin http://.../linux-2.6.git

This step needs to have "add -m master" instead of just "add".

> 	$ git config branch.master.remote origin
> 	$ git config branch.master.merge refs/heads/master
>         $ git fetch
>         $ git merge origin

Otherwise you end up having to say "git merge origin/master" here.

>
> should work, because I knew about this problem and fixed it in
> git-fetch in v1.5.0.
