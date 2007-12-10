From: Andreas Ericsson <ae@op5.se>
Subject: Re: "remote end hung up unexpectedly"
Date: Mon, 10 Dec 2007 14:11:21 +0100
Message-ID: <475D3AF9.60402@op5.se>
References: <CE1FB037-26E3-475E-9F9D-AC3874987B9C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Clifford Heath <clifford.heath@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 14:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1iQE-0006iC-JC
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 14:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbXLJNL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 08:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbXLJNL0
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 08:11:26 -0500
Received: from mail.op5.se ([193.201.96.20]:36108 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754018AbXLJNLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 08:11:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CADCD1F0802C;
	Mon, 10 Dec 2007 14:11:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ur0tOhfR-sL7; Mon, 10 Dec 2007 14:11:22 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 430CF1F08028;
	Mon, 10 Dec 2007 14:11:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <CE1FB037-26E3-475E-9F9D-AC3874987B9C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67711>

Clifford Heath wrote:
> Be patient with me, it's my first day on git... I like it better than 
> svn already,

Welcome to a better world.

> but I need a bit of help.
> 
> After cloning a remote repository, I wanted to update (rebase) an existing
> remote branch to get the latest master commits, so I switched to it using
> git checkout, then did a "git merge origin/master" and it updated my local
> copy so it looked reasonable... I have changes to add to this branch, but
> I wanted a proper base, so I did a "git commit" and a "git push". The push
> gave me the above message.
> 
> I've checked ssh access (don't have shell) to the other side, my PK is 
> set up.
> 
> What went wrong? How can I diagnose it further (-v doesn't help)
> 

How did you clone it? If you cloned via git:// protocol, you most likely
can't push back there. The git-daemon supports pushing, but does no
authentication.

If you cloned via ssh it's a bit harder to diagnose, since all git knows
is that the ssh-server closed its connection. For security reasons, it
doesn't necessarily tell you why it did that, so it's hard to know what
the real problem is.

> I understand that to add my further changes, I should set up a local branch
> to track this updated remote branch. But I'm assuming that the rebase must
> be done while switched to the remote branch...?
> 

Not really. You can do "git rebase --onto origin/master master". However,
since you merged origin/master earlier, a rebase will only tell you that
you're up-to-date.

"git help rebase" might be worth looking into though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
