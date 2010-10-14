From: Philippe De Muyter <phdm@macqel.be>
Subject: git-svn : can dcommit commit tags ?
Date: Thu, 14 Oct 2010 14:53:34 +0200
Message-ID: <20101014125334.GA20464@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 14:53:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6NJX-00059o-UV
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 14:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab0JNMxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 08:53:38 -0400
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:37404 "EHLO
	mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753539Ab0JNMxi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 08:53:38 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArcFAGSZtkzCTtAn/2dsb2JhbACTLY14cbwhhUgEikY
Received: from mail.macqel.be ([194.78.208.39])
  by relay.skynet.be with ESMTP; 14 Oct 2010 14:53:36 +0200
Received: from localhost (localhost [127.0.0.1])
	by mail.macqel.be (Postfix) with ESMTP id 18ABC130CE7
	for <git@vger.kernel.org>; Thu, 14 Oct 2010 14:53:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from mail.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GTj9S7oOl-7X for <git@vger.kernel.org>;
	Thu, 14 Oct 2010 14:53:34 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by mail.macqel.be (Postfix) with ESMTP id 8C548130A70
	for <git@vger.kernel.org>; Thu, 14 Oct 2010 14:53:34 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 718D3DF0874; Thu, 14 Oct 2010 14:53:33 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159050>

Hello list,

I have used git for a project, and I am now requested :( to convert
the repo to a svn repo.

I use the following script :

    SVNREPO=${SVNDIR}repo
    svnadmin create ${SVNREPO}
    cd ${GITDIR}
    svn mkdir --parents file://${SVNREPO}/{trunk,tags,branches} -m "Creating repo"
    git svn init file://${SVNREPO} -s
    git svn fetch
    git rebase trunk
    git status
    git svn dcommit -A ~/authorname
    git log
    git tag
    cd ..
    svn co file://${SVNREPO} ${SVNDIR}
    cd ${SVNDIR}
    svn log
    svn ls file://${SVNREPO}/tags

But I did not find a way to recreate the existing git tags in the
svn repository.

How can I achieve that ?

Thanks in advance

Philippe De Muyter
