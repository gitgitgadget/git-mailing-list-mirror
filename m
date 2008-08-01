From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 12:34:58 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 21:36:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP0Pz-0007BR-S2
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 21:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbYHATfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 15:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbYHATfB
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 15:35:01 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52510 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752375AbYHATfA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 15:35:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71JYw95028300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 1 Aug 2008 12:34:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71JYwfi031645;
	Fri, 1 Aug 2008 12:34:58 -0700
In-Reply-To: <20080731194042.a1534b4d.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.412 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91078>



On Thu, 31 Jul 2008, Andrew Morton wrote:
> 
> A minor thing.
> 
> Commit 76ecb4f2d7ea5c3aac8970b9529775316507c6d2 is displayed thusly:
> 
>   commit 76ecb4f2d7ea5c3aac8970b9529775316507c6d2
>   Author: Zhang, Rui <rui.zhang@intel.com>
>   Date:   Thu Apr 10 16:20:23 2008 +0800
> 
>       ACPI: update thermal temperature
> 
> but that isn't a valid email address.  Because it contains a comma it
> must be quoted:  "Zhang, Rui".

The email address is rui.zhang@intel.com.

The name is Zhang, Rui.

Git at no point ever mixes the two up. It's _not_ one field ("Zhang, Rui 
<rui.zhang@intel.com>"), it's literally two different parts that you set 
separately, that just get shown (and encoded in the commit, for that 
matter) in a way that resembles a single email address.

> I assume that something in the git toolchain removed his quotes, and
> that was arguably incorrect.

No, it would be incorrect to keep them, because the name doesn't contain 
the quotes. The name is just that 

	Zhang, Rui

part.

I've considered having the email->name detection change "A, B" into "B A", 
but it's not always right, so it doesn't try to munge the names it finds 
in other ways except to remove obvious crud from the ends.

And Andrew, this is true of Signed-off-by: lines too, btw. If you actually 
want to send emails to them, _then_ you need to add quotes to follow the 
email rules. 

		Linus
