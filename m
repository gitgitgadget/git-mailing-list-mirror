From: Mark Levedahl <mlevedahl@gmail.com>
Subject: regression in git-gui since 2c5c66b... Merge branch 'jp/get-ref-dir-unsorted
Date: Sun, 16 Oct 2011 14:10:58 -0400
Message-ID: <4E9B1E32.7030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 20:11:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFVBA-00021O-12
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 20:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab1JPSLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 14:11:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:39418 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754977Ab1JPSLL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 14:11:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RFVB0-0001y3-DD
	for git@vger.kernel.org; Sun, 16 Oct 2011 20:11:10 +0200
Received: from pool-173-73-114-154.washdc.fios.verizon.net ([173.73.114.154])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 20:11:10 +0200
Received: from mlevedahl by pool-173-73-114-154.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 20:11:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pool-173-73-114-154.washdc.fios.verizon.net
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183731>

I have a project organized as a number of nested git modules (not using 
git-submodule), and frequently use git-new-workdir to create the nested 
modules.

Since the above merge-commit, git-gui is confused by this arrangement 
and reports every file in every nested module as being an untracked file 
in the top-level (super) project. Prior to the above merge, git-gui 
properly stops recursing when finding a .git directory. git-gui also 
continues working correctly when the modules are full clones, it just 
doesn't work correctly when the .git directory contains symlinks to the 
real .git directory contents.

git-gui works correctly on either parent of the above merge, just not 
after the merge. As the merge was not clean, I guess Junio gets to 
decide who owns the problem :^).

Note that core git is fine up to current master, it is only git-gui that 
has become confused (e.g., git-status shows the top-level directory of 
each nested module as untracked, but does not list files in the nested 
modules).


Mark
