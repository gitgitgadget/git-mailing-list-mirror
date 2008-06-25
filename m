From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 5/7] parse-opt: fake short strings for callers to believe
  in.
Date: Wed, 25 Jun 2008 17:07:35 +0200
Message-ID: <48625F37.8030808@op5.se>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <1214298732-6247-1-git-send-email-madcoder@debian.org> <1214298732-6247-2-git-send-email-madcoder@debian.org> <1214298732-6247-3-git-send-email-madcoder@debian.org> <1214298732-6247-4-git-send-email-madcoder@debian.org> <1214298732-6247-5-git-send-email-madcoder@debian.org> <1214298732-6247-6-git-send-email-madcoder@debian.org> <alpine.LFD.1.10.0806241019370.2926@woody.linux-foundation.org> <20080624192634.GA9189@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Wed Jun 25 17:09:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBWbw-0001sU-Qc
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 17:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbYFYPHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 11:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbYFYPHk
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 11:07:40 -0400
Received: from mail.op5.se ([193.201.96.20]:39345 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbYFYPHj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 11:07:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A4B551B800A3;
	Wed, 25 Jun 2008 17:05:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MRW0J0BS6ToB; Wed, 25 Jun 2008 17:05:34 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id AC1271B80082;
	Wed, 25 Jun 2008 17:05:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080624192634.GA9189@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86287>

Pierre Habouzit wrote:
> On Tue, Jun 24, 2008 at 05:20:28PM +0000, Linus Torvalds wrote:
>>
>> On Tue, 24 Jun 2008, Pierre Habouzit wrote:
>>> If we begin to parse -abc and that the parser knew about -a and -b, it
>>> will fake a -c switch for the caller to deal with.
>>>
>>> Of course in the case of -acb (supposing -c is not taking an argument) the
>>> caller will have to be especially clever to do the same thing. We could
>>> think about exposing an API to do so if it's really needed, but oh well...
>> Well, if the other parser is _also_ parse_options() (ie you just cascade 
>> them incrementally in a loop), then the other parser should get it right 
>> automatically. No?
> 
>   Exactly. There are minor glitches wrt the help generation to deal
> with, but for pure parsing issues yes, it will work.
> 

Why not just provide some api-functions to return a strbuf of the short
and long options each?

parse_opt_short_help(strbuf *sb, options...);
parse_opt_long_help(strbuf *sb_long, options...);

That way multi-parseopt programs can get their help-texts done right
with very little extra work.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
