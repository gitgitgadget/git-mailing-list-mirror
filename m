From: Yuri D'Elia <wavexx@users.sf.net>
Subject: rename tracking and file-name swapping
Date: Sun, 13 Sep 2009 13:17:13 +0200
Message-ID: <wavexx-2ECE7F.13171313092009@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 13:21:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmn8h-0002cm-Uv
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 13:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbZIMLUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 07:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbZIMLUD
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 07:20:03 -0400
Received: from lo.gmane.org ([80.91.229.12]:59118 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbZIMLUC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 07:20:02 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mmn7k-0002Ni-Mn
	for git@vger.kernel.org; Sun, 13 Sep 2009 13:20:04 +0200
Received: from 88-149-143-162.dynamic.ngi.it ([88.149.143.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 13:20:04 +0200
Received: from wavexx by 88-149-143-162.dynamic.ngi.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 13:20:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 88-149-143-162.dynamic.ngi.it
User-Agent: MT-NewsWatcher/3.5.2 (PPC Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128356>

Hi everyone. Does rename tracking recognize two file names being swapped?

% ls -l
total 24
-rw-rw-r--   1 wavexx  wavexx  5952 Sep 13 13:09 file1.txt
-rw-rw-r--   1 wavexx  wavexx  3330 Sep 13 13:09 file2.txt
% mv file1.txt file3.txt 
% mv file2.txt file1.txt
% mv file3.txt file2.txt
% git add file1.txt file2.txt 
% git diff -M --stat --cached
 file1.txt |  150 +++++++++++++++++++++++-------------------------------------
 file2.txt |  150 +++++++++++++++++++++++++++++++++++++-----------------------
 2 files changed, 150 insertions(+), 150 deletions(-)

I would expect at least to see

  file1.txt => file2.txt
  file2.txt => file1.txt

if the contents are totally unchanged.

Am I doing something wrong?

Thanks
