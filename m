From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 23:53:11 +0200
Message-ID: <20080429215311.GC2413@steel.home>
References: <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org> <20080429204417.GC6301@steel.home> <48178FD6.90104@gnu.org> <20080429213323.GA2413@steel.home> <48179625.3050704@gnu.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:54:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqxly-0007oP-F3
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYD2VxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbYD2VxP
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:53:15 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:8221 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbYD2VxO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:53:14 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+D1WRsg==
Received: from tigra.home (Fabc8.f.strato-dslnet.de [195.4.171.200])
	by post.webmailer.de (mrclete mo27) (RZmta 16.27)
	with ESMTP id k008edk3TI9CnQ ; Tue, 29 Apr 2008 23:53:12 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 078BF277BD;
	Tue, 29 Apr 2008 23:53:12 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CB1D556D28; Tue, 29 Apr 2008 23:53:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48179625.3050704@gnu.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80750>

Paolo Bonzini, Tue, Apr 29, 2008 23:41:57 +0200:
>> Hmm... Which one do you mean? I cannot find his reply to message-id
>> <cover.1209391614.git.bonzini@gnu.org>
>
> http://permalink.gmane.org/gmane.comp.version-control.git/80720
>

Just received it

>>> are also a start towards that, even though I don't think your 
>>> transition  plan is feasible (also because it would break "git remote 
>>> update"  completely).
>>
>> Which part of "warn people in git-fetch" will break "git remote update"?
>> Or what will break after the "git remote add" start setting
>> skipDefaultUpdate?
>
> People will expect the new remotes to be, ehm, updated by "git remote  
> update".
>

Ah, right. How about a warning, then? Like:

    $ git remote add abc host:src/project
    warning: fetch and push without arguments WILL update the references of "abc"
    $

>> It is not. It seem to propose, instead of fixing existing behaviour,
>
> Do you know how to "fix" existing behavior?
>

Never considered it broken. OTOH, it hasn't occured to me to run "git
push" without arguments. And I do expect "git fetch" to fetch just the
remote my current branch is related to (and not all remotes).

> I mean, I just wonder why as long as I had one remote only, I could  
> write "git push", while now I have to write "git push origin && git push  
> mirror".  The patch to "git fetch" comes from this observation too, and  
> I think it is a good idea, even though I'm less attached to it and it  
> would influence my workflow much less.

Have you tested your patches in your workflow? Worked with them for
some weeks? Gave them to your peers?
