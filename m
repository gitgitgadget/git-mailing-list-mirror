From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: quote double-dash in "<commit> -- <filename>"
 for AsciiDoc
Date: Tue, 28 Jun 2011 12:17:49 -0500
Message-ID: <20110628171748.GA11485@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 19:32:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbc8e-00065t-PJ
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 19:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441Ab1F1RTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 13:19:46 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45557 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760087Ab1F1RR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 13:17:57 -0400
Received: by iyb12 with SMTP id 12so322552iyb.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=WJyjmrT4nCxzst/bj89ZNnvSABfSOGjYX2P6NKd93Po=;
        b=OD5E/l/RIUKWFvpEVyytQd7RcvQMt0Sgs4ggcVG9MQxwNqKRX7Leys+5iewBHFxMmg
         /W+NhKvIV3tDUuHrVdAwhnMoiMI+OMm011TVVDoeDY+6R/nHgVZJkUacv+D55Q8bW2Ad
         FFOhuMYKyuca0+yOdJK0zoxY0BQ8bH0sKNCa8=
Received: by 10.42.117.73 with SMTP id s9mr9209804icq.250.1309281476228;
        Tue, 28 Jun 2011 10:17:56 -0700 (PDT)
Received: from elie (adsl-69-209-66-254.dsl.chcgil.sbcglobal.net [69.209.66.254])
        by mx.google.com with ESMTPS id hp8sm287451icc.11.2011.06.28.10.17.54
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 10:17:55 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176410>

As explained in v1.7.3-rc0~13^2 (Work around em-dash handling in newer
AsciiDoc, 2010-08-23), outside of verbatim environments, newish
versions of AsciiDoc will convert double hyphens to en dashes.  Use
the litdd syntax introduced by that patch to avoid such misformatting
in sentences where "--" represents the two-character "end of options"
argument that separates revision names from filename patterns.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-commit.txt |    2 +-
 Documentation/git-revert.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 7951cb7b..1764cf10 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -284,7 +284,7 @@ When recording your own work, the contents of modified files in
 your working tree are temporarily stored to a staging area
 called the "index" with 'git add'.  A file can be
 reverted back, only in the index but not in the working tree,
-to that of the last commit with `git reset HEAD -- <file>`,
+to that of the last commit with `git reset HEAD {litdd} <file>`,
 which effectively reverts 'git add' and prevents the changes to
 this file from participating in the next commit.  After building
 the state to be committed incrementally with these commands,
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index ac10cfbb..a516d577 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -23,7 +23,7 @@ throw away all uncommitted changes in your working directory, you
 should see linkgit:git-reset[1], particularly the '--hard' option.  If
 you want to extract specific files as they were in another commit, you
 should see linkgit:git-checkout[1], specifically the `git checkout
-<commit> -- <filename>` syntax.  Take care with these alternatives as
+<commit> {litdd} <filename>` syntax.  Take care with these alternatives as
 both will discard uncommitted changes in your working directory.
 
 OPTIONS
-- 
1.7.6.rc3
