From: Daniel Lenski <dlenski@gmail.com>
Subject: gitk bug? Tree view doesn't show all contents in non-top-level directory
Date: Fri, 13 May 2016 18:17:21 +0000 (UTC)
Message-ID: <loom.20160513T195919-67@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 20:17:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Hee-0005Xu-DG
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 20:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbcEMSRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 14:17:37 -0400
Received: from plane.gmane.org ([80.91.229.3]:58425 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbcEMSRg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 14:17:36 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1b1HeU-0005LP-8s
	for git@vger.kernel.org; Fri, 13 May 2016 20:17:30 +0200
Received: from 70.102.74.164 ([70.102.74.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 May 2016 20:17:30 +0200
Received: from dlenski by 70.102.74.164 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 May 2016 20:17:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 70.102.74.164 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.108 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294554>

Hi all,

I have been running into a bug in gitk, wherein it doesn't show the complete 
contents of the repository in the Tree view, when invoked from a subdirectory 
of the working tree (as opposed to the top level).

The bug is very simple to reproduce:

  $ git --version
  git version 2.8.2
  $ mkdir test
  $ cd test
  $ git init
  $ mkdir subdir
  $ touch a.txt subdir/b.txt
  $ git add a.txt subdir/b.txt 
  $ git ci -m test
  $ gitk &         # All files are shown in Tree view
  $ cd subdir/
  $ gitk &         # Only files under subdir/ are shown in Tree view

The bug seems to only affect the Tree view, *not* the Patch view. All modified 
files are shown in the Patch view. (I think the Patch view may have been fixed 
in 2011: http://thread.gmane.org/gmane.comp.version-control.git/170853)

Thanks,
Dan Lenski
