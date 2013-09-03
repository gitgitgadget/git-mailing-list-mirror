From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: the pager
Date: Mon, 2 Sep 2013 22:37:45 -0400
Message-ID: <201309030237.r832bjZp014060@freeze.ariadne.com>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 03 04:37:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGgV7-0002qt-36
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 04:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759207Ab3ICChs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 22:37:48 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:52292
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753966Ab3ICChr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 22:37:47 -0400
Received: from omta16.westchester.pa.mail.comcast.net ([76.96.62.88])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id LS341m0031uE5Es53SdmdE; Tue, 03 Sep 2013 02:37:46 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta16.westchester.pa.mail.comcast.net with comcast
	id LSdm1m00A1KKtkw3cSdmRj; Tue, 03 Sep 2013 02:37:46 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r832bjFe014061;
	Mon, 2 Sep 2013 22:37:45 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r832bjZp014060;
	Mon, 2 Sep 2013 22:37:45 -0400
In-reply-to: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
	(worley@alum.mit.edu)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1378175866;
	bh=U2F8muqSiO1heBTiQyES4A2uU9O69dMWIIf2e2V0pIQ=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=ttxh/SrPSxAItr2mP10iKzCAGAKszAMiY2nIVOnHObxPKCRFKexj7Rx03euyyvnZh
	 0ys9aJ2YkIqQX6jtkMOSkT2jOnhCg60RwPN/4zsgRyRQJ9PVZYPG/byY02Y0pXtSA4
	 ljjsTh2e8mu1O9nGWfB0ixuwbb9pcfc5oySPLic7vYaEA9RiEOtwqh8MhbznVomBPX
	 IngPtODfKkxxE8Shat16C/PjFWJM9GdzGyJBuVYDVezOG4Deko2Hg0OPSiZRCSn/3t
	 C0REPp3CSuDZEUGby1fk+GfQzIBlCl0FQAoxF6D0wOjOHGGgmzDYhVW0sARWkebDjY
	 aV8icb1oJoTRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233676>

> I've noticed that Git by default puts long output through "less" as a
> pager.  I don't like that, but this is not the time to change
> established behavior.  But while tracking that down, I noticed that
> the paging behavior is controlled by at least 5 things:
> 
> the -p/--paginate/--no-pager options
> the GIT_PAGER environment variable
> the PAGER environment variable
> the core.pager Git configuration variable
> the build-in default (which seems to usually be "less")

One complication is the meaning of -p/--no-pager:

With the remaining sources, we assume that there is a priority
sequence, and that is used to determine what the pager is.

There is a somewhat independent question of when the pager is
activated.  What I know so far is that some commands use the pager by
default and some by default do not.  My expectation is that
--no-pager can be used to suppress the pager for *any* command.  Is it
also true that -p can force the pager for *any* command, or are there
commands which will not page even with -p?

I assume that if -p is specified but the "which pager" selection is
"cat" (or some other specification of no pager), then there is no
paging operation.

Dale
