From: "Luis Gutierrez" <Luis.Gutierrez@arm.com>
Subject: git svn problem
Date: Thu, 15 Jul 2010 12:00:33 +0100
Message-ID: <DBB61D38F7942B49AD43397D38954724080AB1@ZIPPY.Emea.Arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 15 13:45:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZMsD-0007Tj-Je
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 13:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757875Ab0GOLo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 07:44:59 -0400
Received: from new-admin0.cambridge.arm.com ([217.140.96.53]:52260 "EHLO
	new-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757438Ab0GOLo6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 07:44:58 -0400
X-Greylist: delayed 2660 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jul 2010 07:44:58 EDT
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by new-admin0.cambridge.arm.com (8.13.8+Sun/8.13.8) with ESMTP id o6FB0poH025617
	for <git@vger.kernel.org>; Thu, 15 Jul 2010 12:00:51 +0100 (BST)
x-mimeole: Produced By Microsoft Exchange V6.5
x-cr-puzzleid: {C0B12E38-06E6-4149-951F-4F3B928DD440}
x-cr-hashedpuzzle: AuyF BIcE BPbp BeGZ CRA/ DMOf DNcw EDQb EISA Emqh GH/I IgEJ JJ+s Jrnv KZ5R Kpfu;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{C0B12E38-06E6-4149-951F-4F3B928DD440};bAB1AGkAcwAuAGcAdQB0AGkAZQByAHIAZQB6AEAAYQByAG0ALgBjAG8AbQA=;Thu, 15 Jul 2010 11:00:33 GMT;ZwBpAHQAIABzAHYAbgAgAHAAcgBvAGIAbABlAG0A
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git svn problem
Thread-Index: AcskDPJaXEIex5XlRr6dW0m2ushHog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151074>

Hi,

I did the usual google search, wiki  and mail list search looking for an
answer, but I can't find it anywhere.

I'm trying to use git svn to interact with (surprise) and SVN
repository. 
git svn clone <url> does the trick in getting a copy of the repo.
However, there are a couple of misbehaving sym links that git-index does
not know how to handle.

Doing a git-svn-rebase or a git-stash will result in this error:

> git stash
Saved working directory and index state WIP on master: 919e091 L2C:
added X-checking assertions and l2c->RAM interface properties.
error: git checkout-index: unable to create symlink < path to file>
(File name too long)
error: git checkout-index: unable to create symlink < path to file >
<filename> (File name too long)
fatal: Could not reset index file to revision 'HEAD'.

As far as I can tell, the symlink was full-path symlink (instead of the
usual relative path) done by someone thousand of svn commits ago.

I've tried with both a full history import, and a shallow (the last 10
commits) import and in both cases I'm stuck with this files.

Now, I can't really replace this file with the svn one because on a
git-svn-dcommit it will try to replace it.

As you can imagine, this is killing all the fun. 

Any ideas on what to do?
I would really love to use git instead of SVN for development, but I'll
settle for using just to browse the history and changes. 

Regards,

Luis Gutierrez
-- 
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
