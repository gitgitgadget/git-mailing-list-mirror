From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/2] Add optional parameters to the diff option
 "--ignore-submodules"
Date: Wed, 09 Jun 2010 00:11:14 +0200
Message-ID: <201006090011.14995.johan@herland.net>
References: <4C0E7037.8080403@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 09 00:12:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM71s-0006IM-DI
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 00:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700Ab0FHWLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 18:11:19 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40168 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756542Ab0FHWLS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 18:11:18 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3P0057TUYTUG50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 09 Jun 2010 00:11:17 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 6BCA51EA564A_C0EC005B	for <git@vger.kernel.org>; Tue,
 08 Jun 2010 22:11:17 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 58F3B1EA3F49_C0EC005F	for <git@vger.kernel.org>; Tue,
 08 Jun 2010 22:11:15 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3P009S3UYR4S10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 09 Jun 2010 00:11:15 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <4C0E7037.8080403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148726>

On Tuesday 08 June 2010, Jens Lehmann wrote:
> After thinking some time about peoples expectations and troubles
> with the recursive scanning of submodules, I came up with this:
> 
> What about expanding the "--ignore-submodules" option of the git diff
> family with three parameters:
> 
> --ignore-submodules=all : Same behavior as "--ignore-submodules",
>   submodules show never up as modified.
> 
> --ignore-submodules=untracked : Don't consider submodules as modified
>   when they only contain untracked files, but do if the commits in the
>   superproject are different or tracked content is modified.
> 
> --ignore-submodules=dirty : Don't consider submodules as modified
>   when their work tree is dirty, no matter why. This is the pre 1.7.0
>   behavior and doesn't recurse into submodules at all.

Pardon my ignorance: Does this make "dirty" a superset of "untracked"? Or 
are they orthogonal. And how does "all" compare to "dirty"? Are they 
synonyms, or is "all" a superset of "dirty"?

> To make that more useful the default could be controlled by the
> .git/config or .gitmodules file. So you could have two submodules:
> 
> [submodule "sub1"]
> 	path = sub1
> 	url = /home/me/sub1.git/
> 	ignore = dirty
> [submodule "sub2"]
> 	path = sub2
> 	url = /home/me/sub2.git/
> 	ignore = untracked
> 
> [...]
> 
> Opinions?

I agree with adding support for this in .gitmodules, to allow customizing on 
a per-submodule level.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
