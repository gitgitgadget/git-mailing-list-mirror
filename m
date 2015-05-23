From: Mike Hommey <mh@glandium.org>
Subject: Re: git status doesn't ignore GIT_DIR directory?
Date: Sat, 23 May 2015 14:39:00 +0900
Message-ID: <20150523053900.GA2364@glandium.org>
References: <555FD1EA.2060706@rightscale.com>
 <CAPc5daW2yTHHegPDrEWS5KiSYWZECV+AxMnewzz9ayASB1QNUw@mail.gmail.com>
 <20150523022256.GA17789@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thorsten von Eicken <tve@rightscale.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 23 07:39:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yw29u-0008MH-GP
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 07:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbbEWFjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 May 2015 01:39:21 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40827 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbbEWFjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 01:39:20 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1Yw29E-0000vh-R7; Sat, 23 May 2015 14:39:00 +0900
Content-Disposition: inline
In-Reply-To: <20150523022256.GA17789@lanh>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269795>

On Sat, May 23, 2015 at 09:22:56AM +0700, Duy Nguyen wrote:
> On Fri, May 22, 2015 at 07:03:48PM -0700, Junio C Hamano wrote:
> > As far as I know, GIT_DIR was prepared as a mechanism to point at
> > another .git directory that does not live inside the working tree, =
not
> > as a mechanism to rename it to arbitrary name. E.g.
> >=20
> >  $ git init
> >  $ mv .git .svn
> >  $ GIT_DIR=3D$(pwd)/.svn ; export GIT_DIR
> >=20
> > is not expected to work.
>=20
> This is not the first time we get this report. Perhaps we should
> document it.
>=20
> -- 8< --
> Subject: git.txt: mention the special name ".git" in GIT_DIR
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 90c5f37..91d6dd2 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -691,6 +691,9 @@ Git so take care if using Cogito etc.
>  	specifies a path to use instead of the default `.git`
>  	for the base of the repository.
>  	The '--git-dir' command-line option also sets this value.
> ++
> +Note that if GIT_DIR is set explicitly to a directory inside working
> +tree, the directory name must be ".git".

Isn't the requirement that it _ends_ with ".git" (that is,
GIT_DIR=3D/path/to/foo.git would work)

Mike
