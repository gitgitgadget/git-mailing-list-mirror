From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Merging commits together into a super-commit
Date: Thu, 10 May 2007 11:51:01 +0100
Organization: Insert joke here
Message-ID: <1178794261.5806.98.camel@murta.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 12:51:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm6F6-00036k-CZ
	for gcvg-git@gmane.org; Thu, 10 May 2007 12:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbXEJKvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 06:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754343AbXEJKvR
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 06:51:17 -0400
Received: from mx.transitive.com ([217.207.128.220]:54311 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754794AbXEJKvR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 06:51:17 -0400
Received: from [192.168.2.164] (helo=[192.168.2.164])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1Hm5yy-0005jK-OW
	for git@vger.kernel.org; Thu, 10 May 2007 10:34:49 +0000
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46855>

Hi,

I really love the fact I can micro-commit changes when I'm developing.
However at some point the combination of changes I have made can be
considered a single body of work. This is especially true when you start
doing things like re-basing on code that has moved around a lot. You
don't want to be correcting a whole bunch of merge failures for every
commit in your current tree.

So far the only was I can see to do this is a:

git-diff master..HEAD > my.patch

And then re-applying your patch in stages, manually doing the commits.

Am I missing something?

I'm thinking something like git-cherrypick taking multiple commits and
create a new super commit on a new tree. i.e.:

git-cherrypick -m "Valgrind fixes" 12345.. 12678.. 565757..

Merging the existing commit comments would be nice too.

-- 
Alex, homepage: http://www.bennee.com/~alex/
All God's children are not beautiful. Most of God's children are, in
fact, barely presentable. -- Fran Lebowitz, "Metropolitan Life"
