From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] post-update hook: update working copy
Date: Fri, 02 Nov 2007 11:34:33 +0100
Message-ID: <472AFD39.6000006@op5.se>
References: <1193964304-10847-1-git-send-email-sam.vilain@catalyst.net.nz> <7vd4ut7948.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:35:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Intrg-0007UM-91
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbXKBKek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 06:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbXKBKek
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:34:40 -0400
Received: from mail.op5.se ([193.201.96.20]:44051 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbXKBKej (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 06:34:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 942DA17306E2;
	Fri,  2 Nov 2007 11:34:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UlDzfckcBVmc; Fri,  2 Nov 2007 11:34:34 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 3219D17306D9;
	Fri,  2 Nov 2007 11:34:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vd4ut7948.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63099>

Junio C Hamano wrote:
> Sam Vilain <sam.vilain@catalyst.net.nz> writes:
> 
>> Now that git-stash is available, it is not so unsafe to push to a
>> non-bare repository, but care needs to be taken to preserve any dirty
>> working copy or index state.  This hook script does that, using
>> git-stash.
> 
> Honestly, I am reluctant to do things that _encourages_ pushing
> into a live tree.
> 

"Live" and "living" are perhaps two different things here. I for one have
something similar, but only for repositories residing on certain servers,
where there really must be zero local changes to the working tree.

>  - Who guarantees that the reflog is enabled for the HEAD?
> 

I disable reflogs on that server. There's (hardly ever) any human interaction
with the scripts in that repo, so I really, really don't care about reflogs.

>  - Who guarantees that a human user is not actively editing the
>    work tree files without saving?

There are times when one simply doesn't care.

I realize that for my situation, a much simpler script can (and is) used, so
I agree with your concerns. The idea that every git repo has a human hacking
on it isn't true though, so doing things like this are sometimes useful,
timesaving and a real help.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
