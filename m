X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: git-commit: select which files to commit while editing the commit message
Date: Fri, 8 Dec 2006 12:36:31 +0000 (UTC)
Message-ID: <loom.20061208T131919-178@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 12:37:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 201.37.99.93 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33693>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GseyS-0007Y0-8z for gcvg-git@gmane.org; Fri, 08 Dec
 2006 13:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425492AbWLHMgs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 07:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425491AbWLHMgr
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 07:36:47 -0500
Received: from main.gmane.org ([80.91.229.2]:49143 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425492AbWLHMgq
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 07:36:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gsexx-0004OH-IH for git@vger.kernel.org; Fri, 08 Dec 2006 13:36:38 +0100
Received: from C925635D.poa.virtua.com.br ([C925635D.poa.virtua.com.br]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 13:36:37 +0100
Received: from pazu by C925635D.poa.virtua.com.br with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006
 13:36:37 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio's reworking of the git-commit documentation, and the ensuing discussion
about what is commited, and how do you select that, made me remember how much I
liked SVK -- particularly, how much I liked to remove files from the commit
message template, and have them removed from the commit.

At first, I thought "great opportunity to contribute my first patch to git",
until I realized that git-commit is written in bash, and my brain refuses to
understand that. Yep, I'm that bad. So I'm writing this, and maybe someone
well-versed in bash will find this a good idea and code it :-)

For those not familiar with SVK, if you remove the files mentioned in the commit
template (that "here are the files that you're about to commit" part), SVK won't
commit them. For example, if I modify a couple of files in git, and execute 'git
commit -a', an editor will popup showing something like this:

# Please enter the commit message for your changes.
# (Comment lines starting with '#' will not be included)
# On branch refs/heads/next
# Updated but not checked in:
#   (will commit)
#
#	modified:   perl/Makefile
#	modified:   var.c

Here's where the magic would happen. Removing the line "modified: var.c" would
remove var.c from this commit. Of course, the template message should be
modified to tell the user he can do that.

So, what do you think about this?

-- Pazu
