From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 5 Oct 2007 19:24:25 +0200
Message-ID: <20071005172425.GD31413@uranus.ravnborg.org>
References: <20071005082026.GE19879@artemis.corp> <20071005085522.32EFF1E16E@madism.org> <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org> <20071005162139.GC31413@uranus.ravnborg.org> <alpine.LFD.0.999.0710050933330.23684@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 19:23:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdqtF-0003y6-GM
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 19:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296AbXJERW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 13:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755605AbXJERW4
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 13:22:56 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:47211 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011AbXJERW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 13:22:56 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id B0064E30FCA;
	Fri,  5 Oct 2007 19:22:54 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 67442580D2; Fri,  5 Oct 2007 19:24:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710050933330.23684@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60116>

Hi Linus.

> No, following patch is fundamentally broken - it's not even a good 
> starting point. It's bad, bad, bad.
> 
> It's also broken in another way: we want it to be really easy to use 
> strbuf's as normal C strings.
> 
> Yes, many (totally idiotic and broken) interfaces think it's so important 
> to "protect" their internal data structures that you have a 
> "string_to_c()" helper function for that. That may be "good abstraction", 
> but it's totally idiotic, because it results in horrible source code!
> 
> Tell me which is more readable:
> 
> 	printf("Hello %s\n", sb->buf);
> 
> or
> 
> 	printf("Hello %s\n", strbuf_to_c(sb));

Point taken although no sane person would name it strbuf_to_c(...).

	Sam
