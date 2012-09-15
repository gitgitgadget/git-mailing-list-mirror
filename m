From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] rerere.c: mark private file-scope symbols as static
Date: Sat, 15 Sep 2012 14:10:51 -0700
Message-ID: <1347743452-2487-6-git-send-email-gitster@pobox.com>
References: <5054AA62.2040603@ramsay1.demon.co.uk>
 <1347743452-2487-1-git-send-email-gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 23:11:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCzeC-00052v-7l
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab2IOVLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:11:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373Ab2IOVLE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:11:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AD0C856F;
	Sat, 15 Sep 2012 17:11:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yaUH
	95+uZ0nV9X33eZJmHBIe15w=; b=JKFHtiH3HmfLikrYADRT+b2O1bhQqcl7Hrx9
	eJw7jDezjQs5iEwGdkPVGrDQMMxu7SShr0pD9sQsKh4spNRacPTuXhBl1qgTBjeL
	mApHq79uqkcs8akrVGnnM/wIQTq5tKxPus/WG5ZEEc0gxTqVp9LLvAZIVaLf6nf2
	WSqa0Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	nwkah/K8VWLrFSfTByLzrcV3grbd6BEUBkerWC60p+QMUYSaNiw0EXSq6dwbfb6s
	NtMEl7+FUIqqiIA7PUxbtnF/kJ997JGcXTx6ivP1xLS2DNLSZRGV6yauHqHb5Tzo
	blKpTq7jjlxwsCCKtaQXDrEewNHEI8rclXSpVkhzJhI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 666D3856E;
	Sat, 15 Sep 2012 17:11:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C72AD856B; Sat, 15 Sep 2012
 17:11:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.508.g4d78187
In-Reply-To: <1347743452-2487-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DB998BAC-FF79-11E1-8256-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205579>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 2 +-
 rerere.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/rerere.c b/rerere.c
index b57a34d..a6a5cd5 100644
--- a/rerere.c
+++ b/rerere.c
@@ -25,7 +25,7 @@ const char *rerere_path(const char *hex, const char *file)
 	return git_path("rr-cache/%s/%s", hex, file);
 }
 
-int has_rerere_resolution(const char *hex)
+static int has_rerere_resolution(const char *hex)
 {
 	struct stat st;
 	return !stat(rerere_path(hex, "postimage"), &st);
diff --git a/rerere.h b/rerere.h
index fcd8bc1..156d2aa 100644
--- a/rerere.h
+++ b/rerere.h
@@ -16,7 +16,6 @@ extern void *RERERE_RESOLVED;
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
 extern const char *rerere_path(const char *hex, const char *file);
-extern int has_rerere_resolution(const char *hex);
 extern int rerere_forget(const char **);
 extern int rerere_remaining(struct string_list *);
 extern void rerere_clear(struct string_list *);
-- 
1.7.12.508.g4d78187
