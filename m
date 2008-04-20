From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] completion: allow 'git remote' subcommand completion
Date: Sun, 20 Apr 2008 14:34:07 -0500
Message-ID: <1208720047-5200-1-git-send-email-dpmcgee@gmail.com>
References: <20080420192259.GI29771@spearce.org>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:35:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnfJR-0002jc-Ez
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 21:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127AbYDTTeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 15:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755854AbYDTTeL
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 15:34:11 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:59599 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437AbYDTTeK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 15:34:10 -0400
Received: by py-out-1112.google.com with SMTP id u52so2131635pyb.10
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=22XPeaBoZPzLykEhhaB4sKnACZwRAph+srTrVWlzlqs=;
        b=u5WTsUKqBKo+l9QuRPEmREyGoPR+0OM6LycIL6nKITOCD8GRMmAWE7zw3Sm0W5tA7Saw8kQPgbnTA8kaGR4n/BZ5jpPJ0q6vPNDHzlI973rHCfhwX8iedI5sHIbLCMfry/VfxbFQgtTwDf2w9VLl7WcewFdG+yom71ZR8nfazlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h7MzaLFOpotFjWRHKEGZSDJNSXkIlXeByr/fXSXm+QUAp3F1SDZbl7mCkO6q/RGl0b9sP3OllQF6v8kN+9gzoflSKImxkTSWj+Hmlqx88NgqkFX2Y0YduKz/IZ0rZkfy2Ced/X41DRkxO4hEUEf9HNxaNqAhyLLp1iKKkrvX23A=
Received: by 10.35.70.17 with SMTP id x17mr9078689pyk.12.1208720049452;
        Sun, 20 Apr 2008 12:34:09 -0700 (PDT)
Received: from localhost ( [76.193.177.245])
        by mx.google.com with ESMTPS id z52sm3722973pyg.1.2008.04.20.12.34.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Apr 2008 12:34:08 -0700 (PDT)
X-Mailer: git-send-email 1.5.5
In-Reply-To: <20080420192259.GI29771@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79980>

After typing 'git remote ', the subcommand options were not shown. Fix it
by adding the missing __gitcomp call.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---

Resubmit per Shawn's comments- duh. I was just thinking backwards since
remote has a prune subcommand.

 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3f78630..6012047 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1052,6 +1052,7 @@ _git_remote ()
 	local subcommands="add rm show prune update"
 	local subcommand="$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
 		return
 	fi
 
-- 
1.5.5
