From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: "git gc" doesn't seem to remove loose objects any more
Date: Mon, 15 Dec 2008 16:12:13 +0000
Message-ID: <20081215161212.GE31145@sirena.org.uk>
References: <808wqhzjl9.fsf@tiny.isode.net> <237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com> <20081215140834.GA3684@atjola.homenet> <20081215155610.GA11502@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Mikael Magnusson <mikachu@gmail.com>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 15 17:13:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCG4d-0001UW-JE
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 17:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbYLOQMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 11:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbYLOQMR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 11:12:17 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4308 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbYLOQMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 11:12:17 -0500
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.63)
	(envelope-from <broonie@sirena.org.uk>)
	id 1LCG3J-00042r-KR; Mon, 15 Dec 2008 16:12:13 +0000
Content-Disposition: inline
In-Reply-To: <20081215155610.GA11502@mit.edu>
X-Cookie: Knowledge is power.
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103175>

On Mon, Dec 15, 2008 at 10:56:10AM -0500, Theodore Tso wrote:
> On Mon, Dec 15, 2008 at 03:08:34PM +0100, Bj?rn Steinbrink wrote:

> > To clarify that a bit more: git gc keeps unreachable objects unpacked,
> > so that git prune can drop them. And git gc invokes git prune so that
> > only unreachable objects older than 2 weeks are dropped.

> To be even more explicit, "git gc" will **unpack** objects that have
> become unreachable and were currently in packs.  As a result, the
> amount of disk space used by a git repository can actually go **up**
> dramatically after a "git gc" operation, which could be surprising for
> someone who is running close to full on their filesystem, deletes a
> number of branches from a tracking repository, and then does a "git
> gc" may get a very unpleasant surprise.

It can also cause things like the "please repack" warning in git gui to
go off.  This is especially unhelpful since they tend to tell you to go
and do a gc to resolve the problem.
