From: Andreas Ericsson <ae@op5.se>
Subject: Re: cg-commit does not run pre-commit hook?
Date: Thu, 12 Oct 2006 16:42:39 +0200
Message-ID: <452E545F.6060406@op5.se>
References: <20061012142736.74DE7353BDE@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 16:46:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY1lm-0002VP-NW
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 16:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWJLOmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 10:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWJLOmn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 10:42:43 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:56275 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932105AbWJLOmm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 10:42:42 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 713BF6BE1D; Thu, 12 Oct 2006 16:42:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 45B8C6BE19; Thu, 12 Oct 2006 16:42:40 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20061012142736.74DE7353BDE@atlas.denx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28781>

Wolfgang Denk wrote:
> Dear Petr,
> 
> in message <20061012011548.GT20017@pasky.or.cz> you wrote:
>>   historically, Git and Cogito use a different set of hooks (Cogito got
>> hooks first but Git picked own names and usage and now is prevalent).
> 
> I see. And current versions of cogito don't support any pre-commit
> script, right?
> 
>> I have plans for making Cogito support Git hooks and slowly deprecate
>> those own ones for which Git has counterparts, but didn't get to it yet.
>> I might do today during the more boring lectures... ;-)
> 
> Keeping my fingers crossed :-)
> 
> I'm looking for a way  to  register  the  commit  message  into  some
> changelog  file  which  gets  checked  in with the same commit. Or is
> there another way to do this? 
> 

git log

The commit message is already saved and git (and cogito, I presume) 
provide tools to fetch those messages in the relevant different orders 
(although ordering by date is flakey sometimes; see list-archives for 
discussion).

One part of why a proper SCM is so good to use is that you shouldn't 
have to maintain a separate changelog. The SCM should create one for you 
when you ask it, based on the comments you've entered when actually 
making the changes.

That aside, for actual releases, I generally write a short, gisted 
"what's new" thingie inside the tag, based on the shortlog output and my 
own memory. This comes in handy when management wants to have their 
version of the shortlog, and developers can pretty easily find new 
features by just sifting through the tag-messages.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
