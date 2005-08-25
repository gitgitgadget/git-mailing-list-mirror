From: Darrin Thompson <darrint@progeny.com>
Subject: Merges without bases
Date: Thu, 25 Aug 2005 16:10:28 -0500
Message-ID: <1125004228.4110.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 25 23:12:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8OzY-0007W1-B0
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 23:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbVHYVK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 17:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbVHYVK3
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 17:10:29 -0400
Received: from zealot.progeny.com ([216.37.46.162]:6276 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S1751469AbVHYVK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 17:10:29 -0400
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP id 7AD20636A4
	for <git@vger.kernel.org>; Thu, 25 Aug 2005 16:10:28 -0500 (EST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7764>

I have a weird situation I want to support. I want to be able to merge a
foreign-tree repeatedly.

What makes the foreign tree foreign is that it may not yet share any
history with this branch.

What I tried to do was fetch foreign tree material and run octopus.
Octopus understandably barfed when it could not find a merge base for
the foreign tree.

What I think is newsworthy is that I figured out a sick way to get it
done. I created an empty tree object and used it as the merge base for
git-read-tree -m.

Could git-read-tree -m 3-args be made smart enough to treat a 0 as arg 1
as an implicit empty tree?

Once that is done, git octopus will be able to handle the no merge base
case.

--
Darrin
