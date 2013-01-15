From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] test-lib.sh: unfilter GIT_PERF_*
Date: Tue, 15 Jan 2013 19:53:29 +0700
Message-ID: <1358254409-15187-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 13:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv61I-0004wC-TK
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 13:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab3AOMxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 07:53:16 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:51372 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab3AOMxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 07:53:15 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so26809pbb.15
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 04:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=vJnRW3+ZZ51mnZBHImEjFdA3lVuZk9s7A4tlk0dyejM=;
        b=Bc9MBEKknsVmtEANk+/tsUW51fKZkcUgdaccI7j4gCxr9qnywHMgl4+uv9Piy2tsXV
         FVYgEk5AMqGHwPJ9AMSNe1O6rHgi1hogzbumOukBoYtr7iyqM56rGshmqG60V3fZLCP5
         Tqp4hpdTePRlLplmld2D0EoYN9Fa24W8rCep14YIfoRberFtbXXoGFI+BNHddbkkegWg
         zNVb9Eow2CZ4JwIvczZ7ojxnWAJf2UQzYbP5giQQk0ZNLQqYqlgdzjzmEp46jaIBmajq
         4n79l/cI6COoxZoIMJzBvVc5UhQMmvRk7CSwuW22gQducLGAwxjbQy9c3NdaVqoJLdRm
         XYtQ==
X-Received: by 10.68.236.100 with SMTP id ut4mr268305909pbc.92.1358254394801;
        Tue, 15 Jan 2013 04:53:14 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id wh4sm4722820pbc.18.2013.01.15.04.53.11
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 04:53:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 15 Jan 2013 19:53:31 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213631>

These variables are user parameters to control how to run the perf
tests. Allow users to do so.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/test-lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f50f834..b8d35d1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -86,6 +86,9 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e=
 '
 		PROVE
 		VALGRIND
 		PERF_AGGREGATING_LATER
+		PERF_LARGE_REPO
+		PERF_REPEAT_COUNT
+		PERF_REPO
 	));
 	my @vars =3D grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
--=20
1.8.0.rc2.23.g1fb49df
