From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 22 Oct 2007 17:42:48 +0200
Message-ID: <87AF88A8-93B2-448C-B100-10B8EFFB6627@zib.de>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>  <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de> <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se> <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> <Pine.LNX.4.64.0710221558230.25221@racer.site> <471CBEB1.2030008@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 19:52:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik1Rr-0005lv-Ov
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 19:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbXJVRvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 13:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbXJVRvz
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 13:51:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:47112 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbXJVRvy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 13:51:54 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9MHpgaM024066;
	Mon, 22 Oct 2007 19:51:42 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db11d6f.pool.einsundeins.de [77.177.29.111])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9MHpfSF025518
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 22 Oct 2007 19:51:41 +0200 (MEST)
In-Reply-To: <471CBEB1.2030008@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62031>


On Oct 22, 2007, at 5:16 PM, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
>> Hi,
>> On Mon, 22 Oct 2007, Andreas Ericsson wrote:
>>> Johannes Schindelin wrote:
>>>
>>>> On Mon, 22 Oct 2007, Andreas Ericsson wrote:
>>>>
>>>>> If I were to suggest any improvements, it'd be to change the  
>>>>> semantics of git-pull to always update the local branches set  
>>>>> up to be merged with the remote tracking branches when they,  
>>>>> prior to fetching, pointed to the same commit, such that when
>>>>>
>>>>> $ git show-ref master
>>>>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/heads/master
>>>>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/remotes/origin/ 
>>>>> master
>>>>>
>>>>> refs/heads/master gets set to refs/remotes/origin/master post- 
>>>>> fetch.
>>>> In general, this should fail.  Because you are expected to have  
>>>> local changes in the local branches.
>>>
>>> BS argument.
>> Aha.  So you want to make sure that the local branches are no  
>> longer "purely" local.  And you want to stop updating them when  
>> unpushed changes are in the local branches.
>
> To me, it's more along the lines of "let git help me not make the  
> mistake of hacking on a six-week old codebase when I've explicitly  
> asked it to merge these and those remote tracking branches into  
> these and those local branches". Not updating those branches when  
> there *are* changes on them is something users can understand and  
> will probably also appreciate, but the reason for not allowing even  
> fast-forwards escape me.

Here's also an interesting asymmetry. By default, git push
updates all remote branches matching a local branch. But git
pull "updates" only the current local branch to the state of
the remote head (by updating all local copies of the remote
branches, but merging only a single of these heads).

Maybe this asymmetry adds to the confusion. I see arguments
for both behaviours:
1) In both cases, update only the branch you're on
or
2) in both cases update all matching branches.
(btw, if I do not intend to merge at all, you can always use
"git fetch".)

	Steffen
