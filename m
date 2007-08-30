From: Andreas Ericsson <ae@op5.se>
Subject: Re: Add --rebase option to git-pull?
Date: Thu, 30 Aug 2007 15:07:54 +0200
Message-ID: <46D6C12A.5090705@op5.se>
References: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 15:08:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQjko-00035m-J3
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 15:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbXH3NIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 09:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbXH3NIF
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 09:08:05 -0400
Received: from mail.op5.se ([193.201.96.20]:44921 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbXH3NID (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 09:08:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BA0D41943F7;
	Thu, 30 Aug 2007 15:08:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EGB6+62mJCpd; Thu, 30 Aug 2007 15:07:57 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id ADE5D19435F;
	Thu, 30 Aug 2007 15:07:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57039>

Tom Clarke wrote:
> Hi,
> 
> I'm in the process of setting up a git environment with a number of
> shared branches. To avoid putting unnecessary merges into the trunk,
> we'd like to normally use rebase when updating private branches. I
> wondered if it would be possible to automatically determine the
> correct remote branch to rebase against.
> 
> The most logical place to do this seemed to be in git-pull, so I
> experimented with adding a '--rebase' option, per the (rough) diff
> below.
> 
> I'm quite new to git, so is this a good strategy?
> 

If I read the patch correctly (which I may not, ofcourse), you're
rebasing the upstream changes to on top of your own work. That's
not something you can readily do, since the parentage chain in
git is supposed to be immutable, so mutating the one you get from
an already published source would be a horribly bad idea indeed.

You need to do it the other way around, so that you rebase your
local changes onto the upstream HEAD prior to pushing.

If that's what the patch does, then I guess all is fine and dandy,
although I think it'd be better to add the merge-strategy rebase
or possibly rebase-ours or rebase-theirs, which can be given as
arguments to git-pull.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
