From: Eric Raible <raible+git@gmail.com>
Subject: RFH: spawning pager takes long time when when unconnected from network
Date: Tue, 10 Feb 2009 02:07:10 +0000 (UTC)
Message-ID: <loom.20090210T015515-886@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 03:17:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWiBA-0007yP-QB
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 03:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbZBJCPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 21:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752992AbZBJCPG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 21:15:06 -0500
Received: from main.gmane.org ([80.91.229.2]:51930 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952AbZBJCPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 21:15:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LWi9O-0007bp-DT
	for git@vger.kernel.org; Tue, 10 Feb 2009 02:15:02 +0000
Received: from mail.nextest.com ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 02:15:02 +0000
Received: from raible+git by mail.nextest.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 02:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109175>

Hello All -

I've got a weird one which I haven't been able to figure out.
The problem is that git sometimes takes a long time (~5-10 seconds)
before producing output when it needs to internally spawn a pager.

This only occurs when I'm not plugged in to a network.
When I'm plugged in everything operates at the normal speed.

This would be slow: git diff some-branch
This would be fast: git diff some-branch | less

Unsetting core.pager (IOW setting core.pager="") is also fast.

Tracking this down has been problematic, because I suspect it's
got to do with the relative timing of the two processes, and I
don't know the code well enough to figure out an effective debugging
strategy.

Any ideas or things to try?

Thanks - Eric
