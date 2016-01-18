From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/5] ls-remote: document --refs option
Date: Mon, 18 Jan 2016 17:57:15 +0100
Message-ID: <1453136238-19448-3-git-send-email-t.gummerer@gmail.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 17:57:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLD7L-0003S4-OF
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 17:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969AbcARQ5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 11:57:15 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35176 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921AbcARQ5L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 11:57:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id 123so10521150wmz.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 08:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eIv3bfDtBbxvLjjzrlKPEGVEgEEYuOFzcKdReeOOw30=;
        b=0AHJ5jcEXvXQdY3TIW1NuVFATT/MUC2UYSt+HdmQp8uwCeQh+/aETcpnuj9e5reH0X
         zVycjWhdhMObJHFa6KzeXkVPm1Qu6YdOHAgTGPqSROjgShdcIBSJW9bGYEq51/0BV0nL
         tQgRdy/8RRQLRBFs1jLYVmvqLgksEmKmg7dRyJfLo5wxuEcR/JutEgfj5m8tTUQkjiFL
         9YiaqG8sxlRka2iyQA1lRasJXQYYexvkW1pzzt40jBq5K1Uc9qKYjAqrLwwZIh7R8KHh
         ditCDYU4Q7Qcg0B5PJ9TgqAtNMq+CUh/Vxz8gq5DK3MxVNpJykZGaMlBzzRbtSF/khJF
         AtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eIv3bfDtBbxvLjjzrlKPEGVEgEEYuOFzcKdReeOOw30=;
        b=i9GgAvaD81+zHa57npARZ0clKAjidr1IsE++5C2dMR5QJLrjS77DmzEnwBm+T9RL+A
         QUW6E8f0hT4V9u+JoWamntLe7RiXk2vGf/rKNJUXDFSs702BbQY+j6jSCAz8lc9juak9
         ePqHrf447Z6ESHP6XVuRhhvUv2Ly0r3YWBYH9jXWwLPgLCx2beAAMqcM9ExztCeX2geS
         R9hsn4MBMU7U1Jt+y1nJ7XirTwFc6HPMggs2giENCkLfkJDU+xEhC1DE2/8tmaMKxM99
         l/RwEDjsjO/AY35KgK7qCyogPm66erRyipovM6ZAf3AzR03Wn/JYSh0Xp06BQ/nAK47m
         4Mtw==
X-Gm-Message-State: ALoCoQnQ/3Ub/gNWJTOAMRnpOg7p95FAxmZjMscmk6Fw4SJB8EB1Yd77f7PJ7e1hFngyWWc1CEWudG5mkC0Shdl1ot3zoHbW5g==
X-Received: by 10.194.117.169 with SMTP id kf9mr24562628wjb.122.1453136229980;
        Mon, 18 Jan 2016 08:57:09 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id 198sm16598181wml.22.2016.01.18.08.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 08:57:08 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.gd0a78e9.dirty
In-Reply-To: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284295>

The --refs option was originally introduced in 2718ff0 ("Improve
git-peek-remote").  The ls-remote command was first documented in
972b6fe ("ls-remote: drop storing operation and add documentation."),
but the --refs option was never documented.  Fix this.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-ls-remote.txt | 6 +++++-
 builtin/ls-remote.c             | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 27380de..5cd47c0 100644
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
@@ -29,6 +29,10 @@ OPTIONS
 	both, references stored in refs/heads and refs/tags are
 	displayed.
 
+--refs::
+	Do not show peeled tags or pseudo-refs like HEAD or MERGE_HEAD
+	in the output.
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
2.7.0.30.gd0a78e9.dirty
