From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Thu, 08 Jan 2009 15:31:29 +1300
Message-ID: <49656581.4010805@vilain.net>
References: <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>  <20081104152351.GA21842@artemis.corp>  <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>  <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain>  <20081104004001.GB29458@artemis.corp>  <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de>  <20081104083042.GB3788@artemis.corp>  <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>  <20081104152351.GA21842@artemis.corp>  <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>  <20090106111712.GB30766@artemis.corp>  <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de> <1231359317.6011.12.camel@maia.lan> <alpine.LFD.2.00.0901071222300.3057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 03:33:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKki9-0000HR-Gm
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 03:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264AbZAHCbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 21:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbZAHCbk
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 21:31:40 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:50786 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755264AbZAHCbj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 21:31:39 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 3319221D115; Thu,  8 Jan 2009 15:31:37 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.56.172] (cat11g.catalyst.net.nz [202.78.240.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 432F821C164;
	Thu,  8 Jan 2009 15:31:29 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.LFD.2.00.0901071222300.3057@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104874>

Linus Torvalds wrote:
> On Thu, 8 Jan 2009, Sam Vilain wrote:
>   
>> Whatever happens, the current deterministic diff algorithm needs to stay
>> for generating patch-id's... those really can't be allowed to change.
>>     
>
> Sure they can.
>
> We never cache patch-id's over a long time. And we _have_ changed xdiff to 
> modify the output of the patches before, quite regardless of any patience 
> issues: see commit 9b28d55401a529ff08c709f42f66e765c93b0a20, which 
> admittedly doesn't affect any _normal_ diffs, but can generate subtly 
> different results for some cases.
>   

There's at least one person who thinks that they should be deterministic 
enough to be able to be placed in commit messages;

http://article.gmane.org/gmane.comp.version-control.git/95671

Now of course the git cherry-pick feature to add the old patch ID to the 
commit message isn't written yet; but unless there was a fall-back mode 
to produce a "stable" patch ID, these breadcrumbs would become (even 
more) worthless.

Sam
