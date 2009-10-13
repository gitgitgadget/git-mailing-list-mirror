From: bill lam <cbill.lam@gmail.com>
Subject: Re: quote in help code example
Date: Tue, 13 Oct 2009 10:16:17 +0800
Message-ID: <20091013021616.GA10554@debian.b2j>
References: <20091012102926.GA3937@debian.b2j>
 <20091012194016.GS23777@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 04:23:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxX2y-0001P3-VD
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758695AbZJMCRC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 22:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758610AbZJMCRB
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:17:01 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:52974 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981AbZJMCRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:17:00 -0400
Received: by pzk32 with SMTP id 32so9640837pzk.21
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 19:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8lnaf7DPXxJNURZg01ImwK4H9z8EkFRQ8ueoTZpqOxI=;
        b=SMamU9OXAoOWgOUYjSQpyCft7loJzjfvZ5b2mlgdsXF/zWSHTd+qCF0B1LbUAfW9V6
         oD8uIUMDO1zfM8DTIBsdYMOFfBRIcRh79vND4RA+hsKYxDvGO71ACCVW+xPm3WuMxtw4
         TnIvV6RF32HqWo5Z92awGMrVXPMSweBdxVB/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=I3BYL6zrc7zOXXHPJwIbmqM128mpybFbuRUhzcnaKp1B1IAcUz72F0Nz14cjOJucuD
         PsGS5jXONw8dDxqK5IxoIKcvOZ2MJqAk/uZAKo4srFlNcqLfP04dffo0jeREMLZrgi74
         8wVf7PNWlHdH/hYzmuX3X9dFE5khACoNLrtRk=
Received: by 10.114.248.7 with SMTP id v7mr11366117wah.92.1255400184079;
        Mon, 12 Oct 2009 19:16:24 -0700 (PDT)
Received: from localhost (n219079103006.netvigator.com [219.79.103.6])
        by mx.google.com with ESMTPS id 21sm620106pxi.11.2009.10.12.19.16.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 19:16:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091012194016.GS23777@genesis.frugalware.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130102>

On Mon, 12 Oct 2009, Miklos Vajna wrote:
> On Mon, Oct 12, 2009 at 06:29:26PM +0800, bill lam <cbill.lam@gmail.c=
om> wrote:
> > In git man, eg. git help filter-branch
> > The code examples for command line or shell scripts inside .ft pair=
s
> > use (smart?) quote instead of single quotes, like
> >=20
> >   .ft C
> >    git filter-branch --tree-filter =B4rm filename=B4 HEAD
> >    .ft
> >=20
> > Is this intentional or just some configuration problem during
> > compiling.
>=20
> Just a guess: do you have docbook-xsl >=3D1.73.0 and you did not set
> ASCIIDOC_NO_ROFF?
>=20
> Try rebuilding the documentation using 'make ASCIIDOC_NO_ROFF=3DYesPl=
ease'.

I'm not familiar with how to twist git makefile.  By adding a line to .=
/Makefile

# Platform specific tweaks
#

# We choose to avoid "if .. else if .. else .. endif endif"
# because maintaining the nesting to match is a pain.  If
# we had "elif" things would have been much nicer...

ASCIIDOC_NO_ROFF =3D YesPlease       # <--- this line added
ifeq ($(uname_S),Linux)

However, the man page still display the same

  .ft C
   git filter-branch --tree-filter =B4rm filename=B4 HEAD
   .ft

I use debian lenny 64bit with
Package: docbook-xsl
Version: 1.73.2.dfsg.1-5

Package: asciidoc
Version: 8.2.7-3~lenny1

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
