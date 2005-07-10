From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sun, 10 Jul 2005 13:46:24 +0100
Message-ID: <20050710134624.B3279@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org> <12c511ca050707170964a2cc92@mail.gmail.com> <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org> <20050709225818.A31045@flint.arm.linux.org.uk> <20050709232955.B31045@flint.arm.linux.org.uk> <7vpstrv8z6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507092158290.17536@g5.osdl.org> <Pine.LNX.4.58.0507092211470.17536@g5.osdl.org> <20050710075548.A11765@flint.arm.linux.org.uk> <7v4qb3uo63.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Tony Luck <tony.luck@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 14:46:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrbCk-0002t1-Tr
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 14:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVGJMqi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 08:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVGJMqi
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 08:46:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49420 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261927AbVGJMqg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 08:46:36 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DrbCT-00017x-Re; Sun, 10 Jul 2005 13:46:26 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DrbCS-00024q-J8; Sun, 10 Jul 2005 13:46:24 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <7v4qb3uo63.fsf@assigned-by-dhcp.cox.net>; from junkio@cox.net on Sun, Jul 10, 2005 at 12:15:48AM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10, 2005 at 12:15:48AM -0700, Junio C Hamano wrote:
> As a workaround until Cogito gets updated, would it help to have
> the environment variable GIT_ALTERNATE_OBJECT_DIRECTORIES
> pointing at the untouched copy of Linus tree's .git/objects/
> directory?  All your other trees would find the objects in your
> copied-Linus tree (including packed one) available to them
> already and hopefully pull breakage does not even have to touch
> those objects.

That seems to work, thanks.  I think this is a good idea anyway -
it seems to mean that each working tree ends up with an empty set of
.git/objects/* directories.  When new work is done in a tree, the
corresponding objects then appear, and only these objects need
transferring upstream.

It means that rsync --delete-after can (in theory) be used when
making changes available to the upstream maintainer.

-- 
Russell King
