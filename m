From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH] allow git to use the PATH for finding subcommands and
	help docs
Date: Fri, 19 Oct 2007 07:18:05 -0700
Message-ID: <20071019141805.GE1463@srparish.net>
References: <20071019065931.GB1463@srparish.net> <47185DAF.7060809@viscovery.net> <20071019130402.GD1463@srparish.net> <4718AF48.9020607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:18:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IisgH-0003LM-6I
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760277AbXJSOSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 10:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760253AbXJSOSO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:18:14 -0400
Received: from smtp-gw6.mailanyone.net ([208.70.128.57]:47851 "EHLO
	smtp-gw6.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760136AbXJSOSN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:18:13 -0400
Received: from mailanyone.net
	by smtp-gw6.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP quinn@srparish.net)
	id 1Iisg0-0005Wm-AQ; Fri, 19 Oct 2007 09:18:12 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Fri, 19 Oct 2007 07:18:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4718AF48.9020607@viscovery.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61714>

On Fri, Oct 19, 2007 at 03:21:12PM +0200, Johannes Sixt wrote:

>  Scott Parish schrieb:
> > I have a situation where software for a distribution is installed
> > into a fake "prefix" and then moved to one of several potential
> > places to be used by users. Given that the final location isn't
> > static, i can't depend on builtin_exec_path. I'd really like users
> > to be able to get started with git as easily as possible. With the
> > current setup, they would have to create and maintain either an
> > GIT_EXEC_PATH or an alias for including --exec-path, as well as a
> > MANPATH and PERL5LIB. This seem like an unnessisary burden.
> 
>  Interesting. How does this compare to this 2-patch-series:
> 
>  http://repo.or.cz/w/git/mingw.git?a=commitdiff;h=e479ea2f911b8c70a269ba59372a4fef90f8907c
>  http://repo.or.cz/w/git/mingw.git?a=commitdiff;h=00a4ff4f3f8ec7e6b3ac15456f00b22b03f438ae
> 
>  which I had come up with to accomplish something very similar
>  (on Windows). Your approach looks superior, but I hadn't gone
>  into depths, yet.

I know very little about what's available on windows. Looking at
your code, it looks like the command isn't passed in in argv[0] and
that it contains the windows style path seperators. My code currently
assumes that PATH is a colon separated list, and that directories
are separated with '/'. How should these assumptions change for
windows?

sRp

-- 
Scott Parish
http://srparish.net/
