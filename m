From: Mike Hommey <mh@glandium.org>
Subject: Re: What's not in 'master' but should be
Date: Sat, 19 Jan 2008 07:14:21 +0100
Organization: glandium.org
Message-ID: <20080119061421.GA5023@glandium.org>
References: <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801181638500.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?Q?Gr=E9goire?= Barbier <gb@gbarbier.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 07:15:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG6z7-0002XH-Hk
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 07:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYASGOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 01:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbYASGOp
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 01:14:45 -0500
Received: from vuizook.err.no ([85.19.215.103]:46558 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbYASGOp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 01:14:45 -0500
Received: from aputeaux-153-1-59-190.w82-124.abo.wanadoo.fr ([82.124.13.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JG6yf-0001JM-Hq; Sat, 19 Jan 2008 07:14:55 +0100
Received: from mh by jigen with local (Exim 4.68)
	(envelope-from <mh@jigen>)
	id 1JG6yD-0002ZS-KL; Sat, 19 Jan 2008 07:14:21 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801181638500.5731@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 5.2): Yes, score=5.2 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71081>

On Fri, Jan 18, 2008 at 06:28:03PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 18 Jan 2008, Junio C Hamano wrote:
>=20
> > Junio C Hamano <gitster@pobox.com> writes:
> >=20
> > > Currently the ones I looked at and consider possible 1.5.4 materi=
al=20
> > > are http-push fixes from Gr=E9goire Barbier and parse_commit_buff=
er()=20
> > > tightening from Martin Koegler.
> >=20
> > It seems that for the past few days, people were having too much fu=
n=20
> > bashing how broken MacOS X is, and the real work has stalled in the=
=20
> > meantime.  Well, not really stalled but they certainly made the pat=
ches=20
> > and discussions harder to find in the list archive.
> >=20
> > [...]
> >
> > But there are still unapplied patches that deserve attention. The o=
ne=20
> > that I am most worried about is Gr=E9goire Barbier's http-push chan=
ges:
> >=20
> >   $gmane/70406 <1200250979-19604-1-git-send-email-gb@gbarbier.org>
>=20
> This patch makes http-push Warn if URL does not end if "/", but it wo=
uld=20
> be even better to just handle it... we know exactly that HTTP URLs _m=
ust_=20
> end in a slash.
>=20
> It gives a better warning if the URL cannot be accessed, alright.  Bu=
t I=20
> hate the fact that it introduces yet another function which does a bu=
nch=20
> of curl_easy_setopt()s only to start an active slot and check for err=
ors.
>=20
> Currently, I am not familiar enough with http-push.c to suggest a pro=
per=20
> alternative, but I suspect that the return values of the _existing_ c=
alls=20
> to curl should know precisely why the requests failed, and _this_ sho=
uld=20
> be reported.

=46WIW, I have a work in progress refactoring the http code, avoiding a
great amount of curl_easy_setopt()s and simplifying the whole thing.
It's been sitting on my hard drive during my (quite long) vacation. I
will probably start working again on this soonish.

Mike
