From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH 2/5] commit.c/GPG signature verification: Also look at the
 first GPG status line
Date: Tue, 26 Mar 2013 00:46:17 +0100
Message-ID: <5150E1C9.6050400@physik.tu-berlin.de>
References: <7v8v5b1nlp.fsf@alter.siamese.dyndns.org> <cover.1364254748.git.jaseg@physik-pool.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 00:47:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKH6R-0005p6-Gg
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 00:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759035Ab3CYXqV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 19:46:21 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:17876 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757679Ab3CYXqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 19:46:19 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UKH5m-0002r2-EY; Tue, 26 Mar 2013 00:46:18 +0100
Received: from [192.168.0.103] (cable-124-189.zeelandnet.nl [82.176.124.189])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 49E5B11403;
	Tue, 26 Mar 2013 00:46:18 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <cover.1364254748.git.jaseg@physik-pool.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219121>

Signed-off-by: Sebastian G=F6tte <jaseg@physik-pool.tu-berlin.de>
---
 commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 1aeb17a..f53a06d 100644
--- a/commit.c
+++ b/commit.c
@@ -1027,8 +1027,8 @@ static struct {
 	char result;
 	const char *check;
 } signature_check[] =3D {
-	{ 'G', "\n[GNUPG:] GOODSIG " },
-	{ 'B', "\n[GNUPG:] BADSIG " },
+	{ 'G', "[GNUPG:] GOODSIG " },
+	{ 'B', "[GNUPG:] BADSIG " },
 };
=20
 static void parse_signature_lines(struct signature *sig)
--=20
1.8.1.5
