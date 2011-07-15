From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 14:42:11 -0400
Message-ID: <20110715184211.GH8453@thunk.org>
References: <20110714190844.GA26918@sigill.intra.peff.net>
 <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net>
 <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net>
 <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net>
 <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <CAJo=hJtuxNLhSjn_sDJxG7xu5k2wbJ_QLf_n+Z1E=o2AndAuJQ@mail.gmail.com>
 <CA+55aFw_XjWm+4XwsN6CRJnsrcEu5YEChOHSHN51UUBN6PynWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 20:42:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhnLC-0002q0-Kp
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 20:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab1GOSmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 14:42:18 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:40466 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753604Ab1GOSmR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 14:42:17 -0400
Received: from root (helo=tytso-glaptop)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1QhnL2-0003G7-QZ; Fri, 15 Jul 2011 18:42:12 +0000
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1QhnL2-0007kh-1J; Fri, 15 Jul 2011 14:42:12 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFw_XjWm+4XwsN6CRJnsrcEu5YEChOHSHN51UUBN6PynWw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177208>

On Fri, Jul 15, 2011 at 09:44:21AM -0700, Linus Torvalds wrote:
> So I would like to repeat: I think our commit-date based hack has been
> pretty successful. We've lived with it for years and years. Even the
> "let's try to fix it by adding slop" code is from three years ago
> (commit 7d004199d1), which means that for three years we never really
> saw any serious problems. I forget what problem we actually did see -
> I have this dim memory of it being Ted that had problems with a merge
> because git picked a crap merge base, but that may just be my
> Alzheimer's speaking.

My original main issue was simply that "git tag --contains" and "git
branch --contains" was either (a) incorrect, or (b) slower than
popping up gitk and pulling the information out of the GUI.  The
reason for (b) is because of gitk.cache.

Maybe the answer then is creating a command-line tool (it doesn't have to
be in "core" of git) which just pulls the dammned information out of
gitk.cache....

(Yes, it's gross, but I'm not worrying about the long-term
architecture of git or anything high-falutin' like that.  I'm just a
poor dumb user who just wants git tag --contains and git branch
--contains to be fast and accurate...)

						- Ted
