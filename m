From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 41/47] t1020-subdirectory: test alias expansion in a subdirectory
Date: Fri, 26 Nov 2010 22:32:37 +0700
Message-ID: <1290785563-15339-42-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:49:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Y9-0000nz-3q
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265Ab0KZPtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:49:19 -0500
Received: from mail-pw0-f66.google.com ([209.85.160.66]:39840 "EHLO
	mail-pw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab0KZPtS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:49:18 -0500
Received: by mail-pw0-f66.google.com with SMTP id 5so469831pwj.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CEKOa56h9zfAbaxe2hC6aZCof0TqmQP8Sxe1uRn6YTQ=;
        b=OyDv0vxXZPBEX2V3Byy/+bfJi++EdfQffZyeAf7AXQt3ubOFJiCZ4PLuNDV5dkKflC
         S1MCTO8EPJSyPLorfMn3tgaocGrPKD554Gn+03XC1iDZ8cJ535ou2IhRD2Cavm8XaZFc
         BdS76gNEdWhOC5Mp8MqDWhmqIFb4SE64etb7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xHnAZvVVVv7JNF1jCeCNpy4N2fdL/B0MoXFzQiVlQX/0mzYIyE/NYJQ3awRef0kBr7
         MBu4vm7jfbC09ZK0LOlw4jdIDyZN6ykQ5herWrR0cxozJ/NWP2VdL8Q7LijgqFnaRRGx
         kZ42wMfklml48PZBq5pruP/TVNyY8UVnEi1eU=
Received: by 10.142.134.2 with SMTP id h2mr2526677wfd.332.1290786558751;
        Fri, 26 Nov 2010 07:49:18 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id p8sm2694189wff.4.2010.11.26.07.49.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:49:17 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:48:05 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162252>

=46rom: Michael J Gruber <git@drmicha.warpmail.net>

Add a test for alias expansion in a subdirectory of the worktree.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1020-subdirectory.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index a3ac338..1fd187c 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -110,6 +110,14 @@ test_expect_success 'read-tree' '
 	)
 '
=20
+test_expect_success 'alias expansion' '
+	(
+		git config alias.ss status &&
+		cd dir &&
+		git status &&
+		git ss
+	)
+'
 test_expect_success 'no file/rev ambiguity check inside .git' '
 	git commit -a -m 1 &&
 	(
--=20
1.7.3.2.316.gda8b3
