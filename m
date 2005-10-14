From: Junio C Hamano <junkio@cox.net>
Subject: Re: Peeling the onion
Date: Fri, 14 Oct 2005 01:40:42 -0700
Message-ID: <7vpsq8trsl.fsf@assigned-by-dhcp.cox.net>
References: <7v3bnra20z.fsf@assigned-by-dhcp.cox.net>
	<8764snyufn.fsf@ualberta.net>
	<7v4q875bbj.fsf@assigned-by-dhcp.cox.net>
	<20050927094029.GA30889@pasky.or.cz>
	<7v64sm30dh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509271020530.3308@g5.osdl.org>
	<7v64sm1hp3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509271414000.3308@g5.osdl.org>
	<7virwlumyo.fsf@assigned-by-dhcp.cox.net>
	<7voe5sws7y.fsf_-_@assigned-by-dhcp.cox.net>
	<46a038f90510140048r30c7ec36n35f77a1ac52c4691@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 10:43:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQL7f-0004hX-AN
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 10:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVJNIkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 04:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVJNIkp
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 04:40:45 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:60559 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750743AbVJNIko (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 04:40:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051014084034.LPFT19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Oct 2005 04:40:34 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510140048r30c7ec36n35f77a1ac52c4691@mail.gmail.com>
	(Martin Langhoff's message of "Fri, 14 Oct 2005 20:48:39 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10104>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> I personally don't care much for the -t option, at the moment. I do
> think that tree identity is in some contexts more important than
> commit identity, so there will be instances where you really want to
> have a canonical way to "drill down" to the tree.

I do not know how useful it would be, but the onion peeler can
be told to dereference commit to tree.

$ ./git-cat-file -s 'v0.99.8^{tree}' 
6875
$ ./git-cat-file -s 'v0.99.8^{commit}' 
435
$ ./git-cat-file -t 'v0.99.8^{tree}' 
tree
$ ./git-cat-file -t 'v0.99.8^{commit}' 
commit
$ ./git-rev-parse v0.99.8 \
  v0.99.8^0 v0.99.8^{commit} \
  v0.99.8^{commit}^{tree} v0.99.8^{tree}
b041895af323bdef10cc9a718bda468ba3622bc0
91dd674e30ba0298e89c9be2657024805170c2ac
91dd674e30ba0298e89c9be2657024805170c2ac
bfd844a69bfd582d107622c27b89e9b959e89fd8
bfd844a69bfd582d107622c27b89e9b959e89fd8
