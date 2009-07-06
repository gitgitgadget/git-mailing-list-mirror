From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: hooks/post-receive-email bug?
Date: Mon, 06 Jul 2009 10:49:30 -0400
Message-ID: <4A520EFA.10309@xiplink.com>
References: <4A396C6E.2050600@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 06 16:50:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNpW9-0000wO-Hr
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 16:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZGFOt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 10:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbZGFOtz
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 10:49:55 -0400
Received: from smtp132.dfw.emailsrvr.com ([67.192.241.132]:45953 "EHLO
	smtp132.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbZGFOty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 10:49:54 -0400
Received: from relay3.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 52EBC5D8362;
	Mon,  6 Jul 2009 10:49:58 -0400 (EDT)
Received: by relay3.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 14D7F5D834E;
	Mon,  6 Jul 2009 10:49:57 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <4A396C6E.2050600@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122791>

Ping?

		M.


Marc Branchaud wrote:
> Hi all,
> 
> We currently have two main development branches: master and release. 
> These branches exist on our shared git server.  I had to make a change
> in both branches, so I made a topic branch off of their merge-base and
> did the work:
> 
>  o--o--A--B--C        <-- origin/master
>     |\
>     | X--Y        <-- origin/release
>      \
>       1--2--3        <-- topic
> 
> I then merged topic into both master and release.  The merges were clean:
> 
>  o--o--A--B--C---D    <-- master
>     |\           |
>     | X--Y----Z /    <-- release
>      \       / /
>       1--2--3--    <-- topic
> 
> Then I did
>     git push origin
> to push matching refspecs to the origin repo.
> 
> port-receive-email sent two messages for that push, one for each
> branch.  Each message showed that commits 1, 2 and 3 were applied to the
> appropriate branch:
> 
>     The branch, release has been updated
>            via  hash for Z (commit)
>            via  hash for 3 (commit)
>            via  hash for 2 (commit)
>            via  hash for 1 (commit)
>           from  hash for Y (commit)
> 
> However, the details of the topic commits were missing from both
> messages.  Instead, both only contained the details of the merge commits
> D and Z.
> 
> I was expecting at least one of the messages to have the details of
> commits 1, 2 and 3.  Was I wrong to expect that?
> 
> Thanks,
> 
>         M.
