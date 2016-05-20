From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v6 2/2] imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
Date: Fri, 20 May 2016 10:37:08 +0000
Message-ID: <20160520103708.38308-3-gitter.spiros@gmail.com>
References: <20160520103708.38308-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, sunshine@sunshineco.com, peff@peff.net
X-From: git-owner@vger.kernel.org Fri May 20 12:38:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3hol-0006QP-Pl
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 12:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933063AbcETKh6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 06:37:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32964 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455AbcETKh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 06:37:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id 67so4883317wmg.0
        for <git@vger.kernel.org>; Fri, 20 May 2016 03:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ylbmv8xm2iwVBHuWYo+1+k1LoASQAchPvT/UCwzxTOE=;
        b=hOC6kah9lU0JOIDHWgQPnbV1a7+QYayLzNd2fbjI1+M/rVM/HU4EY0weriFG/wHwDZ
         L43omxjvWe9Yz4PbKUYiKpmFLaPb+/O/+wySNHj1j3JNpwmsJBnM6hKI6Yhda3SFNHnx
         z0okHmSafuXLj5Z0uskrJPgnArUD2+p2szR0+zyNnJWQB75Y6/vDBfKB5UilZl3T3a8S
         GO/W0xig/rvwuzYaUDlgiUaX6rmn3u1/7pg8Elkmh0jZSDs9d+O9aV6NQ4c1X3oaBvLH
         PShh1i8Kxd3JJFae9X0N61Y4hOC/6xBexnIoCJWoXQ83SpTmfOrU99BriknZdO6eGyyT
         s3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ylbmv8xm2iwVBHuWYo+1+k1LoASQAchPvT/UCwzxTOE=;
        b=Au3w1k1LYH1cXXB6bWhP+PN/7Xd7C5wzOTi00yT9qhdUD0+wG18pnr7nyxGvkwZgYC
         U8jyV0kwcdC/59Ga9Dwv/CMnuGAkd+5X8WoQVa3k7NbfuoVxlGtGQrvAOlNnNM6Upyg9
         LRW8xlfPz4Syui2I5QjU07bdPph8z9V/vQ0Q9xNGourOXpzUpg1i2Wg8k6/ZIYI6dt5n
         t8DChAiwh/cDdfaFCYh3rQeDy4bUUDLKdkwUxuIL3P8Tio9Yh+79FupfJ575Z6VbCfAe
         w090aqt1dCnPgtmHW3y81X5qH7Y5ouZYN+OTtNRXmYbbAmKm3kP0vyOyYHN1vTdH9Jhw
         nymw==
X-Gm-Message-State: AOPr4FWoQofCyBvJDVoCcH10wOzzzcCbwzFee/2ZCLilkkI0NI+PTA9a5sctH9DdnXsmPQ==
X-Received: by 10.194.114.228 with SMTP id jj4mr2538381wjb.121.1463740669202;
        Fri, 20 May 2016 03:37:49 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id k127sm1372659wmf.21.2016.05.20.03.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 May 2016 03:37:48 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.435.g7c6234f.dirty
In-Reply-To: <20160520103708.38308-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295157>

Permit the use of the GIT_TRACE_CURL environment variable calling
the setup_curl_trace http.c helper routine.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 imap-send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/imap-send.c b/imap-send.c
index 938c691..50377c5 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1443,6 +1443,7 @@ static CURL *setup_curl(struct imap_server_conf *=
srvc)
=20
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
+	setup_curl_trace(curl);
=20
 	return curl;
 }
--=20
2.8.2.435.g7c6234f.dirty
