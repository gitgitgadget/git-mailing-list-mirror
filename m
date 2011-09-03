From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Rebase & Trailing Whitespace
Date: Sat, 3 Sep 2011 22:18:32 +0200
Message-ID: <20110903201832.GB8362@ecki>
References: <CAE1pOi0rY4kRR4rvEdFhzzTgfhUczHMX=H5_9+o5aHnv4vTadw@mail.gmail.com>
 <20110901023127.GB31838@sigill.intra.peff.net>
 <29267EE41F9343E68AAAE2C33AA40E1A@PhilipOakley>
 <20110901212618.GB16308@sigill.intra.peff.net>
 <4E6086AA.40806@drmicha.warpmail.net>
 <20110902082851.GA17703@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Philip Oakley <philipoakley@iee.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 03 22:21:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qzwi8-0006Bo-Pg
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 22:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab1ICUU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 16:20:57 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:60998 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752017Ab1ICUU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 16:20:56 -0400
Received: from localhost (p5B22F905.dip.t-dialin.net [91.34.249.5])
	by bsmtp.bon.at (Postfix) with ESMTP id 24D3B130045;
	Sat,  3 Sep 2011 22:20:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110902082851.GA17703@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180665>

On Fri, Sep 02, 2011 at 04:28:51AM -0400, Jeff King wrote:
> 
> Yeah, there are a lot. Because of the potential disruption to patches in
> progress, though, we tend not to do big bulk updates of style changes.
> But it may be worth using the
> 
>   rm foo.c
>   git diff -R | git apply --whitespace=fix

I am looking at the output of:

 git diff --check 4b825 -- $(git ls-files '*.[ch]'|grep -v ^compat)

Most of those are false positives from multiline function argument
lists, which are aligned with the first line. So the above command
would break more than it would fix.

I don't care either way, but for future reference: Do we or do we
not want indentation with spaces in this case?

Clemens
