From: Drew Northup <drew.northup@maine.edu>
Subject: Re: contrib/thunderbird-patch-inline: do not require /bin/bash to
	run
Date: Wed, 30 Mar 2011 14:53:28 -0400
Message-ID: <1301511208.22607.38.camel@drew-northup.unet.maine.edu>
References: <AANLkTinUh0BX3O+2Y1CiUTx7xvzW6ydrAGiGQUx4pbeP@mail.gmail.com>
	 <1301507039.22607.33.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>,
	Lukas =?ISO-8859-1?Q?Sandstr=F6m?= <luksan@gmail.com>
To: Maxin john <maxin@maxinbjohn.info>
X-From: git-owner@vger.kernel.org Wed Mar 30 20:58:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q50az-0005BY-UC
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 20:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548Ab1C3S6R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2011 14:58:17 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:40896 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab1C3S6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 14:58:16 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p2UIrXH0026535
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Mar 2011 14:53:33 -0400
In-Reply-To: <1301507039.22607.33.camel@drew-northup.unet.maine.edu>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p2UIrXH0026535
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1302116022.93041@nI3WJsfPO96xnj80R4m7mQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170405>

You can ignore this, I hadn't found the new thread yet....

On Wed, 2011-03-30 at 13:43 -0400, Drew Northup wrote:
> On Tue, 2011-03-29 at 10:08 +0300, Maxin john wrote:
> > contrib/thunderbird-patch-inline: do not require /bin/bash to run
> >=20
> > Modified the patch by incorporating the suggestions from =C3=81ngel
> > Gonz=C3=A1lez <ingenit@zoho.com> and Junio C Hamano <gitster@pobox.=
com>
> >=20
> > Signed-off-by: Maxin B. John <maxin@maxinbjohn.info>
> > ---
> > diff --git a/contrib/thunderbird-patch-inline/appp.sh
> > b/contrib/thunderbird-patch-inline/appp.sh
> > index cc518f3..1d109a5 100755
> > --- a/contrib/thunderbird-patch-inline/appp.sh
> > +++ b/contrib/thunderbird-patch-inline/appp.sh
> > @@ -1,8 +1,8 @@
> > -#!/bin/bash
> > +#!/bin/sh
> >  # Copyright 2008 Lukas Sandstr=C3=B6m <luksan@gmail.com>
> >  #
> >  # AppendPatch - A script to be used together with ExternalEditor
> > -# for Mozilla Thunderbird to properly include pathes inline i e-ma=
ils.
> > +# for Mozilla Thunderbird to properly include patches inline in e-=
mails.
> >=20
> >  # ExternalEditor can be downloaded at http://globs.org/articles.ph=
p?lng=3Den&pg=3D2
> >=20
> > @@ -16,7 +16,12 @@ else
> >         cd > /dev/null
> >  fi
> >=20
> > -PATCH=3D$(zenity --file-selection)
> > +#check whether zenity is present
> > +if ! type zenity >/dev/null 2>&1 ; then
> > +       exit 1
> > +fi
> > +
> > +PATCH=3D`zenity --file-selection`
>=20
> I could be missing something, but I thought we were trying to
> standardize to the $(....) syntax..., no? I didn't think that was a
> bash-ism.
>=20
> >  if [ "$?" !=3D "0" ] ; then
> >         #zenity --error --text "No patchfile given."

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
