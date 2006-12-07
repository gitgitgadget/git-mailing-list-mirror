X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Commit f84871 breaks build on OS X
Date: Thu, 7 Dec 2006 10:29:16 -0500
Message-ID: <E8038C15-B359-4DE9-B3E0-45B065AEDBFA@silverinsanity.com>
References: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com> <Pine.LNX.4.63.0612071554180.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 15:29:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612071554180.28348@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33593>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsLBd-0007VS-Mp for gcvg-git@gmane.org; Thu, 07 Dec
 2006 16:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032295AbWLGP3U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 10:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937987AbWLGP3U
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 10:29:20 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:41121 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937986AbWLGP3U (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 10:29:20 -0500
Received: from [IPv6???1] (localhost [127.0.0.1]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 silverinsanity.com (Postfix) with ESMTP id 60D4F1FFD203 for
 <git@vger.kernel.org>; Thu,  7 Dec 2006 15:29:19 +0000 (UTC)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alex Riesen wrote:
> Strange. You seem to have the old, generated Makefile you perl/
> directory. Haven't your pull failed?

My pull didn't fail, and your suggested list of commands tells me  
"Already up-to-date."  I've pulled, reset, and removed perl/Makefile  
repeatedly when I was trying to use git-bisect.  Primarily because of  
merge conflicts in perl/Makefile that running make causes.

Johannes Schindeli wrote:
>> When I pulled the most recent changes for git (de51faf), `make` began
>> failing with the following messages: [...]
>
> I found the same, but could not reproduce it. But a "touch perl/ 
> perl.mak"
> fixes at least compilation.

Indeed, the following sequence works:

git reset --hard
touch perl/perl.mak
make

But this one doesn't:

git reset --hard
make
touch perl/perl.mak
make

That one fails with "make[2]: *** No rule to make target  
`instlibdir'.  Stop."

And both of these sequences cause `git status` to report that "perl/ 
Makefile" has been changed, which doesn't seem ideal.

(I'm replying to multiple messages because the list archive I'm  
browsing is getting the messages faster than I am, and I didn't feel  
the need to wait.)

