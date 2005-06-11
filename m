From: Junio C Hamano <junkio@cox.net>
Subject: Re: do people use the 'git' command?
Date: Sat, 11 Jun 2005 00:50:40 -0700
Message-ID: <7vu0k5xrfz.fsf@assigned-by-dhcp.cox.net>
References: <E1DgodI-0003ov-Fl@highlab.com>
	<7vy89h4m9r.fsf@assigned-by-dhcp.cox.net>
	<E1DgyW0-0004PE-Ct@highlab.com>
	<2cfc403205061023346c03a25b@mail.gmail.com>
	<7vpsutz88z.fsf@assigned-by-dhcp.cox.net>
	<2cfc403205061100204cd43334@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Kuzminsky <seb@highlab.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 09:51:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh0lf-00010x-An
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 09:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVFKHwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 03:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVFKHuy
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 03:50:54 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54197 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261640AbVFKHun (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 03:50:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611075042.LZRU19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Jun 2005 03:50:42 -0400
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc403205061100204cd43334@mail.gmail.com> (Jon Seymour's
 message of "Sat, 11 Jun 2005 17:20:46 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JS" == Jon Seymour <jon.seymour@gmail.com> writes:

JS> Then:

JS>     git update-cache 

JS> would work as expected.

I'd rather teach the user to say git-update-cache once they
learned how git works.

Let's stop and think.  Compare lower level binaries and
git-*-script commands, especially paying attention to the level
of operation of what they do.  Notice the difference?

The git-*-script commands are already more or less Porcelain
themselves, and for that reason alone, they deserve to have
CVS/SVN familiarity wrapper.  They are designed to be usable
even by people who are still not familiar with the GIT way of
doing things, and the purpose of the "git" wrapper is to help
these people try putting their toes in the water.  Once they
understand how these scripts work, they either care about
Plumbing because they want to do something existing Porcelain
layers do not offer (in which case they would write their own
Porcelain extensions using Plumbing commands).  Or with luck,
they may not have to worry about Plumbing at all.

I grant you that what the current "git" wrapper offers is not
Porcelain enough, and to perform anything meaningful you either
need to use Porcelain or bare Plumbing commands yourself.  But
when that day comes, "git update-cache" is not something you
would want to have anyway.  You would rather want to have things
like "git add" and "git remove", which are written in terms of
git-update-cache.

See what I am saying?

