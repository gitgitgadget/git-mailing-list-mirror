From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 26 Sep 2007 22:36:33 -0400
Message-ID: <20070927023633.GA28902@coredump.intra.peff.net>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 04:36:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IajF7-0003D9-0e
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 04:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbXI0Cgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 22:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbXI0Cgh
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 22:36:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3887 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbXI0Cgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 22:36:36 -0400
Received: (qmail 31961 invoked by uid 111); 27 Sep 2007 02:36:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Sep 2007 22:36:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2007 22:36:33 -0400
Content-Disposition: inline
In-Reply-To: <7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59257>

On Wed, Sep 26, 2007 at 01:05:59PM -0700, Junio C Hamano wrote:

> * jk/diff-rename (Tue Sep 25 15:29:42 2007 -0400) 1 commit
>  + diffcore-rename: cache file deltas
> 
> Parked in 'next' for now but is 'master' material.

My tests after this patch show that spanhash_find is responsible for
a large portion of the processing time in large renames, so I am going
to look into speeding that up.

> * lh/merge (Mon Sep 24 00:51:45 2007 +0200) 6 commits
>  + git-merge: add --ff and --no-ff options
>  + git-merge: add support for --commit and --no-squash
>  + git-merge: add support for branch.<name>.mergeoptions
>  + git-merge: refactor option parsing
>  + git-merge: fix faulty SQUASH_MSG
>  + Add test-script for git-merge porcelain
> 
> Comments?  I personally never felt need for --no-ff but the
> series is reasonably clean so I do not see strong objection
> against this series either.

I like it. I know that --no-ff is frowned upon, but I think previous
discussions have mentioned workflows where it might be used
intelligently. Since the patch is unlikely to break anything for
traditional workflows, I think it is a nice way to let people experiment
with alternative workflows that use --no-ff. Maybe something interesting
will come of it.

-Peff
