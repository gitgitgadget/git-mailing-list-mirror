From: Pavel Roskin <proski@gnu.org>
Subject: git 1.5.1-rc1 doesn't like empty files
Date: Mon, 19 Mar 2007 23:30:24 -0400
Message-ID: <1174361424.3143.42.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 04:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTV3S-00062P-R5
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 04:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933075AbXCTDad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 23:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933175AbXCTDad
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 23:30:33 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:59420 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933075AbXCTDa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 23:30:27 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HTV1O-0006HX-O1
	for git@vger.kernel.org; Mon, 19 Mar 2007 23:28:26 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HTV3I-0002Ca-Ir
	for git@vger.kernel.org; Mon, 19 Mar 2007 23:30:24 -0400
X-Mailer: Evolution 2.10.0 (2.10.0-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42698>

Hello!

I don't know where this problem appeared, but it present in the current
git (1.5.1-rc1).  Empty files become invalid objects in the repository:

$ touch file 
$ git-init
Initialized empty Git repository in .git/
$ git-add file
$ git-commit -m "first commit"
Created initial commit 16a476808d3cb0a4758997ba58193a9dcfad0fd8
error: garbage at end of loose object
'e69de29bb2d1d6434b8b29ae775ad8c2e48c5391'
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file
$

A file with a one newline is OK (replace "touch file with "echo >file"
and the error will go away).

This is Linux, Fedora Development, i386.

The testsuite fails at test 7 in t9200-git-cvsexportcommit.sh, but it
seems to be unrelated.

-- 
Regards,
Pavel Roskin
