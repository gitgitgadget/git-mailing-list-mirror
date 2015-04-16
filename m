From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] dir: allow a BOM at the beginning of exclude files
Date: Thu, 16 Apr 2015 17:09:18 +0200
Message-ID: <1429196958.3097.15.camel@elego.de>
References: <1429193112-41184-1-git-send-email-cmn@elego.de>
	 <13f82e720ac12a6bc12e8b9f566dd48e@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 17:17:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YilXv-0006N7-W0
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 17:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbbDPPRg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2015 11:17:36 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:40491 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbbDPPRd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 11:17:33 -0400
Received: from centaur.local (p57A97B07.dip0.t-ipconnect.de [87.169.123.7])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id DF95BDE72E;
	Thu, 16 Apr 2015 17:09:18 +0200 (CEST)
In-Reply-To: <13f82e720ac12a6bc12e8b9f566dd48e@www.dscho.org>
X-Mailer: Evolution 3.12.9-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267295>

On Thu, 2015-04-16 at 17:03 +0200, Johannes Schindelin wrote:
> Hi Carlos,
>=20
> On 2015-04-16 16:05, Carlos Mart=C3=ADn Nieto wrote:
> > Some text editors like Notepad or LibreOffice write an UTF-8 BOM in
> > order to indicate that the file is Unicode text rather than whateve=
r the
> > current locale would indicate.
> >=20
> > If someone uses such an editor to edit a gitignore file, we are lef=
t
> > with those three bytes at the beginning of the file. If we do not s=
kip
> > them, we will attempt to match a filename with the BOM as prefix, w=
hich
> > won't match the files the user is expecting.
> >=20
> > ---
> >=20
> > If you're wondering how I came up with LibreOffice, I was doing a
> > workshop recently and one of the participants was not content with =
the
> > choice of vim or nano, so he opened LibreOffice to edit the gitigno=
re
> > file with confusing consequences.
> >=20
> > This codepath doesn't go as far as the config code in validating th=
at
> > we do not have a partial BOM which would mean there's some invalid
> > content, but we don't really have invalid content any other way, as
> > we're just dealing with a list of paths in the file.
>=20
> Yeah, users are entertaining!
>=20
> I agree that this is a good patch. *Maybe* we would need the same han=
dling in more places, in which case it might make sense to refactor the=
 test into its own function.

Yes, this was my train of thought. If we (discover that) need it in a
third place, then we can unify the test and skip. For two places I
reckoned it was fine if we duplicated a bit.

>=20
> In any case, though, the Git project requires a [Developer's Certific=
ate of Origin](https://github.com/git/git/blob/v2.3.5/Documentation/Sub=
mittingPatches#L234-L277); Would you mind adding that?
>=20

Yeah, sorry. I keep forgetting to do that. I'll reply to my original
e-mail with it.

Cheers,
   cmn
