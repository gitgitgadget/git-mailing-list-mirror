From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] Documentation: point to related commands from gitignore
Date: Wed, 10 Nov 2010 13:00:48 -0600
Message-ID: <20101110190048.GC12365@burratino>
References: <1289387440-8509-1-git-send-email-sitaram@atc.tcs.com>
 <20101110185555.GA12365@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sitaram Chamarty <sitaram@atc.tcs.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 20:01:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGFv3-0006lL-0i
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 20:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab0KJTBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 14:01:11 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47602 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab0KJTBK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 14:01:10 -0500
Received: by pzk28 with SMTP id 28so235070pzk.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 11:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0bvYrZGtg8tff78/c0vrXZR+XfyOZvuR/2d7rIdiJNA=;
        b=MmWPhWb66JnoEm8i623bngMeutOVrCAkrq1lfh7QlPCHkRbCEjM4qXbUKNDZVhwSMC
         odHahIz1lnHPtnilhnkTEgqAg+m3t90fnvo2km1JHo7W/CwEVGGV/ET+1HKhrtjJY8YK
         B4CFna0/jtq4Lt/XTi5ZIrb9OJultWUFEH0TM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UhP9+GSu/28kDZDAfDQ7ykIfRLCsXc2ToMH2Q4AZd2DImVw1r87SzBmo0F7qEs1T2t
         fxLAmjKN0MyvLf3DhuIzN3KrK2Y+ienq/hBpyomXrz67lD32++Z3mWgzoqgfpz+BMQcp
         8A9QrpiOVdnv3kFrHiwCsYRJVMQinxnLa8sjc=
Received: by 10.142.156.3 with SMTP id d3mr1969408wfe.202.1289415669434;
        Wed, 10 Nov 2010 11:01:09 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id e18sm285280vcf.36.2010.11.10.11.01.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 11:01:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101110185555.GA12365@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161172>

A frequently asked question on #git is how to stop tracking a file
that is mistakenly tracked by git.  A frequently attempted strategy is
to add such files to .gitignore.

Thus one might imagine that the gitignore documentation could be a
good entry point for 'git rm' documentation.  Add some
cross-references in this vein.

While at it, move a reference to update-index --assume-unchanged from
the DESCRIPTION to lower down on the page.  This way, the methodical
reader can benefit from first learning what excludes files do, then
how they relate to other git facilities.

Based-on-patch-by: Sitaram Chamarty <sitaram@atc.tcs.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 This NOTES section is a bit of a placeholder.  I think it is an
 improvement already, but if someone wants to flesh it out I wouldn't
 complain.

 Hope that helps.

 Documentation/gitignore.txt |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 254bc1a..8416f34 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -14,11 +14,8 @@ DESCRIPTION
 
 A `gitignore` file specifies intentionally untracked files that
 git should ignore.
-Note that all the `gitignore` files really concern only files
-that are not already tracked by git;
-in order to ignore uncommitted changes in already tracked files,
-please refer to the 'git update-index --assume-unchanged'
-documentation.
+Files already tracked by git are not affected; see the NOTES
+below for details.
 
 Each line in a `gitignore` file specifies a pattern.
 When deciding whether to ignore a path, git normally checks
@@ -99,6 +96,18 @@ PATTERN FORMAT
    For example, "/{asterisk}.c" matches "cat-file.c" but not
    "mozilla-sha1/sha1.c".
 
+NOTES
+-----
+
+The purpose of gitignore files is to ensure that certain files
+not tracked by git remain untracked.
+
+To ignore uncommitted changes in a file that is already tracked,
+use 'git update-index {litdd}assume-unchanged'.
+
+To stop tracking a file that is currently tracked, use
+'git rm --cached'.
+
 EXAMPLES
 --------
 
@@ -142,6 +151,11 @@ Another example:
 The second .gitignore prevents git from ignoring
 `arch/foo/kernel/vmlinux.lds.S`.
 
+SEE ALSO
+--------
+linkgit:git-rm[1], linkgit:git-update-index[1],
+linkgit:gitrepository-layout[5]
+
 Documentation
 -------------
 Documentation by David Greaves, Junio C Hamano, Josh Triplett,
-- 
1.7.2.3.557.gab647.dirty
