From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import crashes
Date: Fri, 12 Oct 2007 23:34:07 -0400
Message-ID: <20071013033407.GM27899@spearce.org>
References: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com> <20071013032916.GL27899@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Shun Kei Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 05:34:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgXle-0000Pn-90
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 05:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620AbXJMDeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 23:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbXJMDeM
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 23:34:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48544 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270AbXJMDeL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 23:34:11 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IgXlE-0008HF-Cf; Fri, 12 Oct 2007 23:33:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ACDA820FBAE; Fri, 12 Oct 2007 23:34:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071013032916.GL27899@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60718>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Shun Kei Leung <kevinlsk@gmail.com> wrote:
> > I am using git 1.5.3.4.206.g58ba4-dirty on Mac OS X 10.4.
...
> > Program received signal EXC_BAD_ACCESS, Could not access memory.
> > Reason: KERN_INVALID_ADDRESS at address: 0x64617469
...
> This looks like it is
> memory corruption (e.g. someone overwriting a free'd segment),
> but that sort of memory corruption is very hard to track down.

OK, so the version you have (58ba4) is the latest fast-import after
the strbuf.c series went in.  The one immediately before that series
was 4bf538 and is probably actually stable.

So I wonder, can you test 4bf538 and then if it is good bisect
between those two commits?  There must be a memory corruption
introduced by one of the strbuf changes...

-- 
Shawn.
