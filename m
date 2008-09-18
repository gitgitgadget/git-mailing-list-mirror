From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 4/4] diff.c: convert builtin funcname patterns to extended
 regular expressions
Date: Thu, 18 Sep 2008 09:18:47 +0200
Message-ID: <48D200D7.9080800@op5.se>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org> <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Sep 18 09:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDoD-0003SR-1Q
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 09:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbYIRHTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 03:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbYIRHTD
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 03:19:03 -0400
Received: from mail.op5.se ([193.201.96.20]:37804 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbYIRHTB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 03:19:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DF92E1B8008F;
	Thu, 18 Sep 2008 09:08:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.686
X-Spam-Level: 
X-Spam-Status: No, score=-3.686 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.713, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r1kxq886Ttxr; Thu, 18 Sep 2008 09:08:48 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.171])
	by mail.op5.se (Postfix) with ESMTP id A22F51B80085;
	Thu, 18 Sep 2008 09:08:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96176>

Brandon Casey wrote:
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> 
> 
> This is a blind conversion removing \\ before ( and { etc.
> and adding \\ before naked ( and { etc.
> 
> I hope the authors who last touched these patterns will help with testing:
> 
> bibtex: Johan Herland
>   html: Johan Herland
>   java: Junio Hamano, Jeff King
> pascal: Avery Pennarun
>    php: Andreas Ericsson
> python: Kirill Smelkov
>   ruby: Giuseppe Bilotta
>    tex: Johan Herland
> 

The PHP one seems to work just fine.

Signed-off-by: Andreas Ericsson <ae@op5.se>

Nicely done, although I'd rather have "ereg_funcname" instead of
"xfuncname", but I don't care very much for myself, as I'll
rather submit my patterns upstream than add them to .git/config ;-)

Junio:
Can we issue a deprecation heads-up for the current "funcname"
along with a "call for patterns" and then have "funcname" and
"ereg_funcname" mean the same for a while until we obsolete
ereg_funcname in favour of funcname, perhaps? I can't imagine
anyone wanting to use posix regular expressions if extended
ones are available everywhere.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
