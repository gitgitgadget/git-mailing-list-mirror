From: Vietor Liu <vietor@vxwo.org>
Subject: [PATCH] imap-send.c: fix pointer to be const
Date: Wed, 28 Oct 2009 13:09:51 +0800
Message-ID: <1256706591-2763-1-git-send-email-vietor@vxwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 06:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N30kN-0003KT-QM
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 06:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292AbZJ1FGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 01:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757273AbZJ1FGq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 01:06:46 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:57736 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562AbZJ1FGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 01:06:45 -0400
Received: by yxe17 with SMTP id 17so376953yxe.33
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 22:06:50 -0700 (PDT)
Received: by 10.150.29.5 with SMTP id c5mr14576161ybc.34.1256706409811;
        Tue, 27 Oct 2009 22:06:49 -0700 (PDT)
Received: from localhost.localdomain ([123.113.74.202])
        by mx.google.com with ESMTPS id 6sm272089ywc.24.2009.10.27.22.06.46
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 22:06:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131404>

=46ixes some compiler warnings:
imap-send.c: In function =E2=80=98ssl_socket_connect=E2=80=99:
warning: assignment discards qualifiers from pointer target type

Signed-off-by: Vietor Liu <vietor@vxwo.org>
---
 imap-send.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3847fd1..10dd025 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -273,7 +273,7 @@ static int ssl_socket_connect(struct imap_socket *s=
ock, int use_tls_only, int ve
 	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
 	return -1;
 #else
-	SSL_METHOD *meth;
+	const SSL_METHOD *meth;
 	SSL_CTX *ctx;
 	int ret;
=20
--=20
1.6.5.2
