From: Knut Franke <k.franke@science-computing.de>
Subject: Re: [PATCH 2/2] Allow core.askpass to override SSH_ASKPASS.
Date: Fri, 27 Aug 2010 14:45:24 +0200
Organization: science + computing ag
Message-ID: <201008271445.26098.k.franke@science-computing.de>
References: <201008271251.23136.k.franke@science-computing.de> <AANLkTik5eMLCKK7muBW9k8-0ZAxraATCs5hHVcX-Zutn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Frank Li <lznuaa@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 27 14:45:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoyJL-0003Bt-MI
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 14:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab0H0Mpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 08:45:30 -0400
Received: from smtp2.belwue.de ([129.143.2.15]:51557 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506Ab0H0Mp3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 08:45:29 -0400
Received: from mx4.science-computing.de (mx4.science-computing.de [193.197.16.30])
	by smtp2.belwue.de with ESMTP id o7RCjRNb003699
	for <git@vger.kernel.org>; Fri, 27 Aug 2010 14:45:27 +0200 (MEST)
	env-from (prvs=84877ebac=k.franke@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 6815E414003;
	Fri, 27 Aug 2010 14:45:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eOIJKpqaidPk; Fri, 27 Aug 2010 14:45:26 +0200 (CEST)
Received: from sirmione.science-computing.de (sirmione.science-computing.de [10.10.24.2])
	by scmail.science-computing.de (Postfix) with ESMTP id C71D9414002;
	Fri, 27 Aug 2010 14:45:26 +0200 (CEST)
Received: from sirmione.localnet (localhost [127.0.0.1])
	by sirmione.science-computing.de (Postfix) with ESMTP id B5BA6AE358;
	Fri, 27 Aug 2010 14:45:26 +0200 (CEST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.29-0.1-pae; KDE/4.1.3; i686; ; )
In-Reply-To: <AANLkTik5eMLCKK7muBW9k8-0ZAxraATCs5hHVcX-Zutn@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154595>

On Friday 27 August 2010 14:00:16 Erik Faye-Lund wrote:
> > From: Knut Franke <k.franke@science-computing.de>
>
> You don't need this line unless you're forwarding a patch for someone
> else (or using a different e-mail account).

ACK.

> > Modify handling of the 'core.askpass' option so that it has the sam=
e
> > effect as GIT_ASKPASS also if SSH_ASKPASS is set.
>
> Why are you sending a two-patch series where the second patch tries t=
o
> correct the first one? Wouldn't it make more sense to squash the two?

a) The author of the first patch is on holiday, and I didn't want to pa=
ss off=20
his work as mine nor my mistakes as his. ;-)

b) Maybe not everyone agrees about the correct order of precedence.

> > diff --git a/connect.c b/connect.c
> > index e296bfc..f97b84c 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -627,9 +627,13 @@ char *git_getpass(const char *prompt)
> > =A0 =A0 =A0 =A0static struct strbuf buffer =3D STRBUF_INIT;
> >
> > =A0 =A0 =A0 =A0askpass =3D getenv("GIT_ASKPASS");
> > +
>
> Why?

Considering the check for SSH_ASKPASS added below, I believe this impro=
ves=20
legibilty since all of the "if (!askpass..." blocks are similar in inte=
ntion.

--=20
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier,=20
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Michel Lepert
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196=20
