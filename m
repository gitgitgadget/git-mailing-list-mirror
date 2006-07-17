From: "Post, Mark K" <mark.post@eds.com>
Subject: git-repack not removing files from $GIT_DIR/objects/[00-ff]
Date: Sun, 16 Jul 2006 20:44:52 -0400
Message-ID: <5A14AF34CFF8AD44A44891F7C9FF410507E43005@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Mon Jul 17 02:45:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2HEZ-0001rn-Cs
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 02:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWGQApF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 20:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWGQApF
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 20:45:05 -0400
Received: from ahmler3.mail.eds.com ([192.85.154.74]:2753 "EHLO
	ahmler3.mail.eds.com") by vger.kernel.org with ESMTP
	id S1751300AbWGQApD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jul 2006 20:45:03 -0400
Received: from ahmlir4.mail.eds.com (ahmlir4-2.mail.eds.com [192.85.154.134])
	by ahmler3.mail.eds.com (8.13.7/8.12.10) with ESMTP id k6H0j2gZ003040;
	Sun, 16 Jul 2006 20:45:02 -0400
Received: from ahmlir4.mail.eds.com (localhost [127.0.0.1])
	by ahmlir4.mail.eds.com (8.13.7/8.12.10) with ESMTP id k6H0itGY010107;
	Sun, 16 Jul 2006 20:44:55 -0400
Received: from usahm011.amer.corp.eds.com ([130.175.214.152])
	by ahmlir4.mail.eds.com (8.13.7/8.12.10) with ESMTP id k6H0it1w010097;
	Sun, 16 Jul 2006 20:44:55 -0400
Received: from usahm236.amer.corp.eds.com ([130.175.214.169]) by usahm011.amer.corp.eds.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 16 Jul 2006 20:44:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-repack not removing files from $GIT_DIR/objects/[00-ff]
thread-index: AcapOjdECosubpNeTgWs1J8FQtm0BQ==
To: <git@vger.kernel.org>
X-OriginalArrivalTime: 17 Jul 2006 00:44:54.0482 (UTC) FILETIME=[38535320:01C6A93A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23958>

I'm having a problem that just started occurring with git-repack not
removing the files from $GIT_DIR/objects/*, and therefore not removing
the directories, since they're not empty.  The command I'm using (as the
git user) is this:
GIT_DIR=/home/git/pub/scm/linux-2.6.git git-repack -a -d -l

This used to work, but then suddenly stopped working.  I ran an strace
-f -F with this same command, and I don't see any attempt being made to
unlink the files in $GIT_DIR/objects/*/, but I do see the rmdir commands
failing because the directories are not empty.  All of the files in
those directories are owned by git:git.

I tried upgrading to git 1.4.1, but the same thing happens.  The gzipped
strace output is almost 5MB in size, certainly not appropriate to attach
here.  I can make it available from the system's web server if anyone
wants to look at it.

Please let me know if there's any other information needed.


Mark Post
