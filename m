X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 3/4] Default to displaying /all/ non-tag refs, not just
 locals
Date: Fri, 03 Nov 2006 11:55:56 +0100
Message-ID: <454B203C.9040006@op5.se>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com> <200611021111.22604.andyparkins@gmail.com> <7vac39mew2.fsf@assigned-by-dhcp.cox.net> <200611030847.22252.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 10:56:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200611030847.22252.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30823>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfwiU-0007dI-6P for gcvg-git@gmane.org; Fri, 03 Nov
 2006 11:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752864AbWKCK4B (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 05:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbWKCK4B
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 05:56:01 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:43152 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1752864AbWKCK4B (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 05:56:01 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 2999D6BD62; Fri, 
 3 Nov 2006 11:56:00 +0100 (CET)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 4CDC06BD29; Fri,  3 Nov 2006 11:55:56 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> On Friday 2006 November 03 02:40, Junio C Hamano wrote:
> 
>> That is a change in behaviour and given that we introduced
>> remotes for the explicit purpose of not to clutter the local
>> branch namespace, I doubt defaulting to _show_ remotes is a good
> 
> Really?  I had imagined it was to prevent accidental checking out of an 
> upstream-tracking branch.  Also; I don't think "not cluttering the namespace" 
> is the same as "not showing multiple namespaces".  The local namespace 
> remains as uncluttered as it ever was.  This is a question of what to 
> display.
> 
> Assuming my "mixed mode" display thing were in place, doesn't that make the 
> two choices of UI
> 
> 1)
>  git-branch            : show local branches
>  git-branch --all      : show local and remote branches
>  git-branch -r         : show remote branches
> 2)
>  git-branch            : show local and remote branches
>  git-branch --local    : show local branches
>  git-branch -r         : show remote branches
> 
> In case 2) the switch is simply selecting a filter, and so fits in with 
> the "-r" better.
> 

I think it'd make more sense if git-branch could instead take a --filter 
parameter that does a simple strncmp(filter, branch, strlen(filter)) to 
see if it should show a branch or not. That way, "--filter=remotes" 
would work splendidly. "local" as keyword to "--filter" could possibly 
be a special case and need documentation.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
