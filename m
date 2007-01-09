From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Bug in git-status with non-ascii characters:
Date: Tue, 9 Jan 2007 00:09:45 -0500
Message-ID: <7BACA5DE-9DBA-4299-A965-E248263E27E2@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jan 09 06:10:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H49FZ-0003n9-6e
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 06:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbXAIFJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 9 Jan 2007 00:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbXAIFJu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 00:09:50 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:36616 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbXAIFJt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jan 2007 00:09:49 -0500
Received: from [192.168.1.5] (cpe-66-67-221-135.rochester.res.rr.com [66.67.221.135])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 86B271FFC02B
	for <git@vger.kernel.org>; Tue,  9 Jan 2007 05:09:48 +0000 (UTC)
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36309>

`git status` always reports the following:

----- 8< -----
# On branch refs/heads/master
# Untracked files:
#   (use "git add <file>..." to incrementally add content to commit)
#
#       gitweb/test/M=E4rchen
no changes added to commit (use "git add" and/or "git commit [-a|-i|-=20
o]")
----- 8< -----

When I do `rm gitweb/test/M<tab>` to remove this apparently unneeded =20
file, `git status` reports:

----- 8< -----
# On branch refs/heads/master
# Changed but not added:
#   (use "git add <file>..." to incrementally add content to commit)
#
#       deleted:    gitweb/test/M=E4rchen
#
no changes added to commit (use "git add" and/or "git commit [-a|-i|-=20
o]")
----- 8< -----

This is on Mac OS X, file system is HFS+ (Journaled).  Is this =20
expected?  I can't figure out why it's happening.

~~ Brian