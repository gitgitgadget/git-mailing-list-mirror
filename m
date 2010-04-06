From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH 1/6] string_list: Fix argument order for print_string_list
Date: Tue, 06 Apr 2010 02:11:33 +0100
Message-ID: <20100406011139.71279.53152.julian@quantumfyre.co.uk>
References: <20100406011106.71279.92681.julian@quantumfyre.co.uk>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 03:28:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyxb3-0007HK-BH
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 03:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756967Ab0DFB2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 21:28:46 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:45397 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756236Ab0DFB2p (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 21:28:45 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 00DB1819C45F;
	Tue,  6 Apr 2010 02:28:39 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 57BA717773B;
	Tue,  6 Apr 2010 02:28:44 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id usCznyOfPD1z; Tue,  6 Apr 2010 02:28:44 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 183B820C8E7;
	Tue,  6 Apr 2010 02:28:44 +0100 (BST)
X-git-sha1: 5c1cbf0ee541f88e896809b5fb2cf2dd8ece7e92 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100406011106.71279.92681.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144076>

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
1.7.0.2
