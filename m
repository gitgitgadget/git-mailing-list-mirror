From: Philip Pokorny <ppokorny@mindspring.com>
Subject: Re: PATCH[0/4]: Allow tree-id to return the ID of a tree object
Date: Thu, 28 Apr 2005 00:11:37 -0700
Message-ID: <42708CA9.2050201@mindspring.com>
References: <426FBBE7.1090806@mindspring.com> <20050427232223.GM22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 09:10:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR39M-0000lW-Nk
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 09:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVD1HOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 03:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVD1HMp
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 03:12:45 -0400
Received: from smtpauth09.mail.atl.earthlink.net ([209.86.89.69]:49334 "EHLO
	smtpauth09.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261836AbVD1HLj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 03:11:39 -0400
Received: from [68.164.169.208] (helo=[172.16.1.11])
	by smtpauth09.mail.atl.earthlink.net with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.34)
	id 1DR3BS-0002Gr-OS; Thu, 28 Apr 2005 03:11:38 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050427232223.GM22956@pasky.ji.cz>
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4d2eaa3e7670f5b9d092bd67e35a9ad3e2350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.164.169.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>Could you please functionally split and sign off your patch?
>  
>
Apologies, I'm still a bit new to LKML etiquette...

>Also, I'd prefer not to have the sha1 completion logic duplicated; what
>about just having commit-id take a parameter not to validate its id?
>Actually, that's ugly too. I think the cleanest solution would be to
>reintroduce the cg-Xnormid, now to only really do the _common_ stuff -
>basically everything up to the typecheck (exclusively) in commit-id.
>  
>
OK, so following this will be a new set of patches (I assume you mean 
one patch per file changed when you asked for a "functional split") that 
re-introduce cg-Xnormid, and then convert commit-id, tree-id, and 
parent-id to use the new core.

In re-writing these, I've put great effort into making the scripts *not* 
exec a sub-shell or process, so the bash constructs may look strange. 
I'm sure Linux can exec very quickly, but bash parses and executes even 
faster when it doesn't have to fork.
