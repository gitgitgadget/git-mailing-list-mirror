From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 5/5] name-hash.c: rename to name_compare()
Date: Wed, 18 Jun 2014 11:45:17 -0700
Message-ID: <1403117117-10384-6-git-send-email-jmmahler@gmail.com>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 20:46:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxKsL-0007SQ-1e
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 20:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbaFRSqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 14:46:16 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38621 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339AbaFRSqP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 14:46:15 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so1018278pbb.8
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QaD24kxASX0qVyrQkxt9bdTwaei56LlOK4TySvguzQI=;
        b=w2WDqKpxiHmT8TO8zmWRT2nW0mbPEt/TO5XIPS3S72Cpr8QJlxoLq+bcJUzoqKtc61
         9uUxyy9vtW3ppfC6e12TEdTiRWmxbT5iJeS+4kjQu8vi7amT9RWMSVe2vId3T2wC+Yz9
         qbYD7ki4Rz577zWxvF1z4Qi4qf9+dW5ye1EOTjVnhGRWCDWXjm6N4QRmhMlXb+OS1uAr
         mQjTe7Aw0LecAI7OqVlqUhSkiuQC/rngM8y1wPEbHpNb+AHE0OteCdmmL454ii88vnOS
         wh4yGEohdI6asGKK6GQbjdYbS2qYAdlpPk55rujXIWvyqd1krGNF+Ee/zq3o14VYdzAE
         fiEQ==
X-Received: by 10.68.171.229 with SMTP id ax5mr4363157pbc.125.1403117174843;
        Wed, 18 Jun 2014 11:46:14 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id kq10sm4642188pbc.90.2014.06.18.11.46.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jun 2014 11:46:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.697.g57b47e0
In-Reply-To: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252023>

Rename the call to cache_name_compare() to name_compare().

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 name-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/name-hash.c b/name-hash.c
index be7c4ae..e2bea88 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -179,7 +179,7 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	 * Always do exact compare, even if we want a case-ignoring comparison;
 	 * we do the quick exact one first, because it will be the common case.
 	 */
-	if (len == namelen && !cache_name_compare(name, namelen, ce->name, len))
+	if (len == namelen && !name_compare(name, namelen, ce->name, len))
 		return 1;
 
 	if (!icase)
-- 
2.0.0
