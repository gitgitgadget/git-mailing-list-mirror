From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Tue, 17 Dec 2013 16:02:55 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131217210255.GA18217@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
 <20131217140746.GB15010@thyrsus.com>
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 22:03:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt1nA-0004CX-UW
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 22:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab3LQVC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Dec 2013 16:02:56 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:35951
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab3LQVC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 16:02:56 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 3A539380868; Tue, 17 Dec 2013 16:02:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239404>

Jakub Nar=C4=99bski <jnareb@gmail.com>:
> Errr... doesn't cvs-fast-export support --export-marks=3D<file> to sa=
ve
> progress and --import-marks=3D<file> to continue incremental import?

No, cvs-fast-export does not have --export-marks. It doesn't generate t=
he
SHA1s that would require. Even if it did, it's not clear how that would=
 help.

> I would check it in cvs-fast-export manpage, but the page seems to
> be down:
>=20
>   http://isup.me/www.catb.org
>=20
>     It's not just you! http://www.catb.org looks down from here.

Confirmed.  Looks like ibiblio is having a bad day.  I'll file a bug re=
port.=20

> > Fortunately, incremental dump is trivial to implement in the output
> > stage of an exporter if you have access to the exporter source code=
=2E
> > I've done it in two different exporters.  cvs-fast-export now has a
> > regression test for this case
>=20
> This is I guess assuming that information from later commits doesn't
> change guesses about shape of history from earlier commits...

That's the "stability" property that Martin Langhoff and I were discuss=
ing
earlier.

cvs-fast-export conversions are stable under incremental
lifting providing a commitid-generating version of CVS is in use
during each increment.  Portions of the history *before the first
lift* may lack commitids and will nevertheless remain stable through
the whole process.

All versions of CVS have generated commitids since 2004.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>
