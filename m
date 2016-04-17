From: santiago@nyu.edu
Subject: [PATCH v6 2/6] t7030: test verifying multiple tags
Date: Sun, 17 Apr 2016 18:26:57 -0400
Message-ID: <1460932021-27633-3-git-send-email-santiago@nyu.edu>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:27:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arvAA-00055l-VD
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 00:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbcDQW1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 18:27:15 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33644 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbcDQW1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 18:27:14 -0400
Received: by mail-qg0-f54.google.com with SMTP id v14so17085887qge.0
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F8OBHOiYUCnGlta2b6AkPULnYS1UWvUxOS+qw7qkXdw=;
        b=aeUXkABYa7FszbHZl4UUkK30id8+E3Q/c3viPRK8hoQB7s6pkVHNcAhKljLnZBtJtA
         iKZZx1KX1n8m+gGXQz6iQcFhED9eSHzCd9J4PwqviL9RHrbNYHENq8oS1AO2Hnx7RwGE
         XjtzRghCu+sPSze1ECleQTGr//DMNm0GH1/Wdv3dkNvJ5ciB4hTYQ5fj5aJhEpTOOLaL
         0mTPiVV3yYpAJgZBGjI7qA20Xq7ghQy/W8v8JIMs1vbWshvGGgZJNjEApuI7t6ux3Ugi
         5y6GPK2fLp6q/CXPtWkyR8bFOO3NplTIPPEmP6bAz8AV8h0OREMpuynvsaNpbW6jpQkf
         HUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F8OBHOiYUCnGlta2b6AkPULnYS1UWvUxOS+qw7qkXdw=;
        b=EO1AjiK08sejroiIMrY1lHq3vFKNQfXWfAFnJC59qviSsqapMj65jV7t1KLrKB/YQ8
         CJF4OL5+HFPYlugk8Jx+hrPjJvkLi3ofvx8nOtpvltVorSjGpnpM4ZJuWnyKmotFUnXj
         673v9A0voFEJo53gY4Y93uFg2AdWol0UbCbkiX303Dn5p4T/ZTcQ9niYQEdJ60JuAqH5
         dSRyUej09uEv/iDdmrqb/SKjRh4A0Irse2I5QmrVyc3ia63TOHWrpiDRCtIQilywC3RD
         rpa1ykzTeM+1vxmiRqL+sxynowBKRNUp55MQLq15rMMGMvxUv57krmd/SLcNlrnlE0DE
         sDew==
X-Gm-Message-State: AOPr4FVHQUIeKLDTsofWctq0UmbFMTAMC1N9duiyJKuMwDNjVrnWpSZUs+hTAquriFMw2b+R
X-Received: by 10.140.105.180 with SMTP id c49mr38130754qgf.36.1460932033105;
        Sun, 17 Apr 2016 15:27:13 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id j75sm5120767qgd.19.2016.04.17.15.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Apr 2016 15:27:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291781>

From: Santiago Torres <santiago@nyu.edu>

The verify-tag command supports multiple tag names to verify, but
existing tests only test for invocation with a single tag.

Add a test invoking it with multiple tags.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7030-verify-tag.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 4608e71..07079a4 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -112,4 +112,17 @@ test_expect_success GPG 'verify signatures with --raw' '
 	)
 '
 
+test_expect_success GPG 'verify multiple tags' '
+	tags="fourth-signed sixth-signed seventh-signed" &&
+	for i in $tags
+	do
+		git verify-tag -v --raw $i || return 1
+	done >expect.stdout 2>expect.stderr.1 &&
+	grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&
+	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
+	grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
+	test_cmp expect.stdout actual.stdout &&
+	test_cmp expect.stderr actual.stderr
+'
+
 test_done
-- 
2.8.0
