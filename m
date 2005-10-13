From: Zack Brown <zbrown@tumblerings.org>
Subject: cg-prev and cg-next
Date: Thu, 13 Oct 2005 07:38:52 -0700
Message-ID: <20051013143852.GA5057@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 13 16:49:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ4Ec-0005Ty-Ox
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 16:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVJMOjD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 10:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbVJMOjD
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 10:39:03 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:43904 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S1751400AbVJMOjC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 10:39:02 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.52)
	id 1EQ4EO-000319-Ei
	for git@vger.kernel.org; Thu, 13 Oct 2005 07:38:52 -0700
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10072>

Hi folks,

Sometimes I just want to surf through a project's history, getting a sense of
where I was over time. So I wrote these short scripts to let me do that easily:

cg-prev:

    cg-seek `cg-log | grep "^commit " | head -n 2 | tail -n 1 | cut -d ' ' -f 2`


cg-next:

    CURRENT=`cg-log | grep "^commit " | head -n 1`       
    cg-seek > /dev/null
    cg-seek `cg-log | grep "^commit " | grep -B 1 "^$CURRENT" | head -n 1 | cut -d ' ' -f 2`

Even better, I guess would be to be able to do something like this:

$ cg-seek next
$ cg-seek prev

and have it do the right thing.

Be well,
Zack

-- 
Zack Brown
