From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] rebase--interactive: Replace unportable 'tac' by a sed
 script.
Date: Mon, 28 Apr 2008 11:11:15 +0200
Message-ID: <481594B3.4020608@op5.se>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <48158070.7090007@viscovery.net> <20080428090417.GB16153@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:12:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqPPF-0002eE-O5
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 11:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbYD1JL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 05:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbYD1JL2
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 05:11:28 -0400
Received: from mail.op5.se ([193.201.96.20]:39295 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328AbYD1JL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 05:11:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 44F3B1F08040;
	Mon, 28 Apr 2008 11:11:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id axC513tGkHER; Mon, 28 Apr 2008 11:11:14 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 693D61F08085;
	Mon, 28 Apr 2008 11:11:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <20080428090417.GB16153@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80512>

Jeff King wrote:
> On Mon, Apr 28, 2008 at 09:44:48AM +0200, Johannes Sixt wrote:
> 
>>> +    perl -e 'print reverse <>' | \
>> [...]
>> +	sed -ne '1!G;$p;h' | \
> 
> Wow, and people complain about perl being unreadable. ;)
> 

Well, the tmtowtdi dogma has its drawbacks. Here's another sed-script
that does the exact same thing:

	sed '1!G;h;$!d'

That being said, perl borrows most of its regex notation from sed, so
it's not as if perl is easier. This is just the top-end of the scale
that things like "sed s/foo/bar/" is at the bottom of ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
