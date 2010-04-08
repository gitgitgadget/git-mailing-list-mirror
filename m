From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 2/3] http: make end_url_with_slash() public
Date: Thu,  8 Apr 2010 10:15:17 +0800
Message-ID: <1270692918-4300-2-git-send-email-rctay89@gmail.com>
References: <1270656067-688-2-git-send-email-rctay89@gmail.com>
 <1270692918-4300-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 04:15:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzhHY-0003Hm-0l
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 04:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab0DHCPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 22:15:45 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:39591 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0DHCPf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 22:15:35 -0400
Received: by qyk9 with SMTP id 9so1957959qyk.1
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 19:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=baNzlyuuAWXX03jdCv9WhgxxTv8GzJOIxZj2bx5tvNw=;
        b=Lzk107bYG+DSrJiGuqFR+iFsLnKTE1YrQtRaa633SIPJtrai4xicGfrOUmhSSqCv20
         nY5RFXI07dBB2WnlyNFa7aqCWtwnyhddaeWw9TN82Al9AFDuR9ghhpH2Q2tAiXLPryKj
         HehAOqvKHXqWyu1zDsIep0bR3cBpmTurEiKU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M1zqSDUON8W/ZFxt0zD36U36Xn79COM80IZD2L7BMrlS0fkMKWIgY1pfW/mg7E1a/2
         W7pZlf8nP6u7sdVqHAK3ZAny5tXo9FCzbSJquiLCzO2SAIglueoRhn91bMZp4ewlmqOl
         lbnfa7VNwBzuTrv29EcXJcVniuhOnQgx5qhJQ=
Received: by 10.229.218.21 with SMTP id ho21mr3619308qcb.79.1270692934409;
        Wed, 07 Apr 2010 19:15:34 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id v26sm8664223qce.13.2010.04.07.19.15.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 19:15:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1270692918-4300-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144307>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
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
