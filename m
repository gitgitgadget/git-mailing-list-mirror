From: Richard Knutsson <ricknu-0@student.ltu.se>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Wed, 15 Aug 2007 03:35:27 +0200
Message-ID: <46C2585F.60802@student.ltu.se>
References: <1186984174.10249.7.camel@localhost>  <200708131933.10125.m.kozlowski@tuxland.pl>  <1187026955.2688.4.camel@laptopd505.fenrus.org>  <1187037445.6628.98.camel@heimdal.trondhjem.org>  <1187054366.2757.0.camel@laptopd505.fenrus.org>  <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>  <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>  <46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost> <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joe Perches <joe@perches.com>, Rene Herman <rene.herman@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 03:38:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL7qT-0003yl-RL
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 03:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759701AbXHOBih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 21:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759636AbXHOBih
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 21:38:37 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:37361 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758883AbXHOBif (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 21:38:35 -0400
Received: from [130.240.205.31] (thinktank.campus.luth.se [130.240.205.31])
	by gepetto.dc.ltu.se (8.12.5/8.12.5) with ESMTP id l7F1b374023849;
	Wed, 15 Aug 2007 03:37:03 +0200 (MEST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
In-Reply-To: <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55872>

Linus Torvalds wrote:
> On Tue, 14 Aug 2007, Joe Perches wrote:
>
>   
>> On Tue, 2007-08-14 at 20:03 +0200, Rene Herman wrote:
>>     
>>> "git info --maintainer drivers/ide/ide-cd.c" or some such would say "Alan 
>>> Cox <alan@...>".
>>>       
>> Perhaps maintainer(s), approver(s), listener(s)?
>>
>> I think something like this should be a git-goal.
>> What do the git-wranglers think?
>>     
>
> The thing is, if you have git, you can basically already do this.
>
> Do a script like this:
>
> 	#!/bin/sh
> 	git log --since=6.months.ago -- "$@" |
> 		grep -i '^    [-a-z]*by:.*@' |
>   
sed -r "s/^.*by: \"?([^\"]+)\"?/\1/" |
> 		sort | uniq -c |
> 		sort -r -n | head
>
> and it gives you a rather good picture of who is involved with a 
> particular subdirectory or file.
>
>   
Like the script! Especially since it reveled --since=6.month.ago and 
uniq to me.
Just wondering, why order them in the acked, signed and tested? Other 
then removing those, the added 'sed' also fix the <name> vs 
"<name>"-"problem". + adding '-i' to uniq should help the result too, right?

Now a simple "diffstat -p1 -l <patch> | xargs <preferred script-name>" 
makes the day. Too bad, as Joe pointed out, it does not include relevant ML.

cheers
Richard Knutsson
