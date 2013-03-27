From: Rich Fromm <richard_fromm@yahoo.com>
Subject: Re: propagating repo corruption across clone
Date: Wed, 27 Mar 2013 11:51:49 -0700 (PDT)
Message-ID: <1364410309241-7580845.post@n2.nabble.com>
References: <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com> <20130325145644.GA16576@sigill.intra.peff.net> <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com> <20130325155600.GA18216@sigill.intra.peff.net> <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com> <20130325200752.GB3902@sigill.intra.peff.net> <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com> <20130326165553.GA7282@sigill.intra.peff.net> <1364340037755-7580771.post@n2.nabble.com> <7vr4j1qzao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 19:52:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKvSM-0007rs-9X
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab3C0Svu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:51:50 -0400
Received: from sam.nabble.com ([216.139.236.26]:56570 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753649Ab3C0Svt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:51:49 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <richard_fromm@yahoo.com>)
	id 1UKvRt-0001w3-9G
	for git@vger.kernel.org; Wed, 27 Mar 2013 11:51:49 -0700
In-Reply-To: <7vr4j1qzao.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219302>

Junio C Hamano wrote
> If you use --local, that is equivalent to "cp -R".  Your corruption
> in the source will faithfully be byte-for-byte copied to the
> destination.  If you do not
> ...
> transport layer will notice
> object corruption.
> ...
> The difference between --mirror and no --mirror is a red herring.
> You may want to ask Jeff Mitchell to remove the mention of it; it
> only adds to the confusion without helping users.

Just to clarify, I don't know Jeff Mitchell personally, and I'm not
affiliated with the KDE project.  I happened to have recently implemented a
backup strategy for a different codebase, that relies on `git clone
--mirror` to take the actual snapshots of the live repos, and I read about
Jeff's experiences, and that's why I started following this discussion. 
Apologies if my questions are considered slightly off topic -- I'm not
positive if this is supposed to be a list for developers, and not users.

Nevertheless, I will try to contact Jeff and point him at this.  My initial
reading of his blog posts definitely gave me the impression that this was a
--mirror vs. not issue, but it really sounds like his main problem was using
--local.

However, I think there may be room for some additional clarity in the docs. 
The --local option in git-config(1) says "When the repository to clone from
is on a local machine, this flag bypasses the normal "git aware" transport
mechanism".  But there's no mention of the consequences of this transport
bypass.  There's also no mention of this in the "GIT URLS" section that
discusses transport protocols, and I also don't see anything noting it in
either of these sections of the git book:

http://git-scm.com/book/en/Git-on-the-Server-The-Protocols
http://git-scm.com/book/en/Git-Internals-Transfer-Protocols




--
View this message in context: http://git.661346.n2.nabble.com/propagating-repo-corruption-across-clone-tp7580504p7580845.html
Sent from the git mailing list archive at Nabble.com.
