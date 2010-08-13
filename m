From: Steve Folly <steve@spfweb.co.uk>
Subject: git fetch origin --tags --prune deletes origin/master?
Date: Fri, 13 Aug 2010 08:36:28 +0000 (UTC)
Message-ID: <loom.20100813T102636-936@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 10:36:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojpkv-0005Ed-Mo
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 10:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934080Ab0HMIgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 04:36:45 -0400
Received: from lo.gmane.org ([80.91.229.12]:37323 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934087Ab0HMIgh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 04:36:37 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ojpki-00059G-9W
	for git@vger.kernel.org; Fri, 13 Aug 2010 10:36:36 +0200
Received: from 82.152.64.57 ([82.152.64.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 10:36:36 +0200
Received: from steve by 82.152.64.57 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 10:36:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.152.64.57 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-gb) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153465>

Hi,

Using git 1.7.2.1...

Doing "git fetch origin --tags --prune" deletes my local ref of
origin/master? Is this right? The remote is not affected. To reproduce:

$ cd /tmp &&
    git init --bare remote.git &&
    git clone remote.git local &&
    cd local &&
    touch file &&
    git stage file &&
    git commit -m "add file"
    git push origin master

$ git branch -a
* master
  remotes/origin/master

$ git fetch origin --tags --prune
 x [deleted]         (none)     -> origin/master

$ git branch -a
* master

$ git fetch 
From /tmp/remote
 * [new branch]      master     -> origin/master

$ git branch -a
* master
  remotes/origin/master


Am I just not understanding something or is this a bug?

Cheers,
Steve
