X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Documentation: Update information about <format> in git-for-each-ref
Date: Wed, 01 Nov 2006 09:25:51 +0100
Message-ID: <45485A0F.3040807@op5.se>
References: <200610281930.05889.jnareb@gmail.com> <7vslh86uz9.fsf@assigned-by-dhcp.cox.net> <200610282323.57797.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 08:26:40 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200610282323.57797.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30620>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfBQV-0002Fl-BQ for gcvg-git@gmane.org; Wed, 01 Nov
 2006 09:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946709AbWKAIZy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 03:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946708AbWKAIZy
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 03:25:54 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:39917 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1946709AbWKAIZx (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 03:25:53 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id B5BA76BD5D; Wed, 
 1 Nov 2006 09:25:52 +0100 (CET)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 990366BD5A; Wed,  1 Nov 2006 09:25:51 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Junio C Hamano wrote:
>> [PATCH] for-each-ref: epoch and epochdate
>>
>> This adds "epoch" (which is parallel to "tagger" or "committer")
>> and "epochdate" (corresponds to "taggerdate" and
>> "committerdate").
>>
>> As other "date" fields, "epochdate" sorts numerically
>> and displays human readably
> 
> I was thinking about having only "epochdate" (corresponding to either 
> "taggerdate" or "committerdate"), only named "epoch". There is I think 
> no need for field which would be "tagger" or "committer", and 
> especially not named "epoch" ;-).
> 
> Otherwise looks fine, thanks a lot.
> 
> 
> BTW. I had to translate
> +       if (strcmp(who, "tagger") && strcmp(who, "committer"))
> to
> +       if (strcmp(who, "tagger") == 0 || strcmp(who, "committer") == 0)
> to understand it. But this is probably my lack of contact with such
> C idioms.


But this does the exact opposite. The condition will now be true if the 
'who' variable holds a pointer to a string that is either "tagger" or 
"committer", whereas it used to be true for strings that were anything 
*but* any of those.

"Compare" (as in "strcmp") also translates to "are equal to" and isn't 
only a verb. This is unfortunate for people who aren't natively english 
and has had me confused on many a long night. I once ended up doing a 
macro called "string_matches" just to wrap my head around an insanely 
long conditional with too many strcmp() with about half of them negated 
by !.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
