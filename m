From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Wed, 31 Aug 2005 10:27:50 +0100
Message-ID: <tnxaciyo3qh.fsf@arm.com>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
	<20050819194832.GA8562@fanta>
	<1124572356.7512.21.camel@localhost.localdomain>
	<20050821094059.GA5453@fanta>
	<Pine.LNX.4.63.0508221707520.23242@iabervon.org>
	<tnxvf1wd24m.fsf@arm.com>
	<Pine.LNX.4.63.0508231304130.23242@iabervon.org>
	<20050823212305.GA5936@fanta>
	<Pine.LNX.4.63.0508231731370.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Veldeman <jan.veldeman@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 11:29:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAOuL-0006ZH-8A
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 11:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVHaJ2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 05:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVHaJ2M
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 05:28:12 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:56732 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751385AbVHaJ2K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2005 05:28:10 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j7V9RuQb004030;
	Wed, 31 Aug 2005 10:27:56 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA09383;
	Wed, 31 Aug 2005 10:27:53 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.140]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 31 Aug 2005 10:27:51 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508231731370.23242@iabervon.org> (Daniel
 Barkalow's message of "Tue, 23 Aug 2005 18:23:57 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 31 Aug 2005 09:27:51.0187 (UTC) FILETIME=[421C8E30:01C5AE0E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7974>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 23 Aug 2005, Jan Veldeman wrote:
>> The parents which should be visible to the outside, will always be versions
>> of my development tree, which I have previously pushed out. My way of
>> working would become:
>> * make changes, all over the place, using stgit
>> * still make changes (none of these gets tracked, intermittent versions are
>>   lost)
>> * having a good day: changes looks good, I want to push this out:
>>   * push my tree out
>>   * stgit-free (which makes the pushed out commits, the new parents of my
>>     stgit patches)
>> * restart from top
>
> I'm not sure how applicable to this situation stgit really is; I see stgit
> as optimized for the case of a patch set which is basically done, where
> you want to keep it applicable to the mainline as the mainline advances.
>
> For your application, I'd just have a git branch full of various stuff,
> and then generate clean commits by branching mainline, diffing development
> against it, cutting the diff down to just what I want to push, and
> applying that. Then the clean patch goes into stgit.

StGIT has the 'refresh' command which allows a patch to be
indefinitely modified (that's pretty much how I use StGIT). I use it
for the case where I would like to keep the changes in separate
logical entities (patches) but they are not independent enough to
create separate branches.

Take for example a new platform port, you can have some of the
existing code re-worked in a patch, some CPU support in the next
patch, basic platform support in another patch, some device drivers
specific to this platform in yet another patch. Subsequent patches are
dependent on the previous ones. Branching from the mainline for each
of these features might not make sense and keeping all of them in the
same branch can make maintenance a bit more difficult.

-- 
Catalin
