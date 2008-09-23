From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 13:16:24 +0200
Message-ID: <20080923111624.GA20259@neumann>
References: <20080922155749.c8070681.stephen@exigencecorp.com>
	<20080922231927.ef18f420.stephen@exigencecorp.com>
	<48D88813.9060400@viscovery.net>
	<20080923024653.a3bb8666.stephen@exigencecorp.com>
	<48D8A6EA.4020805@op5.se>
	<20080923040302.c4d0d33b.stephen@exigencecorp.com>
	<48D8B2C1.5070800@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 23 13:17:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki5th-0003lD-0U
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 13:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbYIWLQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Sep 2008 07:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbYIWLQ2
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 07:16:28 -0400
Received: from francis.fzi.de ([141.21.7.5]:17575 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751178AbYIWLQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 07:16:27 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Sep 2008 13:16:24 +0200
Content-Disposition: inline
In-Reply-To: <48D8B2C1.5070800@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 23 Sep 2008 11:16:24.0951 (UTC) FILETIME=[D0DC5070:01C91D6D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96548>

Hi,

On Tue, Sep 23, 2008 at 11:11:29AM +0200, Andreas Ericsson wrote:
> That's beside the point though, as I firmly believe git should be mor=
e
> helpful in this situation. If "git rebase -i -p" doesn't help you fix
> the problems, I'll see what I can do to help.
I will just throw in an other workflow, where keeping merges during
(non-interactive) rebase would be really helpful for me.

The DAG looks like this:

  -A--------------H    master
    \
     B--C------F--G    topic
         \    /
          D--E         subtopic

I develop a new feature in my private repository on branch 'topic'.
Every now and then there are two or more commits that somehow belong
together (e.g. a refactoring consisting of multiple commits).  I
prefer having this "belong together" information explicitly in the
repository, therefore for these commits (D and E) I create the new
branch 'subtopic' that will be merged back into 'topic' (with
--no-ff).  This way I can see in the logs or in gitk explicitly that
those commits belong together.  While working on a bigger feature
there might be multiple 'subtopic' branches that get merged back into
'topic'.

But now I can't rebase 'topic' on top of master, because rebase would
linearize the history, losing the subtopic merges.


Best,
G=E1bor
