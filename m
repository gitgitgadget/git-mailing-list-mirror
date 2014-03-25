From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 003/144] git-pull.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:08 -0700
Message-ID: <1395735989-3396-4-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:39:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMtl-0005Dm-1r
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbaCYIjY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:39:24 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:43157 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612AbaCYI0j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:39 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so128719pab.13
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QV+eKs38L2JoewY9w0v33zg64GvTQuxC5fE+SnaJ/ZY=;
        b=FXuW8Z6O2/QmB1wUb9DDVh65z3KbUNhONpTL3l8EUx2t35k107Dc26SxYSP/edNMfc
         os7pg838b/lwvvf7Ub9fPEfP5ewp42AwAXUCRW/F6wK9F5OH+K0bmRPDbgLnWS9nhfM9
         JmwJiWLAqp8Q94+pcno/FOfbqR8LnT29S6JJPxYXeTu3V6m7CtgjVj/C8lkXeC0oKO3k
         lnP5ZUcaF2vLfboQPFX+1QZz1f5SVxo1mO6TossdD5R0xUofMcCZhBUmyrTaozlorl9W
         9l2yyk57xoyFKy0r2VYOJ37tqdY9qtnRbyeCmmUJt4tGYq7CwQ48tXcDMes/dQYt1/pt
         C1wg==
X-Received: by 10.69.26.103 with SMTP id ix7mr77816191pbd.41.1395735999050;
        Tue, 25 Mar 2014 01:26:39 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245016>

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
 git-pull.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index 6cd8ebc..cfc589d 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -108,7 +108,7 @@ do
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
 		case "$#,$1" in
 		*,*=3D*)
-			strategy=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'` ;;
+			strategy=3D$(expr "z$1" : 'z-[^=3D]*=3D\(.*\)') ;;
 		1,*)
 			usage ;;
 		*)
--=20
1.7.10.4
