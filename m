From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: interactive rebase results across shared histories
Date: Tue, 23 Feb 2016 23:57:06 +0100
Message-ID: <56CCE3C2.1050608@moritzneeb.de>
References: <87io1j6laz.fsf@gmail.com> <56C91D21.90306@moritzneeb.de>
 <87io1f5nsi.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Seb <spluque@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 23:57:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYLtK-0000sP-HV
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 23:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710AbcBWW5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 17:57:09 -0500
Received: from moritzneeb.de ([78.47.1.106]:58723 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698AbcBWW5I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 17:57:08 -0500
Received: from [192.168.1.3] (x4db4a26a.dyn.telefonica.de [77.180.162.106])
	by moritzneeb.de (Postfix) with ESMTPSA id 315041C0F6;
	Tue, 23 Feb 2016 23:57:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456268227;
	bh=7DtI2cYEW71tZpfItkHB/u+O1+cSJm/Zhz1KObPu9vU=;
	h=Subject:To:References:From:Date:In-Reply-To:From;
	b=qKW6cfxVmumqM3HBbpGztoDt7/Ca0FxiiyYSlSLlrIYOYK18F2c2zKa+E5SjkydnO
	 r7cykRuadw2Px86tnmDmREII4qFhRot8IK8+eN7mCJ00Dm9zuof8pBJdKS5ZiigCVa
	 vM6k5W0Tr7cWz0CCpS6pVE3+O3p2folIWwSX7oFI=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <87io1f5nsi.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287137>

On 02/23/2016 06:39 PM, Seb wrote:
> On Sun, 21 Feb 2016 03:12:49 +0100,
> Moritz Neeb <lists@moritzneeb.de> wrote:
> 
>> Hi Seb,
>> On 02/20/2016 11:58 PM, Seb wrote:
>>> Hello,
> 
>>> I've recently learnt how to consolidate and clean up the master
>>> branch's commit history.  I've squashed/fixuped many commits thinking
>>> these would propagate to the children branches with whom it shares
>>> the earlier parts of the its history.  However, this is not the case;
>>> switching to the child branch still shows the non-rebased (dirty)
>>> commit history from master.  Am I misunderstanding something with
>>> this?
> 
>> I am not sure what you meand by "child branch". If I understand
>> corretly, you have something like:
> 
> [...]
> 
>> Maybe, to get a better understanding, you could use visualization tool
>> like "tig" or "gitk" to observe what happens to your commits (hashes)
>> and branches (labels) and just play around with some of these
>> operations.
> 
> OK, I've followed this advice and looked at the dependency graphs in
> gitk before and after rebasing, I've managed to obtain what I was
> after.  The repository now has two branches: master and topic.  However,
> Gitk reveals a problem with a string of commits that are not part of any
> branch:
> 
> A---B---H---I                   (master)
>      \
>       C---D---E                 (loose string of commits)
>        \
>         D'---E'---F---G         (topic)
> 
> How do I remove these loose commits (C, D, E)?
>

what you might be after is "git gc". But I never used it, it was not
neccesary for me. I would let the automatic garbage collection drop my
dangling commits. It's safer - who knows when you will still want to
restore your recent "loose string of commits".

How exactly are the loose commits causing trouble?

-Moritz
