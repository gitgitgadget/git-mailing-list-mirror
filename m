From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/5] ls-remote: document --refs option
Date: Tue, 19 Jan 2016 00:20:47 +0100
Message-ID: <1453159250-21298-3-git-send-email-t.gummerer@gmail.com>
References: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 00:21:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLJ71-0006mm-Bg
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 00:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652AbcARXVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 18:21:20 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33697 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbcARXUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 18:20:45 -0500
Received: by mail-wm0-f66.google.com with SMTP id u188so19464129wmu.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 15:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+UBTekMpf4pKiv1AHxsnRk1ALitSaFzRBaEN+ng7pK8=;
        b=ahIL7duTaPHEq0m6jQl4/Dc3RY8bym5/gNR0hYy+lnXbnHmpGbMdvHxR8LJPxy7BDy
         sLrZBV2NRJO0JsL1eWNMMi0itAIH+owxc0PJZJvMDNXNXUeoFkwCOi3gxUB25pfBzXB5
         mdGB8XSVxXK44Pj03WmPE1BdEgF4Li0qSLiFCXrkDBXm/BG8s/CHuFGFGhql2ctlGcOs
         OTPKVn8qVcEdLJjPvYQJvyHfe7UjQMUcVW6GsKHa/lnpHhQzecBzChCfPnzV1qwdQF1a
         QwlcqwRiuzPdcz5AtDuMS/ot6RbuNCib2oAl5SVYF4bBXtO0hiDvcMnsPTW0EBH8pJH8
         JcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+UBTekMpf4pKiv1AHxsnRk1ALitSaFzRBaEN+ng7pK8=;
        b=V1yqEjtKE4vSXV9Jcf5nT1obk1NSV0WzlwVa7R3f689RLPoaSFKKEDROFHpyJkM2ny
         IRxiAWfDxYhR4rjpSQrID2Er5Ur3B7zQBfFyxdq5x20DD1pAhbZ8m+gpeSQgTaMJCCpj
         svRPHFbulPmy6/TF9E2TGO20xHvlhWwsetLfKmHDZUofzZqJw+XFB8KwLgYSXpcclOOo
         prlHqKJFGsfxl/RizuB3D9uf6tRHZ2FohWhltDFfnpLOciJqz17yLZ81qhCf1o+Errqn
         lCAbqZ5SUUZ2VkUMfCModGKGwW1EiO9SbtMEh0EzIwEObe/P3tpyAGBqiu301M2GVdh0
         uD+A==
X-Gm-Message-State: AG10YOTpEK32siZHqlydcFqP9TpmIW4ihYZux0nftcTcTUsdd5rChh6a6yYicVwMCjOrDg==
X-Received: by 10.28.176.131 with SMTP id z125mr16796119wme.5.1453159244103;
        Mon, 18 Jan 2016 15:20:44 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id c203sm17759332wmd.5.2016.01.18.15.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 15:20:43 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.g56a8654.dirty
In-Reply-To: <1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284338>

The --refs option was originally introduced in 2718ff0 ("Improve
git-peek-remote").  The ls-remote command was first documented in
972b6fe ("ls-remote: drop storing operation and add documentation."),
but the --refs option was never documented.  Fix this.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-ls-remote.txt | 5 ++++-
 builtin/ls-remote.c             | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 27380de..7467162 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -9,7 +9,7 @@ git-ls-remote - List references in a remote repository
 SYNOPSIS
 --------
 [verse]
-'git ls-remote' [--heads] [--tags]  [--upload-pack=<exec>]
+'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
 	      [-q | --quiet] [--exit-code] <repository> [<refs>...]
 
 DESCRIPTION
@@ -29,6 +29,9 @@ OPTIONS
 	both, references stored in refs/heads and refs/tags are
 	displayed.
 
+--refs::
+	Do not show peeled tags or pseudorefs like HEAD	in the output.
+
 -q::
 --quiet::
 	Do not print remote URL to stderr.
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index fa65a84..db21e52 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -4,7 +4,7 @@
 #include "remote.h"
 
 static const char ls_remote_usage[] =
-"git ls-remote [--heads] [--tags]  [--upload-pack=<exec>]\n"
+"git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
 "                     [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]";
 
 /*
-- 
2.7.0.30.g56a8654.dirty
