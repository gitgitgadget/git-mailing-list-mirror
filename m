From: Mark Struberg <struberg@yahoo.de>
Subject: Re: any way to apply tag across all branches in repository?
Date: Wed, 20 May 2009 08:58:12 +0000 (GMT)
Message-ID: <627610.63870.qm@web27808.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Friesen <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Wed May 20 10:58:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6hd0-0003wK-6A
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 10:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbZETI6O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 04:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbZETI6N
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 04:58:13 -0400
Received: from web27808.mail.ukl.yahoo.com ([217.146.182.13]:28316 "HELO
	web27808.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752466AbZETI6M convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 04:58:12 -0400
Received: (qmail 64852 invoked by uid 60001); 20 May 2009 08:58:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1242809892; bh=gzIsxDYIQLz1Z2HE1EF6WZpeJfD7/06aARfnzBT6zc8=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=RpilP0eJ9LS6cKvmte9amlLuxTIm5bu4JB9RZmQ52Lt3WdsXbcxstpukHwagYYS+EfyU0pFoISUSrCSTd7GrLKbXr6H9qHz3+GmRvwiQwVKmjOHuTpGg01/cGX1o7zNqR1Fvv5BEY6f2WB1hkD799lhwQXwLOn10Hayf9VEpm4k=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BXBi+VLQz3jpow53OH4WYnrn1GQm0H9w7Ac8PTT2PNGVZ7AnPURgRvOHSyN9bza+78Udq2jlNFGdv7bJlWMw5E5veOO2BK+/2WW/XCjJ1ZoVlY+QTCjV6jYd4UCqyCqPqRbqBGMZ7oQy8+fpQSrYOL/sBv9iIOaNowdNcBMCH5g=;
X-YMail-OSG: HhB7qbYVM1m35.bGfugNF5WPTOcAFUA8Y6aBRQkrr1CifNR3_OUh0QLbQOqjIiIla6QK5dKQBJZC2a0lvkSdujGI8CE2MnW6K9Bdkn.WSjwtOue7OcMkAEL._Kk.oHVG59Vfsx53bqWK4hYblmIg.5iQNADSLKJm4BRFXfxedMghGHckpDE6smLoi3FzVHd5ABBxzhg59hmfsgxrxv4Db0Paz0UJV7NJk4R6BUl2Qq9z54YE15hHji3tWDkxN8QY9I3lVhd3GD0LQIJL_ftKpiWNyb3mUD0nf7W74_97LW88JpNKP_PFn1aFF.UjqCdZkz788CxYURmA.9G6sTKn_2o-
Received: from [213.235.230.200] by web27808.mail.ukl.yahoo.com via HTTP; Wed, 20 May 2009 08:58:12 GMT
X-Mailer: YahooMailClassic/5.3.9 YahooMailWebService/0.7.289.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119590>


> We have one "official" branch for each target board...so
> maybe a dozen or so branches.

Chis, to me this sounds more like you abuse SCM branches for what shoul=
d be into 'modules'
In SVN this would make not a big difference (because of the silly svn:c=
opy thingy) but for any sane SCM, tags are not directories!

If you move all your board specific code into child-modules, then you c=
ould happily tag over your whole project (including all those modules).

LieGrue,
strub

--- Chris Friesen <cfriesen@nortel.com> schrieb am Di, 19.5.2009:

> Von: Chris Friesen <cfriesen@nortel.com>
> Betreff: Re: any way to apply tag across all branches in repository?
> An: "Linus Torvalds" <torvalds@linux-foundation.org>
> CC: "Brandon Casey" <casey@nrlssc.navy.mil>, git@vger.kernel.org
> Datum: Dienstag, 19. Mai 2009, 23:31
> Linus Torvalds wrote:
> >=20
> > On Tue, 19 May 2009, Chris Friesen wrote:
> >> The tagging would be done only by the "official"
> build process (which
> >> pulls from an "official" repository), not by each
> designer.=A0 Typically
> >> the official builds would be done weekly, more
> frequently if requested.
> >=20
> > Well, you can tag when you do that official build. Do
> you really do=20
> > "official" builds from all branches? That sounds a bit
> insane.
>=20
> We have one "official" branch for each target board...so
> maybe a dozen
> or so branches.
>=20
> Developers do private builds, but they're not tagged.
>=20
> > Remember: you don't have to tag whatever is the "top"
> - tagging can happen=20
> > later. Tagging at build-time is perfectly fine.
>=20
> Tagging at build-time is actually the plan.
>=20
> > In fact, I'd suggest going even further. Don't tag the
> source branch when=20
> > you build - tag it after it has passed whatever
> testing you do (I hope you=20
> > _do_ have some extensive test-suite before release),
> and as you actually=20
> > make it public (or whatever you do). Only at _that_
> point, tag the tree=20
> > with "release-$branch-$date" or something like that.
>=20
> There's a fairly extensive test suite.=A0 This might be
> an option.
>=20
> > Remember: you don't have to tag the top-of branch. You
> can tag any commit,=20
> > after-the-fact. So even if you've done other
> development since, just make=20
> > sure to tag the commit you actually built and tested.
>=20
> Good point.=A0 I think I've got enough information to
> get something
> working.=A0 Thanks for all the help.
>=20
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe
> git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20


     =20
