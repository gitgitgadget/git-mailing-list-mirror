X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Restore a single file in the index back to HEAD
Date: Fri, 27 Oct 2006 10:08:46 +0200
Message-ID: <4541BE8E.5050605@op5.se>
References: <200610261641.11239.andyparkins@gmail.com> <81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com> <200610270827.17659.andyparkins@gmail.com> <20061027073834.GC29057@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 08:09:46 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061027073834.GC29057@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30304>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdMlr-0007gn-8W for gcvg-git@gmane.org; Fri, 27 Oct
 2006 10:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946241AbWJ0IIv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 04:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946244AbWJ0IIv
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 04:08:51 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:36551 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1946241AbWJ0IIt (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 04:08:49 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id C041B6BE79; Fri,
 27 Oct 2006 10:08:48 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 276D26BE76; Fri, 27 Oct 2006 10:08:47 +0200 (CEST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Andy Parkins <andyparkins@gmail.com> wrote:
>> However, it led me to wonder what the inverse of git-update-index is.
> 
> git-update-index  :-)
> 
> You can use something like:
> 
>     git ls-tree HEAD oops/file1 | git update-index --index-info 
> 
> to restore the index state of oops/file1.
> 
> 
> Which leads us to the always interesting, fun and exciting:
> 
>     git ls-tree -r HEAD | git update-index --index-info 
> 
> which will undo everything except 'git add' from the index, as
> ls-tree -r is listing everything in the last commit.
> 

... and also shows The Power of the Pipe, which Daniel@google was 
missing in recent versions of git. ;-)

Btw, this is most definitely not a documented thing and requires a bit 
of core git knowledge, so perhaps the "shell-scripts were good for 
hackers to learn what to pipe where" really *is* a very important point.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
