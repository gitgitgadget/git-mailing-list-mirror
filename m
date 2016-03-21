From: "Jose Ivan B. Vilarouca Filho" <joseivan@lavid.ufpb.br>
Subject: Re: [PATCH] Fixing segmentation fault when merging FETCH_HEAD
Date: Sun, 20 Mar 2016 20:11:42 -0400
Message-ID: <1458519102-32621-1-git-send-email-joseivan@lavid.ufpb.br>
References: <CAPig+cRVtzLjKTW7FZ-h8thEXkTqBJtbSwpKJs3+wdRHYV1qrQ@mail.gmail.com>
Cc: git@vger.kernel.org,
	"Jose Ivan B. Vilarouca Filho" <joseivan@lavid.ufpb.br>
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Mon Mar 21 01:12:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahnSF-0001Q4-GK
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 01:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbcCUAMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 20:12:13 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:34886 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbcCUAMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 20:12:12 -0400
Received: by mail-qg0-f67.google.com with SMTP id 51so5784371qgy.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 17:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lavid-ufpb-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wr/0oHlGdI8ZcwRukjK4N/seY4rBGOB5gYEOEQ86fSQ=;
        b=kuDk4HDLQ8iRPwn/nVit/L21JnjsKLAZOXiZO603JandfPQVmgZGV4PVBsA2bkVu8Z
         2yxPAr5kz/XaOnCJUWBQAUbRttiO4JWg2AZiRbHdSDFEb2e1CxvH9SDBqki4InYaEMg/
         Bn97M+ccU05Bq5vHXglnomYmT6rzPtCZUcaYIczAQEgGB1HvKC9o8m+1JrWasuZqyNgF
         4uPk93kzy5Jzzwg+Vitb7pGGTDi3iwph8cXYGMPRi7qstF4AI+AhZF6ZzawiW6OuHufG
         XVfz17rhcZmgASiLjnTmHw4MS0uecsPvaIQdgOAKpbQY6URPm78J4ktxMPFhZ+yzkqyg
         I+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wr/0oHlGdI8ZcwRukjK4N/seY4rBGOB5gYEOEQ86fSQ=;
        b=fMA+CISxbXPfnKdpGEg28reFsmIbOdRsQJw4/Eo+0f64/DLdtBK31ZsYwHUEC/a494
         iA1WHS54NKrwLN8UrxfmVWWNV1EN4lFYw3wEfauwyvVAcP50bSQZ15LN/zZxZ6rluNqw
         RmfCSTKcUZLsiHmBOQRaTFkFze5OpZXcjCZBC2nQM1rpabZIg5jdeV0lcJj08TUuSZYC
         F4BSX0apS3gM6JWse55Hrt2vCqiVVPl+e+TPEicLgMWF9VFMYi6lMZqMMZPjWLGZbF3O
         9v+2ypDsy2kix/PCM+5sF6wGgdu6T6KOdLuVQg1rDHjJyX31DdwHrRKk8tZf9wECJRhx
         wRdA==
X-Gm-Message-State: AD7BkJL5niGM7zBiClCus7bjmgPhR81USERFG2TRvkJOpLz8aHWvWsd8vlHYalHQmAxLXw==
X-Received: by 10.140.218.139 with SMTP id o133mr39198606qhb.33.1458519130426;
        Sun, 20 Mar 2016 17:12:10 -0700 (PDT)
Received: from cinema-lenovo1.pet.ci.ufpb.br ([186.207.136.144])
        by smtp.gmail.com with ESMTPSA id w16sm11131729qka.35.2016.03.20.17.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Mar 2016 17:12:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <CAPig+cRVtzLjKTW7FZ-h8thEXkTqBJtbSwpKJs3+wdRHYV1qrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289391>

From: "Jose Ivan B. Vilarouca Filho" <joseivan@lavid.ufpb.br>

Hello, Eric.

Thanks for suggestions. I've added a test in commit replacing git fetch origin by a fake FETCH_HEAD content.

merge: don't dereference NULL pointer

A segmentaion fault is raised when trying to merge FETCH_HEAD
formed only by "not-for-merge" refs.

Ex:
    git init .
    git remote add origin ...
    git fetch origin
    git merge FETCH_HEAD

Signed-off-by: Jose Ivan B. Vilarouca Filho <joseivan@lavid.ufpb.br>
---
 builtin/merge.c         |    4 ++--
 test-merge-fetchhead.sh |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100755 test-merge-fetchhead.sh

diff --git a/builtin/merge.c b/builtin/merge.c
index 101ffef..098aa8a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1270,9 +1270,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			    "an empty head"));
 		remoteheads = collect_parents(head_commit, &head_subsumed,
 					      argc, argv, NULL);
-		remote_head = remoteheads->item;
-		if (!remote_head)
+		if (!remoteheads || !remoteheads->item)
 			die(_("%s - not something we can merge"), argv[0]);
+		remote_head = remoteheads->item;
 		if (remoteheads->next)
 			die(_("Can merge only exactly one commit into empty head"));
 		read_empty(remote_head->object.oid.hash, 0);
diff --git a/test-merge-fetchhead.sh b/test-merge-fetchhead.sh
new file mode 100755
index 0000000..383415a
--- /dev/null
+++ b/test-merge-fetchhead.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+GIT=$(pwd)/git
+REPO_DIR=./test-fetch-head-repo
+
+if [ ! -x "${GIT}" ]; then
+    echo "Missing git binary"
+    exit 1
+fi
+
+${GIT} init ${REPO_DIR} || rm -rf ${REPO_DIR} || exit 1
+pushd ${REPO_DIR} || rm -rf ${REPO_DIR} || exit 1
+#Let's fake a FETCH_HEAD only formed by not-for-merge (git fetch origin)
+echo -ne "f954fc9919c9ec33179e11aa1af562384677e174\tnot-for-merge\tbranch 'master' of https://github.com/git/git.git" > .git/FETCH_HEAD
+${GIT} merge FETCH_HEAD
+GRET=$?
+popd
+if [ ${GRET} -eq 139 ]; then
+    rm -rf ${REPO_DIR}
+    exit 1
+fi
+
+rm -rf ${REPO_DIR}
+exit 0
-- 
1.7.10.4
