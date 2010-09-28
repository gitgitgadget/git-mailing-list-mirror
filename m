From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Pull request for msysGit patches
Date: Tue, 28 Sep 2010 23:20:38 +0200
Message-ID: <AANLkTikpDwEJR8rAk+R0auXN5y-G1Cd4z8djoL0VzTYw@mail.gmail.com>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201009282252.25688.j6t@kdbg.org>
 <AANLkTikSxpXJkeneWbJQ_2g32w1bV-CEdyk2_5G2Xd+u@mail.gmail.com> <201009282313.48278.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Sep 28 23:21:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0hbq-0003Ti-Kv
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 23:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab0I1VU7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 17:20:59 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63683 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab0I1VU6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 17:20:58 -0400
Received: by gxk9 with SMTP id 9so47899gxk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=QMgevTOwCBd9OaystPIW1YMIsB2+TqPmNmByZmaBcWI=;
        b=ujGg0lU9pa9S1mSup1gk6Jluw9GiMVgkPd+Tw1zoc1S0AHA5y1JmLo26KCvK+++nBE
         UdyEZxk6cd4QGSZKjn6xIWNUZxPMNTbQUufHqKb8HPRXb4eVQj58HdEPTA3Y1A1pyf2w
         KhfsFMpFcIxKkRfYgdI8bU5h+2hPeZHGfhvDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=IhQJoznZa6sM9wwBI1SJOguFfP5Xqc/vTgm1lfJYLr807zoKkssYjtuJTWEPAD1Hp5
         i46I2PDiYadxXG1sg52plZJ412Ztu3mxyTPm1Yz6NuhR9kmVgm6uSmj0k1fJCRp2M2y7
         2gJJ7TVIOfy3UZPlR5OdDaz7E9IDH4qISF3DY=
Received: by 10.236.111.1 with SMTP id v1mr243713yhg.17.1285708858332; Tue, 28
 Sep 2010 14:20:58 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Tue, 28 Sep 2010 14:20:38 -0700 (PDT)
In-Reply-To: <201009282313.48278.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157476>

On Tue, Sep 28, 2010 at 11:13 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Dienstag, 28. September 2010, Erik Faye-Lund wrote:
>> On Tue, Sep 28, 2010 at 10:52 PM, Johannes Sixt <j6t@kdbg.org> wrote=
:
>> >> =A0 =A0 =A0 mingw: do not crash on open(NULL, ...)
>> >
>> > This one is bogus, and as it stands, it must have my Ack removed. =
:)
>> > Needs the same fix in mingw_fopen as mingw_freopen. (There remains=
 an
>> > unprotected dereference of filename.)
>>
>> I believe the version in for-junio already has this fix squashed in.
>> The following hunk, taken from
>> http://repo.or.cz/w/git/mingw/4msysgit.git/blobdiff/4e93566b07dcf47e=
cb6484d
>>225418c04c1eedee6..b18500977d88b13803ecc60cf383538139ec09d8:/compat/m=
ingw.c
>> shows that it is... Or are you thinking of something else?
>>
>> @@ -346,7 +346,7 @@ FILE *mingw_fopen (const char *filename, const c=
har
>> =A0 =A0 =A0 if (hide_dotfiles =3D=3D HIDE_DOTFILES_TRUE &&
>> =A0 =A0 =A0 basename((char*)filename)[0] =3D=3D '.')
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^^^^^^^^
> This can crash, too.
>

Ah, indeed. Thanks for pointing that out! I'll send out a new version,
with this squashed on top:

diff --git a/compat/mingw.c b/compat/mingw.c
index 2fbe381..2584e9f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -343,11 +343,13 @@ FILE *mingw_fopen (const char *filename, const
char *otype)
 {
 	int hide =3D 0;
 	FILE *file;
-	if (hide_dotfiles =3D=3D HIDE_DOTFILES_TRUE &&
-	    basename((char*)filename)[0] =3D=3D '.')
-		hide =3D access(filename, F_OK);
-	if (filename && !strcmp(filename, "/dev/null"))
-		filename =3D "nul";
+	if (filename) {
+		if (hide_dotfiles =3D=3D HIDE_DOTFILES_TRUE &&
+		    basename((char*)filename)[0] =3D=3D '.')
+			hide =3D access(filename, F_OK);
+		if (!strcmp(filename, "/dev/null"))
+			filename =3D "nul";
+	}
 	file =3D fopen(filename, otype);
 	if (file && hide && make_hidden(filename))
 		warning("Could not mark '%s' as hidden.", filename);
@@ -359,11 +361,13 @@ FILE *mingw_freopen (const char *filename, const
char *otype, FILE *stream)
 {
 	int hide =3D 0;
 	FILE *file;
-	if (hide_dotfiles =3D=3D HIDE_DOTFILES_TRUE &&
-	    basename((char*)filename)[0] =3D=3D '.')
-		hide =3D access(filename, F_OK);
-	if (filename && !strcmp(filename, "/dev/null"))
-		filename =3D "nul";
+	if (filename) {
+		if (hide_dotfiles =3D=3D HIDE_DOTFILES_TRUE &&
+		    basename((char*)filename)[0] =3D=3D '.')
+			hide =3D access(filename, F_OK);
+		if (!strcmp(filename, "/dev/null"))
+			filename =3D "nul";
+	}
 	file =3D freopen(filename, otype, stream);
 	if (file && hide && make_hidden(filename))
 		warning("Could not mark '%s' as hidden.", filename);
