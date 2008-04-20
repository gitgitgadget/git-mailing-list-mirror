From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] completion: allow 'git remote' subcommand completion
Date: Sun, 20 Apr 2008 12:28:45 -0500
Message-ID: <1208712525-1747-2-git-send-email-dpmcgee@gmail.com>
References: <1208712525-1747-1-git-send-email-dpmcgee@gmail.com>
Cc: git@vger.kernel.org, Dan McGee <dpmcgee@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Apr 20 19:29:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JndM8-00013N-Mf
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 19:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbYDTR2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 13:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754319AbYDTR2w
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 13:28:52 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:42794 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbYDTR2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 13:28:51 -0400
Received: by py-out-1112.google.com with SMTP id u52so2066231pyb.10
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ue7q65aKapSAq3DI5dI1TBemjXkG3M4Wpo0O5HLlMv4=;
        b=d6jngvkmSuQ+KcIN3hQYp+dw9fkus+o2Hl8+Md/XBxgHFCRMg3ps3+ZR14PEAoM1QIhIausXHnQesMRVfKElW/nEro1ReXQRb3sWyjx2cSgOwI1YoObBrDM7Wk09Uo9P7R5NLtREDQf54LkYaTtsWyCGfHJg+A1LWLERw9OEwLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ScBJc4cONT36JwdXju0bUpeWR1b3DJpWxvsD/sfPXT/6Ido1+O4JIqEOmGnZTTdwkhnBjcCOu+jQLt9Mdibb0u8w59umRcz8FZNHWIbvQucOOL4mJ543X9rQfbTVqufRaHyzh/2g74Q/mfR4Gr47Qrnu7PajcVCJ1SZSG+BqjQs=
Received: by 10.35.65.17 with SMTP id s17mr8866440pyk.37.1208712530731;
        Sun, 20 Apr 2008 10:28:50 -0700 (PDT)
Received: from localhost ( [76.193.177.245])
        by mx.google.com with ESMTPS id f79sm3515568pyh.25.2008.04.20.10.28.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Apr 2008 10:28:49 -0700 (PDT)
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208712525-1747-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79968>

After typing 'git prune ', the subcommand options were not shown. Fix it.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
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
