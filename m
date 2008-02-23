From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/2] pull: document usage via OPTIONS_SPEC
Date: Fri, 22 Feb 2008 19:52:30 -0500
Message-ID: <1203727950-14980-2-git-send-email-jaysoffian@gmail.com>
References: <1203727950-14980-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 01:53:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSie5-0005OG-9k
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 01:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937377AbYBWAwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 19:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937609AbYBWAwl
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 19:52:41 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:34279 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937377AbYBWAwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 19:52:37 -0500
Received: by an-out-0708.google.com with SMTP id d31so163542and.103
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 16:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=yIOkFAgT8ZgptiCjw89H4zGSYUFoZjKEAtgJQRxbuM0=;
        b=R7/N6RrbqavPIGVmFYztyi/AdOKrFDJjbTkUcTLfrKx6bOTsQoIjujYF7nf8ZkY+C0VO3zJ8g4ebTkmTNLApZK9diyAcmIiM05nCw1Ldr3PYSgRRzdKbOJpBmmRvB+yCcJvpjZ0V3fFsQlYvesq8M0y2g3rDvBWVKQ8VmamihyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=dshS6KwArCbjKsNC0cZp2OlAHGaV/vNsCok8UAmvgZuiZEN3xaRSXibycRgDvOEaHuC4Zqefgy9/FtU+D0RiWwrDhV6RBKLGQYvDRnUTG2rHmqhLCp6wyRYWALxomSfENRnPS3rVJvsoSrhPTu+/rKpLl2VBOQM7l7JAhB216z0=
Received: by 10.100.195.15 with SMTP id s15mr1435752anf.65.1203727956451;
        Fri, 22 Feb 2008 16:52:36 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id c28sm3530623anc.32.2008.02.22.16.52.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Feb 2008 16:52:35 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.285.g1e9f
In-Reply-To: <1203727950-14980-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74774>

document usage via OPTIONS_SPEC

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-pull.sh |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 3ce32b5..194c1d0 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,10 +4,36 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
-USAGE='[-n | --no-summary] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
-LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
+OPTIONS_SPEC="\
+git pull [options] [<repo>] [<refspec>]
+--
+  fetch options
+q,quiet          make the fetch process less verbose
+v,verbose        make the fetch process more verbose
+a,append         append to FETCH_HEAD instead of overwritting
+upload-pack=,    specify path to git-fetch-pack on remote end
+f,force          force local branch to be updated by remote branch
+t,tags           fetch all remote tags
+no-tags          do not fetch any remote tags
+k,keep           keep downloaded pack
+u,update-head-ok used internally between git pull and git fetch
+depth=           deep shallow history by specified number of commits
+  merge options
+summary          show diffstat at end of merge
+n,no-summary     do not show diff stat at end of merge
+commit           commit the result after merging
+no-commit        do not commit the result after merging
+squash           update the index and working tree only
+no-squash        override --squash, perform a normal merge and commit
+ff               only update branch pointer if merge is a fast-forward
+no-ff            do a merge commit even if the merge is a fast-forward
+s,strategy=      use given merge strategy
+  rebase options
+rebase           rebase after fetching
+no-rebase        merge after fetching
+s,strategy=      use given merge strategy; implies -m to rebase
+"
 . git-sh-setup
 set_reflog_action "pull $*"
 require_work_tree
-- 
1.5.4.2.285.g1e9f
