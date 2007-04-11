From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Thu, 12 Apr 2007 10:59:36 +1200
Message-ID: <461D6858.4090007@vilain.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org> <461D6432.90205@vilain.net> <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hblof-0004IC-4q
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 01:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161396AbXDKXAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 19:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161399AbXDKW77
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 18:59:59 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47587 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161390AbXDKW7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 18:59:44 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 2C1DF13A403; Thu, 12 Apr 2007 10:59:42 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D2E6513A3E1;
	Thu, 12 Apr 2007 10:59:38 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44273>

Linus Torvalds wrote:
> > Does this consider the case where the intent of the subprojects are to
> > collate multiple, small projects into one bigger project?
> > 
> > In that case, you might want to keep all of the subprojects in the same
> > git repository.
>
> I assume you mean "you might want to keep all of the subprojects' objects 
> in the same git object directory".
>
> And yes, that's absolutely true, but it's technically no different from 
> just using GIT_OBJECT_DIRECTORY to share objects between totally unrelated 
> projects, or using git/alternates to share objects between (probably 
> *less* unrelated repositories, but still clearly individual repos).
>   

Would that be the only distinction?

Would submodules be descended into for object reachability questions?

> So the main point of superproject/subprojects is to allow independence 
> (because independence is what allows it to scale), but there is nothing to 
> say that things *have* to kept totally isolated. 
>   

I'm particularly interested in repositories with, say, thousands of
submodules but only a few hundred meg. I really want to avoid the
situation where each of those submodules gets checked or descended into
separately for updates etc.

Sam.
