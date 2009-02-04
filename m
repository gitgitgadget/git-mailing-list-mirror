From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Question about --tree-filter
Date: Wed, 4 Feb 2009 16:08:05 +0000 (UTC)
Message-ID: <loom.20090204T155824-858@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 17:11:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUkJy-0000Wr-OR
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 17:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbZBDQIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 11:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbZBDQIW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 11:08:22 -0500
Received: from main.gmane.org ([80.91.229.2]:40555 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbZBDQIW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 11:08:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LUkIT-0000CY-C7
	for git@vger.kernel.org; Wed, 04 Feb 2009 16:08:17 +0000
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:08:17 +0000
Received: from sergio.callegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:08:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.5) Gecko/2008121621 Ubuntu/8.04 (hardy) Firefox/3.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108388>

Hi,

in working with the "rezip" filter for the efficient git management of
openoffice, zip and docx files, I am encountering the following problem.

Suppose that you have an existing repository and that you want to convert it
into a repository using the rezip filters: git filter-branch should be the tool
to do the conversion.

Initially I believed that once set up the appropriate .git/config filter entries
and a .git/info/attributes file tying the filter to the appropriate file types,
it would have been enough to

git filter-branch --tree-filter true tag-name-filter cat

to do the conversion.
This is also what I suggested in my original post about the rezip script.

Unfortunately, this does not seem to work as expected.  Not all files get
rewritten as filtered blobs.  The only way to do the right job seems to use a
tree-filter that touches every single file in the project.

Any idea why it is so?

Also this is not very nice, because it makes the filter-branch result in a huge
amount of work. In other terms, the rezip blob rewriting gets called many many
times more than needed with this technique.

Does anybody have some suggestion of a tree filter that would be both "safe" and
"efficient" ?

Thanks

Sergio 
