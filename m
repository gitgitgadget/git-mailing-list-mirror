From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Why is TreeWalk.forPath(...) returning null
Date: Wed, 12 Nov 2008 17:24:30 -0500
Message-ID: <491B579E.6050408@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 23:26:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0OA3-0002Wt-P9
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbYKLWYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbYKLWYa
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:24:30 -0500
Received: from vms173005pub.verizon.net ([206.46.173.5]:52483 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbYKLWYa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 17:24:30 -0500
Received: from [192.168.1.101] ([71.184.206.167]) by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA800MFSRKS6SB9@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 12 Nov 2008 16:24:29 -0600 (CST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100823>


My "git status" command shows:

# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#    modified:   xml/minDB/SubmitObjectsRequest_CMSScheme.xml

The file above was committed and then modified. I want to use jgit to 
find the comitted version of that file.

When I do the following code I get a null treeWalk? Why is that? What 
should I specify for path instead?

            String path = "xml/minDB/SubmitObjectsRequest_CMSScheme.xml";
            String versionName = Constants.HEAD;

            Commit commit = repository.mapCommit(versionName);

            if (commit == null) {
                log.trace("Did not find Commit. versionName:" + 
versionName);
            } else {
                ObjectId[] ids = {commit.getTree().getId()};
                TreeWalk treeWalk = TreeWalk.forPath(repository, path, ids);
            }

Thanks.

-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
