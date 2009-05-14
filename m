From: Josh Micich <josh.micich@gmail.com>
Subject: Proposed patch for mktree [0/3]
Date: Thu, 14 May 2009 05:06:30 +0000 (UTC)
Message-ID: <loom.20090514T050424-673@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 07:07:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4T9n-0002yo-TV
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 07:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbZENFGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 01:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbZENFGv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 01:06:51 -0400
Received: from main.gmane.org ([80.91.229.2]:37946 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbZENFGu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 01:06:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M4T9b-0006ah-K1
	for git@vger.kernel.org; Thu, 14 May 2009 05:06:48 +0000
Received: from adsl-69-104-91-41.dsl.pltn13.pacbell.net ([69.104.91.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 May 2009 05:06:47 +0000
Received: from josh.micich by adsl-69-104-91-41.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 May 2009 05:06:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.104.91.41 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119136>

Here is a series of 3 patches to git-mktree in addition to the recent work done 
on pu.

The first is just small fixes after the work on the '--missing' option.
The second patch adds a '--batch' option to mktree (similar to '--batch' in 
cat-file) that allows multiple tree objects to be created interactively by a 
single process.
Finally there are some improvements to the validation of the type of object 
identified by the tree entry sha1 (previously the sha1 was only used to check 
for existence, not type).

-josh


Josh Micich (3):
  --missing option for mktree: re-added strbuf_release(&p_uq), Updated man page
  added --batch option to mk-tree
  improved validation of entry type in mktree

 Documentation/git-mktree.txt |   16 ++++++++--
 builtin-mktree.c             |   63 +++++++++++++++++++++++++++++++----------
 2 files changed, 60 insertions(+), 19 deletions(-)
