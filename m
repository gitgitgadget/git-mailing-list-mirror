From: Anton Korobeynikov <asl@math.spbu.ru>
Subject: Re: Possible bug: git-svn leaves broken tree in case of error
Date: Wed, 31 Oct 2007 17:04:39 +0300
Organization: Saint Petersburg State University
Message-ID: <1193839479.26720.16.camel@asl.dorms.spbu.ru>
References: <1193729426.30755.32.camel@asl.dorms.spbu.ru>
	 <20071031075524.GB7798@muzzle>  <20071031084257.GA2911.SS5073SS@mayonaise>
Reply-To: asl@math.spbu.ru
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:15:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InEMQ-0000gL-Av
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 15:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706AbXJaOPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 10:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbXJaOPn
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 10:15:43 -0400
Received: from star.math.spbu.ru ([195.19.226.178]:1915 "EHLO
	star.math.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbXJaOPm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 10:15:42 -0400
Received: from [195.19.254.136] (asl.dorms.spbu.ru [195.19.254.136])
	by star.math.spbu.ru (8.13.6/8.13.6) with ESMTP id l9VEFZn8040771;
	Wed, 31 Oct 2007 17:15:37 +0300 (MSK)
In-Reply-To: <20071031084257.GA2911.SS5073SS@mayonaise>
X-Mailer: Evolution 2.12.1 
X-Virus-Scanned: ClamAV version 0.88.7, clamav-milter version 0.88.7 on star.math.spbu.ru
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 3.1.0 (2005-09-13) on star.math.spbu.ru
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62834>

Hello, Eric

> With the following test case, I'm not able to reproduce what you're
> describing.
Looks like something nasty here. I also failed to reproduce with such
test, however I definitely was sure, that I modelled it properly.

The typical scenario here is that I'm syncing with external repository
by hands. I tried to replay this with "bad" authors file, but it doesn't
allow me to past through "bad" changeset. And yes, adding new entry to
authors files fixes the problem.

I saw corruption, when git-svn in the next run continues fetch
changesets. As I saw this problem several times with my current setup, I
added some extra backups, so I hope next time I'll catch tree before and
after breakage. Sorry for bothering.

Btw, there is way, how repository can be broken (however, by user only):
after such error 'git fsck' reports dangling trees, and running 'git gc
--prune' will break any future sync.

Anyway, thanks alot.

-- 
With best regards, Anton Korobeynikov.

Faculty of Mathematics & Mechanics, Saint Petersburg State University.
