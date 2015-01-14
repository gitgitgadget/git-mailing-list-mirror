From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/10] line-log.c: make line_log_data_init() static
Date: Wed, 14 Jan 2015 15:40:47 -0800
Message-ID: <1421278855-8126-3-git-send-email-gitster@pobox.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:41:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXYn-0002cw-5b
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbbANXlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:41:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751364AbbANXlB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:41:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C028F2DB81;
	Wed, 14 Jan 2015 18:41:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+1re
	pYNgUhfGaA8NOTxMh0C45TI=; b=TcdGWkW2bZNf9xPk/FZnwhmBwN1z2H4cSLrp
	0k+U3iArGVw4vwAdQxnHPzoiDToTw5vU1Xj+CI0BX/hw83W0dzH4fmra5/7b4pXQ
	iOafdn37VLTk98CmlyXdk08oVCQBXWgzckOiDFmZoC2FDFoSJxajdt45INathF+C
	xYoiKKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=VTg84K
	yvHPfWl/8//1mIoWIDTqUgbvC1dUMitJ02xTkMVXLJTouDYchW6a5YEZFM1c5BW5
	Hk7TtmmnKULhZ8+XnV1kpDMF8RcrtBzSBAH891isgZ+ULCn12ul8rX8WC3rj4UZy
	aqmJq4kNYfIIn6Kfliq5YhhsRGhBRzhrDqtgU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABC982DB80;
	Wed, 14 Jan 2015 18:41:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF9C52DB7C;
	Wed, 14 Jan 2015 18:40:59 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc0-134-g109a908
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CB45290C-9C46-11E4-A9B1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262442>

No external callers exist.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 line-log.c | 2 +-
 line-log.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/line-log.c b/line-log.c
index b7864ad..a490efe 100644
--- a/line-log.c
+++ b/line-log.c
@@ -237,7 +237,7 @@ static void diff_ranges_release(struct diff_ranges *diff)
 	range_set_release(&diff->target);
 }
 
-void line_log_data_init(struct line_log_data *r)
+static void line_log_data_init(struct line_log_data *r)
 {
 	memset(r, 0, sizeof(struct line_log_data));
 	range_set_init(&r->ranges, 0);
diff --git a/line-log.h b/line-log.h
index a9212d8..7a5c24e 100644
--- a/line-log.h
+++ b/line-log.h
@@ -54,8 +54,6 @@ struct line_log_data {
 	struct diff_ranges diff;
 };
 
-extern void line_log_data_init(struct line_log_data *r);
-
 extern void line_log_init(struct rev_info *rev, const char *prefix, struct string_list *args);
 
 extern int line_log_filter(struct rev_info *rev);
-- 
2.3.0-rc0-134-g109a908
