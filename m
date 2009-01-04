From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH] git-web--browse: don't add start as candidate on
	Ubuntu
Date: Sun, 4 Jan 2009 14:29:47 +0100
Message-ID: <20090104132947.GV12275@machine.or.cz>
References: <495D3964.6040006@ramsay1.demon.co.uk> <200901040833.25849.chriscool@tuxfamily.org> <7vljtr33sb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 14:31:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJT4f-0004x8-Fc
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 14:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757721AbZADN3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 08:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757512AbZADN3x
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 08:29:53 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43028 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757021AbZADN3w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 08:29:52 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 9B8E61E4C029; Sun,  4 Jan 2009 14:29:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vljtr33sb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104516>

On Sat, Jan 03, 2009 at 11:53:56PM -0800, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>=20
> > Le jeudi 1 janvier 2009, Ramsay Jones a =E9crit :
> > ...
> >> Does anybody else see this issue and can someone test the patch?
> >
> > Petr, as you added support for using /bin/start on MinGW, could you=
 test?

Sorry, I don't have access to MinGW system anymore.

> > diff --git a/git-web--browse.sh b/git-web--browse.sh
> > index 78d236b..7ed0fad 100755
> > --- a/git-web--browse.sh
> > +++ b/git-web--browse.sh
> > @@ -115,7 +115,7 @@ if test -z "$browser" ; then
> >  	browser_candidates=3D"open $browser_candidates"
> >      fi
> >      # /bin/start indicates MinGW
> > -    if test -n /bin/start; then
> > +    if test -x /bin/start; then
> >  	browser_candidates=3D"start $browser_candidates"
> >      fi
>=20
> In any case, the original test is simply bogus.  'test -n "$foo"' is =
to
> see if $foo is an empty string, and giving a constant /bin/start alwa=
ys
> yields true.

Oops. :-) That should've obviously been -f.

--=20
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
