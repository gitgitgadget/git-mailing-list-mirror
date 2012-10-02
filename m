From: Brian Charles Gernhardt <gernhard@cs.rochester.edu>
Subject: t4055 failure: see error
Date: Tue, 2 Oct 2012 08:18:22 -0400
Message-ID: <7667682A-3BDB-484F-A3E4-0E5826FD2076@cs.rochester.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 15:04:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ28g-0000F0-NQ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 15:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab2JBNDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 09:03:44 -0400
Received: from slate.cs.rochester.edu ([192.5.53.101]:35938 "EHLO
	slate.cs.rochester.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab2JBNDn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2012 09:03:43 -0400
X-Greylist: delayed 2713 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Oct 2012 09:03:43 EDT
Received: from [10.10.10.10] (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	(authenticated bits=0)
	by slate.cs.rochester.edu (8.14.4/8.14.4) with ESMTP id q92CINsR019336
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 2 Oct 2012 08:18:29 -0400
X-Mailer: Apple Mail (2.1498)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206795>

Another problem caused by BSD v GNU sed, I think.

$ ./t4055-diff-context.sh -i -v
Initialized empty Git repository in /Users/brian/dev/git/t/trash directory.t4055-diff-context/.git/
expecting success: 
	cat >x <<-\EOF &&
	firstline
	b
	c
	d
	e
	f
	preline
	postline
	i
	j
	k
	l
	m
	n
	EOF
	git update-index --add x &&
	git commit -m initial &&

	git cat-file blob HEAD:x |
	sed "/preline/a\
	ADDED" >x &&
	git update-index --add x &&
	git commit -m next &&

	git cat-file blob HEAD:x |
	sed s/ADDED/MODIFIED/ >x

[master (root-commit) d5fa2e5] initial
 Author: A U Thor <author@example.com>
 1 file changed, 14 insertions(+)
 create mode 100644 x
sed: 1: "/preline/a	ADDED": command a expects \ followed by text
