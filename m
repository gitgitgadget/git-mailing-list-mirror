From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] git.txt: document GIT_TRACE_PACKET
Date: Sun,  9 Jun 2013 12:53:30 +0700
Message-ID: <1370757210-2994-1-git-send-email-pclouds@gmail.com>
References: <20130609053621.GA1854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 07:52:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlYYI-0007cM-6h
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 07:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000Ab3FIFwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 01:52:13 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:54992 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab3FIFwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 01:52:12 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so179884pdi.13
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 22:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k5EZdS9zvYWWuhyPI7nn1DlBwaZDU/5Ux4BeSdMcFTY=;
        b=ahErMbxPuGs09iexQToIRHjGHTgA7YzCoUv7D/P13W1vT3B4n6bnKIfNkdfJ/klMC7
         IZyyRGkFh2cCoPcUW/hQLu2cMbQZ0NbSO8aGJ5We0/XNL20OqnROFyi/iYErQVCegMRR
         ICXxP7SCADjWsdV0HhDQ9WW6v7KwaPTccQWcu8awxqqnxXXBUvc6MM2aO4ua4RGtX4Xt
         L+bMzTE0VB52id0DJPFs025tEHMwgBPqawRNi7I4NE76TPoZBBOg5UMjQdnBuWgH7Cwv
         wszI/zOoq+h+MWREqlAgzXptSWh2QO78bc/PWUprVcEdhDY/c2afWNwFGBFAvi/V64cF
         AVqw==
X-Received: by 10.68.43.197 with SMTP id y5mr5011515pbl.140.1370757131905;
        Sat, 08 Jun 2013 22:52:11 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id xn5sm9553711pab.0.2013.06.08.22.52.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 22:52:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 12:53:42 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <20130609053621.GA1854@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226888>

"This can help with debugging object negotiation or other protocol
issues."

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 >> +'GIT_TRACE_PACKET'::
 >> + =C2=A0 =C2=A0 If this variable is set, it shows a trace of all pa=
ckets
 >> + =C2=A0 =C2=A0 coming in or out of a given program. This can help =
with
 >> + =C2=A0 =C2=A0 debugging object negotiation or other protocol issu=
es.
 >
 > This is not quite true. It stops showing packets after it sees a pac=
ket
 > starting with "PACK" (optionally with a sideband prefix). So you wou=
ld
 > miss, for example, a sideband error that came after the pack had
 > started. So it is really only useful for looking at the ref and obje=
ct
 > negotiation phases.

 I blindly copied the first paragraph from bbc30f9 (add packet tracing
 debug code - 2011-02-24) and missed the "PACK" bit in the second one.
 How about this?

 Documentation/git.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c760918..c10b647 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -845,6 +845,12 @@ for further details.
 	recorded. This may be helpful for troubleshooting some
 	pack-related performance problems.
=20
+'GIT_TRACE_PACKET'::
+	If this variable is set, it shows a trace of all packets
+	coming in or out of a given program. This can help with
+	debugging object negotiation or other protocol issues. Tracing
+	is turned off at a packet starting with "PACK".
+
 GIT_LITERAL_PATHSPECS::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
--=20
1.8.2.83.gc99314b
