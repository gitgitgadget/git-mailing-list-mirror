From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Can I switch a git-svn clone from a file => http url?
Date: Sat, 5 Apr 2008 02:23:10 +0200
Message-ID: <20080405002310.GB3101@atjola.homenet>
References: <p06240804c41942f6276e@[192.168.1.114]> <20080402151721.GA31738@atjola.homenet> <p06240802c419e22d78a7@[63.138.152.125]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 02:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhwCL-0000dn-J5
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 02:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbYDEAXN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2008 20:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbYDEAXN
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 20:23:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:36097 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751391AbYDEAXM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 20:23:12 -0400
Received: (qmail invoked by alias); 05 Apr 2008 00:23:10 -0000
Received: from i577BB809.versanet.de (EHLO atjola.local) [87.123.184.9]
  by mail.gmx.net (mp006) with SMTP; 05 Apr 2008 02:23:10 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/tNcQ5pTvtpe1JInOdlt+3os28R5F+PtmmmQd4AL
	iQwWBjhJo3qSoF
Content-Disposition: inline
In-Reply-To: <p06240802c419e22d78a7@[63.138.152.125]>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78829>

[missed the message because you dropped me from Cc:...]

On 2008.04.02 22:06:48 -0400, Stephen Bannasch wrote:
> Thanks Bj=F6rn,
>=20
> At 5:17 PM +0200 4/2/08, Bj=F6rn Steinbrink wrote:
> >On 2008.04.02 10:38:34 -0400, Stephen Bannasch wrote:
> > > Is there an operation I can now do to switch the base url from:
> >>
> >>   file:///Path/to/svn/repository/projects
> >>
> >> to
> >>
> >>   https://svn.concord.org/svn/projects
> >
> >Basically, this should work:
> >
> >Change the URL to the repo in your .git/config.
>=20
> Done
>=20
> >Use filter-branch to change all git-svn-id lines in the log entries.
>=20
> I've just started using git so please forgive the beginner questions.
>=20
> What should I change the log entries to?
>=20
> Here's what the log entries look like now:
>=20
> $ git-filter-branch --msg-filter 'echo $GIT_COMMIT'
> ^MRewrite 89817efa5b290d375786a5af9a0dcc338df8a68c (1/13099)^MRewrite=
 b090d1d40cba2c66a494d52e370317487d103484 (2/13099)^M

Ouch, that replaced your commit messages with the sha1 hashes... Should
have been something like:
git filter-branch --msg-filter 'sed "s,file:///....,http:///,"' -- --al=
l

Bj=F6rn
