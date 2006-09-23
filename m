From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: git pull for update of netdev fails.
Date: Sat, 23 Sep 2006 14:10:17 +0100
Message-ID: <b0943d9e0609230610h46ffb995gb25ebda8332570e8@mail.gmail.com>
References: <20060920080308.673a1e93@localhost.localdomain>
	 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org>
	 <20060920155431.GO8259@pasky.or.cz>
	 <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060920160756.GP8259@pasky.or.cz>
	 <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
	 <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060923034407.GF8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 15:11:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR7He-0005mQ-Ry
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 15:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWIWNKU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 09:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWIWNKU
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 09:10:20 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:10529 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751067AbWIWNKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 09:10:18 -0400
Received: by py-out-1112.google.com with SMTP id n25so1670756pyg
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 06:10:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eel9qovOvbnVjAbeN0VGJ4GpvuGu3j5i9ScU//omKSWKjnAPf5mt69WrK8SgBEECYvTeC+5FusinHg8s+0PN0DcWRdyPwUWcyU3kO3eI35pIeuvGuXkAMiDzdzkBx3mGztAcRknJyFa/8RV1XdKXvx5fkGPBbrUbbtOmXrrAgYQ=
Received: by 10.35.96.7 with SMTP id y7mr3671452pyl;
        Sat, 23 Sep 2006 06:10:18 -0700 (PDT)
Received: by 10.35.77.5 with HTTP; Sat, 23 Sep 2006 06:10:17 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060923034407.GF8259@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27587>

Petr,

(I'm slow at replying and even slower at implementing anything over
the next 2-3 weeks - paternity leave :-))

On 23/09/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Wed, Sep 20, 2006 at 11:14:25PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > Another, even more serious problems with rebasing: You can introduce a bug
> > by rebasing. Meaning: git-rebase can succeed, even compilation is fine,
> > but the sum of your patches, and the patches you are rebasing on, is
> > buggy. And there is _no_ way to bisect this, since the "good" version can
> > be gone for good.
>
> Yes, I agree that this really is a problem, but that's a fundamental
> limitation. At least for StGIT-maintained floating branches the latest
> bleeding edge StGIT could fix that. (Except that the problem outlined by
> Linus is present here as well, first prune will wipe your older patch
> versions and your patch log will be useless - Catalin? Can we store the
> older patch versions references in something like
> .git/refs/patches-old/?) And except that it does that only for you -
> there should be a way to conveniently mirror (clone+pull) the patch
> stack setup.

I wasn't following this thread (well, any thread in the last days) but
the current patch history implementation in StGIT is prune-safe as it
generates additional commits to keep the history. If you undo an
operation (push, refresh), the undo will be recorded in the patch
history (that's really immutable). However, deleting a patch would
delete the corresponding history log as well.

-- 
Catalin
