From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [BUG] git rebase is confuse if conflict resolution doesn't
	produce diff
Date: Fri, 15 Aug 2008 20:24:39 +0200
Message-ID: <20080815182439.GB23326@leksak.fem-net>
References: <1218819643.6345.57.camel@cass-lpt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guillaume Desmottes <guillaume.desmottes@collabora.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 15 20:25:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU3zd-0003LR-RG
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 20:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885AbYHOSYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756866AbYHOSYn
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 14:24:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:46390 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756505AbYHOSYm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 14:24:42 -0400
Received: (qmail invoked by alias); 15 Aug 2008 18:24:40 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp042) with SMTP; 15 Aug 2008 20:24:40 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/KhrA450jKWmUL4TXPYSY30zwjcotdehhX27NWEP
	iDeW9M7bgY01Wh
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KU3yZ-0005UY-8B; Fri, 15 Aug 2008 20:24:39 +0200
Content-Disposition: inline
In-Reply-To: <1218819643.6345.57.camel@cass-lpt>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92504>

Hi,

Guillaume Desmottes wrote:
> To reproduce:
> - Rebase a branch "foo" on a branch "bar" in a way that there is a
> conflict that you have to manually resolve.
> - Run git diff and see the conflict
> - Edit the conflicted file and remove all the conflicting bits (that
> could be a valid resolution of the conflict)
> - Now git diff produces an empty diff
> - git add $CONFLICTED_FILE  as you have resolve the conflict
> - git rebase --continue
> 
> You get the following error:
> No changes - did you forget to use 'git add'?
> 
> git status is empty as the conflict was resolved.
> 
> A simple workaround is to add a dummy blank line in the conflicted file
> so the diff is not empty.

I think this is no bug, since you would generate an empty commit, i.e
a commit with no changes at all. Usually you do not want such commits.
So git rebase --skip is perhaps what you want.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
