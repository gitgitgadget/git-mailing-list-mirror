From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/16] narrow spec: put '+' before a spec will change semantic of '*'
Date: Sun, 14 Sep 2008 20:08:01 +0700
Message-ID: <1221397685-27715-13-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
 <1221397685-27715-8-git-send-email-pclouds@gmail.com>
 <1221397685-27715-9-git-send-email-pclouds@gmail.com>
 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
 <1221397685-27715-11-git-send-email-pclouds@gmail.com>
 <1221397685-27715-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:10:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerNS-00063M-2l
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbYINNJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbYINNJq
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:09:46 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbYINNJp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:09:45 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=tgkowy1enVSrfJBIgzCbn5ZU+tMN0wMnyXhuOmjUQv0=;
        b=FA+SYamiswjmqnztEftmKgOJAX3gg5KgQBW1uqVBhI5rM6YAqxPoMojE3svt20GjHM
         /Pw+r6Q5zM9GnUFO5qIb3bFSJTtsAmuGdK/JVuztcIH/mAz9HNYs6RxtA405KJv4z73b
         sfxIW0mR7TRtmyi2Dz+MCDuIrb3C8m4oZ5juY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oDejkjqg1yfqnU8bx3ouS0V7hDiBmN/AroEE8WB4L9oXty9mYq4Ci97uh+Fwy//9/B
         U+lj0JRn5DNplZvpu//dNiTMgvLEgASlkyGEF81jA+coeuDFY6M5OK3+mN+4n0kj1Qvu
         3VKGQPSedjNJ4UGw12DFSPbdr03PBXGt35Yqw=
Received: by 10.142.255.14 with SMTP id c14mr2246987wfi.296.1221397785211;
        Sun, 14 Sep 2008 06:09:45 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 20sm20019451wfi.11.2008.09.14.06.09.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:09:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:09:37 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-12-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95839>

Previously '*' in narrow spec means 'match everything, even slashes'.
With this change, '*' is now 'match everything except slashes' so it is
more like shell wildcard one. Putting '+' before a spec will make
'*' as powerful as before.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 968cc98..3782de6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -812,10 +812,15 @@ int match_narrow_spec(const char *spec_, const ch=
ar *path, const char *prefix)
=20
 	while (!match) {
 		char *next_spec =3D strchr(cur_spec, ':');
+		int flag =3D 0;
 		if (next_spec)
 			*next_spec =3D '\0';
=20
-		if (!fnmatch(cur_spec, path+prefix_len, 0))
+		if (*cur_spec =3D=3D '+')
+			cur_spec++;
+		else
+			flag =3D FNM_PATHNAME;
+		if (!fnmatch(cur_spec, path+prefix_len, flag))
 			match =3D 1;
=20
 		if (!next_spec)
--=20
1.6.0.96.g2fad1.dirty
