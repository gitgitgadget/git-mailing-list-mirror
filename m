From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 1/3] i18n: Fixes uncatchable comments for translators
Date: Thu, 17 Apr 2014 13:37:17 +0800
Message-ID: <3f527f9939d093c7e063337f47fea41a740899c3.1397712142.git.worldhello.net@gmail.com>
References: <cover.1397712142.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 07:37:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Waf1K-0000Ve-Iw
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 07:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbaDQFhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 01:37:54 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:58734 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060AbaDQFht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 01:37:49 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so11527315pdj.22
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 22:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RU5FTX6W60AIsiRasmwawx7cSvOQg1nsrqhir1ex5v0=;
        b=bovgCRqQL2QPZENcjGKdlTaL0/oX/asuD5Yt959F+//xDbar0ECJWE5lAFRLSjiMZ4
         89WclzrmH8y765x8yhREfB8SFYudtuJ7Ij0fYHt/VVNGKNELCsS3ORFalyKlyD/wBulj
         F1IQb5F7JaQF2a0quCFvXHY8UWSbkVdEorDF/e/oBFrPgDlwhG9GhKbT642xWise93yE
         ytsAXFEcSCHaUqvNfpzq5xS+6H3ZlSqtB9F1DVwmNHrGax2LudnFhzc3AOAJOglwj1zg
         ltz53z7vyOZg8NkLAe4ddsHTvLYx8HPwzfwftn5NaxDWe2imVfoLJjG9w4Gm81EMJJC/
         q+1g==
X-Received: by 10.66.192.41 with SMTP id hd9mr13213153pac.87.1397713067499;
        Wed, 16 Apr 2014 22:37:47 -0700 (PDT)
Received: from localhost.localdomain ([124.207.10.6])
        by mx.google.com with ESMTPSA id n6sm50901640pbj.22.2014.04.16.22.37.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Apr 2014 22:37:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.461.g942803f
In-Reply-To: <cover.1397712142.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1397712142.git.worldhello.net@gmail.com>
References: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com> <cover.1397712142.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246403>

Comment for l10n translators can not be extracted by xgettext if it is
not right above the l10n tag.  Moving the comment right before the l10n
tag will fix this issue.

Reported-by: Brian Gesiak <modocache@gmail.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 date.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/date.c b/date.c
index e1a2cee..782de95 100644
--- a/date.c
+++ b/date.c
@@ -144,8 +144,8 @@ void show_date_relative(unsigned long time, int tz,
 		if (months) {
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
-			/* TRANSLATORS: "%s" is "<n> years" */
 			strbuf_addf(timebuf,
+				 /* TRANSLATORS: "%s" is "<n> years" */
 				 Q_("%s, %lu month ago", "%s, %lu months ago", months),
 				 sb.buf, months);
 			strbuf_release(&sb);
-- 
1.9.2.461.g942803f
