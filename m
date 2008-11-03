X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Francis Galiegue <fg@one2team.net>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Mon, 3 Nov 2008 22:59:03 +0100
Organization: One2team
Message-ID: <200811032259.03394.fg@one2team.net>
References: <200811031943.30033.angavrilov@gmail.com> <200811031944.03116.fg@one2team.net> <200811032017.47652.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 3 Nov 2008 22:00:59 +0000 (UTC)
Cc: "Alexander Gavrilov" <angavrilov@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
User-Agent: KMail/1.9.9
In-Reply-To: <200811032017.47652.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1Kx7UW-0005Fw-Nv for gcvg-git-2@gmane.org; Mon, 03 Nov 2008
 23:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751871AbYKCWA0 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 17:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbYKCWA0
 (ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 17:00:26 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:36333 "EHLO
 ns35774.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751650AbYKCWAZ convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>);
 Mon, 3 Nov 2008 17:00:25 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-75-194.w90-20.abo.wanadoo.fr
 [90.20.62.194]) (Authenticated sender: fg@one2team.net) by ns35774.ovh.net
 (Postfix) with ESMTP id 4E87E92C011; Mon,  3 Nov 2008 23:00:11 +0100 (CET)
Sender: git-owner@vger.kernel.org

Le Monday 03 November 2008 20:17:47 Jakub Narebski, vous avez =C3=A9cri=
t=C2=A0:
> Dnia poniedzia=C5=82ek 3. listopada 2008 19:44, Francis Galiegue napi=
sa=C5=82:
> > Le Monday 03 November 2008 19:18:56 Jakub Narebski, vous avez =C3=A9=
crit=C2=A0:
>=20
> > > > Well, as far as Apache is concerned, it can do:
> > > >=20
> > > > * basic .htpasswd authentication,
> > > > * LDAP,
> > > > * PAM,
> > > > * SSL certificate check (via mod_ssl),
> > > > * probably others.
> > > >=20
> > > > Plenty of possibilities.
> > > [...]
> > >=20
> > > Well, the question is if Apache (and other web servers used with
> > > gitweb) can do authentication based on path_info or on query-stri=
ng.
> > > Because it is encoded in gitweb (via $projectroot) where to find =
git
> > > repositories...
> > >=20
> >=20
> > Can you expand on path_info and query-string? Keep in mind that Apa=
che
> > has mod_rewrite, which can rewrite URLs in any way before it gets
> > actually sent to the underlying program (whether it be a CGI or
> > anything else), even badly (or mischievously).
>=20
> What I mean here that the following example gitweb URLs
>=20
>   http://example.com/gitweb.cgi?p=3Dsome/project.git;a=3Dcommit;h=3DH=
EAD
>   http://example.com/gitweb.cgi/some/project.git/commit/HEAD
>=20
> with the following gitweb configuration
>=20
>   $projectroot =3D /var/scm
>=20
> both refer to git repository (directory) at
>=20
>   /var/scm/some/project.git
>=20
> Apache (or other web server) would have to somehow decide based on UR=
L
> that it refers to some project, and based on project and authenticati=
on
> decide whether to grant access to it.
>=20
>=20
> What is more, and what cannot be done by web server alone, is that we
> would want to not show projects which you don't have access to in the
> 'projects_list' page, i.e. at
>=20
>   http://example.com/gitweb.cgi
>=20

I see the point. Note that the second URL can be converted into the fir=
st one with mod_rewrite, and probably the first to the second as well.

As to what repository is accessible to whom, does gitweb really have an=
 internal mechanism for this? Wouldn't it be "better" is privately acce=
ssible projects were available on another website to start with?


--=20
