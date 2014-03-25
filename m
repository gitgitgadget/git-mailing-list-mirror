From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 061/144] t5505-remote.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:06 -0700
Message-ID: <1395735989-3396-62-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:33:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMnd-00067W-LD
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbaCYIdR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:33:17 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:56464 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbaCYI1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:45 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so129781pbc.32
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=c+Y9yhgpoCRVFYw6gvqNnHomGkaixo3ChZSr2csyiy8=;
        b=BpM23GVjX+/6ZEM+LAaWS4fePvoD1m3ePe6+cx83MFJEKq4e7f096fD6dcVgX2ZUcP
         Xbbl6ufFI02R65/ZX1igzo20rhNILOVpSR0cSizZWbE7w5tfrbnbOb8T2Qy68/KekNVV
         VHXu8tLuKDaK4KuHWkkbr3AjWIA43Vo06yBAEBbMhIGVl9gpOXe1cogr9Me/p3WWRfO9
         +Mo9mXa7A5vONHp582rt4FOz0UTdBJF53LBO1U/BhePkmb+kCJ/0hYPluGKdWioyeabY
         TzlHm0fa9IX2S2A8+OiQdpWUMB8mTkoYQEoLeTdtKRvZXBbbs++Vumep0g+TnBlH/fwL
         iytQ==
X-Received: by 10.67.13.226 with SMTP id fb2mr9164420pad.146.1395736064995;
        Tue, 25 Mar 2014 01:27:44 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244976>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5505-remote.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ac79dd9..366a583 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -85,7 +85,7 @@ test_expect_success C_LOCALE_OUTPUT 'check remote-tra=
cking' '
 test_expect_success 'remote forces tracking branches' '
 	(
 		cd test &&
-		case `git config remote.second.fetch` in
+		case $(git config remote.second.fetch) in
 		+*) true ;;
 		 *) false ;;
 		esac
--=20
1.7.10.4
