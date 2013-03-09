From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 02/19] Add from-submodule. Conflicts: .gitignore
 contrib/subtree/git-subtree.sh test.sh
Date: Sat, 9 Mar 2013 19:20:58 +0000
Message-ID: <CALeLG_=Ch2eTBF59UKTCr1vCpW=asbAdXBs+uYP+gtv=w4H6AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	James Roper <jroper@vz.net>, mhart <michael@adslot.com>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>,
	Paul Cartwright <paul.cartwright@ziilabs.com>,
	Peter Jaros <pjaros@pivotallabs.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:21:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPKf-0005ie-CS
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161Ab3CITU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:20:59 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:45794 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CITU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:20:58 -0500
Received: by mail-oa0-f50.google.com with SMTP id l20so3257774oag.37
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=O2sa2H2DpKp1YNxg5Ec8bG9xFB6qfo2QFk3TWpvQg1Y=;
        b=lBLNYlWwDMMw3V/pVKCnvMeEcTmJoJwXnu6NIhLwEPyWxSD+6ym4bpIIMGeh10INoN
         6sfNZMHenEUvWsYUG8Dsxdg9SEo8DwbAfLCYvvh8y6/vemjJkA5wHIxZPEPaP9KlyNz8
         x2xw7DDJJ08dx7oN3WtJoIEblM1E5lLGsRj7vTKvcnhIuHG9WtgBbDKBar1mOJqzNdxU
         x7GHhadnxCb7EuHVUyRh7rawEFOkg4rxkigSo6ewye0Kly2U3+VpqOaMpN+OKdd8SPbM
         tKCyaHCHLu64V7LLFl96G2re2hVx9mhp/5oNYMWz4HNR4EOf6mECi0LzyuN1TRr8XMvP
         Jzvg==
X-Received: by 10.60.14.226 with SMTP id s2mr5054192oec.124.1362856858273;
 Sat, 09 Mar 2013 11:20:58 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:20:58 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQmlITzsMrqnvTejTKKWJi5SrSOKfNPjyOywqJu6MtN+AhzFP4W+4Is75RnmrPJXau+F8DX9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217738>

>From 718c99d167255b28830b6f684d6e6e184fba0f7c Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:30:20 +0000
Subject: [PATCH 02/19] Add from-submodule. Conflicts: 	.gitignore
 contrib/subtree/git-subtree.sh 	test.sh

Original-Author: Peter Jaros <pjaros@pivotallabs.com>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8a23f58..caf4988 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -14,6 +14,7 @@ git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <refspec...>
 git subtree push  --prefix=<prefix> <repository> <refspec...>
 git subtree split --prefix=<prefix> <commit...>
+git subtree from-submodule --prefix=<prefix>
 --
 h,help        show the help
 q             quiet
@@ -101,7 +102,7 @@ done
 command="$1"
 shift
 case "$command" in
-	add|merge|pull) default= ;;
+	add|merge|pull|from-submodule) default= ;;
 	split|push) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
 esac
@@ -721,4 +722,31 @@ cmd_push()
 	fi
 }

+cmd_from-submodule()
+{
+	ensure_clean
+
+	local submodule_sha=$(git submodule status $prefix | cut -d ' ' -f 2)
+
+	# Remove references to submodule.
+	git config --remove-section submodule.$prefix
+	git config --file .gitmodules --remove-section submodule.$prefix
+	git add .gitmodules
+
+	# Move submodule aside.
+	local tmp_repo="$(mktemp -d /tmp/git-subtree.XXXXX)"
+	rm -r $tmp_repo
+	mv $prefix $tmp_repo
+	git rm $prefix
+
+	# Commit changes.
+	git commit -m "Remove '$prefix/' submodule"
+
+	# subtree add from submodule repo.
+	cmd_add_repository $tmp_repo HEAD
+
+	# Remove submodule repo.
+	rm -rf $tmp_repo
+}
+
 "cmd_$command" "$@"
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
