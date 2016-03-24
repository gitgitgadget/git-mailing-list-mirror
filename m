From: Motroni Igor <motroniii@gmail.com>
Subject: [PATCH 1/2] Modified flag field type in rev_list_info struct in bisect.h. There is no need for flag field to be signed, as it is not supposed to be used as decimal.
Date: Thu, 24 Mar 2016 22:41:08 +0300
Message-ID: <1458848469-12663-2-git-send-email-motroniii@gmail.com>
References: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
Cc: Pontifik <motroniii@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 20:41:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajB8E-0005OT-Ku
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 20:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbcCXTlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 15:41:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36214 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbcCXTlR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 15:41:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id r8so4630069lfe.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I32lR6n4Y1NkpoIX2wdDVYodqmGeh3AsIqCaWDw3naE=;
        b=p079xEwbcOlsZ4wadplT8PhX1JyR+hohIZEr5mbKssG6MidknXo80hnklAGxG4rFMo
         NYWeMeKLpsdhKc+3WjSoMhaei4XS9JeitXNLlKVdIXR5OKDSQnZAN8afmbj/ZuaAInML
         uDY66zNX44A5C6Ewr4u4SqSpuMI7FXiMP4ffyD3TbtmTCsZo+9NXbC2y6HmEidx1V4xE
         jf0V23NtfEr/JjuDUZU34ZFVQpPhU9DmW7fyQJZ1ph4MYfyRjIRhREqSUqa9Hl6O5fTy
         w0b4wC1jLSIBqu78nFvDNGfB9cL2DI9aC5zzZtJyy4OkeSLcU220pFOj5+AEd5sAwgaD
         O7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I32lR6n4Y1NkpoIX2wdDVYodqmGeh3AsIqCaWDw3naE=;
        b=CTOjzpvwmgrE4mswea8bq7tNmaL3C+RNm14OJcm8pnADv1JZAymRWzU5W2FdfVW/ht
         GKkRo5ZZvIqYDMAdjsddSXZJ4WoLEF+wjE3QGo79u+U+0RFnWNzpVoDrMF0kDE0mn5Zg
         aVVqBGzc08UUXi1sTTzwaun7twcygIWmAvA0idK9xr3s5MM/qO0UHQcbDENkxz/3TO9V
         DibWtLRVnxD79/avFCZyMNkmWekFFYUaUPjnAP5LPS3EDvuj8MvoOaBTm4lEyQynMpDu
         Hf6Ww5AtRbrgBqK52DJF8OTYDS4MvwNPRFm0Va1vxU8d99ERb1BN7Cl0a5ivOaq+8qJD
         VGDA==
X-Gm-Message-State: AD7BkJJ8V6fgW1vuYE0qs1V4ufXDWSdjc7g1DMyIGB0zB+edqrXtTuItdn8NIdC+UgH8rg==
X-Received: by 10.25.154.65 with SMTP id c62mr4527494lfe.54.1458848475684;
        Thu, 24 Mar 2016 12:41:15 -0700 (PDT)
Received: from localhost.localdomain (ppp91-76-147-218.pppoe.mtu-net.ru. [91.76.147.218])
        by smtp.gmail.com with ESMTPSA id i8sm1390220lbj.30.2016.03.24.12.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 12:41:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289785>

From: Pontifik <motroniii@gmail.com>

Signed-off-by: Pontifik <motroniii@gmail.com>
---
 bisect.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.h b/bisect.h
index acd12ef..a979a7f 100644
--- a/bisect.h
+++ b/bisect.h
@@ -16,7 +16,7 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
 
 struct rev_list_info {
 	struct rev_info *revs;
-	int flags;
+	unsigned int flags;
 	int show_timestamp;
 	int hdr_termination;
 	const char *header_prefix;
-- 
2.5.0
