From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] column doc: rewrite documentation for column.ui
Date: Tue, 25 Jun 2013 21:24:36 +0530
Message-ID: <1372175676-5423-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 17:58:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrVd8-0006c6-Sy
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 17:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065Ab3FYP6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 11:58:02 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61917 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab3FYP6B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 11:58:01 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so12756315pad.5
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ZgjTExllkpJBBM/KLP6Gf2sLooAOEtia30Ichk9ntcI=;
        b=xxkKI09dxUHWpdlwPkqKMvt2i03MThPqLQjo1bNUZ7BDgHumnxM+xR2nONmiPzmUqG
         fo2nuaFGMQhgnv+d9sJ6biN3MpmahZdxscYbIjq3ZyJUFnhbihfAzaFNEhe3tKA4dzc4
         vcamTyZWvZlaIOB5q2Gy/zjOE1HhEZx9J9Wm130nxCtJMgceiMeOY1zdsIes2RNqwajc
         i6c6l+OiftbZ9elfwSXD9gxZmopgrEhZAX+DBH+Yu39pmDcYD0ScvbS6gutbU78YmTGS
         NSuZ/458B6arJQXWMELd7c8h5rM+atoQiShI1JOv393d02coGADeDExDiWpofihd/tuo
         Atyw==
X-Received: by 10.68.247.226 with SMTP id yh2mr28384905pbc.164.1372175880792;
        Tue, 25 Jun 2013 08:58:00 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id vz8sm25822929pac.20.2013.06.25.08.57.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 08:58:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.585.g9832cb9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228979>

The configuration option column.ui is very poorly documented, and it is
unclear what the defaults are, and what option can be combined with
what.  Rewrite it by splitting up the options into three sections
clearly showing how COL_ENABLED, COL_LAYOUT_MASK, and COL_DENSE work.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1153585..5a10169 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -934,6 +934,9 @@ column.ui::
 	This variable consists of a list of tokens separated by spaces
 	or commas:
 +
+These three options control when the feature should be enabled
+(defaults to 'never'):
++
 --
 `always`;;
 	always show in columns
@@ -941,19 +944,30 @@ column.ui::
 	never show in columns
 `auto`;;
 	show in columns if the output is to the terminal
+--
++
+These three options control layout (defaults to 'column').  Setting
+layout implies 'always' if none of 'always', 'never', or 'auto' are
+specified.
++
+--
 `column`;;
-	fill columns before rows (default)
+	fill columns before rows
 `row`;;
 	fill rows before columns
 `plain`;;
 	show in one column
+--
++
+Finally, these options can be combined with a layout option (defaults
+to 'nodense'):
++
+--
 `dense`;;
 	make unequal size columns to utilize more space
 `nodense`;;
 	make equal size columns
 --
-+
-This option defaults to 'never'.
 
 column.branch::
 	Specify whether to output branch listing in `git branch` in columns.
-- 
1.8.3.1.585.g9832cb9
