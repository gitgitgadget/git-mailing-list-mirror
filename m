From: Junio C Hamano <junkio@cox.net>
Subject: Re: using git directory cache code in darcs?
Date: Sun, 17 Apr 2005 16:23:36 -0700
Message-ID: <7vvf6lugw7.fsf@assigned-by-dhcp.cox.net>
References: <20050416132231.GJ2551@abridgegame.org>
	<Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org>
	<20050417121712.GA22772@abridgegame.org>
	<Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>
	<4262E50C.2070006@lazy.shacknet.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:20:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJ3Z-0005Me-Qn
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVDQXXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVDQXXv
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:23:51 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:10474 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261544AbVDQXXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 19:23:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417232336.UGVL19936.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 19:23:36 -0400
To: Nomad Arton <lkml@lazy.shacknet.nu>
In-Reply-To: <4262E50C.2070006@lazy.shacknet.nu> (Nomad Arton's message of
 "Mon, 18 Apr 2005 00:37:00 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NA" == Nomad Arton <lkml@lazy.shacknet.nu> writes:

NA> Linus Torvalds schrieb:
>> In fact, one of my hopes was that other SCM's could just use the git
>> plumbing. But then I'd really suggest that you use "git" itself, not any
>> "libgit". Ie you take _all_ the plumbing as real programs, and instead of
>> trying to link against individual routines, you'd _script_ it.

NA> please excuse; libgit and scripting to me arent a contradiction. many
NA> sripting languages are extended by C modules, while still happening to
NA> have all the scripting rapidity. its just a matter of how to
NA> communicate with the C code, isnt it?

You are arguing for scripting language binding like what Swig
creates.  While that would also be a worthy addition, having
language binding is not the only way to do _script_.

What Linus is saying is that he wants you to talk with git
plumbing by invoking the executables he have, via system(3),
popen(3), etc.

The C-level first has to be libified before you can start
talking about host language bindings but that just started to
happen and is not ready yet.  However, you can use and benefit
from GIT without waiting for that kind of integration, if you
use the "spawning the executables" approach.  I agree with him.

