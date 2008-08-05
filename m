From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 1/8] bash completion: Add completion for 'git clone'
Date: Mon,  4 Aug 2008 23:50:31 -0600
Message-ID: <1217915438-6838-2-git-send-email-lee.marlow@gmail.com>
References: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 07:51:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQFSW-0007Wq-3H
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 07:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbYHEFur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 01:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754299AbYHEFuq
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 01:50:46 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:56663 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbYHEFul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 01:50:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3753909wfd.4
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=t763C1mZrNu9XmtpC/TPKttUmukqM6+dpEMLcfKTh6Q=;
        b=A3pwO148Dg6srJFAmmfSwewbyNXD5nv8S35QCHySMG56t8mbjTo151sKfBBuXVfvr4
         SO2n8/HE6o4PVlaUAUkyd+2okQuHEGeGzdTR6jJSsZYg42jfqSoUWUKy6BoB6jQJvwND
         2uV0xNjmyIVoNgi7dik0x3dv9wuaXaKvvXYGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mLC2vIkQsT64sEE1RtWKUt/MrVBN64stNJx9UxPoMsa0jGfK0qFxXuuY+WmJKSJ81h
         MAqW/IC914JRzVfcDPvCZQ43W2DbaX1iVMlfSEDHGqWTvCHqwup1lAtbnwtFHIINCSdl
         D1GP0Ge7dNdLe1LTIgLx7hHGgmB4grAsVqR1Q=
Received: by 10.142.47.6 with SMTP id u6mr5266480wfu.300.1217915441681;
        Mon, 04 Aug 2008 22:50:41 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id 32sm10686014wfc.12.2008.08.04.22.50.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 22:50:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.48.g2b6032
In-Reply-To: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91420>

Added completions for all long options specified in the docs
	--local --no-hardlinks --shared --reference
	--quiet --no-checkout --bare --mirror --origin
	--upload-pack --template= --depth

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 678a155..6ffe259 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -667,6 +667,31 @@ _git_cherry_pick ()
 	esac
 }
 
+_git_clone ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--local
+			--no-hardlinks
+			--shared
+			--reference
+			--quiet
+			--no-checkout
+			--bare
+			--mirror
+			--origin
+			--upload-pack
+			--template=
+			--depth
+			"
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_commit ()
 {
 	__git_has_doubledash && return
@@ -1475,6 +1500,7 @@ _git ()
 	checkout)    _git_checkout ;;
 	cherry)      _git_cherry ;;
 	cherry-pick) _git_cherry_pick ;;
+	clone)       _git_clone ;;
 	commit)      _git_commit ;;
 	config)      _git_config ;;
 	describe)    _git_describe ;;
-- 
1.6.0.rc1.48.g2b6032
