From: Andreas Ericsson <ae@op5.se>
Subject: Re: Do most people feel tracking branches useful?
Date: Wed, 29 Oct 2008 12:53:27 +0100
Message-ID: <49084EB7.1000109@op5.se>
References: <49082514.9050405@gmail.com> <49083166.7090804@op5.se> <49083957.2060702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 12:56:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv9dS-0007lu-33
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 12:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbYJ2Lxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 07:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbYJ2Lxg
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 07:53:36 -0400
Received: from mail.op5.se ([193.201.96.20]:54393 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbYJ2Lxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 07:53:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E39AE24B0025;
	Wed, 29 Oct 2008 12:47:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tDr6--nc6zlF; Wed, 29 Oct 2008 12:47:56 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id 250D324B0023;
	Wed, 29 Oct 2008 12:47:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <49083957.2060702@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99362>

Liu Yubao wrote:
> Andreas Ericsson wrote:
>> Liu Yubao wrote:
>>
>> Use "git fetch" instead of "git pull" and you won't need the 'my' branch.
>> If you use "git pull --rebase" you won't need to bother at all.
>>
> Thank you very much, I didn't know the "--rebase" option, now I learn
> the 'branch.<name>.rebase' configuration too by "git help pull".
> 
> [...snip...]
> 
>> I can't understand why you're working so hard for a linear history, but
>> perhaps
>> that's just an effect of only having leaf developers. I also can't
>> understand
> You got it exactly, we are leaf developers and make enhancement mostly,
> we don't want the upstream branch full of merging commit for many
> not so major changes. I remember keeping linear history is recommended
> in git's documentation.
> 

That should probably be rephrased to "Think before you merge" or something
like that. Keeping history linear provides very little value in itself,
but mindlessly criss-cross-merging makes history difficul to review for
no good reason. Any perceived value of mindless merging is quickly
nullified once one starts looking at "git rerere".

The only time you'll run into problems with non-linear history is when
you're bisecting, and bisection ends up at a merge-commit where all the
merged branhces tips' pre-merge work flawlessly, but the merge-commit
itself introduces breakage by erroneously resolving a conflict, or by
introducing changes of its own (git commit --amend, fe).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
