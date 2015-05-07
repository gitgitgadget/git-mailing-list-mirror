From: Danny Lin <danny0838@gmail.com>
Subject: Re: --squash has no effect in git subtree push?
Date: Thu, 7 May 2015 15:52:33 +0800
Message-ID: <CAMbsUu4v9w6+wiAUm2hpiNrDaoL3U9Z_suXR3NPVGo-JhH3E+Q@mail.gmail.com>
References: <CAMbsUu5g=r867_WOhLCySG3caKj1jhmQgfzBxK4TYV27+nUpsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git develop <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 07 09:52:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqGbo-0007Ip-Az
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 09:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbbEGHwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 03:52:36 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36689 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbbEGHwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 03:52:34 -0400
Received: by qgeb100 with SMTP id b100so16972001qge.3
        for <git@vger.kernel.org>; Thu, 07 May 2015 00:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=Kg1FXA/HrEdgq4KO+3rKXEvORumu5iXqBz0LgAjKgT4=;
        b=f3yaYUKsetDPcGib/iAwEnt0K0g8eIEZFXtMR+c/YRCErZ0nGCTuH6GgImXl1ZPZ6f
         ftu/J+2c1ImGjODSerNmjUVZ/9i0z8vE4cM2/feU3NS9KbbSo/ppHTUTm4GZWUu8FFE4
         YMGd+EuieFiNUsxFvk2/J0umSd+ALNI8xW8E0J5LF10hSOIzdD0EG96YjZQvqI940KXe
         9HBgF1AVQxUJtmSAax+osaYllnU+b9D+xfPHB1iZYII68FhJiUpBMsYlh0HavnSJj0g4
         hEruz/03wluUo9PKD0ENwVM86hAj5Xwp6Fa0AAnc6yqSC0ce0VM32vu/ezR3q31ah/Wz
         SIyA==
X-Received: by 10.140.129.65 with SMTP id 62mr3526459qhb.102.1430985154266;
 Thu, 07 May 2015 00:52:34 -0700 (PDT)
Received: by 10.140.98.145 with HTTP; Thu, 7 May 2015 00:52:33 -0700 (PDT)
In-Reply-To: <CAMbsUu5g=r867_WOhLCySG3caKj1jhmQgfzBxK4TYV27+nUpsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268508>

Subject: [PATCH] contrib/subtree: there's no push --squash

The documentation says that --squash is for 'add', 'merge',
'pull' and 'push', while --squash actually doesn't change
the behavior of 'push'. Correct the documentation.

Signed-off-by: Danny Lin <danny0838@gmail.com>
---
 contrib/subtree/git-subtree.sh  | 2 +-
 contrib/subtree/git-subtree.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index fa1a583..6328c87 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -26,7 +26,7 @@ b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
- options for 'add', 'merge', 'pull' and 'push'
+ options for 'add', 'merge', and 'pull'
 squash        merge subtree changes as a single commit
 "
 eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 54e4b4a..60d76cd 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -146,7 +146,7 @@ OPTIONS
 OPTIONS FOR add, merge, push, pull
 ----------------------------------
 --squash::
-    This option is only valid for add, merge, push and pull
+    This option is only valid for add, merge, and pull
     commands.
 +
 Instead of merging the entire history from the subtree project, produce
-- 
2.3.7.windows.1
