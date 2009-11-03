From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: git pull --rebase and losing commits
Date: Tue, 3 Nov 2009 08:01:38 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0911030757400.15633@ds9.cixit.se>
References: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se> <20091102151022.GA3995@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:02:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5DP4-0007b9-2I
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 08:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902AbZKCHBv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 02:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbZKCHBv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 02:01:51 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:41304 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755893AbZKCHBu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 02:01:50 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id nA371dgW016456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Nov 2009 08:01:39 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id nA371cPm016452;
	Tue, 3 Nov 2009 08:01:39 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20091102151022.GA3995@atjola.homenet>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 03 Nov 2009 08:01:39 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131945>

Thomas Rast:

> Not very surprising if you use the 'ours' strategy, which doesn't mer=
ge at=20
> all but instead takes the 'ours' side (IIRC that's the upstream for a=
=20
> rebase, but I always have these mixed up).

Sounds like it should be called "theirs", then. Or the documentation sh=
ould=20
be clarify.

> So what happens is that git-rebase rebuilds some commit C from your s=
ide=20
> on some base B from the remote, but the 'ours' strategy turns the *tr=
ee*=20
> for C' into that of B.

Right. I thought it was working on the individual blobs (I want it to=20
automatically resolve conflicts by applying the version that is in the=20
repository I am running the rebase from, no matter what).


Bj=F6rn Steinbrink:

> The "ours" strategy doesn't just avoid merge conflicts, it avoids mak=
ing
> any changes at all. The ours strategy means "just keep our state, jus=
t
> pretend that we've merged". And rebase will see that there were no
> changes and conclude:
>
> Already applied: 0001 test commit
>
> And thus it will drop the commit.

I've seen that message show up in my logs a couple of times. I'd better=
 drop=20
the --strategy=3Dours, then. :-/


Now to figure out if it is possible to get a setup like this working at=
 all.=20
Maybe dropping rebase in favour of regular merge may help a bit, but I =
still=20
want it to auto-resolve any conflicts for me.

--=20
\\// Peter - http://www.softwolves.pp.se/
