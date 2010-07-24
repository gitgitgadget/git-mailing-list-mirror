From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/6] Makefile: Split out the untested functions target
Date: Sat, 24 Jul 2010 20:51:00 +0000
Message-ID: <1280004663-4887-4-git-send-email-avarab@gmail.com>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 22:51:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OclhK-0007bl-TQ
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 22:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab0GXUvw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 16:51:52 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42551 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575Ab0GXUvu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 16:51:50 -0400
Received: by mail-ey0-f174.google.com with SMTP id 25so268827eya.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=3WSOcxzc30Gb58a8sTQ+l4FzYObJXA0xdqCc/xjrCyE=;
        b=c/oEK/x/gXTaJAfNwopRpJ/gUhHuqia/MwFLf+lrw/LuBN/TKBVIxDVqiRI8Jk2d5f
         mRhKKYce/2tF4bFH8sDEwANbVRWYYEj0ZWfTCIWtWLuy8krlw/7XKLUy6l/WhrPcJR8t
         vaGHb0S8YMbLmTfJjN7PZyRj6bM8Zxc45i8Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=b69Ss7DbikU8nNohT8Xg3bAVu0Lq1vV5XmuL5Ar1MGmDnqk4Y44v3nw2cA+MaKoYwB
         8cGg486/EjEK2Dq/wDvnV4Cxmnh5uiAIWF+Qg7d3+jnjthag7ufEFy0j/Y9nJM3gS0xY
         qONEzw9/C8137idlGjGMkfnJB6Oxa8KIYJJvc=
Received: by 10.213.16.197 with SMTP id p5mr4692816eba.65.1280004709786;
        Sat, 24 Jul 2010 13:51:49 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm2701243eei.6.2010.07.24.13.51.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 13:51:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280004663-4887-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151672>

Change the coverage-report target so that it doesn't generate the
coverage-untested-functions file by default. I'm adding more targets
for doing various things with the gcov files, and they shouldn't all
run by default.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 63f3f84..5e9a6a2 100644
--- a/Makefile
+++ b/Makefile
@@ -2299,6 +2299,8 @@ coverage-report:
 	gcov -b -o builtin builtin/*.c
 	gcov -b -o xdiff xdiff/*.c
 	gcov -b -o compat compat/*.c
+
+coverage-report-untested-functions:
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
 		| tee coverage-untested-functions
--=20
1.7.0.4
