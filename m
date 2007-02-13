From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 21:42:48 +0100
Message-ID: <20070213204248.GA21046@uranus.ravnborg.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com> <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org> <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org> <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 21:42:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH4Ts-00072p-8m
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 21:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbXBMUmY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 15:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbXBMUmY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 15:42:24 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:41826 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbXBMUmY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 15:42:24 -0500
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id D48BAE31259;
	Tue, 13 Feb 2007 21:42:22 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id BBC66580D2; Tue, 13 Feb 2007 21:42:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39584>

> Anyway, BY DEFAULT it is off regardless, because it requires a
> 
> 	[core]
> 		AutoCRLF = true
> 
> in your config file to be enabled. We could make that the default for 
> Windows, of course, the same way we do some other things (filemode etc).

This whole auto CRLF things seems to deal with DOS issues that I personally
have not encountered since looong time ago.
Granted notepad in Windows does not understand UNIX files but that a bug
in notepad and everyone knows that wordpad can be used.

I wonder what we are really trying to address here. Or in other words
could the original poster maybe tell what Windows IDE's that does
not handle UNIX files properly?

core git today should not care about CRLF as opposed to LF end-of-line
as long as the end-of-line is consistent - correct?

So defaulting to autoCRLF in Windows/DOS environments was maybe
sane 10 years ago but today that seems to be the wrong thing to do.
For certain project the option could be useful if the tool-set in
the project *requires* CRLF, but if the toolset like all modern toolset
supports both CRLF and LF then git better avoid changing end-of-line marker.

	Sam
