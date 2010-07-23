From: Chris Webb <chris@arachsys.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 09:31:50 +0100
Message-ID: <20100723083149.GD27082@arachsys.com>
References: <4C472B48.8050101@gmail.com>
 <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>
 <AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com>
 <AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com>
 <AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
 <4C4778DE.9090905@web.de>
 <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com>
 <m31vavn8la.fsf@localhost.localdomain>
 <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	?var Arnfj?r? Bjarmason <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 10:52:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcDza-00028e-NQ
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 10:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab0GWIwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 04:52:25 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:42582 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab0GWIwX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 04:52:23 -0400
X-Greylist: delayed 1129 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2010 04:52:23 EDT
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1OcDhE-0004HB-95; Fri, 23 Jul 2010 09:33:32 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151507>

Avery Pennarun <apenwarr@gmail.com> writes:

> I actually think Linus's contribution - the particular change to the
> repo format to have trees link to commits - was exactly right.  If we
> want to talk about failings of git-subtree, they all precisely come
> down to the fact that, because it has tree->tree links instead of
> tree->commit links, it has to stash commitid information in the commit
> message, which is gross and error prone.
> 
> git-subtree would have benefitted from tree->commit links, but because
> git's implementation of them is broken, that wasn't an option.

I considered using submodules for one of my projects, and decided against
for some of the usability reasons with multiple repositories which you
highlight. (I didn't know about subtree.)

You've surely considered this already, but reading your description in this
thread, my first thought is that commits within trees could mean different
things depending on whether they're at paths listed in .gitmodules or not.
If the path is listed, the commit is in an external repository. If it isn't,
it's a reference to a local commit, allowing submodules to live in the same
repo as their parent and share some of the advantages you describe for
sub-tree.

Over time, git could then become smarter about recursing through commits in
trees, although I can see a potential problem with needing to know about a
.gitmodules blob in the top-level tree when we're examining a deeper level
tree.

Cheers,

Chris.
