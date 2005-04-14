From: David Mansfield <david@cobite.com>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 15:21:52 -0400
Message-ID: <425EC2D0.2090904@cobite.com>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com> <20050414181224.GA16126@elte.hu> <Pine.LNX.4.58.0504141124220.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
	git@vger.kernel.org, James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:20:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9rG-0006ws-SL
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVDNTV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVDNTV5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:21:57 -0400
Received: from iris.cobite.com ([208.222.83.2]:34496 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S261594AbVDNTVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 15:21:55 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id D3A4497D59; Thu, 14 Apr 2005 15:21:51 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07498-08; Thu, 14 Apr 2005 15:21:51 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id 9D20A98678; Thu, 14 Apr 2005 15:21:51 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 46BAA97D59; Thu, 14 Apr 2005 15:21:50 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504141124220.7211@ppc970.osdl.org>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 14 Apr 2005, Ingo Molnar wrote:
> 
>>there's no redundancy caused by this method: only renames (which are 
>>rare) go through the rename_commit redirection. (to speed up the lookup 
>>the rename_commit object could cache the offset of the two names within 
>>their tree objects.)
> 
> 

> 
> Some "higher level" thing can add its own rules _on_top_ of git rules. The
> same way we have normal applications having their _own_ rules on top of
> the kernel. You do abstraction in layers, but for this to work, the base 
> you build on top of had better be damn solid, and not have any ugly 
> special cases.
> 

Maybe you (or the group) should standardize on a way to 'extend' the 
commit 'object' in terms of:

the layer1 (git) header for commit object is defined as such-and-such
the layer2 (scm or other) header for commit object is defined as 
such-and-such

Much the way network protocols stack on top of each other.  If a 
standard way of stacking is defined, then it could be much cleaner for 
future implementors to understand a 'new' stacking protocol, and it will 
make the scm-level extensions easier to discuss it terms of their own 
'layer'.

David
