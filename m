From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] diff.c: mark private file-scope symbols as static
Date: Sat, 15 Sep 2012 14:10:48 -0700
Message-ID: <1347743452-2487-3-git-send-email-gitster@pobox.com>
References: <5054AA62.2040603@ramsay1.demon.co.uk>
 <1347743452-2487-1-git-send-email-gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 23:11:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCzeB-00052v-Oe
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab2IOVLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:11:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373Ab2IOVK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:10:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72B8E855C;
	Sat, 15 Sep 2012 17:10:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=sJBN
	tRMJZ4gJ6iOIldiRCJoCH14=; b=mxHIflrPFDYvCye0jxeoBVuMYcY3Blafh3un
	gCD1BTPtX0zLgZBvz8D1LInAKueM5OohYd2HiuxhfUcLtkTrExk6kxk8Cp7szjAg
	YaSWjI/WzpzQMBklkac8vrNlWH0JIiie9M4DbsVJOG9PVfIsHRHeFifu8n9vXtJc
	PWtaEIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	TXzaOhlAp5St6hM2uxC66hvPH+HK7xp3qeFz7XQxWwjq6V18XzLocDpszDYQzini
	EifJJfDzWEDD0JGkHoGPd44H9iCzEBcV0SkDXWZKq1TtKRC7EYB1GsVxeNgVDctM
	+fClcgH663HjHdiOryQ8L8SoxadBP5jOP3nwlDkE5Zw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 606B6855B;
	Sat, 15 Sep 2012 17:10:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAF47855A; Sat, 15 Sep 2012
 17:10:57 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.508.g4d78187
In-Reply-To: <1347743452-2487-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D7FE6954-FF79-11E1-8790-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205580>

---
 diff.c | 2 +-
 diff.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 32142db..35d3f07 100644
--- a/diff.c
+++ b/diff.c
@@ -25,7 +25,7 @@
 static int diff_detect_rename_default;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
-int diff_use_color_default = -1;
+static int diff_use_color_default = -1;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
diff --git a/diff.h b/diff.h
index e25addb..a658f85 100644
--- a/diff.h
+++ b/diff.h
@@ -243,7 +243,6 @@ extern int parse_long_opt(const char *opt, const char **argv,
 
 extern int git_diff_basic_config(const char *var, const char *value, void *cb);
 extern int git_diff_ui_config(const char *var, const char *value, void *cb);
-extern int diff_use_color_default;
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int);
 extern void diff_setup_done(struct diff_options *);
-- 
1.7.12.508.g4d78187
