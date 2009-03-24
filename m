From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH] Documentation: push.default applies to all remotes
Date: Tue, 24 Mar 2009 09:30:15 +0100
Message-ID: <20090324083015.GA22271@pvv.org>
References: <1237850318-3671-1-git-send-email-santi@agolina.net> <7v7i2f6cj7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 09:32:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm23C-0005DY-T2
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757005AbZCXIaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 04:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756961AbZCXIaZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:30:25 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:43939 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966AbZCXIaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:30:23 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Lm21X-0001Mo-Vm; Tue, 24 Mar 2009 09:30:16 +0100
Content-Disposition: inline
In-Reply-To: <7v7i2f6cj7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114426>

On Mon, Mar 23, 2009 at 04:32:28PM -0700, Junio C Hamano wrote:
> Santi B=E9jar <santi@agolina.net> writes:
>=20
> > push.default is not only for the current remote but setting the def=
ault
> > behavior for all remotes.
> >
> > Signed-off-by: Santi B=E9jar <santi@agolina.net>
> > ---
> > Hi,
> >
> >   this applies on top of next.
> >
> >  Documentation/config.txt |   11 +++--------
> >  1 files changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 089569a..7f5fe43 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -1215,19 +1215,14 @@ push.default::
> >  	Defines the action git push should take if no refspec is given
> >  	on the command line, no refspec is configured in the remote, and
> >  	no refspec is implied by any of the options given on the command
> > -	line.
> > -+
> > -The term `current remote` means the remote configured for the curr=
ent
> > -branch, or `origin` if no remote is configured. `origin` is also u=
sed
> > -if you are not on any branch. Possible values are:
> > +	line. Possible values are:
> >  +
> >  * `nothing` do not push anything.
> > -* `matching` push all matching branches to the current remote.
> > +* `matching` push all matching branches.
> >    All branches having the same name in both ends are considered to=
 be
> >    matching. This is the current default value.
> >  * `tracking` push the current branch to the branch it is tracking.
> > -* `current` push the current branch to a branch of the same name o=
n the
> > -  current remote.
> > +* `current` push the current branch to a branch of the same name.
> > =20
> >  rebase.stat::
> >  	Whether to show a diffstat of what changed upstream since the las=
t
> [...]
> If we want to explain that a "git push" that does not say where-to de=
cides
> where to push by looking at branch.<name>.remote configuration and fa=
lling
> back to origin, push.default is not the place to explain it.  This
> configuration variable is not involved in that decision in any way.

I originally had an option to push all tracking branches to their
respective counterparts here, but decided against including it. Then
it made sense to distinguish which options pushed to the current
remote, and which did not. Since that option is gone, removing the
extra text seems like an improvement.

- Finn Arne
