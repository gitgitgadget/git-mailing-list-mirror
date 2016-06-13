From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] lib-httpd.sh: print error.log on error
Date: Mon, 13 Jun 2016 19:35:09 +0700
Message-ID: <20160613123509.22412-1-pclouds@gmail.com>
References: <20160613115608.GA5652@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 14:35:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCR5l-0007o1-1Y
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 14:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbcFMMfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 08:35:34 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36034 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161105AbcFMMf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 08:35:29 -0400
Received: by mail-pa0-f66.google.com with SMTP id fg1so10458515pad.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XCYke/FxZXAcIIs+Gea1xIu/KqcXIfsrG9EhtCbAScA=;
        b=UsN+EYwALYofrdCD0TXnChZGd0fCyV6ihkbDFsRgBOHg9gTMRPYZGBcexgHt8xfLy6
         GODlko8WwWxRUnA7cQ6uzGnuqNem4mxBBXxjNAEkpwvBt8RFG+dgSp1XmDOEbO/F7BRM
         GA2z9mq2CJSqgfRMyYJZG/jF0pNExeMi1YWH3orF213zu1CKpu7ui6TAuZ8SrFBq5yrY
         vGP9dWHDVp1wwivWiAKhLSejdEuqgLnciqrqsyzJaEf5XhW0odclUPL9ZwYEIqgNKmfV
         XIdGh9Nh8QaYiAYlqgcaeW+5/UklmWzXwf6mnXj3DxkOl4DSUhUHTMD1Li2RHGHiHI5H
         Jjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCYke/FxZXAcIIs+Gea1xIu/KqcXIfsrG9EhtCbAScA=;
        b=QY1RYlu+isMOnzeFIQECBXvODmqImOVZCVBC3bHXmL3gJgiFiYq3TgUOibOIdSrxj+
         FqbL4G36a2WYprlb3/xaXU9Wusjy6D+lkgCNQKlI9R+xXPo/RcgcOPqEj++EuzCf9oCd
         WQi2CLhzrLT/W0b/O5FZK6P2I1MM0FZmo5hJB20zrBMsH5UgwtAPVU1xS9dNYTZZfJ7g
         7gysKtI+5+pKgGQJPECi7LRlpJ69eaPzZdiqsH/Q6xDcuz4s8KzDVrGx6svfjR4zvj2g
         VBFmbv+N2hbZyfkOg4w7iga86FFwNTGbyQkdGeayVRsqBJid79xPl8MlpnPMdCqR54Fd
         JlVw==
X-Gm-Message-State: ALyK8tKaYcrOYG6pLIj01n1+udUbvMqwE1DQjSPb7Evb4CgVm0T3LwKa0P96wb4xZaPraQ==
X-Received: by 10.66.237.175 with SMTP id vd15mr21421307pac.139.1465821328452;
        Mon, 13 Jun 2016 05:35:28 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id 7sm37565348pfn.30.2016.06.13.05.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2016 05:35:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Jun 2016 19:35:24 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160613115608.GA5652@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297189>

=46ailure to bring up httpd for testing is not considered an error, so =
the
trash directory, which contains this error.log file, is removed and we
don't know what made httpd fail to start. Improve the situation a bit,
print error.log but only in verbose mode.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Redirect stdout to "verbose stderr" instead of testing $verbose.

 t/lib-httpd.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index f9f3e5f..ac2cbee 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -180,6 +180,7 @@ start_httpd() {
 	if test $? -ne 0
 	then
 		trap 'die' EXIT
+		cat "$HTTPD_ROOT_PATH"/error.log >&4 2>/dev/null
 		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
 	fi
 }
--=20
2.8.2.524.g6ff3d78
