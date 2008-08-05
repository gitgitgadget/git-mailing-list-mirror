From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 4/8] bash completion: Add completion for 'git revert'
Date: Mon,  4 Aug 2008 23:50:34 -0600
Message-ID: <1217915438-6838-5-git-send-email-lee.marlow@gmail.com>
References: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-2-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-3-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-4-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 07:52:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQFT8-0007dV-7g
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 07:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbYHEFu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 01:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754977AbYHEFuy
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 01:50:54 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:58782 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbYHEFuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 01:50:46 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3753957wfd.4
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 22:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4pIojD8drNvW1xzRHBt5EiRQuujZIiygbNdLhpxFBBw=;
        b=hCijUhq603Z7rwgCrYvn9rBb7aY1+c2c7F+Wt9yWJgjadg1bf0a+MbS1mog1SuUknW
         ezwpR6nIWyuB2wiae2jlqKvXMjzYpDJvID2gFvQ8NZrok2B11inc0v3JPhLNq3CABcMb
         RrRmLHvsJldVgBoerr8HEsP1YhOJ86TH4cN7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=josJ8lYMC5TENgEdVB9Md+STogLEuC8yt9ovkpxWs+kZTZ+1SGmRUhVKa9HI6AYNmX
         XyoVwSvLYYTJgxRTtFkyqvBh2OnPrT/Sfl7U9dm0bXRhdHA9VuMuThgyk537IoQB+qGz
         R+OeYoOt1q0wM6AvoPIbuC/C8g98Br/MvjrK8=
Received: by 10.142.242.11 with SMTP id p11mr5269339wfh.135.1217915445529;
        Mon, 04 Aug 2008 22:50:45 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id 32sm10686014wfc.12.2008.08.04.22.50.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 22:50:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.48.g2b6032
In-Reply-To: <1217915438-6838-4-git-send-email-lee.marlow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91426>

Added completions for all long options specified in the docs
        --edit --mainline --no-edit --no-commit --signoff

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c7a6d92..6a5c4cd 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1264,6 +1264,18 @@ _git_reset ()
 	__gitcomp "$(__git_refs)"
 }
 
+_git_revert ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_rm ()
 {
 	__git_has_doubledash && return
@@ -1554,6 +1566,7 @@ _git ()
 	rebase)      _git_rebase ;;
 	remote)      _git_remote ;;
 	reset)       _git_reset ;;
+	revert)      _git_revert ;;
 	rm)          _git_rm ;;
 	send-email)  _git_send_email ;;
 	shortlog)    _git_shortlog ;;
-- 
1.6.0.rc1.48.g2b6032
