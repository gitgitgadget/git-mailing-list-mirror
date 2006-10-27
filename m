X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Restore a single file in the index back to HEAD
Date: Fri, 27 Oct 2006 11:50:40 +0200
Message-ID: <4541D670.6000900@op5.se>
References: <200610261641.11239.andyparkins@gmail.com>	 <81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com>	 <200610270827.17659.andyparkins@gmail.com>	 <20061027073834.GC29057@spearce.org> <4541BE8E.5050605@op5.se>	 <20061027081545.GF29057@spearce.org> <81b0412b0610270245w6c29b3c3va7967991f53db298@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 09:50:50 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <81b0412b0610270245w6c29b3c3va7967991f53db298@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30318>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdOMQ-0003AP-Ic for gcvg-git@gmane.org; Fri, 27 Oct
 2006 11:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946036AbWJ0Juo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 05:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946294AbWJ0Jun
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 05:50:43 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:55756 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1946036AbWJ0Jun (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 05:50:43 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id D10A66BD6F; Fri,
 27 Oct 2006 11:50:41 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 8B2D26BCEC; Fri, 27 Oct 2006 11:50:40 +0200 (CEST)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Alex Riesen wrote:
>>> >Which leads us to the always interesting, fun and exciting:
>>> >
>>> >    git ls-tree -r HEAD | git update-index --index-info
>>> >
>>> >which will undo everything except 'git add' from the index, as
>>> >ls-tree -r is listing everything in the last commit.
>>> >
>>>
>>> ... and also shows The Power of the Pipe, which Daniel@google was
>>> missing in recent versions of git. ;-)
>>>
>>> Btw, this is most definitely not a documented thing and requires a bit
>>> of core git knowledge, so perhaps the "shell-scripts were good for
>>> hackers to learn what to pipe where" really *is* a very important point.
>>
>> Agreed.
> 
> Still, it is very impressive, it is supported (and will be supported, I 
> assume),
> and as such - worth mentioning at least in these examples everyone keeps
> dreaming about. Until that happened, why not mention that the output
> of "git ls-tree" is compatible with --index-info of "update-index"?
> 

+1. Me likes, although I would amend the command-line that Shawn sent 
and describe what it does. Examples > descriptions everywhere else in 
the git docs, so it would be concise to do so.

> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> index f283bac..0ab9913 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -64,6 +64,8 @@ Output Format
> 
> When the `-z` option is not used, TAB, LF, and backslash characters
> in pathnames are represented as `\t`, `\n`, and `\\`, respectively.
> +This output format is compatible with what "--index-info --stdin" of
> +git-update-index expects.
> 
> 
> Author
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
