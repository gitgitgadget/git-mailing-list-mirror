From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git rev-list ordering
Date: Wed, 19 Nov 2008 09:26:38 +0100
Message-ID: <20081119082638.GA3538@atjola.homenet>
References: <alpine.LFD.2.00.0811151922310.2935@sys-0.hiltweb.site> <bd6139dc0811151727k605a3575hf409fed32a3a4baf@mail.gmail.com> <alpine.LFD.2.00.0811152040570.2935@sys-0.hiltweb.site> <alpine.DEB.1.00.0811162215370.30769@pacific.mpi-cbg.de> <4923256B.3000807@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ian Hilt <ian.hilt@gmx.com>, sverre@rabbelier.nl,
	Git Mailing List <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 09:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2iQ0-0000rN-Jp
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 09:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbYKSI0o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Nov 2008 03:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYKSI0o
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 03:26:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:56891 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752016AbYKSI0n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 03:26:43 -0500
Received: (qmail invoked by alias); 19 Nov 2008 08:26:41 -0000
Received: from i577BAED4.versanet.de (EHLO atjola.local) [87.123.174.212]
  by mail.gmx.net (mp050) with SMTP; 19 Nov 2008 09:26:41 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+rz10TVF2rn1z3fm4w+8fUsA9ZI04FiET4y5DC/v
	h6LPysamBcXQlr
Content-Disposition: inline
In-Reply-To: <4923256B.3000807@pcharlan.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101315>

On 2008.11.18 12:28:27 -0800, Pete Harlan wrote:
> I have a script that runs periodically where I need to know the email
> address of who added $file to the system, for a handful of $files,
> because I'm moving them somewhere else and want to let them know.  Th=
e
> most recent commits aren't interesting, it's the first commit that ma=
tters.
>=20
> I use:
>=20
>   git rev-list --reverse --pretty=3Dformat:%ae HEAD -- $file
>=20
> and the second line has the information I need.
>=20
> Perhaps there's a more straightforward way to answer the question "wh=
o
> first put this file here".
>=20
> (One can imagine that may be no "first", because $file merged from
> different paths, but in mine as in many real-world cases, it (a) won'=
t
> happen and (b) whatever happens will be fine if it does.)
>=20
> I don't need this to work differently than it does, but perhaps it
> constitutes an "interesting situation where you need to list the olde=
st
> n commits"?

What you're asking for are commits that added the file, and you can tel=
l
git to find them, instead of using the --reverse work-around:

git log --diff-filter=3DA --pretty=3Dformat:%ae HEAD -- $file

If you're running that with a single file, you might want to add
--follow and maybe add R to the diff-filter as well (to get the renamin=
g
commits).

Bj=F6rn
