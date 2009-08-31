From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn messing up merge commits on dcommit
Date: Sun, 30 Aug 2009 18:37:39 -0700
Message-ID: <20090831013739.GA30367@dcvr.yhbt.net>
References: <20090830013225.GA6475@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 31 03:37:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhvq9-00047V-TI
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 03:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbZHaBhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2009 21:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbZHaBhj
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 21:37:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39118 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939AbZHaBhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 21:37:38 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id E40261F798;
	Mon, 31 Aug 2009 01:37:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090830013225.GA6475@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127449>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> Hi Eric,
>=20
> I have two "test cases" here (attached), which I actually wrote month=
s
> ago, but forgot to sent, as I wanted to clean them up/turn them into
> something suitable for the test suite, but honestly, I'll probably ne=
ver
> get around to do that, so here they are, as they are. They show git-s=
vn
> messing up merge commits when dcommitting a branch that is not
> up-to-date WRT the svn repo.
>=20
> The basic history for both cases (before dcommit) is:
>=20
>         C---D (master)
>        /   /
>       /---E (side)
>      /
> A---B (trunk)
>      \
>       X (revision in SVN, not yet fetched)
>=20
> So the dcommit (which would send C and D to the svn repo) needs to
> "rebase" C and D.
>=20
> In the first test case, this rebasing causes conflicts, and leads to =
a
> linearized history:
>=20
>       E (side)
>      /
> A---B---X---C' (trunk)
>              \
>               D (master)
>=20
> The merge is broken apart. This is probably expected, but I thought I=
'd
> tell anyway.

As noted in the CAVEATS section of the manpage, pull/merge isn't
recommended with dcommit because it generates non-linear history.

Keep in mind this was written before SVN got merge tracking support, bu=
t
I haven't been particularly motivated to revisit the topic since then..=
=2E

> I hope that makes any sense to you (or you can figure it out from the
> testing scripts).

Thanks for posting these, though.  They do seem to be good test cases
for developing on and hopefully somebody with more interest in
this topic can pick up where we leave off.

On a side note, I have been meaning to refactor git svn and break it
apart into separate Perl modules for easier hacking for the longest tim=
e
now...

--=20
Eric Wong
