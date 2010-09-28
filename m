From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 1/2] gettext: use const char* instead of char*
Date: Tue, 28 Sep 2010 18:29:36 +0000
Message-ID: <1285698577-28395-2-git-send-email-avarab@gmail.com>
References: <AANLkTinHCETsaM=ytHuE9S5A+uAb=e3YLETsJJLga+DM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 20:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ewO-00042J-Cm
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 20:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab0I1SaB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 14:30:01 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37232 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962Ab0I1SaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 14:30:00 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so369006wwd.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=t5d0UFLV5K8OP0X9jJmHiPfkQ8mAG/fmJToOxBQgni4=;
        b=NiYOjN9BtCAJw8AVVnVoyJePi4ijEzx1Kcrx8gBWMt9JOEZZIqrvltZaFpy2og2PpH
         LpV9H5Vq61X9L12h27y1sZTJsNbImC/9dETBk3sbwH+ApzhENVOJbWGv5hdTXwuwCXB5
         iCG9tjoYJ+d2MNozvjfo3MkRDXLkXuYIjqdrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cWboXusyjfRf9ugSyKrxb3xmGQyHSibZzhBUNLIaZ6qUSNcGgaNnpUgvtOv/PFZTti
         dgi0VUb9cVQnb0slS9OS7ynnhqjtMK3DCAep0SE5TIGa+AQFHS6myN7j557OYiASeyrm
         dA/Edz6IXVONErmY6O2QNezBl1vt9mCDe1kLY=
Received: by 10.216.23.206 with SMTP id v56mr1457923wev.67.1285698588659;
        Tue, 28 Sep 2010 11:29:48 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id x33sm4718305weq.23.2010.09.28.11.29.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 11:29:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <AANLkTinHCETsaM=ytHuE9S5A+uAb=e3YLETsJJLga+DM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157453>

=46rom: Erik Faye-Lund <kusmabite@gmail.com>

Change the charset variable in git_setup_gettext from char* to const
char*.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 gettext.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gettext.c b/gettext.c
index 8644098..d20bb39 100644
--- a/gettext.c
+++ b/gettext.c
@@ -7,7 +7,7 @@
 extern void git_setup_gettext(void) {
 	char *podir;
 	char *envdir =3D getenv("GIT_TEXTDOMAINDIR");
-	char *charset;
+	const char *charset;
=20
 	if (envdir) {
 		(void)bindtextdomain("git", envdir);
--=20
1.7.3.159.g610493
