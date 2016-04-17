From: santiago@nyu.edu
Subject: [PATCH v6 3/6] verify-tag: change variable name for readability
Date: Sun, 17 Apr 2016 18:26:58 -0400
Message-ID: <1460932021-27633-4-git-send-email-santiago@nyu.edu>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:27:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arvA1-000518-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 00:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbcDQW1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 18:27:16 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36681 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbcDQW1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 18:27:14 -0400
Received: by mail-qg0-f46.google.com with SMTP id f52so107442702qga.3
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8yBFoL5IqIRtOMOzXCF/vg3n4iS15QfT7d0/vIs0UwY=;
        b=dceH4ZUQ0bMNSNyZw9eCQl0sJgP0ubB1ylDEjpu2RpjJ3NwOXa3Ik9nY5ZLt8i7Tmk
         bB8JsyPMdr/GNvpmK9veH9rnROSd7p+RtwPNf6vrlq1dJt+zmiMgDaB8L200tG10vZm2
         vCKoDTGSkXxqatsSFZR4arexRZlM6oAKXV0RLZ5XC9n1MoMtaQSty2SawjSwMA02VF7q
         fPU3gEIg7CRpuBbcPrn3SJS2D8lYlJVRqeKMAvxRYKF7x3NE74Rt8oAnXs6Yd7ISAVBT
         jVGHB2KQcYcrpxRHiJWgviA6P6MQm9nZI07TX853gMHCJk7IbD2Lut9VHJN6dfdD3Tpf
         nKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8yBFoL5IqIRtOMOzXCF/vg3n4iS15QfT7d0/vIs0UwY=;
        b=YhLypB9QkXc8w5ygOIY0wjAQgZZZH1NR0QTVqwFtJolmTyK1xRz6KPsUMF0vieB0/w
         D6u7uqQI/ljVPTbN/CsWa0Qab/5pp4QPCgmI3XEfIXOs0Gutf+A51AM8ab1+1sZ/KQ0r
         NbaV4zwwyygCO+m7S1oxrbzRZHxjBNgWzQJ1q8j8nVGQAxYEwvPT20GZUJeYqK9DsLk0
         eHoxHHfpPK142AVg9klSWo5kZ9ySno8XP1MaI3N7SyK5xxZbI68X6AmiPA6G+ZpKwBv7
         VzU1xdK+Q9Spp21Wbb1AYHa1aJFxXWP00oLNw+xduTyRaxOdLQtWodQvIdVfe4Wvyt5C
         6BTg==
X-Gm-Message-State: AOPr4FUG6KtPT4MJykok8tTwfelek9gQ+HwZpbn/I7oUPX5hSSyW/9TPx7vYJH4ou4l9xFu9
X-Received: by 10.140.97.202 with SMTP id m68mr38399054qge.102.1460932033717;
        Sun, 17 Apr 2016 15:27:13 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id j75sm5120767qgd.19.2016.04.17.15.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Apr 2016 15:27:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291777>

From: Santiago Torres <santiago@nyu.edu>

The run_gpg_verify() function has two variables, size and len.

This may come off as confusing when reading the code.  Clarify which
one pertains to the length of the tag headers by renaming len to
payload_length.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/verify-tag.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 77f070a..010353c 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -21,20 +21,21 @@ static const char * const verify_tag_usage[] = {
 static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 {
 	struct signature_check sigc;
-	int len;
+	int payload_size;
 	int ret;
 
 	memset(&sigc, 0, sizeof(sigc));
 
-	len = parse_signature(buf, size);
+	payload_size = parse_signature(buf, size);
 
-	if (size == len) {
+	if (size == payload_size) {
 		if (flags & GPG_VERIFY_VERBOSE)
-			write_in_full(1, buf, len);
+			write_in_full(1, buf, payload_size);
 		return error("no signature found");
 	}
 
-	ret = check_signature(buf, len, buf + len, size - len, &sigc);
+	ret = check_signature(buf, payload_size, buf + payload_size,
+				size - payload_size, &sigc);
 	print_signature_buffer(&sigc, flags);
 
 	signature_check_clear(&sigc);
-- 
2.8.0
