From: Junio C Hamano <junkio@cox.net>
Subject: Re: qgit reports errors in the git repository
Date: Sat, 17 Dec 2005 01:36:52 -0800
Message-ID: <7vu0d812vf.fsf@assigned-by-dhcp.cox.net>
References: <1134433440.3798.27.camel@dv> <1134624477.5360.6.camel@dv>
	<e5bfff550512150501v48bb65abwf44b3fc21f33bdf6@mail.gmail.com>
	<1134665095.27212.22.camel@dv>
	<e5bfff550512151100k33a66db5tdb2eb1ff2da10a59@mail.gmail.com>
	<1134693349.22652.22.camel@dv>
	<e5bfff550512152258t3f7b2eb1i1c709572b18fe3f7@mail.gmail.com>
	<1134757942.2248.11.camel@dv>
	<e5bfff550512161247v4c187cc0gedae8234d454c3b6@mail.gmail.com>
	<7virto9pr0.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550512170044v59f96262ica6511e981889ea9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 10:37:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnYUu-0003fV-Eu
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 10:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVLQJgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 04:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVLQJgy
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 04:36:54 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52122 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932268AbVLQJgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2005 04:36:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051217093528.JBJI17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Dec 2005 04:35:28 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550512170044v59f96262ica6511e981889ea9@mail.gmail.com>
	(Marco Costalba's message of "Sat, 17 Dec 2005 09:44:52 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13775>

Marco Costalba <mcostalba@gmail.com> writes:

> Using
>
> git-clone http://digilander.libero.it/mcostalba/qgit.git qgit_test
>
> does not work (never did). Peraphs it's time I dig a little bit deeper.

Do you keep qgit.git/info/refs, qgit.git/objects/info/packs, and
possibly qgit.git/objects/info/alternates up-to-date under
http://digilander.libero.it/mcostalba/?  Your server seems to
give friendly "no such page" instead of usual 404 not found for
nonexisting paths, which means that you would probably need to
have an empty info/alternates file there, and if you do not have
packs then empty info/packs files as well.

Also I suspect once you start packing your repository the
downloaders would have a hard time --- instead of getting "not
found" as a cue to switch to fetching packs they would get the
"friendly page" and mistakenly think the loose object stored in
your repository is corrupt.
