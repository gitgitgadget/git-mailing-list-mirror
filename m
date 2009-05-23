From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Sun, 24 May 2009 00:50:42 +1000
Message-ID: <20090523145042.GA13139@dektop>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> <1242899229-27603-2-git-send-email-pclouds@gmail.com> <1242899229-27603-3-git-send-email-pclouds@gmail.com> <4A164C85.3000703@viscovery.net> <fcaeb9bf0905220030l45e1b7dfqd30f35b7c8e43b51@mail.gmail.com> <20090523092603.GA7420@dektop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlsrc.navy.mil>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun May 24 03:52:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M82tR-0005pO-Kj
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 03:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbZEXBwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 May 2009 21:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbZEXBwR
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 21:52:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:54729 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbZEXBwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 21:52:17 -0400
Received: by rv-out-0506.google.com with SMTP id f9so815756rvb.1
        for <git@vger.kernel.org>; Sat, 23 May 2009 18:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iV1BIZfLLyEwyo6t4dZ0Ob919rQpU2OwAEiA8vIWVGk=;
        b=m0hF+z7Tfqz8YDl+jGSnqQDvmoKB8ZaJYiv5GB/247zQxwbQhp6WjsOxA/DgQ5p5k2
         n3UyjORyPnm+HG6VshFZGhguBL9Twh+9bEo01MgThulQBuk2WdHb74kZetN5HpzvwhVf
         K5LHNpWpratFMNc+/3aZk/hmnBBkjJZmdiISU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Hu4v16393gX3Dw/i8tRXbcXGqLD9Uxkb68O+oElnZoAHAha4WQO2RiBZO4EygfNnRp
         LyDE4LwvvOYD+a2e4dsIwYFBkvOvw37hiKHNp5KOniqAbuF/yCNxKxILaCKXsaZ/q0qo
         vFyGsqgDuAXdri+DaMdczhnrtviY9bWb0TgxI=
Received: by 10.141.40.20 with SMTP id s20mr2166647rvj.86.1243129936802;
        Sat, 23 May 2009 18:52:16 -0700 (PDT)
Received: from dektop ([121.91.81.118])
        by mx.google.com with ESMTPS id c20sm15322675rvf.0.2009.05.23.18.52.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 18:52:15 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun, 24 May 2009 00:50:42 +1000
Content-Disposition: inline
In-Reply-To: <20090523092603.GA7420@dektop>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119808>

On Sat, May 23, 2009 at 07:26:03PM +1000, Nguyen Thai Ngoc Duy wrote:
> On Fri, May 22, 2009 at 05:30:31PM +1000, Nguyen Thai Ngoc Duy wrote:
> > 2009/5/22 Johannes Sixt <j.sixt@viscovery.net>:
> > > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> > >> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pcloud=
s@gmail.com>
> > >
> > > Is it possible for you to test this series on Windows? Many rebas=
e tests
> > > fail, but I haven't investigated why.
> >=20
> > I'll try it this weekend.
>=20
> This patch makes t3*rebase*.sh pass for me except t3412 (more exactly
> t3412.8). That test failed even with git-rebase.sh. Hmm... Anyway
> could you try again to see what tests still fail?

Someone with better Windows knowledge than me should explain how this w=
orks. Windows'
snprintf() just cuts out the last character in this statement:

snprintf(buf, 8, "--%s", "onto"); // result: '--ont', expected: '--onto=
'

All rebase tests now pass for me on Windows (Vista something, I have
yet to find where it hides its "uname" command)

-->--
diff --git a/compat/snprintf.c b/compat/snprintf.c
index 357e733..1cea768 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -13,7 +13,7 @@
 int git_vsnprintf(char *str, size_t maxsize, const char *format, va_li=
st ap)
 {
 	char *s;
-	int ret =3D -1;
+	int size, ret =3D -1;
=20
 	if (maxsize > 0) {
 		ret =3D vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
@@ -26,18 +26,19 @@ int git_vsnprintf(char *str, size_t maxsize, const =
char *format, va_list ap)
 		return ret;
=20
 	s =3D NULL;
-	if (maxsize < 128)
-		maxsize =3D 128;
+	size =3D maxsize < 128 ? 128 : maxsize;
=20
 	while (ret =3D=3D -1) {
-		maxsize *=3D 4;
-		str =3D realloc(s, maxsize);
-		if (! str)
+		size *=3D 4;
+		s =3D realloc(s, size);
+		if (!s)
 			break;
-		s =3D str;
-		ret =3D vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
-		if (ret =3D=3D maxsize-1)
+		s =3D s;
+		ret =3D vsnprintf(s, size-SNPRINTF_SIZE_CORR, format, ap);
+		if (ret =3D=3D size-1)
 			ret =3D -1;
+		else
+			memcpy(str, s, maxsize-1);
 	}
 	free(s);
 	return ret;
-->--
