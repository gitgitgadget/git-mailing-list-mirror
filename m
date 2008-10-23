From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to push to http(s) repository with authentication?
Date: Thu, 23 Oct 2008 21:05:44 +0200
Message-ID: <20081023190544.GA21079@blimp.localdomain>
References: <20081020182502.GH9707@raven.wolf.lan> <20081023175336.GA3526@raven.wolf.lan>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Thu Oct 23 21:07:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt5WP-0005qZ-FT
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 21:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbYJWTFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Oct 2008 15:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755676AbYJWTFs
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 15:05:48 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:37159 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbYJWTFr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 15:05:47 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8A081of0=
Received: from tigra.home (Fac0e.f.strato-dslnet.de [195.4.172.14])
	by post.webmailer.de (fruni mo12) (RZmta 17.14)
	with ESMTP id N001f1k9NHKvip ; Thu, 23 Oct 2008 21:05:45 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id F2898277C8;
	Thu, 23 Oct 2008 21:05:44 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id A33B036D27; Thu, 23 Oct 2008 21:05:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081023175336.GA3526@raven.wolf.lan>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98982>

Josef Wolf, Thu, Oct 23, 2008 19:53:37 +0200:
> On Mon, Oct 20, 2008 at 08:25:02PM +0200, Josef Wolf wrote:
>=20
> > I have set up a repository as described in
> >=20
> >   http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-s=
erver-over-http.txt
> >=20
> > over SSL with basic authentication.  DAV access works fine with kon=
queror,
> > cadaver and and curl, using this .curlrc:
> > [ ... ]
>=20
> Is nobody interested in this topic?  Or am I in the wrong list?

       --cacert <CA certificate>
              (SSL) Tells curl to use the specified certificate file to=
 verify
              the peer. The file may contain  multiple  CA  certificate=
s.  The
              certificate(s) must be in PEM format.

              curl  recognizes the environment variable named =E2=80=99=
CURL_CA_BUNDLE=E2=80=99
              if that is set, and uses the given path as a path to a  C=
A  cert
              bundle. This option overrides that variable.

              The  windows  version  of  curl will automatically look f=
or a CA
              certs file named =C2=B4curl-ca-bundle.crt=C2=B4, either i=
n the same direc=E2=80=90
              tory as curl.exe, or in the Current Working Directory, or=
 in any
              folder along your PATH.

              If curl is built against the NSS SSL library  then  this =
 option
              tells  curl the nickname of the CA certificate to use wit=
hin the
              NSS database defined by the environment variable SSL_DIR =
(or  by
              default  /etc/pki/nssdb).   If  the NSS PEM PKCS#11 modul=
e (lib=E2=80=90
              nsspem.so) is available then PEM files may be loaded.

              If this option is used several times, the last one will b=
e used.

Does this (setting $CURL_CA_BUNDLE) help?
