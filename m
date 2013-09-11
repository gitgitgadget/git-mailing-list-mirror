From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/21] pack v4: add a note that streaming does not support OBJ_PV4_*
Date: Wed, 11 Sep 2013 13:06:11 +0700
Message-ID: <1378879582-15372-11-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:08:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdb3-0006AH-Cs
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab3IKGII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:08:08 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39823 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab3IKGIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:08:06 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so8743809pdi.13
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8Q6EVV3ymIwMPF1RS2HLVpY28CyKtTxwdoCXUpFy15o=;
        b=mXuuF/lNHjdBPmoBhI9IdkzlGH+oOYGETBYWpk7Ly9tkQ2mbVrakL6GgsXFGz6GE66
         8hatGT8djO/eIS0aHSDizc5KE6V4u7LXDPUz3cFkCFFVR45X+rErcfSfB33NRe4n3sXn
         HDI/AaaJjA+esR/T+j3pu+0jQGGRnUFKs2tzlEOs/UA5+NdoXvQJ2ssB68BYxQ3hvBnQ
         T4KvxKoHQrlAfukH8qJw6fH+snErYb1EiC823iUduLpfMk5+WsiHIczXkd/B1cE7C/gg
         DNvR/JqgmMNu42Dz8NeszYiEswUsf3TB98nwmA/RjfSfICdFcesckRjfssZlD6uF8N1A
         IBDA==
X-Received: by 10.66.243.196 with SMTP id xa4mr1270368pac.174.1378879686327;
        Tue, 10 Sep 2013 23:08:06 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id zq10sm1112765pab.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:08:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:07:58 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234534>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 streaming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/streaming.c b/streaming.c
index debe904..c7edebb 100644
--- a/streaming.c
+++ b/streaming.c
@@ -437,7 +437,7 @@ static open_method_decl(pack_non_delta)
 	unuse_pack(&window);
 	switch (in_pack_type) {
 	default:
-		return -1; /* we do not do deltas for now */
+		return -1; /* we do not do deltas nor pv4 types for now */
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
--=20
1.8.2.82.gc24b958
