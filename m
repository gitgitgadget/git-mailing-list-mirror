From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Mon, 22 Oct 2007 17:16:01 +0200
Message-ID: <471CBEB1.2030008@op5.se>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>  <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de> <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se> <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> <Pine.LNX.4.64.0710221558230.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 17:16:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijz0s-00050h-4D
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 17:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbXJVPQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 11:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbXJVPQG
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 11:16:06 -0400
Received: from mail.op5.se ([193.201.96.20]:55671 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbXJVPQF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 11:16:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6461517305A5;
	Mon, 22 Oct 2007 17:16:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSDC+3wOObAw; Mon, 22 Oct 2007 17:16:02 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 51DF81730598;
	Mon, 22 Oct 2007 17:16:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710221558230.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62019>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 22 Oct 2007, Andreas Ericsson wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Mon, 22 Oct 2007, Andreas Ericsson wrote:
>>>
>>>> If I were to suggest any improvements, it'd be to change the 
>>>> semantics of git-pull to always update the local branches set up to 
>>>> be merged with the remote tracking branches when they, prior to 
>>>> fetching, pointed to the same commit, such that when
>>>>
>>>> $ git show-ref master
>>>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/heads/master
>>>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/remotes/origin/master
>>>>
>>>> refs/heads/master gets set to refs/remotes/origin/master post-fetch.
>>> In general, this should fail.  Because you are expected to have local 
>>> changes in the local branches.
>>
>> BS argument.
> 
> Aha.  So you want to make sure that the local branches are no longer 
> "purely" local.  And you want to stop updating them when unpushed changes 
> are in the local branches.
> 

To me, it's more along the lines of "let git help me not make the 
mistake of hacking on a six-week old codebase when I've explicitly asked 
it to merge these and those remote tracking branches into these and 
those local branches". Not updating those branches when there *are* 
changes on them is something users can understand and will probably also 
appreciate, but the reason for not allowing even fast-forwards escape me.

> Seems I cannot help you.
> 

Well, I knew that much from the start so I didn't ask you to, and since 
you seem to fail to grasp what I had in mind, I'm sure you'd botch the 
implementation anyway. Thanks for not quite offering though ;-)

I'm sure you'll review the patch though, and I'm equally sure I will 
appreciate your technical comments rather a lot more than this current 
bickering about a feature it seems I can't express clearly enough in words.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
