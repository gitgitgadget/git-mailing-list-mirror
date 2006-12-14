X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Ignoring local changes
Date: Thu, 14 Dec 2006 16:26:06 +0000 (UTC)
Message-ID: <loom.20061214T171948-279@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 16:26:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 25
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 201.37.99.93 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34364>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GutPn-0006uw-4h for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932853AbWLNQ0c (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 11:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932855AbWLNQ0c
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:26:32 -0500
Received: from main.gmane.org ([80.91.229.2]:50980 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932853AbWLNQ0b
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 11:26:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GutPa-0002ap-LG for git@vger.kernel.org; Thu, 14 Dec 2006 17:26:24 +0100
Received: from C925635D.poa.virtua.com.br ([C925635D.poa.virtua.com.br]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 17:26:22 +0100
Received: from pazu by C925635D.poa.virtua.com.br with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14 Dec 2006
 17:26:22 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Is there any way to make git completely ignore changes to certain local files? I
know about .gitignore, but that doesn't work when the files I want to ignore
were already added to the repository.

A little more context should help you understand my need. I'm currently tracking
a big subversion repository using git-svn; I do all my develop on local git
branches, and later use git-svn dcommit to push these changes to the svn
repository. 

There are some files in the svn repository (and by extension, on my local
mirrored repository) that are almost always locally modified (eclipse/IDEA
project files or generated artifacts that someone else added to svn), but I
almost never want to commit then. This is a hassle in several situations:

1) git-status always show these files as modified, polluting the output and
making it harder for me to pinpoint the "real" changes.
2) git-rebase refuses to run, since the working copy will always be dirty*
3) since git-svn dcommit uses git-rebase, sometimes it fails for the same reason.

So, is there any way to make git look the other way regarding these files?

* I usually get around this making a local commit with the local modifications,
rebasing, and the using git-reset to revert the last commit.

-- Pazu
