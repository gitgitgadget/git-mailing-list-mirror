From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Handling renames.
Date: Fri, 15 Apr 2005 14:53:12 +0100
Message-ID: <1113573192.27227.45.camel@hades.cambridge.redhat.com>
References: <20050415133759.7560.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 15:52:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMRCo-0004ap-TQ
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 15:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVDONxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 09:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVDONxU
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 09:53:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15772 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261820AbVDONxR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 09:53:17 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DMRG0-0006RK-2T; Fri, 15 Apr 2005 14:53:17 +0100
To: linux@horizon.com
In-Reply-To: <20050415133759.7560.qmail@science.horizon.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-15 at 13:37 +0000, linux@horizon.com wrote:
> > One option for optimising this, if we really need to, might be to track
> > the file back to its _first_ ancestor and use that as an identification.
> > The SCM could store that identifier in the blob itself, or we could
> > consider it an 'inode number' and store it in git's tree objects.
> 
> This suggestion (and this whole discussion about renames) has issues
> with file copies, which form a branch in the revision history.  If I
> copy foo.c to foo2.c (or fs/ext2/ to fs/ext3/), then the oldest ancestor
> isn't a "unique inode number".

That's why I prefer the option of simply annotating the moves. They
don't need to be just renames -- it can cover the cases where files are
split up or merged into one, to indicate where the history of the given
_data_ is coming from.

-- 
dwmw2

