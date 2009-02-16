From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 18:13:58 +0100
Message-ID: <49999ED6.7010608@gmail.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm> <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 18:15:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ749-0007wS-PS
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 18:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbZBPROG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 12:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbZBPROE
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 12:14:04 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:60695 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbZBPROB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 12:14:01 -0500
Received: by bwz5 with SMTP id 5so3238825bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 09:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=gRByugeXBqJ94u6DR+4vHpe8DVkFLAzK/d5B16955/U=;
        b=UpS3/dXYlUqRibkgfSpeygsOprp5HNl3dbEd1Qo+5fJuW0W9rsRpncxbC57fDY1Cjk
         MT8zFwBfMhSt/JyAuvfVhPMcQKVweGcaxG+De5PeZb+kV2bl2eCYGI8tBA+ZQJCbXqOO
         wXKrOnVF2EqEuBPLLBwKCN47ff42OdJCZzAlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=O2wsWTFNqBjG5njtiIxXJegUjsN0T73z9xYtbyhNzV3kXBie8TCn7eKuvk/dXcfKv5
         As5XwSg9nCZXX8dIQZ6LClPaUC97+CCoVSExYmp8MLpOvi6WSwPJRADCQXT9odq7FYU1
         bhFSVeHPpjXtrG+mwtB+O1PArPWH97j0lYIEI=
Received: by 10.223.107.19 with SMTP id z19mr111514fao.27.1234804439437;
        Mon, 16 Feb 2009 09:13:59 -0800 (PST)
Received: from ?192.168.1.99? (host172-56-dynamic.10-87-r.retail.telecomitalia.it [87.10.56.172])
        by mx.google.com with ESMTPS id 35sm3967790fkt.3.2009.02.16.09.13.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 09:13:59 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090216135812.GA20377@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110213>

Jeff King wrote:
> On Mon, Feb 16, 2009 at 10:17:01AM +0000, Sergio Callegari wrote:
>
>   
>>> For people who do not follow the git list regularly, a "HEAD contain the
>>> actual commit" is often called "detached".
>>>       
>> Could you have that done automatically?
>> Namely rather to denying push to a branch b where HEAD->b, when you get such
>> push you detach head?
>>     
>
> See
>
>   http://article.gmane.org/gmane.comp.version-control.git/108923
>
> for discussion.
>
> -Peff
>   
Thanks for the pointer!

However, wrt point 1)

> If you set 'detach' option, this clueless user is not helped; he will
>      happily keep working and would make tons of commits on detached HEAD,
>      and next time he switches to another branch, will lose all of them.
>   
I guess that git does not let you commit on a detached head without 
crying out loud.

Furthermore, one could do just a bit more than detaching, namely store 
the fact that head got detached and the name of the branch where the 
head was.
With this, when the unconscious user types git status or git commit the 
system could alert him that head got detached because someone updated 
the branch behind his shoulders from remote... and then suggest the 
option to either create a new branch from the detached head (I believe 
that this is what gets suggested anyway when one tries to commit from a 
detached head) or to stash the current tree status, get back onto the 
former branch and try applying the changes on the new head of the branch.
The flag triggering this warning at a git status or git commit command 
should then be cleared at the first occasion when the head is changed.

To me this seems natural and helpful. Am I missing something?

Sergio
