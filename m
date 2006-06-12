From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Mon, 12 Jun 2006 04:40:56 -0400
Message-ID: <20060612084056.GA29220@spearce.org>
References: <11500407193506-git-send-email-octo@verplant.org> <46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com> <20060612082448.GA11857@verplant.org> <46a038f90606120134n21c269bbj3e8c7e31d4d93a23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Forster <octo@verplant.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 10:41:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fphyz-0005O2-9O
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 10:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWFLIlH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 04:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWFLIlG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 04:41:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:65445 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751066AbWFLIlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 04:41:05 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fphyn-0003id-2n; Mon, 12 Jun 2006 04:41:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4417420FB20; Mon, 12 Jun 2006 04:40:57 -0400 (EDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90606120134n21c269bbj3e8c7e31d4d93a23@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21697>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> >- If `GIT_DIR/description' is only used by gitweb it may be more
> >  consistent to use the git-repo-config option `gitweb.description' in
> >  the future.
> 
> Not sure how git-repo configurations deal with long entries. Right now
> the description may contain html for instance.

It has to be escaped, which could be ugly with HTML.  For example:

  [gitweb]
    description=<div class=\"description\">\n\
This is a chunk of text which describes this repository.  Some\n\
of this text might be rather long, and might need many lines to\n\
really be able to describe the repository in a nice editor such as\n\
vi running in an 80 character wide xterm.\n\
</div>

Forget a \ in front of a double quote (") or an LF and the entry is
corrupt.  So as nice as it sounds it might not be the best way to
obtain a description for gitweb.

-- 
Shawn.
