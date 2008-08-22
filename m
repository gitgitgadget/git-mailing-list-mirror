From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 12:36:58 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 21:38:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWcSX-0005X4-7X
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 21:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbYHVThF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 15:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYHVThF
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 15:37:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50917 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752149AbYHVThE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 15:37:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7MJaxRT027212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Aug 2008 12:37:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7MJawb6012743;
	Fri, 22 Aug 2008 12:36:58 -0700
In-Reply-To: <20080822182718.GQ23334@one.firstfloor.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.429 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93347>



On Fri, 22 Aug 2008, Andi Kleen wrote:
> 
> Well git fetch does nothing by itself.

Git fetch does exactly what it should do by itself. 

If you think it does "nothing", you're really confused.

It updates the "remote" branches - the ones you are downlaoding.

> Sorry that's what I though initially too. But that's wrong.  Just clone
> e.g. linux-next and then try to update it with pull a day later.  

You SHOULD NOT DO THAT!

linux-next is not a tree that you can track. It's a tree that you can 
fetch _once_ and then throw away.

So what you can do is to "fetch" linux-next, and test it. But you MUST 
NEVER EVER use it for anything else. You can't do development on it, you 
cannot rebase onto it, you can't do _anything_ with it.

So what you can do is to "git fetch" it (to download it), and then "git 
checkout" to create a temporary checkout. That's pretty much all you can 
do with linux-next.

> rebase messed this all up majorly.  And people use that unfortunately.

Exactly. Don't rebase. And don't base your development on somebody who 
does.

And "linux-next" is literally just a temporary tree that is a merge of a 
lot of random trees. It has no future.

Remember how I told you that you should never rebase?

			Linus
