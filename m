From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 05/10] update-index: move 'uc' var declaration
Date: Tue, 29 Dec 2015 08:09:29 +0100
Message-ID: <1451372974-16266-6-git-send-email-chriscool@tuxfamily.org>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:12:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoSl-0008Us-6E
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbbL2HMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:12:47 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37797 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbbL2HMN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:12:13 -0500
Received: by mail-wm0-f53.google.com with SMTP id f206so31411195wmf.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 23:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aKgJnhgmT0jxat64/W3uiupmSRKgUH+N9bAX8inRZYg=;
        b=SO78neBLTEPzpz1W98ImYfjs5D9WQzVqa25eL65qIuHiln2Eus+gQN1+wAfFe8RbTF
         CEZByLyDKuY9zZnI9X1GV/PUDQG0tXixqbkoa2kzjtA9bcZTpOr0moM2MnVawpkoirfo
         uPbI8fNA8MnbExQpthM2dRuVcuKhvk91MRw+Yoz8JOsXunB6KZRE6YeIZWaJRae/tQcS
         dEkxwdxytLgGeTzYCFDOT3FM7x2NLKalJ/Mx7xTB4N+0LnNSo7zIKGkk0i6LCfYJLclm
         3el4bREEuJB7hHEla4PBTcsx7QXfm8XDKDXzYrsSEZ6b0lEdB3wQ/40hC22QKrBhtVRs
         /CPA==
X-Received: by 10.194.6.98 with SMTP id z2mr61259208wjz.101.1451373132010;
        Mon, 28 Dec 2015 23:12:12 -0800 (PST)
Received: from localhost.localdomain (243.40.126.78.rev.sfr.net. [78.126.40.243])
        by smtp.gmail.com with ESMTPSA id uw6sm59795661wjc.42.2015.12.28.23.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 23:12:11 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.10.g544ad6b
In-Reply-To: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283086>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 369c207..fe7aaa3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1116,8 +1116,6 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
 	if (untracked_cache > UC_DISABLE) {
-		struct untracked_cache *uc;
-
 		if (untracked_cache < UC_FORCE) {
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
@@ -1126,7 +1124,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				return 0;
 		}
 		if (!the_index.untracked) {
-			uc = xcalloc(1, sizeof(*uc));
+			struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
 			strbuf_init(&uc->ident, 100);
 			uc->exclude_per_dir = ".gitignore";
 			/* should be the same flags used by git-status */
-- 
2.7.0.rc2.10.g544ad6b
