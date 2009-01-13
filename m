From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Removing options from build
Date: Tue, 13 Jan 2009 23:07:30 +0100
Message-ID: <20090113220730.GF30404@atjola.homenet>
References: <1231883002.14181.27.camel@starfruit> <200901132253.15370.trast@student.ethz.ch> <1231884045.14181.36.camel@starfruit>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:09:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrRR-0001UX-DD
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 23:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344AbZAMWHh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 17:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755294AbZAMWHg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 17:07:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:44971 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753825AbZAMWHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 17:07:35 -0500
Received: (qmail invoked by alias); 13 Jan 2009 22:07:33 -0000
Received: from i577B816A.versanet.de (EHLO atjola.local) [87.123.129.106]
  by mail.gmx.net (mp069) with SMTP; 13 Jan 2009 23:07:33 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/rFQAyiBjrSVKzh/NdtAiDYl4L218udiCnnwTuSG
	im4Z9rVBm1TI+O
Content-Disposition: inline
In-Reply-To: <1231884045.14181.36.camel@starfruit>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105550>

On 2009.01.13 14:00:45 -0800, R. Tyler Ballance wrote:
> On Tue, 2009-01-13 at 22:53 +0100, Thomas Rast wrote:
> > R. Tyler Ballance wrote:
> > > Besides a vigorous flogging, we're looking at other ways to preve=
nt this
> > > sort of thing from happening again; the option we've settled on i=
s to
> > > remove the "--force" flag from our internal build of v1.6.1
> > >
> > > I'm wondering if somebody could point me in the right direction t=
o
> > > remove "--force" (safely) from the builtin-push.c and removing th=
e
> > > "rebase" command (we've got no use for it, and would prefer it go=
ne).
> >=20
> > IMHO your update (or pre-receive) hook should just disallow
> > non-fast-forward updates.
>=20
> Don't merges count as non-fast-forward updates? We generate merge
> commits with almost every merge, rarely do we actually have
> fast-forwards anymore (highly active repository)

No, merges are "fast-forward". In rev-list terms:

git rev-list new_head..old_head =3D=3D> Empty

IOW: No commits are lost by the push.

Merges only add commits to the history, they don't remove anything.

Bj=F6rn
