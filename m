From: Tim Olsen <tim@brooklynpenguin.com>
Subject: still getting 'It is a submodule!" in 1.6.2.5
Date: Mon, 04 May 2009 16:39:35 -0400
Message-ID: <gtnjq8$317$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 22:41:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M14xy-0005pm-C0
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 22:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbZEDUj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 16:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbZEDUj4
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 16:39:56 -0400
Received: from main.gmane.org ([80.91.229.2]:46204 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbZEDUjz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 16:39:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M14x8-00089y-41
	for git@vger.kernel.org; Mon, 04 May 2009 20:39:54 +0000
Received: from cyrus.limewire.com ([76.8.67.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 May 2009 20:39:54 +0000
Received: from tim by cyrus.limewire.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 May 2009 20:39:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cyrus.limewire.com
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118261>

Hello.  I reported a bug last week [1] with regard to merging a
repository that contains submodules.  To summarize the bug, I was
getting the following error message from git-merge:

fatal: cannot read object 83055ffdddde60d41d9811aae77e78be50b329f8
'rubydav': It is a submodule!

when rubydav was never not a submodule.

Clemens replied with a patch [2], but I don't think it got into git's git.

Junio replied with two versions of a patch [3, 4], of which one of them
appears to have made it into git's git as commit
7dae8b21c2fe39a59661c709f0dc17090dafa5a4

1.6.2.5 was then released yesterday which has commit
7dae8b21c2fe39a59661c709f0dc17090dafa5a4.

So I tried out 1.6.2.5 but I got the same error :-(

To help others reproduce the bug, I have made a clone of our git
repository publicly available.  Here are the steps to reproduce the error:

~/git$ git clone git://nolita.limebits.net/limebits-merge-bug
~/git$ cd limebits-merge-bug/
~/git/limebits-merge-bug$ git branch --track 0.15.x origin/0.15.x
Branch 0.15.x set up to track remote branch refs/remotes/origin/0.15.x.
~/git/limebits-merge-bug$ git checkout 0.15.x
Switched to branch '0.15.x'
~/git/limebits-merge-bug$ git merge origin/bits-tiddlywiki-01
fatal: cannot read object ef0b013adc08cb28a35e790088e55df3fb2d7b15
'server': It is a submodule!
~/git/limebits-merge-bug$

Again, 'server' has never been anything but a submodule.

Thanks for the help!

Tim


[1] http://marc.info/?l=git&m=124094048321413&w=2
[2] http://marc.info/?l=git&m=124099458427695&w=2
[3] http://marc.info/?l=git&m=124103124319607&w=2
[4] http://marc.info/?l=git&m=124103686729847&w=2
