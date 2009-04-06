From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 13/14] mergetool: use $( ... ) instead of `backticks`
Date: Mon,  6 Apr 2009 01:31:28 -0700
Message-ID: <1239006689-14695-14-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
 <1239006689-14695-2-git-send-email-davvid@gmail.com>
 <1239006689-14695-3-git-send-email-davvid@gmail.com>
 <1239006689-14695-4-git-send-email-davvid@gmail.com>
 <1239006689-14695-5-git-send-email-davvid@gmail.com>
 <1239006689-14695-6-git-send-email-davvid@gmail.com>
 <1239006689-14695-7-git-send-email-davvid@gmail.com>
 <1239006689-14695-8-git-send-email-davvid@gmail.com>
 <1239006689-14695-9-git-send-email-davvid@gmail.com>
 <1239006689-14695-10-git-send-email-davvid@gmail.com>
 <1239006689-14695-11-git-send-email-davvid@gmail.com>
 <1239006689-14695-12-git-send-email-davvid@gmail.com>
 <1239006689-14695-13-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:35:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkIK-0002l9-Mv
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbZDFIcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754982AbZDFIcN
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:32:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:19616 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773AbZDFIcK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:32:10 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2100228rvb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=u6mg+4KXuTf4QZPEa3b5UicQOEy9PVVrKDQyka1eN9k=;
        b=DhAYP1WFJMMpbzqcrWKAceH5G2VH5+Uqyc+AJEju4zPL0mvTnlRmCYbo1b7jKwRRA6
         xWaAxLt+XqIwk3H4aVtb6p7U7OZ+h1QAcyp+aVLJzToAHdv3jbnSxGzNs5pdUcUzmKEY
         j7yNoEnH6ZdXnJfmo/UYS29YSvEIkJmQgJy0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LaA9bYefExz53ylG8n0BCJBDwvg7IRmh+MWKVfEzP1oES7NJXvfMhUwg/xcCg6j6eK
         LjJnvrpVQ0E8GzhHQOnf0e5jzqEATFQers8Ignqa4gCU2adkIZBZHO1EDzOJXboEyJ/e
         g8hbhTNAdAweO5AMPkiD0sXBnnw1O53Juwp6k=
Received: by 10.114.137.2 with SMTP id k2mr2150216wad.146.1239006728290;
        Mon, 06 Apr 2009 01:32:08 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v25sm5173969wah.16.2009.04.06.01.32.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:32:07 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-13-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115789>

This makes mergetool consistent with Documentation/CodingGuidelines.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index b4d2432..cceebb7 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -137,7 +137,7 @@ checkout_staged_file () {
 merge_file () {
     MERGED="$1"
 
-    f=`git ls-files -u -- "$MERGED"`
+    f=$(git ls-files -u -- "$MERGED")
     if test -z "$f" ; then
 	if test ! -f "$MERGED" ; then
 	    echo "$MERGED: file not found"
@@ -156,9 +156,9 @@ merge_file () {
     mv -- "$MERGED" "$BACKUP"
     cp -- "$BACKUP" "$MERGED"
 
-    base_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}'`
-    local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
-    remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
+    base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
+    local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
+    remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')
 
     base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
     local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
@@ -318,7 +318,7 @@ do
 	-t|--tool*)
 	    case "$#,$1" in
 		*,*=*)
-		    merge_tool=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		    merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
 		    ;;
 		1,*)
 		    usage ;;
@@ -366,7 +366,7 @@ valid_tool() {
 }
 
 init_merge_tool_path() {
-	merge_tool_path=`git config mergetool.$1.path`
+	merge_tool_path=$(git config mergetool.$1.path)
 	if test -z "$merge_tool_path" ; then
 		case "$1" in
 			vimdiff)
@@ -403,7 +403,7 @@ prompt_after_failed_merge() {
 }
 
 if test -z "$merge_tool"; then
-    merge_tool=`git config merge.tool`
+    merge_tool=$(git config merge.tool)
     if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
 	    echo >&2 "Resetting to default..."
@@ -463,7 +463,7 @@ last_status=0
 rollup_status=0
 
 if test $# -eq 0 ; then
-    files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
+    files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
     if test -z "$files" ; then
 	echo "No files need merging"
 	exit 0
-- 
1.6.2.2.414.g81aa9
