From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/3] builtin/apply: get rid of useless 'name' variable
Date: Tue, 22 Mar 2016 21:58:40 +0100
Message-ID: <1458680322-17681-2-git-send-email-chriscool@tuxfamily.org>
References: <1458680322-17681-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 22:06:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiTVs-00013t-Hh
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbcCVVGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:06:43 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36372 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbcCVVGj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:06:39 -0400
Received: by mail-wm0-f43.google.com with SMTP id r129so111000295wmr.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Em9nsBXxKbJ77XjQiMIiLDqzfwqaHMYCFEG8/F1Oe7g=;
        b=SKdp4C135DpGmHyhM6on/se0hz2radh3ojzATBmqkhTP+b4nXoZM7WAZz2iMLJCHeV
         fftcb2X4lyi/VA3KwcvU2O/oqp1A09ZVzBmrJBeUWLsM0HszU/oIW3HnfOsmlpW/a26a
         MY+OQhy6f5lFa//Ni62q5cg8tVdfpOTguUi0iqjW/u9xdSeb+ZsLVKotLK3UucYLbx/i
         1Ihite4iEILm7vWFO8WjbRWQMFdtFsqZLJAEfZp/Wnt/HokbFBPpYyh3VwSAsrtwuOis
         cPrGMMsTxyNWbZOgHmpVd8Mi2vDj3KbMkz4JLsSUuHh4rz3Pt6rcbahHeKkXScAgo7w4
         EP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Em9nsBXxKbJ77XjQiMIiLDqzfwqaHMYCFEG8/F1Oe7g=;
        b=EV7awaI5x1NoWdUfZ113Mk2HWE6BEkEKqkFuSxsFT8y3WBPNYMaQKmOkAbYDZu/0XT
         gaGoh5MfUL0XDAOb56i+UcSU6wbxgY2UFqvCzaSLIsO0R0tHObwYEIG6XuLpMQsynU7V
         IEYWN/mC5B07RKeWUHBnf/QEb04CK3/74tRtdPlQEjomiTS/cJ+tLdRYvWEtbaZrniYO
         5Op7Ru/Y9QNNnGr5dBz2rwtif+jlzlNzPweBHuzE/7Tr3yS2R7DQfKYrZFwaro8yTsC6
         hNY7qrYLj0pM5AjWgpXV/vL4EZvQGS6c1C6x1N5NiSv3er43ifTOrSz/BgUuCVw9LYgY
         Nfhw==
X-Gm-Message-State: AD7BkJKrSzsYEHjhz2jfawVtoaBfvdr8YilXQ9NtM98U7tS+Ia93lOOv9CaO2wgdfjMb8g==
X-Received: by 10.194.92.68 with SMTP id ck4mr37890560wjb.144.1458680797841;
        Tue, 22 Mar 2016 14:06:37 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id i5sm31920087wjx.15.2016.03.22.14.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 14:06:37 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc4.59.g21809a1
In-Reply-To: <1458680322-17681-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289561>

While at it put an 'else' on the same line as the previous '}'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 42c610e..465f954 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -931,22 +931,19 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 		return find_name(line, NULL, p_value, TERM_TAB);
 
 	if (orig_name) {
-		int len;
-		const char *name;
+		int len = strlen(orig_name);
 		char *another;
-		name = orig_name;
-		len = strlen(name);
 		if (isnull)
-			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"), name, linenr);
+			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
+			    orig_name, linenr);
 		another = find_name(line, NULL, p_value, TERM_TAB);
-		if (!another || memcmp(another, name, len + 1))
+		if (!another || memcmp(another, orig_name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
 			    _("git apply: bad git-diff - inconsistent old filename on line %d"), linenr);
 		free(another);
 		return orig_name;
-	}
-	else {
+	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
 			die(_("git apply: bad git-diff - expected /dev/null on line %d"), linenr);
-- 
2.8.0.rc4.1.g302de0d.dirty
