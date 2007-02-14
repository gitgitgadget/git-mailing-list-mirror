From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 09:41:21 +0100
Message-ID: <20070214084121.GB25617@uranus.ravnborg.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com> <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org> <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org> <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org> <20070213204248.GA21046@uranus.ravnborg.org> <Pine.LNX.4.64.0702131524130.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 09:41:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHFhE-0000Io-7G
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 09:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbXBNIk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 03:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbXBNIk5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 03:40:57 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:41035 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168AbXBNIk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 03:40:56 -0500
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 8D90AE3035E;
	Wed, 14 Feb 2007 09:40:55 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id EC7A8580D2; Wed, 14 Feb 2007 09:41:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702131524130.3604@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39623>

> > This whole auto CRLF things seems to deal with DOS issues that I personally
> > have not encountered since looong time ago.
> 
> Maybe you stopped using DOS a loong time ago ;)
Unfortunately not. (Sitting with a Windows 2000 laptop atm but saved by ssh).

> 
> It's definitely an issue. Yes, all windows programs basically *understand* 
> files that have just LF. But almost all of them will *write* files with 
> CRLF.

So the issue with git supporting CRLF -> LF is to make interoperability between
UNIX* programs and Windows programs which is anohter domain.

My main objective is the proposal to make a conversion default when many users
do not need it. For the UNIX* compatibility thing having conversion at lowest
layer make sense.

> (Which means that I suspect I made the default for "auto_crlf" be wrong in 
> my patch: I probably should not default to checking out with CRLF, but 
> checking out with just LF, and only do the CRLF->LF conversion on input).
Expect that it seems a few br0ken programs yet does not support LF as
end-of-line marker - so .gitattriutes make take special care here.

	Sam
