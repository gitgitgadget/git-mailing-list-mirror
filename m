From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] tests: Ignore the Test::Harness .prove file
Date: Fri, 23 Jul 2010 22:58:44 +0000
Message-ID: <1279925924-7304-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 00:59:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcRCn-0000N8-1B
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 00:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758983Ab0GWW6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 18:58:55 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34035 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919Ab0GWW6y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 18:58:54 -0400
Received: by eya25 with SMTP id 25so152902eya.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=yJahFlq9LT/dP7EgC/ZdFcsYLNNlDmXNqdvF9dl5Aek=;
        b=t2l5GmlOHUpfCZrUKU/fI7t2nBu7Ym/F6Zcr5ZtDyenUI+fgdWZ9ZHKVdwjZBC9R0n
         dis5E/FrxaGjN/4fUpWaav3A3JxymFaP1N9IwauyvOhrVaHGXwuv0pBJXNTZXN5X95/f
         xWmDq8QxIE2fLGxb6sMg8EpWVlJ5bHFxxWPVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=jUtiaos2PGSMDPIoxmluEjalKUJ4VqQYaKBzYdcvp04JF033pr8udL3Qk3/w4IKWUD
         8H+VTSfgoGt5XyO12WEhr6AmlX6DIbYHi+YaP6SckDJJ8O5rA4SWw9ZDX8osGJPM9Reh
         I3wBDM9ndxNHqd1wsZ2l6vGEiTlq9XNP46SXk=
Received: by 10.213.114.13 with SMTP id c13mr3646744ebq.90.1279925932577;
        Fri, 23 Jul 2010 15:58:52 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id x54sm1112207eeh.23.2010.07.23.15.58.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 15:58:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151583>

We document how to run prove with the --state option in t/README. This
produces a .prove YAML file in the current directory. Change the t/
gitignore to ignore it, and clean it up on `make clean'.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/.gitignore |    1 +
 t/Makefile   |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/.gitignore b/t/.gitignore
index 7dcbb23..4e731dc 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -1,2 +1,3 @@
 /trash directory*
 /test-results
+/.prove
diff --git a/t/Makefile b/t/Makefile
index cf5f9e2..819b936 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -30,6 +30,7 @@ clean:
 	$(RM) -r 'trash directory'.* test-results
 	$(RM) t????/cvsroot/CVSROOT/?*
 	$(RM) -r valgrind/bin
+	$(RM) .prove
=20
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
--=20
1.7.0.4
