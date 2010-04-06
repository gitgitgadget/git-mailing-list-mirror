From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Apr 2010, #02; Sun, 04)
Date: Tue, 06 Apr 2010 09:12:44 +0800
Message-ID: <4BBA8A8C.2080905@drmicha.warpmail.net>
References: <7vtyrr6nes.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 03:13:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyxM6-0006PX-0G
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 03:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456Ab0DFBNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 21:13:05 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42133 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756236Ab0DFBND (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 21:13:03 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6A278EABC3;
	Mon,  5 Apr 2010 21:13:01 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 05 Apr 2010 21:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=TDfTOW67B9VZiAFVZJpcvsxkxHk=; b=RmYjHZwIkAbLeLj+bL7WAGSlD1PmuJ6LDjnbjpiKSXAS+CI3LCURqfCIDrn2b9iKURhC/K4Nnd9m/H69UBKrxotQzBIXV4TQ2XXn6mGZ/jWcdnj9BPCIx7ahjv5ve6PnR/CFAhtBfmjESINHYsGKVpaxVMRVUdoFtk/KhB2gKQ0=
X-Sasl-enc: fX4ZuAeJe9bCXjO6P3DoAI9NjpjzFVvkcz/OAwVdD5QK 1270516380
Received: from localhost.localdomain (unknown [202.113.236.7])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 005864A6A32;
	Mon,  5 Apr 2010 21:12:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <7vtyrr6nes.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144074>

Junio C Hamano venit, vidit, dixit 05.04.2010 03:14:
> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
> marked with '.' do not appear in any of the integration branches, but I am
> still holding onto them.
> 
> --------------------------------------------------

> * mg/notes-reflog (2010-03-29) 2 commits
>  - refs.c: Write reflogs for notes just like for branch heads
>  - t3301-notes: Test the creation of reflog entries
> 
> Implementation is trivially correct; I am unsure if "notes" tree wants
> reflog in the first place, though.  Please convince me and I'll move it
> to 'next' soon, aiming for -rc0 or -rc1 at the latest.

I think that Jeff's impressive textconv caching is only the first of
many uses of notes where the notes ref is not a branch head with
continuously added history, but where the ref is being rewritten over
and over again. Also, people may rewrite their refs/notes/commits when
experimenting with remote notes trees.

In both cases, I deem the reflog "backup" a useful safety measure (just
as for other refs), and the automatic purging of the reflog provides
just the appropriate housekeeping.

Michael
