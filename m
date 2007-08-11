From: Mark Levedahl <mlevedahl@verizon.net>
Subject: [BUG} git-fetch - won't fetch wildcarded tags
Date: Fri, 10 Aug 2007 22:59:08 -0400
Message-ID: <46BD25FC.1050201@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 04:59:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJhCW-0006Bw-8L
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 04:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761054AbXHKC71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 22:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761133AbXHKC71
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 22:59:27 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:38273 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761054AbXHKC70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 22:59:26 -0400
Received: from [192.168.100.117] ([71.246.233.117])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JML00HAN9MK2CZ9@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 10 Aug 2007 21:59:08 -0500 (CDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55583>

git fetch does not seem to handle refs/tags/* refspecs, at least no from 
bundles...

git>git bundle create /tmp/foo v1.5.2
<snip>
git>git ls-remote /tmp/foo
8b1e5575ab18757272e86c5ec7a10411bbaa3662        refs/tags/v1.5.2
git>git tag -d v1.5.2
Deleted tag v1.5.2.
git>git fetch /tmp/foo 'refs/tags/*:refs/tags/*'
* refusing to create funny ref 'tags/*' locally


Huh?

but...
git>git fetch /tmp/foo 'refs/tags/v1.5.2:refs/tags/v1.5.2'
* refs/tags/v1.5.2: storing tag 'v1.5.2' of /tmp/foo
  tag: 8b1e557

What's going on? This is a severe limitation of the utility of bundles 
to transmit tagged versions.

Mark
