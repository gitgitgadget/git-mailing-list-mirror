From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [TRYTHIS] cvsimport: fix initial import
Date: Tue, 27 Jun 2006 12:35:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606271234350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44A102F0.9090604@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 27 12:36:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvAvH-0007he-81
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 12:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWF0Kfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 06:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWF0Kfr
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 06:35:47 -0400
Received: from mail.gmx.net ([213.165.64.21]:14246 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751087AbWF0Kfq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 06:35:46 -0400
Received: (qmail invoked by alias); 27 Jun 2006 10:35:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 27 Jun 2006 12:35:44 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44A102F0.9090604@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22723>

---
Hi,

On Tue, 27 Jun 2006, Andreas Ericsson wrote:

> Sadly, the cvsimport command no longer works to create new repositories from
> scratch. I'm not nearly perl literate enough to fix it, but the problem seems
> to be firstly 061303f0b50a648db8e0af23791fc56181f6bf93.

My bad. Could you try this patch on top of 'next'?

 git-cvsimport.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 50f5d96..f8eb6ef 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -471,7 +471,6 @@ my %index; # holds filenames of one inde
 
 $ENV{GIT_INDEX_FILE} = $index{$opt_o};
 system("git-read-tree", $opt_o);
-die "read-tree failed: $?\n" if $?;
 
 unless(-d $git_dir) {
 	system("git-init-db");
