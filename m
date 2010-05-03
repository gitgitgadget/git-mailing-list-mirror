From: wfp5p@viridian.itc.virginia.edu (Bill Pemberton)
Subject: Re: [PATCH] blame: add a range option to -L
Date: Mon, 03 May 2010 08:46:10 -0400 (EDT)
Message-ID: <20100503124610.DB96C41205@viridian.itc.virginia.edu>
References: <20100502091433.GA1854@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: jrnieder@gmail.com (Jonathan Nieder)
X-From: git-owner@vger.kernel.org Mon May 03 14:46:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8v2Q-0004QQ-46
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 14:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758300Ab0ECMqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 08:46:13 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:40289 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab0ECMqM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 08:46:12 -0400
Received: by viridian.itc.virginia.edu (Postfix, from userid 1249)
	id DB96C41205; Mon,  3 May 2010 08:46:10 -0400 (EDT)
In-Reply-To: <20100502091433.GA1854@progeny.tock>
X-Mailer: ELM [version 2.5.8.52.g5a79]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146230>

> > In addition to + and - you can now use r to specify how many lines
> > around <start> that you want to see.  For example: -L 20,r5 would s=
how
> > lines 15 through 25
>=20
> >From too much exposure to subversion, the r suggests =E2=80=9Crevisi=
on=E2=80=9D.
> But =C2=B1 is too hard to type, so I guess r will have to do.
>=20

I wasn't too thrilled with using r either, but I couldn't think of
anything better.


> > +		/* if top is negative then top is actually a range
> > +		   that was specified with the r option */
> > +		if (*top < 1) {
> > +		    long x =3D *top;
> > +		    *top =3D *bottom - x;
> > +		    *bottom +=3D x;
> > +		    if (*bottom < 1)
> > +			*bottom =3D 1;
> > +		}
>=20
> How does this treat -L 5,-10?
>=20

Yes, you're correct, my code will mess that up.  I thought I had
verified that parse_loc() would never return a number less than 1 as
*top, but looking again I see I didn't do that.  So my patch is no
good.  Sorry folks.

--=20
Bill Pemberton                                 wfp5p@virginia.edu
ITC/Unix Systems                               flash@virginia.edu
University of Virginia
