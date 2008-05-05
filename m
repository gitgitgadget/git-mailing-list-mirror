From: Bryan Donlan <bdonlan@fushizen.net>
Subject: Re: [PATCH v3 00/10] Fix git's test suite to pass when the path
	contains spaces
Date: Mon, 5 May 2008 03:59:40 -0400
Message-ID: <20080505075940.GB20537@shion.is.fushizen.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net> <1209879480-16910-1-git-send-email-bdonlan@fushizen.net> <481EB155.6050501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 05 10:00:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsvcc-00081w-OI
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 10:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbYEEH7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 03:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbYEEH7m
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 03:59:42 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:55726 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbYEEH7l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 03:59:41 -0400
Received: from [130.111.233.78] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1Jsvbo-0004Jo-PZ; Mon, 05 May 2008 07:59:40 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1Jsvbo-0005gW-UE; Mon, 05 May 2008 03:59:40 -0400
Content-Disposition: inline
In-Reply-To: <481EB155.6050501@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81240>

On Mon, May 05, 2008 at 09:03:49AM +0200, Johannes Sixt wrote:
> Bryan Donlan schrieb:
> > This patch series fixes bugs in git and git's testsuite to allow all tests
> > to pass when the working directory contains whitespace and/or shell
> > metacharacters.
> 
> Thanks a lot, it's appreciated.
> 
> > Bryan Donlan (10):
> >   git-rebase.sh: Fix --merge --abort failures when path contains
> >     whitespace
> >   config.c: Escape backslashes in section names properly
> >   git-send-email.perl: Handle shell metacharacters in $EDITOR properly
> >   test-lib.sh: Add a test_set_editor function to safely set $VISUAL
> >   Use test_set_editor in t9001-send-email.sh
> >   test-lib.sh: Fix some missing path quoting
> >   lib-git-svn.sh: Fix quoting issues with paths containing shell
> >     metacharacters
> >   Don't use the export NAME=value form in the test scripts.
> >   Fix tests breaking when checkout path contains shell metacharacters
> >   Rename the test trash directory to contain spaces.
> 
> The last patch breaks t9400-git-cvsserver-server.sh on my system:
> 
> * expecting success: cat request-anonymous | git-cvsserver --strict-paths
> pserver $SERVERDIR >log 2>&1 &&
>    sed -ne \$p log | grep "^I LOVE YOU$"
> * FAIL 9: req_Root (strict paths)
>         cat request-anonymous | git-cvsserver --strict-paths pserver
> $SERVERDIR >log 2>&1 &&
>            sed -ne \$p log | grep "^I LOVE YOU$"
> 
> D-Quoting $SERVERDIR helps. ;)

Hm, seems I don't have cvs installed :) Will fix.

> 
> Please post an incremental diff when you resend it. Feel free to add:

When you say post an incremental diff, do you mean send just an
additional patch to squash in, or re-send the series with an interdiff
from the previous?

> 
> Tested-by: Johannes Sixt <johannes.sixt@telecom.at>

And does this go on a specific patch or the whole series?

> 
> -- Hannes
> 
> 
