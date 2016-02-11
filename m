From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 02/22] advice.h: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:39 +0000
Message-ID: <1455194339-859-3-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqYH-0000cq-Pk
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbcBKMjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:21 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33806 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbcBKMjU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:20 -0500
Received: by mail-wm0-f66.google.com with SMTP id p63so10438077wmp.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4mwhH+5lRASgBmDVjgFlw+MCEEmhj+lno3Pozq0noic=;
        b=LPRLKqm2+8oYaOJ9QbqXQUTNtlJcVzA/5li/9JURUHj8dBcMrP5BW8f/F+FRG714DS
         7hk6Cm2yhxXhxD3253WeM8S9wU1h9JW8Fb0GiTldTVG8EorFXORQaiXmxMoqsxgDmiW3
         Wn/LNr+zvBm4fnJKKc2uyrelrKCygADbbEK4DfJPFNj6QmRhITFv/vDPurnGOJMqgrNR
         LuNCB+Pj78C5ArLR0sCacqtNmrmcw4RUICOyWi733GInFe5KM4zBYQUpPsnpwVlk5cGx
         bCG6IgpVppzSdvKGwxUdS+vZJE56kLWNzQB3bsi7Lwv9pf11fcNNGYAfUuYB99oQ3SDB
         yhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4mwhH+5lRASgBmDVjgFlw+MCEEmhj+lno3Pozq0noic=;
        b=fkh1jXNPHUymkeTGseItAyuZLedYASeIlnlTcfMiA6TVqj3IGGP+7JXkJgP8bBJMLU
         lQpYzBZkhn69Q9ue7VHcp0loduc720SgrTzBiRsEZoTb5eQ5BCq4TQ+Swr9VjrtSdfeU
         E5UjsX1rre4YkrMFYj8BpTIIzjE1DYIBGZ0Ym/VtyDJYP9lOzwVvQcSRgtI6buqkbOmo
         lRqyJ8RzYKrdTNBrQsKkEv5Wp7hws4T6OO2SjEk7Tqotmv/uh9eRlBKMll9EsocPPiZq
         ANF82c/a4nDyFWbZo14MDGsVbOSu+q8kXjTe8Z9wahKgB5R8Vryq1Oyggw5YCNfqVGuC
         o5DA==
X-Gm-Message-State: AG10YOTZLUxaTJZKb/FtN6xiBr+vhTesYrhCXg5vmfjrq9nyUI4N8xsbk2S1xbqVfCSYfQ==
X-Received: by 10.195.11.100 with SMTP id eh4mr49933967wjd.83.1455194359268;
        Thu, 11 Feb 2016 04:39:19 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:18 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285979>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 advice.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/advice.h b/advice.h
index b341a55..eef82e1 100644
--- a/advice.h
+++ b/advice.h
@@ -20,8 +20,7 @@ extern int advice_object_name_warning;
 extern int advice_rm_hints;
 
 int git_default_advice_config(const char *var, const char *value);
-__attribute__((format (printf, 1, 2)))
-void advise(const char *advice, ...);
+FORMATPRINTF(1,2) void advise(const char *advice, ...);
 int error_resolve_conflict(const char *me);
 extern void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
-- 
2.5.0
