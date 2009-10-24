From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Sun, 25 Oct 2009 01:32:04 +0200
Message-ID: <200910250132.04187.vda.linux@googlemail.com>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com> <20091024100502.GG4615@mx.loc> <m2ocnxt6jl.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0544KM8/QZ3qjiN"
Cc: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, busybox@busybox.net,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Oct 25 01:29:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1q2y-0004vT-4O
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 01:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbZJXX3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 19:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbZJXX3I
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 19:29:08 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33078 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbZJXX3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 19:29:07 -0400
Received: by bwz27 with SMTP id 27so1488521bwz.21
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 16:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :message-id;
        bh=TX5b9H+C5RhsoCcizfhGwJlkctW21Q6zHWCcVc70sX4=;
        b=xmO1RiCOrB/67d9VtKAiF4ZzHb/T4xjxuSicpfIAHSZ7V4QL49b2SaNW2o45ZEZAa1
         azOnrFPBX2NbRxfYbZTBBQwdvpHrIZVPAuKI9OxMt4kMSc8RZrcoDwLJec7RJvoTXta2
         w8GRc3pIuoBxr4TykgqUXqw1k++V9kW4fboB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:message-id;
        b=gvXk0TgN/KmwyVOO/gIR2jsy/FKp93cky/F4baf0j4/dA3yjpNosrylmUt0U+VXPYq
         x151QAUyjOENIWIa7xizyHSpWxc5NEwARZQgn5NwAlvix0xiOWL/jJ5Y6LkQGX2vnze3
         efnG0kOCDFoaYOJrLdApz6HHfl96MeVpULEsI=
Received: by 10.204.2.199 with SMTP id 7mr4209208bkk.76.1256426950356;
        Sat, 24 Oct 2009 16:29:10 -0700 (PDT)
Received: from shadow (79.40.broadband9.iol.cz [90.176.40.79])
        by mx.google.com with ESMTPS id 22sm6686995fkr.47.2009.10.24.16.29.08
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 16:29:08 -0700 (PDT)
User-Agent: KMail/1.8.2
In-Reply-To: <m2ocnxt6jl.fsf@whitebox.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131184>

--Boundary-00=_0544KM8/QZ3qjiN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 24 October 2009 12:44, Andreas Schwab wrote:
> Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>=20
> > On Sat, Oct 24, 2009 at 11:49:10AM +0200, Andreas Schwab wrote:
> >>Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
> >>
> >>> I suppose xf - -o would work?
> >>
> >>Isn't that the same as 'xfo -'?
> >
> > Not really (if you do not permute the arguments which we don't in
> > busybox, for size reasons).
>=20
> There is no argument permutation.  The traditional argument parsing of
> tar does not cluster option letters with option arguments.
>=20
> Of course, just using 'xof -' will work around this busybox bug.

=46rom my side, I prefer to squash that busybox bug.
This is the second time people complain about it,
so it is a reoccurring problem.

The attached patch has been pushed to busybox git.

function                                             old     new   delta
tar_main                                             702     751     +49

=2D-
vda

--Boundary-00=_0544KM8/QZ3qjiN
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="1.patch"

diff -d -urpN busybox.0/archival/tar.c busybox.1/archival/tar.c
--- busybox.0/archival/tar.c	2009-10-20 22:11:09.000000000 +0200
+++ busybox.1/archival/tar.c	2009-10-25 01:27:38.000000000 +0200
@@ -841,6 +841,33 @@ int tar_main(int argc UNUSED_PARAM, char
 #if ENABLE_FEATURE_TAR_LONG_OPTIONS
 	applet_long_options = tar_longopts;
 #endif
+#if ENABLE_DESKTOP
+	if (argv[1][0] != '-') {
+		/* Compat:
+		 * 1st argument without dash handles options with parameters
+		 * differently from dashed one: it takes *next argv[i]*
+		 * as paramenter even if there are more chars in 1st argument:
+		 *  "tar fx TARFILE" - "x" is not taken as f's param
+		 *  but is interpreted as -x option
+		 *  "tar -xf TARFILE" - dashed equivalent of the above
+		 *  "tar -fx ..." - "x" is taken as f's param
+		 * getopt32 wouldn't handle 1st command correctly.
+		 * Unfortunately, people do use such commands.
+		 * We massage argv[1] to work around it by moving 'f'
+		 * to the end of the string.
+		 * More contrived "tar fCx TARFILE DIR" still fails,
+		 * but such commands are much less likely to be used.
+		 */
+		char *f = strchr(argv[1], 'f');
+		if (f) {
+			while (f[1] != '\0') {
+				*f = f[1];
+				f++;
+			}
+			*f = 'f';
+		}
+	}
+#endif
 	opt = getopt32(argv,
 		"txC:f:Opvk"
 		IF_FEATURE_TAR_CREATE(   "ch"  )

--Boundary-00=_0544KM8/QZ3qjiN--
