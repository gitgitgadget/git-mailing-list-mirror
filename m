From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 13:59:14 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181348250.18017@i5.linux-foundation.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>  <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>  <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org> 
 <9e4733911003181216m59a09ad6y6c7c890714d0d20b@mail.gmail.com>  <alpine.LFD.2.00.1003181218400.18017@i5.linux-foundation.org>  <9e4733911003181237i56a00a78k31fac2c1afe5a674@mail.gmail.com>  <alpine.LFD.2.00.1003181241080.18017@i5.linux-foundation.org> 
 <alpine.LFD.2.00.1003181248040.18017@i5.linux-foundation.org> <3f4fd2641003181331t4e70bed0yf1d03e20d1127705@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 22:02:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsMrf-0001an-QM
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 22:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674Ab0CRVCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 17:02:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45248 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752671Ab0CRVCi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 17:02:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IL28Xn023602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 14:02:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IL27C0015456;
	Thu, 18 Mar 2010 14:02:08 -0700
In-Reply-To: <3f4fd2641003181331t4e70bed0yf1d03e20d1127705@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142519>



On Thu, 18 Mar 2010, Reece Dunn wrote:
> 
> What would be better is having a concept of identity aliases. That is,
> a user can say that (for this git project), (user1,email1) is the same
> person as (user2,email2). This would allow someone who has
> mis-configured their git instance to say what the (user,email) pair
> should have been. It also allows people to say that they used to be
> called someone and they are now called somebody.

Yeah. And that's what '.mailmap' is, really.

Does mailmap get annoying? Yes. Is it going to be incomplete? Yes. Do we 
ever even _bother_ to try to make it perfect? No.

In the kernel, for example, we tend to use it _only_ to fix up the real 
name. It's much more capable than that (ie you can use it to fix up email 
addresses too), but we literally haven't cared enough to bother. So you 
still see the "localhost" emails or the "(none)" domains - even if you use 
one of the formats that ask for a "fixed" name and email.

And git itself only fixes up names for certain commands (git blame, git 
shortlog) and with specific format specifiers (%aN and %aE).

The _default_ pretty log format printouts don't do it, for example. Should 
they? Maybe. Or maybe we should have a flag and/or config option to do so 
by default.

				Linus
