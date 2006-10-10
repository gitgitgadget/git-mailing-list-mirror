From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] paginate git-diff by default
Date: Tue, 10 Oct 2006 21:16:25 +0200
Message-ID: <20061010191625.GF8612@admingilde.org>
References: <20061010181337.GE8612@admingilde.org> <20061010181558.GB16972@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 21:16:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXN5b-0007PQ-Ll
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 21:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWJJTQ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 15:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWJJTQ1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 15:16:27 -0400
Received: from agent.admingilde.org ([213.95.21.5]:9190 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932253AbWJJTQ0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 15:16:26 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GXN5V-0003vi-IZ; Tue, 10 Oct 2006 21:16:25 +0200
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20061010181558.GB16972@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28656>

On Tue, Oct 10, 2006 at 02:15:58PM -0400, Shawn Pearce wrote:
> Martin Waitz <tali@admingilde.org> wrote:
> > I always find myself typing "git -p diff".
> > Should we paginate git-diff output by default?
>
> I agree.  I'm very used to git log automatically running my $PAGER;
> I'm always surprised that git diff doesn't do the same when attached
> to my tty.

so here is the overly complex implementation:

---
diff --git a/git.c b/git.c
index 03acb25..3408e81 100644
--- a/git.c
+++ b/git.c
@@ -226,7 +226,7 @@ static void handle_internal_command(int
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
-		{ "diff", cmd_diff, RUN_SETUP },
+		{ "diff", cmd_diff, RUN_SETUP | USE_PAGER },
 		{ "diff-files", cmd_diff_files, RUN_SETUP },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-stages", cmd_diff_stages, RUN_SETUP },

-- 
Martin Waitz
