From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Wed, 23 Mar 2011 19:18:24 +0700
Message-ID: <AANLkTimtGCdo40V-pYZ5YHEO_pzV7zx6Py3bC5aVufYb@mail.gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
 <7vmxl37bdp.fsf@alter.siamese.dyndns.org> <7vvczr5pw6.fsf@alter.siamese.dyndns.org>
 <AANLkTimsv9bO+Go6Mqrrp_1-AZ=sC3ndyAuskPYLVbkv@mail.gmail.com>
 <AANLkTimWPoMEYdLCwTTit6AeuJegOc96gE1JsO8B4fh=@mail.gmail.com>
 <4D871E51.8090106@drmicha.warpmail.net> <7v7hbqk8ox.fsf@alter.siamese.dyndns.org>
 <AANLkTimeEWOvmNXQV9fJKe23Qe3sipT7q=qHVB2fLq0n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 13:19:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2N1h-0002VT-Fc
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 13:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716Ab1CWMS4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 08:18:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39740 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946Ab1CWMSz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 08:18:55 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so7591330wya.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=E3kUdQHKgYCRfi3lf7g95TkwvrTuW7TT5TyfKEJqnsY=;
        b=JmtHRLijxZPR/uNtio+3Ut9FtQJ2Yw4/pWusREgBmf1SjvnY1aNS8fnNIiJGbXmymR
         YEBq74p+EKWu73Y/tsLAM9IPW48VVndLgr7fbZSnf0jEz8EqePcbWjTqCKx8Hh0zYd3W
         l0hIsRhUvw0lo5vLhwSKmxMrIVa2juyOSIg00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=B8r78kFm8fWwTAXgFQvtMPWY2FHRBLxGbPdPF1/lwgsK2eNPry0HplF5RyRVYpuDl8
         3EbE88woBOEpdDjKO9eIb6NhAZI4UaRRcgjALd6ggKewm3ahOeePrhTS4eA+SqZqx4hd
         XYzYboPywcbWSf1/i7OIg2PHAnNMtNn0E2DHE=
Received: by 10.216.157.68 with SMTP id n46mr7838733wek.111.1300882734337;
 Wed, 23 Mar 2011 05:18:54 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 23 Mar 2011 05:18:24 -0700 (PDT)
In-Reply-To: <AANLkTimeEWOvmNXQV9fJKe23Qe3sipT7q=qHVB2fLq0n@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169825>

On Wed, Mar 23, 2011 at 7:10 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> How about ":<path>" for root pathspecs, but reserve ':[^0-9A-Za-z]*'
> for future use?
> ..
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (strchr(reserved, (*src)[1]))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("':%c' syntax is not supported.=
 "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Quote it to match li=
terally.", (*src)[1]);

Hmm.. I need a letter to become quoter. Let's take '\' for that. I
also leave '.' out of reserved range because it may be used frequently
(hidden files).

diff --git a/setup.c b/setup.c
index ef55e5d..b6294be 100644
--- a/setup.c
+++ b/setup.c
@@ -146,8 +146,16 @@ const char **get_pathspec(const char *prefix,
const char **pathspec)
 	while (*src) {
 		const char *p;

-		if ((*src)[0] =3D=3D ':')
-			p =3D prefix_path(NULL, 0, (*src)+1);
+		if ((*src)[0] =3D=3D ':') {
+			const char *reserved =3D "~`!@#$%^&*()-_=3D+[{]}|;:'\",<>/?";
+			const char *s =3D *src + 1;
+			if (*s =3D=3D '\\')
+				s++;
+			else if (strchr(reserved, *s))
+				die("':%c' syntax is not supported. "
+				    "Quote it to match literally.", *s);
+			p =3D prefix_path(NULL, 0, s);
+		}
 		else
 			p =3D prefix_path(prefix, prefixlen, *src);
 		*(dst++) =3D p;
--=20
Duy
