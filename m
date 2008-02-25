From: Sebastian Noack <sebastian.noack@googlemail.com>
Subject: git-svn bug/patch: Don't prompt for client cert password everytime.
Date: Mon, 25 Feb 2008 16:11:30 +0100
Message-ID: <20080225161130.0be0214b@korv>
References: <20080225152535.33dc0893@korv>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6TvWiBu8u36uTIErq=GTsL9";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:04:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JThhA-0007S5-2b
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 19:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299AbYBYSER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 13:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755357AbYBYSER
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 13:04:17 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:41375 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752904AbYBYSEQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 13:04:16 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1PI34IK030757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Feb 2008 10:03:05 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1PI33r2012068;
	Mon, 25 Feb 2008 10:03:04 -0800
X-Return-Path: <sebastian.noack@googlemail.com>
X-Received: from woody.linux-foundation.org (localhost.localdomain [127.0.0.1])
	by woody.linux-foundation.org (8.14.2/8.14.2) with ESMTP id m1PFCeT2026555
	for <torvalds@localhost>; Mon, 25 Feb 2008 07:12:43 -0800
X-Received: from imap1.linux-foundation.org [207.189.120.55]
	by woody.linux-foundation.org with IMAP (fetchmail-6.3.8)
	for <torvalds@localhost> (single-drop); Mon, 25 Feb 2008 07:12:43 -0800 (PST)
X-Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org [207.189.120.13])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1PFCW3h005149
	for <torvalds@imap1.linux-foundation.org>; Mon, 25 Feb 2008 07:12:32 -0800
X-Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1PFBvwo012747
	for <torvalds@osdl.org>; Mon, 25 Feb 2008 07:11:59 -0800
X-Received: by fg-out-1718.google.com with SMTP id 22so1064927fge.18
        for <torvalds@osdl.org>; Mon, 25 Feb 2008 07:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:from;
        bh=GrGW0QhmdsyG+EWyo9NO9x2Tv5aq4Qg3bcG7VMqF0zg=;
        b=ue0Pqkfde8QmiO1Lx2rNE/O291SM84mV+5wwR9tfbsoNNroRuatc1cHkl/S2gVBD8J5XMTKHPFxywIEk3PDKbXzTk+tg3heCIckpfJkpYeFCA5Y9d81yVBWULPg6Bpzq+nYWFNVO2Z5nb4g/GtD1t6d4qJYqvkzbWKm9ddg2ts8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:from;
        b=T/93X0/Fs6t1T/Tg99uHA9L4B5DyyOiKidHIN1BPVo/pBQ6k5ydD0wwEtD0wfs5YqFsFzhMm+vXaju9msl+E7T+dhI0NxsP8sFG4HzvgJ5SNUz93PisoByfFuhRg3Ke4zdCFblWAkSi8U91Oa7r83ITQYtpzTCVrLgFS8N+wQqA=
X-Received: by 10.86.74.15 with SMTP id w15mr3054412fga.46.1203952311355;
        Mon, 25 Feb 2008 07:11:51 -0800 (PST)
X-Received: from korv ( [80.135.156.143])
        by mx.google.com with ESMTPS id 3sm6519733fge.7.2008.02.25.07.11.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Feb 2008 07:11:50 -0800 (PST)
In-Reply-To: <20080225152535.33dc0893@korv>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.12.5; i686-pc-linux-gnu)
Received-SPF: pass (domain of sebastian.noack@googlemail.com designates 72.14.220.152 as permitted sender)
X-Spam-Status: No, hits=-2.812 required=5 tests=BAYES_00,OSDL_HEADER_SPF_PASS
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75039>

--Sig_/6TvWiBu8u36uTIErq=GTsL9
Content-Type: multipart/mixed; boundary="MP_/0S4fph./facOKc79M74RDhE"

--MP_/0S4fph./facOKc79M74RDhE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Eric,

I am using git-svn with a subversion repository using ssl client
certificates and I noted, that every time I do...

git-svn fetch

...for example, it prompts for my export passphrase, even though it is
given in ~/.subversion/servers.

I wrote a patch that fixes this (see attachment).

Btw, the patch I sent you before only works with an old version of git,
this one, attached to this email, works with current HEAD.

Regards
Sebastian Noack

--MP_/0S4fph./facOKc79M74RDhE
Content-Type: text/x-patch;
 name=0001-git-svn-Don-t-prompt-for-client-cert-password-every.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=0001-git-svn-Don-t-prompt-for-client-cert-password-every.patch

=46rom 1ec84f7b3b25970ed76db3fa9326c916d3ddcf23 Mon Sep 17 00:00:00 2001
From: Sebastian Noack <sebastian.noack@gmail.com>
Date: Mon, 25 Feb 2008 15:56:28 +0100
Subject: [PATCH] git-svn: Don't prompt for client cert password everytime.

---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 05fb358..9e2faf9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3643,6 +3643,7 @@ sub _auth_providers () {
 	  SVN::Client::get_ssl_client_cert_file_provider(),
 	  SVN::Client::get_ssl_client_cert_prompt_provider(
 	    \&Git::SVN::Prompt::ssl_client_cert, 2),
+	  SVN::Client::get_ssl_client_cert_pw_file_provider(),
 	  SVN::Client::get_ssl_client_cert_pw_prompt_provider(
 	    \&Git::SVN::Prompt::ssl_client_cert_pw, 2),
 	  SVN::Client::get_username_provider(),
--=20
1.5.3.7


--MP_/0S4fph./facOKc79M74RDhE--

--Sig_/6TvWiBu8u36uTIErq=GTsL9
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHwtquhef27Il4mhgRAmWdAJ942zR2DK45nC5e8k1aq0qw64a1yACggjlv
iP5XeqUr+SkGHHMyr4I0ujg=
=jRAT
-----END PGP SIGNATURE-----

--Sig_/6TvWiBu8u36uTIErq=GTsL9--
