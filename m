From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Not going beyond symbolic links
Date: Tue, 5 Aug 2008 10:15:20 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808051011340.3299@nehalem.linux-foundation.org>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
 <7v8wvc2seh.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041839130.3299@nehalem.linux-foundation.org> <alpine.DEB.1.00.0808050356480.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.1.10.0808041921530.3299@nehalem.linux-foundation.org>
 <7vej54xa80.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 19:17:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQQA9-0001HI-75
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 19:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760928AbYHERQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 13:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760876AbYHERQa
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 13:16:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36943 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754913AbYHERQ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2008 13:16:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m75HFLpd021550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Aug 2008 10:15:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m75HFK89013868;
	Tue, 5 Aug 2008 10:15:20 -0700
In-Reply-To: <7vej54xa80.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.411 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91448>



On Mon, 4 Aug 2008, Junio C Hamano wrote:
> 
> While I admit that I have managed a large directory split across
> partitions grafted via symlinks in pre-git days myself, ever since you
> started "tracking" symbolic links with 8ae0a8c (git and symlinks as
> tracked content, 2005-05-05), you have pretty much been committed to
> "track" symbolic links.

Yes, but my point is:

 - IF the cost is exorbitant (which was my question that triggered this: 
   it sure as h*ll _would_ have been too high back in the days of the 
   original symlink-matching code) ...

 - ... then there really are valid cases that say that we could just call 
   it a feature.

That's really my whole argument. Saying that "ok, we will assume that 
existing paths that git already knows about are stable" is not really an 
odd feature. It's one we have lived with for years, and it's one that is 
actually pretty dang trivial to work with. Yes, it can cause unexpected 
behaviour, but if you hit it, that unexpected behavior is actually not 
_that_ hard to work around.

This is all I'm arguing for. People claim that there are 'correctness' 
issues. I say that 'performance issues' are important, and we can and we 
_should_ take performance issues very seriously. So seriously that we'll 
make performance a _feature_ if required.

			Linus
