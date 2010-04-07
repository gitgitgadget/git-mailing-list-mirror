From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 resend 1/2] http: make end_url_with_slash() public
Date: Thu,  8 Apr 2010 00:01:06 +0800
Message-ID: <1270656067-688-1-git-send-email-rctay89@gmail.com>
References: <p2ube6fef0d1004070857j874c2b60z6a4794d472b0ee8a@mail.gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 18:01:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzXh6-0003dk-PZ
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 18:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034Ab0DGQBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 12:01:25 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:43812 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0DGQBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 12:01:25 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so971657bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=d7zgcZl6IbcD4RDGP6rWPNGdkNHl4za0eP3yRXvpP7Y=;
        b=TG7+DQml2Q4+HSm0tm77j6h5zlBGy0yOs1RBJtWpz3FjZk9rYzr/5dLIDB20abcKFb
         P9qRl9YUUyNSllljOs96GgzNJkDahJGhkcq9Hru4gTduAy9uy4EIaPGrCZffNELkeGQp
         SZGG+uJWnS3PEayL2w7wV8BPE6qdgu/wU4LzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ffw/qPMfrS0pKAQYsDibyv9oiM9SUkG1zgX4KnA7EX65uvUv2hwQ9BoNgzqvdjuHrM
         YyO1IzKK245Iyh42H7ARakXN5k6V+8b2jggIXpP6O5nEtiZLps8AcDhrp6vgofDgC2Yn
         454yEPtc7b8UIyzOeia9+Yyqd9dUtyfP3UYow=
Received: by 10.204.6.212 with SMTP id a20mr1625422bka.22.1270656083181;
        Wed, 07 Apr 2010 09:01:23 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id 14sm7039360bwz.6.2010.04.07.09.01.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 09:01:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <p2ube6fef0d1004070857j874c2b60z6a4794d472b0ee8a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144242>

---
 http.c |    2 +-
 http.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 51253e1..07a03fd 100644
--- a/http.c
+++ b/http.c
@@ -720,7 +720,7 @@ static inline int hex(int v)
 		return 'A' + v - 10;
 }
 
-static void end_url_with_slash(struct strbuf *buf, const char *url)
+void end_url_with_slash(struct strbuf *buf, const char *url)
 {
 	strbuf_addstr(buf, url);
 	if (buf->len && buf->buf[buf->len - 1] != '/')
diff --git a/http.h b/http.h
index 2dd03e8..37a6a6a 100644
--- a/http.h
+++ b/http.h
@@ -117,6 +117,7 @@ extern void append_remote_object_url(struct strbuf *buf, const char *url,
 				     int only_two_digit_prefix);
 extern char *get_remote_object_url(const char *url, const char *hex,
 				   int only_two_digit_prefix);
+extern void end_url_with_slash(struct strbuf *buf, const char *url);
 
 /* Options for http_request_*() */
 #define HTTP_NO_CACHE		1
-- 
1.6.6.1368.g82eeb
