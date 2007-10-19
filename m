From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 12:40:16 +0200
Message-ID: <47188990.1040606@op5.se>
References: <20071019062219.GA28499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 12:45:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IipMA-0003p8-77
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 12:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbXJSKkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 06:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbXJSKkW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 06:40:22 -0400
Received: from mail.op5.se ([193.201.96.20]:33508 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009AbXJSKkW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 06:40:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E42771730671;
	Fri, 19 Oct 2007 12:40:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X9AR9Pchmz0y; Fri, 19 Oct 2007 12:40:18 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id E42741730667;
	Fri, 19 Oct 2007 12:40:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071019062219.GA28499@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61684>

Jeff King wrote:
>   - we abbreviate the local refs (chopping refs/heads,
>     refs/tags, refs/remotes). This means we're losing
>     information, but hopefully it is obvious when storing
>     "origin/master" that it is in refs/remotes.

I like this, since "origin/master" is how that branch is supposed to
be used.


>   - fast forward information goes at the end
>   - cut out "Auto-following ..." text
> 
> What do people think? Some changes? All?
> 

Possibly re-listing "refused" messages last so users who pull from
repos with a huge amount of branches can see it at the bottom.

> Other questions:
>   - Is the "==>" too ugly? It needs to be short (many urls
>     are almost 80 characters already), and it needs to stand
>     out from the "resolving deltas" line, so I think some
>     symbol is reasonable.

Skip the marker altogether and indent the output two spaces.

>   - Should we omit "(fast forward)" since it is the usual
>     case?

I think so, yes, or perhaps just shorten it to 'ff' so the 'refused' and
'merged' messages stand out a bit more.

>   - Should refs/remotes/* keep the "remotes/" part?

I think not. It's used as origin/master (by end-users anyways), so writing
what they're familiar with is most likely the correct thing to do.

>   - How annoying is the doubled '==> $url' line? It comes
>     from the fact that we fetch the tags separately.
> 

Fairly annoying. I'd prefer if it was squelched the second time.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
