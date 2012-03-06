From: Ben Tebulin <nntp.20.jexpert@spamgourmet.com>
Subject: Git on SVN: space characters in branch names
Date: Tue, 06 Mar 2012 18:31:27 +0100
Message-ID: <jj5hl0$7dm$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 18:35:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4yI7-0006jx-8T
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 18:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735Ab2CFRfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 12:35:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:43936 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755947Ab2CFRfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 12:35:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S4yHw-0006WQ-3U
	for git@vger.kernel.org; Tue, 06 Mar 2012 18:35:04 +0100
Received: from 217.6.238.194 ([217.6.238.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 18:35:04 +0100
Received: from nntp.20.jexpert by 217.6.238.194 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 18:35:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 217.6.238.194
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192366>

Hi! I'm trying to move to Git on top of Subversion in my company
environment using Cygwin/Git 1.7.9. Therefore I'm trying to clone
a set of SVN repositories.

The SVN repository I'm trying to clone contains a commit, where a
branch was accidentally named "1.1.x _M1":

   git svn clone -s https://svnserver/repository project.git \
       --ignore-path=".*(?:1.1.x _M1|1.1.x%20_M1)"


This skips the initial commit, but still stumbles on the rename commit:

   Found possible branch point: \
	https://svnserver/repository/branches/1.1.x _M1 => \
	https://svnserver/repository/branches/1.1.x_M1, 2374
   fatal: Not a valid object name refs/remotes/1.1.x _M1
   cat-file commit refs/remotes/1.1.x _M1: command returned error: 128


Do I have to ignore the branch completely?

Thanks
- Ben
