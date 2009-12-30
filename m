From: Robert Zeh <robert.a.zeh@gmail.com>
Subject: [PATCH] Add completion for git-svn mkdirs,reset,and gc
Date: Tue, 29 Dec 2009 18:58:48 -0600
Message-ID: <C065517F-C829-46D1-8D1A-88C18EE2112F@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Dec 30 01:58:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPmtt-0003Zs-FS
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 01:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbZL3A6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 19:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbZL3A6x
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 19:58:53 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:37224 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbZL3A6x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2009 19:58:53 -0500
Received: by yxe17 with SMTP id 17so10494995yxe.33
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version:x-mailer;
        bh=ffWOhH9nPcPbG69tFaX76IVb4V/b5QOKnDsPu0Ljd2E=;
        b=nzhLDLLlQQ8N9WC6bosBaDDA8iUNDzzOPHQnQDiIzJKv2zNXQuwnvQ6X9W+jgjynBz
         uslP7YRvpsmjM/OIUqsbcvDqDQDy5xX0vP8YfLZhQaVO7TC8MQIYGMOD6DguSjzr7meq
         O/hvLQT7mzw9snkcncbGlkzeTx0o2lT5QqJS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer;
        b=vasJvslUWftN+8C7j0/m0rJW4vCj/FGVBU13p0EqU6Y8j7V9Q4uVoP5cRKyAaOuVHd
         c8mn29E4E8T/yF5RFfzJnkgeZgUIKjO3O64+BEDDaAZdh6bHoA5Q6XYcZcVJxRz3Idgz
         iL8KqbgRpGTA9BGKKGwBDB+uAsNyHWud8LMyw=
Received: by 10.150.234.15 with SMTP id g15mr1224904ybh.194.1262134732397;
        Tue, 29 Dec 2009 16:58:52 -0800 (PST)
Received: from ?10.0.1.101? (user-102i1dh.dsl.mindspring.com [64.41.5.177])
        by mx.google.com with ESMTPS id 6sm4601617ywc.24.2009.12.29.16.58.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Dec 2009 16:58:51 -0800 (PST)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135847>


Signed-off-by: Robert Zeh <robert.a.zeh@gmail.com>
---
contrib/completion/git-completion.bash |    7 +++++--
1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fbfa5f2..c65462c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2022,7 +2022,7 @@ _git_svn ()
		init fetch clone rebase dcommit log find-rev
		set-tree commit-diff info create-ignore propget
		proplist show-ignore show-externals branch tag blame
-		migrate
+		migrate mkdirs reset gc
		"
	local subcommand="$(__git_find_on_cmdline "$subcommands")"
	if [ -z "$subcommand" ]; then
@@ -2069,7 +2069,7 @@ _git_svn ()
			__gitcomp "--stdin $cmt_opts $fc_opts"
			;;
		create-ignore,--*|propget,--*|proplist,--*|show-ignore,--*|\
-		show-externals,--*)
+		show-externals,--*|mkdirs,--*)
			__gitcomp "--revision="
			;;
		log,--*)
@@ -2106,6 +2106,9 @@ _git_svn ()
				--no-auth-cache --username=
				"
			;;
+		reset,--*)
+			__gitcomp "--revision= --parent"
+			;;
		*)
			COMPREPLY=()
			;;
-- 
1.6.6.rc3.dirty
