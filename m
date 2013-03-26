From: Rich Fromm <richard_fromm@yahoo.com>
Subject: Re: propagating repo corruption across clone
Date: Tue, 26 Mar 2013 16:20:37 -0700 (PDT)
Message-ID: <1364340037755-7580771.post@n2.nabble.com>
References: <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com> <20130324192350.GA20688@sigill.intra.peff.net> <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com> <20130325145644.GA16576@sigill.intra.peff.net> <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com> <20130325155600.GA18216@sigill.intra.peff.net> <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com> <20130325200752.GB3902@sigill.intra.peff.net> <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com> <20130326165553.GA7282@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 00:21:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKdB8-0007E7-JB
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 00:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab3CZXUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 19:20:40 -0400
Received: from sam.nabble.com ([216.139.236.26]:38582 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab3CZXUi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 19:20:38 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <richard_fromm@yahoo.com>)
	id 1UKdAT-0008Ty-Oj
	for git@vger.kernel.org; Tue, 26 Mar 2013 16:20:37 -0700
In-Reply-To: <20130326165553.GA7282@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219228>

Jeff King wrote
> Fundamentally the problem is
> that the --local transport is not safe from propagating corruption, and
> should not be used if that's a requirement.

I've read Jeff Mitchell's blog post, his update, relevant parts of the
git-clone(1) man page, and a decent chunk of this thread, and I'm still not
clear on one thing.  Is the danger of `git clone --mirror` propagating
corruption only true when using the --local option ?

Specifically, in my case, I'm using `git clone --mirror`, but I'm *not*
using --local, nor am I using --no-hardlinks.  The host executing the clone
command is different than the the host on which the remote repository lives,
and I am using ssh as a transport protocol.  If there is corruption, can I
or can I not expect the clone operation to fail and return a non-zero exit
value?  If I can not expect this, is the workaround to run `git fsck` on the
resulting clone?




--
View this message in context: http://git.661346.n2.nabble.com/propagating-repo-corruption-across-clone-tp7580504p7580771.html
Sent from the git mailing list archive at Nabble.com.
