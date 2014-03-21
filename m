From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 01/28] The tests should not fail if guilt.diffstat is set.
Date: Fri, 21 Mar 2014 08:31:39 +0100
Message-ID: <1395387126-13681-2-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtyi-00045e-3C
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758616AbaCUHdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:19 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:61231 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbaCUHc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:32:58 -0400
Received: by mail-lb0-f173.google.com with SMTP id p9so1371269lbv.4
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v0gABlT0boDKK/CDLJIohK2f5I6iSZpyAMfJaXU+An0=;
        b=NCe8eavH1WZryrbCfbgzzh7nkC5nEgP40uOfzszafZCfjUtGUpRFHfbCHjx1sg+eJl
         FqeXqrvcUYq5ZL7+vVSAkPi6sc34ww0Xjjuw5x9x8+iTWqBOfiratQhOycacoKnR6VSg
         HDAAAiz9yz15ycKWQXfbVnn/vBCHGtY0xkKbt+kHtNDFmf6ZIX136QfHn8y1Wrr7DIwW
         +bSM0RvYNpL53vacJedV0MXkyFbxNGOi+xsB4D7npo71O+OY214Yr7odeofjnO4MFLaV
         6aWGSd/8AKURpssd50LyAo9glBN3WaiL6i0mYwk8Fv7ZvXtUhyaJoZyJDMIBffUHVabH
         6eQA==
X-Gm-Message-State: ALoCoQlIV3kkBw5DW3deBSNS8JyY0BBtgmnZ5P9WLEoErNSelkGJpRUSQT7l+m67FbZES2j/vKdF
X-Received: by 10.112.136.71 with SMTP id py7mr31366424lbb.26.1395387176522;
        Fri, 21 Mar 2014 00:32:56 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.32.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:32:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244672>

Explicitly set guilt.diffstat to its default value.  Without this, the
027 test (and possibly others) fail if guilt.diffstat is set to true
in ~/.gitconfig.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/scaffold | 1 +
 1 file changed, 1 insertion(+)

diff --git a/regression/scaffold b/regression/scaffold
index 546d8c6..5c8b73e 100644
--- a/regression/scaffold
+++ b/regression/scaffold
@@ -87,6 +87,7 @@ function setup_git_repo
 	# Explicitly set config that the tests rely on.
 	git config log.date default
 	git config log.decorate no
+	git config guilt.diffstat false
 }
 
 function setup_guilt_repo
-- 
1.8.3.1
