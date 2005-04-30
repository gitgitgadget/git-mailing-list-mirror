From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 13:13:40 +0100
Message-ID: <1114863221.24014.68.camel@localhost.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	 <42730061.5010106@zytor.com>
	 <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	 <20050430125333.2bd81b18.froese@gmx.de>
	 <1114859594.24014.60.camel@localhost.localdomain>
	 <1114862920.17673.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Edgar Toernig <froese@gmx.de>, Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 14:10:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRqnP-0001Yq-GA
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 14:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVD3MPj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 08:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVD3MPj
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 08:15:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25521 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261205AbVD3MPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 08:15:35 -0400
Received: from shinybook.infradead.org ([81.187.226.99])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DRqsW-0006f0-My; Sat, 30 Apr 2005 13:15:25 +0100
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1114862920.17673.1.camel@localhost.localdomain>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-30 at 14:08 +0200, Kay Sievers wrote:
> Yes, some have half-hour offsets:
> http://www.timeanddate.com/library/abbreviations/timezones/au/nft.html

That doesn't count -- that timezone is honoured all year round. We're
talking about the difference between wintertime and summertime in any
given locale.

TBH I think I'd rather just put a gmt_mktime() which uses my trick of
looking at tm.tm_gmtoff after the mktime call into a separate file
wrapped in #ifdef GLIBC and let anyone else who really cares about their
own non-BSD-compatible system worry about whether it works there and fix
it up accordingly.

-- 
dwmw2

