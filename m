From: Jeff King <peff@peff.net>
Subject: Re: git-config: aliases with parameter expansion ($1 and such)
Date: Mon, 24 Mar 2008 15:29:52 -0400
Message-ID: <20080324192952.GD14002@coredump.intra.peff.net>
References: <47E65AF5.4060708@dirk.my1.cc> <76718490803230645k13471472sc99932563b0239da@mail.gmail.com> <47E66382.5030800@dirk.my1.cc> <20080323193842.GA23227@coredump.intra.peff.net> <20080323194514.GA23492@coredump.intra.peff.net> <76718490803231854u6ee76437h5acf37b0b602f3b1@mail.gmail.com> <7vzlso3kjc.fsf@gitster.siamese.dyndns.org> <47E7A969.8010405@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Mar 24 20:30:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdsNQ-0002wd-PQ
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 20:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760518AbYCXT3z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 15:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760015AbYCXT3z
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 15:29:55 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4418 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755353AbYCXT3y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 15:29:54 -0400
Received: (qmail 7840 invoked by uid 111); 24 Mar 2008 19:29:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 24 Mar 2008 15:29:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2008 15:29:52 -0400
Content-Disposition: inline
In-Reply-To: <47E7A969.8010405@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78082>

On Mon, Mar 24, 2008 at 02:15:21PM +0100, Dirk S=C3=BCsserott wrote:

> Thanks for the help. Both
>    (1) atag =3D !sh -c 'git tag -a -m "$0" "$0"'
> and
>    (2) atag =3D !sh -c 'git tag -a -m "$1" "$1"' -
> work, but in the latter case the '-' is indeed crucial.
> If not given, $1 is not set and git tag complains badly.
> When called without any args, (1) sets a tag called "sh"
> whereas (2) complains about the missing value for the -m option.
> So I decided to use the second form. Shells are funny things. ;-)

I hadn't thought of that when I gave (1) as an example. I think (2) is
clearly superior for that reason.

> BTW: Is it true that "-a" is implicitely added to "git tag"
> when the "-m" switch is present, i.e. are
>    $ git tag -m foo foo
> and
>    $ git tag -a -m foo foo
> equivalent? Thought so, but it's not in the docs.

Yes, see builtin-tag:430-433 (it is also implied by -F). Care to submit
a documentation patch?

-Peff
