From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 03/22] argv-array.h: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:40 +0000
Message-ID: <1455194339-859-4-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:39:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqWx-0007te-Ts
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbcBKMjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36108 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcBKMjV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:21 -0500
Received: by mail-wm0-f67.google.com with SMTP id 128so10425993wmz.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XWSRO3cVGF54VdDajiy054sajx3L9tvzVsxVkFaF2H0=;
        b=AR7OjAOL80ULcbxb24qsQluoCZDWOcUEmxcpL077jaQPGS+4LQgbDW5Vt3XyqLNvpO
         JhiPGN7gvmNkuD4aIpMBcJeqNkRXE0l/HJUsr+xUrsd3m9FbB26D/nxi35wc4XTF7JNq
         tckFBcXexo9dp3Cu/IeOeyzLPcE6yscDo6EZz+oClP4uhTbPdQqHIF6ujLMcrFNGapsm
         WuiooWb+we9uNp00NOxNjzTW71a7+RcKXYf65cK9+Oo2+bQwC00jvcN7SiVxCJCvrk7w
         WG0Tnqr6JjOyXueskoDpnzzeoorCemPOk1R4GcH04+ONrnl+sXscuUuFtqfCEXoMo0R4
         87EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XWSRO3cVGF54VdDajiy054sajx3L9tvzVsxVkFaF2H0=;
        b=I1Njp3PeuUTJjku9/AsWU1lKuW5vxQyBwlfLZnH+W1KskVQn1u4eoprJqzBB1F6nQ3
         qG03aVpJFbRmMXGsuCfnYa7ScuuOxUcuO6Gk237DE3K6TnHl8IQxfg8b64IfQpaq2cLo
         nQqkSpO+vMEPqBPByCSIxw61gmfM2Knmmp0cXmrW/cMVaWcoGdEzaHbi/fC9ygYQIb2Q
         ljHMExxh/2TZEKA99E4g8d+TT53XiQg4SoRQHURRG6hoJDGo+b+HEml/Y9ApD1Qp9oKb
         VHsdzHxFJh/PgHud7GiE3Qy17oJ3eC0kCWoiHscZ/IjUoUjYnd9R7O0FHoZ0EWJVI/+i
         pJhQ==
X-Gm-Message-State: AG10YOSVWnt+p0o7t9ouHnymiN5rtVa7zB5SvSxdKLD3/s5lPebd6YK9iOMZyFu/wReiXQ==
X-Received: by 10.194.158.73 with SMTP id ws9mr51620298wjb.40.1455194359995;
        Thu, 11 Feb 2016 04:39:19 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:19 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285958>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 argv-array.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/argv-array.h b/argv-array.h
index a2fa0aa..e303dfd 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -13,7 +13,7 @@ struct argv_array {
 
 void argv_array_init(struct argv_array *);
 void argv_array_push(struct argv_array *, const char *);
-__attribute__((format (printf,2,3)))
+FORMATPRINTF(2,3)
 void argv_array_pushf(struct argv_array *, const char *fmt, ...);
 LAST_ARG_MUST_BE_NULL
 void argv_array_pushl(struct argv_array *, ...);
-- 
2.5.0
