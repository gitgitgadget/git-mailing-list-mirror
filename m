From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 089/144] t7006-pager.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:34 -0700
Message-ID: <1395735989-3396-90-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:29:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMjy-0001bN-CC
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbaCYI3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:29:42 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:46680 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbaCYI2O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:14 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so136000pbc.4
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bi2SkCS7UJ+O6STUhzsDAONxiH3XlglP4g4ZfkenfiU=;
        b=GwdbXk+trEfRAVwIP87di60bZ9HCZW1ewMKQmpBMhZP1ceEbcHrAzjf4JsrHxT1h0U
         CehZHR2FuwxnTUDsPa0kfxb3pPuJUyA09j9UiAlT//v9LFKG1vGtPsF/99unVXZI8gfe
         KVUA1byrWR2HQ3jz4KMSMZALjEciC4gj/25xlgCSbeZ8kK8cPHOwiaeZ7mpwLOpWg9ki
         k+rrMaNR+Qruyc7CsZ1H11tcRSM/Hyzuy0wLbWKccVzq3LMyx2vwB8jtc2o1MFzTfUnz
         xJ8LXzyS/8bnIzSgPXr1SKoTz/zgQ7cd8kFW0jXx11MCfAlVVnZ9Dg57LPyEUM17nBKN
         P58Q==
X-Received: by 10.68.185.1 with SMTP id ey1mr77768969pbc.33.1395736094346;
        Tue, 25 Mar 2014 01:28:14 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244950>

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
 t/t7006-pager.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index b9365b4..7576fa9 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -436,7 +436,7 @@ test_expect_success TTY 'command-specific pager wor=
ks for external commands' '
 	echo "foo:initial" >expect &&
 	>actual &&
 	test_config pager.external "sed s/^/foo:/ >actual" &&
-	test_terminal git --exec-path=3D"`pwd`" external log --format=3D%s -1=
 &&
+	test_terminal git --exec-path=3D"$(pwd)" external log --format=3D%s -=
1 &&
 	test_cmp expect actual
 '
=20
--=20
1.7.10.4
