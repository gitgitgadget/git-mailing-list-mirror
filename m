From: Junio C Hamano <junkio@cox.net>
Subject: Re: The git protocol and DoS
Date: Wed, 19 Oct 2005 13:50:40 -0700
Message-ID: <7vmzl544f3.fsf@assigned-by-dhcp.cox.net>
References: <4356A5C5.5080905@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 22:53:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESKte-0008Sk-3D
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 22:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVJSUum (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 16:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVJSUum
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 16:50:42 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20902 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751305AbVJSUul (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 16:50:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019205042.WUGO9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 16:50:42 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4356A5C5.5080905@zytor.com> (H. Peter Anvin's message of "Wed,
	19 Oct 2005 13:00:05 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10305>

"H. Peter Anvin" <hpa@zytor.com> writes:

> It would, however, require a protocol change; I would like to hear what 
> people think about this at this stac=ge.

Well, it is full two days since a majorly visible git protocol
enabled server has been announced, and you probably know what
kind of hits you are getting (and please let us know if you have
numbers, I am curious).  If we do a protocol change, earlier the
better.  You already said that the kernel.org git is
experimental.  Does anybody run git daemons and rely on the
current protocol?

I suspect it would not make *any* sense to have a backward
compatible server that optionally allows this cookie exchange --
attackers can just say "I am an older client".  OTOH, it
probably makes sense to have an option on the client side to
skip the cookie exchange stage.  I do not think autodetecting
new/old server on the client side in connect.c is possible.
