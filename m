From: Andreas Ericsson <ae@op5.se>
Subject: Re: Is rebase always destructive?
Date: Mon, 01 Dec 2008 17:45:08 +0100
Message-ID: <49341494.40907@op5.se>
References: <slrngj7jch.2srb.csaba-ml@beastie.creo.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Csaba Henk <csaba-ml@creo.hu>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:47:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Bv2-0008Ue-9v
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 17:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbYLAQpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 11:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYLAQpO
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 11:45:14 -0500
Received: from mail.op5.se ([193.201.96.20]:33839 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999AbYLAQpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 11:45:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8A0F424B0B4A;
	Mon,  1 Dec 2008 17:41:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LCXX7EYJ1Ra6; Mon,  1 Dec 2008 17:41:29 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id AE2EE1B8006F;
	Mon,  1 Dec 2008 17:41:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
In-Reply-To: <slrngj7jch.2srb.csaba-ml@beastie.creo.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102062>

Csaba Henk wrote:
> Hi,
> 
> When doing a rebase, I can find a number of reasons for which one might
> feel like to preserve the rebased branch (that is, perform an operation
> which copies the branch over a new base, not moves).
> 
> -  For example, a successful rebase doesn't necessarily mean that the
>    code, as of the rebased branch, is consistent and compiles. That is,
>    the rebase can be broken even if git can put things together diff-wise.
>    In such a case I wouldn't be happy to lose the original instance of
>    the branch.
> 
> -  Or I might want to build different versions of the program, and each
>    version of it needs a given set of fixes (the same one). Then rebasing
>    my bugfix branch is not a good idea, I'd much rather copy it over all
>    those versions.
> 
> I can't see any option for rebase which would yield this cp-like
> behaviour. Am I missing something? Or people don't need such a feature?
> (Then give me some LART please, my mind is not yet gittified enough to
> see why is this not needed.) Or is it usually done by other means, not
> rebase?
> 

When I feel I'm in any danger of ending up with mis-compiles or whatnot,
I usually do
  git checkout -b try-rebase
  git rebase $target
which does exactly what you want.

For almost all other operations, it's possible to get your previous
branch-pointer back, either by referencing ORIG_HEAD, or the reflogs.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
