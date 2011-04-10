From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: extract Q_() source strings as ngettext()
Date: Sun, 10 Apr 2011 14:54:36 -0500
Message-ID: <20110410195436.GD28163@elie>
References: <1302464221-23381-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 21:54:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90in-0005Eu-4Y
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab1DJTym convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 15:54:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44648 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab1DJTyl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 15:54:41 -0400
Received: by iyb14 with SMTP id 14so4992281iyb.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=w8fnc0/kR3/mRZGf69uD1yN4Wj4FaLuVM2c6elohp18=;
        b=xfYr+TOW5QMXsFokegjxwBX3CuM+3zT6h+ZiJpopmmeLt1EE+ZBv710q49aCh6yegy
         fw8V3lAllNy3Fpfifaij2o+3BwYNux7s3m61HviL/Ed58wQKFH/QYx0/vjnk4zOn2UKq
         F2ubT0mbJ03WdoF157iqznZpAJoo5fPr6T+Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KDjsmKlRhl2PLN1s/mp7CoPumyr49JbbNBt64PB1NbPM7N0esfbLDwf6zSmf6iefT6
         AOf6+N5Sj1Rwir1d5T4StBjlWzfO8juR040FtEMNFXK2NkEZVS0ou1OEHNNcY3hEFev0
         Z1kpm3iSS5UPI/8gCCYNytlh9AHH/xh9sqaZw=
Received: by 10.42.159.201 with SMTP id m9mr6780149icx.244.1302465280712;
        Sun, 10 Apr 2011 12:54:40 -0700 (PDT)
Received: from elie (adsl-69-209-51-92.dsl.chcgil.sbcglobal.net [69.209.51.92])
        by mx.google.com with ESMTPS id jv9sm3430260icb.1.2011.04.10.12.54.38
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:54:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302464221-23381-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171284>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/Makefile
> +++ b/Makefile
> @@ -2051,7 +2051,7 @@ XGETTEXT_FLAGS =3D \
>  	--add-comments \
>  	--msgid-bugs-address=3D"Git Mailing List <git@vger.kernel.org>" \
>  	--from-code=3DUTF-8
> -XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --keyword=3D_ --keyword=3DN_ =
--language=3DC
> +XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --keyword=3D_ --keyword=3DN_ =
--keyword=3D"Q_:1,2" --language=3DC
>  LOCALIZED_C :=3D $(C_OBJ:o=3Dc)

Ack.  The line is getting long.  Maybe it would make sense to split
it up (like this)?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 2441d56..2dbe555 100644
--- a/Makefile
+++ b/Makefile
@@ -2051,7 +2051,8 @@ XGETTEXT_FLAGS =3D \
 	--add-comments \
 	--msgid-bugs-address=3D"Git Mailing List <git@vger.kernel.org>" \
 	--from-code=3DUTF-8
-XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --keyword=3D_ --keyword=3DN_ --=
keyword=3D"Q_:1,2" --language=3DC
+XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=3DC \
+	--keyword=3D_ --keyword=3DN_ --keyword=3DQ_:1,2
 LOCALIZED_C :=3D $(C_OBJ:o=3Dc)
=20
 po/git.pot: $(LOCALIZED_C)
--=20
1.7.5.rc0
