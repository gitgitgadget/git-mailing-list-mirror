From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: What's cooking in git/spearce.git (Oct 2008, #02; Sun, 12)
Date: Mon, 13 Oct 2008 01:37:52 -0500
Organization: Exigence
Message-ID: <20081013013752.8fc16695.stephen@exigencecorp.com>
References: <20081012212543.GG4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 08:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpH5A-0008Ur-H2
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 08:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbYJMGh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 02:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbYJMGh5
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 02:37:57 -0400
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:33814 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbYJMGh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 02:37:56 -0400
Received: from relay6.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 2693E1D4075;
	Mon, 13 Oct 2008 02:37:56 -0400 (EDT)
Received: by relay6.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 95C6E1D40DD;
	Mon, 13 Oct 2008 02:37:55 -0400 (EDT)
In-Reply-To: <20081012212543.GG4856@spearce.org>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98087>


> * sh/maint-rebase3 (Sun Oct 5 23:26:52 2008 -0500) 1 commit
>  - rebase--interactive: fix parent rewriting for dropped commits
> 
> A prior version of sh/rebase-i-p.  This should be dropped.

maint-rebase3 is actually a separate issue than sh/rebase-i-p.

maint-rebase3 deals with commits dropped because they are recognized as
cherry picks, while rebase-i-p deals with commits that can be ignored
from the todo because their parents are not being changed.

I'm surprised they both applied cleanly to pu--I was expecting a
conflict, as I noted in one of my posts. I just fetched pu and they
seem to have each broke the each other's tests as well.

To fix this, I have some local changes to pu that gets both tests
passing again. Should I submit my integration changes as a diff on top
of pu? Or should I try and integrate the two patches into one series?

Technically these two fixes are different things, and I assert you
could apply one or the other, but if you apply both, they require
integration, so I'm not sure what to do.

(...nuts, t3404#22 is failing, so my maint3-rebase/rebase-i-p
integration patch is not quite ready yet.)

(I also have a test comment typo and test_expect_failure change to make
to rebase-i-p from Junio's feedback and would like to know the
preferred way to submit those--e.g. a patch on top of your pu, a patch
on top of the existing series, or a new series all together. Given it
is not next, I'm guessing a new series all together.)

Thanks,
Stephen
