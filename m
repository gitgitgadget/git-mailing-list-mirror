From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with
	an asterisk
Date: Tue, 10 Feb 2009 06:59:43 -0500
Message-ID: <20090210115943.GA15387@coredump.intra.peff.net>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com> <20090210075214.GC1320@atjola.homenet> <20090210111907.GD12089@coredump.intra.peff.net> <20090210115036.GG1320@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 13:01:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWrIe-0000f7-K5
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbZBJL7q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 06:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbZBJL7p
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:59:45 -0500
Received: from peff.net ([208.65.91.99]:60500 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbZBJL7p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:59:45 -0500
Received: (qmail 13070 invoked by uid 107); 10 Feb 2009 12:00:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 07:00:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 06:59:43 -0500
Content-Disposition: inline
In-Reply-To: <20090210115036.GG1320@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109218>

On Tue, Feb 10, 2009 at 12:50:36PM +0100, Bj=C3=B6rn Steinbrink wrote:

> Yeah, that's what I meant when I said "short-shortname". Maybe it's j=
ust
> me, but I really can't see myself using that. Would be likely that
> "origin" references something else than what I expect, especially whe=
n
> switching from one repo to another. And doing "git branch -r" to find
> out if "origin" is the right thing is slower than just typing the ful=
l
> shortname right away. Well, just my 2 cents.

Hmm. I use it all the time. :) I find it especially useful in one
project where everybody has a personal repo with one interesting branch=
,
and I am the integration manager. I use "git remote update' to fetch
from everybody, and then I can diff and pull against them just by namin=
g
their remote.

So I think it is just one of those features that some people find usefu=
l
and others don't.

> Yeah, as I said in the other mail, having it as a default would make =
add
> -m quite pointless.

Not necessarily. You might be interested in some other branch that isn'=
t
their HEAD. So yes, you would hopefully be using it much less because w=
e
would be guessing what you wanted to put there instead of making you
type it. But it would still be useful as an override.

> >   - if it doesn't exist, set it up based on the remote's HEAD. Clon=
e
> >     already does this, but "git remote add -f" should probably do i=
t,
> >     too. I'm not sure if every fetch should do it.
>=20
> FWIW, I would hate fetch for doing that. I dislike the whole
> <remote>/HEAD thing, and wouldn't want fetch to recreate that for me =
all
> the time.

Yeah, I think that is a good reason not to have fetch do it.

> >   - give the user some nice interface (probably via "git remote") t=
o
> >     move the pointer around (right now, it is "git symbolic-ref
> >     refs/remotes/$remote/HEAD refs/remotes/$remote/$branch").
>=20
> Maybe "git remote set-master"? Though I kinda dislike the "master" pa=
rt
> of the name, which I just took from the -m option to "remote add",
> though. I guess that could increase the confusion about the "master"
> branch as pre-setup by "git init" being special, and might lead to
> interesting conclusions about that command affecting the remote
> repository.

I think somebody suggested "set-default" in another thread, which
doesn't quite work either. Perhaps "set-head" is too literal? Maybe
"favorite-branch"? :)

-Peff
