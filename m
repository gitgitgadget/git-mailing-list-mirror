From: Mike Hommey <mh@glandium.org>
Subject: Re: Rewriting history with git-filter-branch and leaking objects
	(?)
Date: Sun, 19 Aug 2007 21:59:00 +0200
Organization: glandium.org
Message-ID: <20070819195900.GA1313@glandium.org>
References: <20070817171851.GB13891@glandium.org> <20070817183115.GA15653@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 19 21:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMqw9-0004bU-3u
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 21:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544AbXHST7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 15:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbXHST7q
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 15:59:46 -0400
Received: from vawad.err.no ([85.19.200.177]:51236 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265AbXHST7p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 15:59:45 -0400
Received: from aputeaux-153-1-37-169.w82-124.abo.wanadoo.fr ([82.124.129.169] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IMqvo-0000TZ-NQ
	for git@vger.kernel.org; Sun, 19 Aug 2007 21:59:43 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IMqvM-0000Py-SD
	for git@vger.kernel.org; Sun, 19 Aug 2007 21:59:00 +0200
Content-Disposition: inline
In-Reply-To: <20070817183115.GA15653@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56144>

On Fri, Aug 17, 2007 at 08:31:15PM +0200, Mike Hommey <mh@glandium.org> wrote:
> On Fri, Aug 17, 2007 at 07:18:51PM +0200, Mike Hommey <mh@glandium.org> wrote:
> > $ rm .git/logs/refs/heads/master 
> > $ rm .git/logs/HEAD
> 
> git-reflog expire --expire-unreachable=$(date +%s) --all
> 
> is cleaner, but git prune -n still misses a tree.

FWIW, I found out what was happening, and why there was still a tree not
being pruned: it was used by the index.

So all in all, no spurious object after cleanup.

Mike
