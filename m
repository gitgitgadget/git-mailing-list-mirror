From: Paul Collins <paul@burly.ondioline.org>
Subject: btrfs and git-reflog
Date: Fri, 25 Jan 2008 21:15:26 +1300
Message-ID: <873asmcodd.fsf@burly.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: btrfs-devel@oss.oracle.com
X-From: git-owner@vger.kernel.org Fri Jan 25 09:28:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIJvS-0008JO-4z
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 09:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765321AbYAYI11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 03:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761211AbYAYI10
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 03:27:26 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:49712 "EHLO
	jenny.ondioline.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932369AbYAYI1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 03:27:25 -0500
Received: by jenny.ondioline.org (Postfix, from userid 10)
	id 0F34F3A17A9; Fri, 25 Jan 2008 21:18:09 +1300 (NZDT)
Received: by burly.wgtn.ondioline.org (Postfix, from userid 1000)
	id 2A6E63B179; Fri, 25 Jan 2008 21:15:26 +1300 (NZDT)
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71687>

I was just playing with git 1.5.3.8 and btrfs 0.11, and I noticed
something odd.

If I prepare a very simple repository:

  $ mkdir foo
  $ cd foo
  $ git init
  Initialized empty Git repository in .git/
  $ echo hi > blort
  $ git add .
  $ git commit -m create
  Created initial commit 4ae9415: create
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 blort

and then attempt to expire the reflogs

  $ git-reflog --expire --all

on ext3, git-reflog completes its work and exits immediately;

and on btrfs, it gets stuck in some sort of loop that causes it to
allocate more and more memory until I kill it or it pushes the
machine into OOM.

Kernel is 2.6.24 or so on x86-64.

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
