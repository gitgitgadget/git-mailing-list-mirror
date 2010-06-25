From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2 1/7] string_list: Fix argument order for print_string_list
Date: Sat, 26 Jun 2010 00:41:33 +0100
Message-ID: <20100625234140.18927.89849.julian@quantumfyre.co.uk>
References: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 01:55:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSIkH-0004gB-ED
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 01:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922Ab0FYXzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 19:55:32 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:39019 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756749Ab0FYXzV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 19:55:21 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 5D1D681AB7A2;
	Sat, 26 Jun 2010 01:20:43 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 254B91EBDAA;
	Sat, 26 Jun 2010 00:45:45 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2dtnrfKFDiWi; Sat, 26 Jun 2010 00:45:44 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 991021EC0CB;
	Sat, 26 Jun 2010 00:45:44 +0100 (BST)
X-git-sha1: 7ec018d359451a10b00540dfad92f8a9461f0061 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149717>

Update the definition and callers of print_string_list to use the
string_list as the first argument.  This helps make the API easier to
use by being more consistent.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 string-list.c |    2 +-
 string-list.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/string-list.c b/string-list.c
index c9ad7fc..b7e57a4 100644
--- a/string-list.c
+++ b/string-list.c
@@ -139,7 +139,7 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 }
 
 
-void print_string_list(const char *text, const struct string_list *p)
+void print_string_list(const struct string_list *p, const char *text)
 {
 	int i;
 	if ( text )
diff --git a/string-list.h b/string-list.h
index 63b69c8..de29dcd 100644
--- a/string-list.h
+++ b/string-list.h
@@ -12,7 +12,7 @@ struct string_list
 	unsigned int strdup_strings:1;
 };
 
-void print_string_list(const char *text, const struct string_list *p);
+void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
 
 /* Use this function to call a custom clear function on each util pointer */
-- 
1.7.0.4
