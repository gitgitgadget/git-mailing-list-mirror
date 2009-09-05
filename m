From: Jeff King <peff@peff.net>
Subject: Re: tracking branch for a rebase
Date: Sat, 5 Sep 2009 10:28:41 -0400
Message-ID: <20090905142841.GB15631@coredump.intra.peff.net>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
 <20090904185949.GA21583@atjola.homenet>
 <20090905061250.GA29863@coredump.intra.peff.net>
 <20090905140127.GA29037@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 05 16:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjwG8-0007Jt-HC
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 16:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbZIEO2o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Sep 2009 10:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbZIEO2n
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 10:28:43 -0400
Received: from peff.net ([208.65.91.99]:44450 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbZIEO2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 10:28:43 -0400
Received: (qmail 27971 invoked by uid 107); 5 Sep 2009 14:28:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 10:28:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 10:28:41 -0400
Content-Disposition: inline
In-Reply-To: <20090905140127.GA29037@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127817>

On Sat, Sep 05, 2009 at 04:01:27PM +0200, Bj=C3=B6rn Steinbrink wrote:

> > And by automating the shorthand we reduce the chance of errors. For
> > example, I usually base my topic branches from origin/master. But t=
he
> > other day I happened to be building a new branch, jk/date, off of
> > lt/approxidate, salvaged from origin/pu. I did "git rebase -i
> > origin/master" and accidentally rewrote the early part of
> > lt/approxidate.
>=20
> Hm, I'd prefer a shorthand for "upstream for this branch", instead of
> magic defaults.

The more I think about, the more I think that is the right solution.
Because magic defaults for "rebase -i" don't help when you want to do
"gitk $UPSTREAM..".

The previous discussion on the topic seems to be here:

  http://article.gmane.org/gmane.comp.version-control.git/113666

And apparently you and I both participated in the discussion, which I
totally forgot about.

Looks like the discussion ended with people liking the idea but not
knowing what the specifier should look like. Maybe tightening the ref
syntax a bit to allow more extensible "special" refs is a good v1.7.0
topic? I dunno.

> > That wouldn't help me, because you can't "pull -i". :)
>=20
> I probably shouldn't tell anyone, as it's a crude hack, but "git pull
> --rebase -s -i" does the trick... *hides*

OK, that's just sick. :)

-Peff
