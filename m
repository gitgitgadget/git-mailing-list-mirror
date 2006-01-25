From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Fix git-format-patch -s to include a Signed-off-by: line...
Date: Wed, 25 Jan 2006 13:03:41 -0700
Message-ID: <m1r76why76.fsf@ebiederm.dsl.xmission.com>
References: <7voe212h53.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 21:04:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1qsm-0007hY-IY
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 21:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWAYUEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 15:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWAYUEL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 15:04:11 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64937 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932161AbWAYUEE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 15:04:04 -0500
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k0PK3fEe013799;
	Wed, 25 Jan 2006 13:03:41 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k0PK3fBi013798;
	Wed, 25 Jan 2006 13:03:41 -0700
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe212h53.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 24 Jan 2006 18:08:56 -0800")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15134>


In the last round of bug fixes the signed-off-by line was still be
generated but it was not including a signed-off-by line :(

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 git-format-patch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

78308e7078be1beb979def50579722910f2ff54f
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 7e67c4e..5fb8ce1 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -178,7 +178,7 @@ my ($signoff_pattern, $done_header, $don
     $last_was_signoff);
 
 if ($signoff) {
-	$signoff = `git-var GIT_COMMITTER_IDENT`;
+	$signoff = "Signed-off-by: " . `git-var GIT_COMMITTER_IDENT`;
 	$signoff =~ s/>.*/>/;
 	$signoff_pattern = quotemeta($signoff);
 }
-- 
1.1.4.g7830
