From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv3 1/3] git.txt: document the new GIT_TRACE_CURL environment variable
Date: Wed, 20 Apr 2016 16:28:23 +0000
Message-ID: <20160420162825.62380-2-gitter.spiros@gmail.com>
References: <20160420162825.62380-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 18:28:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asuzV-0000N1-No
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 18:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbcDTQ2f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 12:28:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36486 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbcDTQ2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 12:28:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id l6so15195253wml.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDDx9CBc5DKVo1EBKW6OT4PzgTcTLnZskYEnTHdhNRk=;
        b=eOlnMqjE5/wOFAyGbuJgpUobqWtNPm6pvflqPIrFxD1HmYdiLF1G3dNEAgCwMKpEPP
         h8wuXKxReNZWWXOyjCFG5QN8uqT7TAarHBuPNSf1d5eqNxVRxq7EvBdE4R4T9exarlVT
         jWvzwZ/LCciN40cLsNg3JCNFPACMMrEi2QCVz2HoViy0TxTlAtP8UeKWB4xF6LcvSlbA
         viJzFrSFgf+NG5d1yw/L2MmJzH8uqknuJvKqSjiZaAouLQ0T9p03I56A0z+csQCuRJ9Y
         EWOPsMFfimCxSMGnjE6SpNFQGxI5xtBXiavdnQaIxF4yQY61OJTo+vIKIsqgJ3CTUclA
         WuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDDx9CBc5DKVo1EBKW6OT4PzgTcTLnZskYEnTHdhNRk=;
        b=A1wUuvVNcm59xGMp7AJ8HO2ipOYWTMov22hTHSygY6mtNqtqzr9M6hh6nC28XptIaV
         BRRGG6YfpAtK+ynHNp2Ph+uM0AnLrxdUBHlYhzPzqsL5MRb/9aiSfUZr8GbHsMiIERDf
         SbxkuOl1/F6dXUkWrF3Hud8CmlTgfoTcFMwYJjZxhiY2+MLRDbbyzDmkYn8muezpiCN/
         o0ydoAo9a5OwnpOJGoqviuyIiELDtqnNIuBVZvhu1eZkxOzGQGS/MAHDLiIB35PmX/4x
         E3ZPL7+XVwTsqugiugQ7DZnOdlNOjb5qgoDE/zBpO15jyrLiRsoyguU4v/XFBopkY9fx
         0mQA==
X-Gm-Message-State: AOPr4FXmiEybuBthwD8hYObEPDzaniVKtQfm5t5WUCIoQVgo3GQDZRNmvojbsSkx02r8Jg==
X-Received: by 10.194.95.167 with SMTP id dl7mr9697276wjb.163.1461169710861;
        Wed, 20 Apr 2016 09:28:30 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id qt3sm6368445wjc.32.2016.04.20.09.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 09:28:30 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.383.g31b84cc
In-Reply-To: <20160420162825.62380-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292041>

Describe the purpose of the GIT_TRACE_CURL environment variable.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Documentation/git.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8afe349..958db0f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1075,6 +1075,14 @@ of clones and fetches.
 	cloning of shallow repositories.
 	See 'GIT_TRACE' for available trace output options.
=20
+'GIT_TRACE_CURL'::
+	Enables a curl full trace dump of all incoming and outgoing data,
+	including descriptive information, of the git transport protocol.
+	This is similar to doing curl --trace-ascii on the command line.
+	This option overrides setting the GIT_CURL_VERBOSE environment
+	variable.
+	See 'GIT_TRACE' for available trace output options.
+
 'GIT_LITERAL_PATHSPECS'::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
--=20
2.8.1.383.g31b84cc
