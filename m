From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 17/22] remote.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:54 +0000
Message-ID: <1455194339-859-18-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXR-0008N9-Vv
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbcBKMjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:54 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33741 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbcBKMjb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:31 -0500
Received: by mail-wm0-f66.google.com with SMTP id c200so10464263wme.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Csw5wl23SKGM2qNDOeyCnk+htzUAUcobpeLmcciS1Ts=;
        b=Z9euIJw81R78W86MMeDJt7RGQH7supqovIXV6ErvWqlg9OhbssXYUfUyzDtaWIGu8f
         yhM6T/xhThThj39Pz2MPrJeOoJMsVS3jUuDyIVh+DYOgjQA2NEkVdUTkeSJ3XU1rPPfy
         BO3f1AaUAkQeTTN8kw7quiwzxgg9REjQozjSdMQopdzW5A5wxdO4wvHooyeJPoHr+1jI
         imNzP0FGulPzDrM/W68cJ0FtKODZHtbqGmTiUiHoIArUYkBvlBLVqeZ9BaZ2tgN7sHg6
         6RExGt/73ifDlXQILA5yatVFiAdpjK4teIYj4XERvycVwSUuG+cB6VB4UR5apWAhXSfW
         EUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Csw5wl23SKGM2qNDOeyCnk+htzUAUcobpeLmcciS1Ts=;
        b=nDbbU+l49s0yFzadxDQk48wBDiiS4iPuNIzZty6BmJymG0bU84kfkH3BJcBlt5Trc+
         mBRPAXS9fNe6zdbxp2fAwf3rrvIr6RaED+/jVVy4jciqrhyg4zOKCnh+2Nht+4UYC68J
         WsM6y/vyIuddUOu/yWmUxMmVN0t7oRaP9swdeg5EgpShf94y7gE6c9/gvdf1UQprYrpL
         GJyQGJb82LTd4B9SPZ0yfSNfhld7sPnhk3mHavw0ztEqWkPFqHsIC+SejLyYTN1Q3aok
         UWJGIn/mx5hmhH4dGBOwfJxCLF0WFrlcbX4kzMH/tFnOZ+y5g77M4mYECH792SJu0llP
         6BmA==
X-Gm-Message-State: AG10YOQcvBTXwaAMO75FBIEf4UwbizfdB0Beccj3qPIj5l+zS/s0+iiEKd7n2PZ8WkrcHw==
X-Received: by 10.28.55.74 with SMTP id e71mr10646655wma.26.1455194370765;
        Thu, 11 Feb 2016 04:39:30 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:30 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285966>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 35940a5..579cfcb 100644
--- a/remote.c
+++ b/remote.c
@@ -1672,7 +1672,7 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
-__attribute((format (printf,2,3)))
+FORMATPRINTF(2,3)
 static const char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
 	if (err) {
-- 
2.5.0
