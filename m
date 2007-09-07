From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: git-svn 1.5.3 does not understand grafts?
Date: Fri, 7 Sep 2007 18:41:17 +0200
Organization: Transmode AB
Message-ID: <1189183276.14841.10.camel@gentoo-jocke.transmode.se>
Reply-To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 18:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITgyV-0005Jo-Ii
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 18:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757881AbXIGQq0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 12:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757877AbXIGQqZ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 12:46:25 -0400
Received: from mail.transmode.se ([83.241.175.147]:4324 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757546AbXIGQqZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 12:46:25 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Sep 2007 12:46:24 EDT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6619.12
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 07 Sep 2007 18:41:17 +0200
X-Mailer: Evolution 2.10.2 
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-svn 1.5.3 does not understand grafts?
Thread-Index: AcfxbelMqS3mhVhFT5GoVe0axpsyCw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58049>

svnadmin create /usr/local/src/TM/svn-tst/7720-svn/
svn mkdir  file:///usr/local/src/TM/svn-tst/7720-svn/trunk -m "Add trunk dir"
svn mkdir  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp -m "Add swp dir"

In my git repo I do
git-svn init  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp 
git-svn fetch
git branch svn remotes/git-svn
#make remotes/git-svn parent to the initial commit in my git tree
graftid=`git-show-ref -s svn`
echo da783cce390ce013b19f1d308ea6813269c6a6b5 $graftid > .git/info/grafts
#da783... is the initial commit in my git tree.
git-svn dcommit

fails with:
Committing to file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp ...
Commit da783cce390ce013b19f1d308ea6813269c6a6b5
has no parent commit, and therefore nothing to diff against.
You should be working from a repository originally created by git-svn


 Jocke
