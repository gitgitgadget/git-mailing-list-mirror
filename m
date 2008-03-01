From: Paul Mackerras <paulus@samba.org>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Sat, 1 Mar 2008 21:59:01 +1100
Message-ID: <18377.14069.25974.10203@cargo.ozlabs.ibm.com>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
	<7v7igqyii9.fsf@gitster.siamese.dyndns.org>
	<18373.58839.636432.448970@cargo.ozlabs.ibm.com>
	<7v1w6yqaim.fsf@gitster.siamese.dyndns.org>
	<18374.39253.408961.634788@cargo.ozlabs.ibm.com>
	<7vprugdxpj.fsf@gitster.siamese.dyndns.org>
	<18375.58359.687664.855599@cargo.ozlabs.ibm.com>
	<7vfxvbd0nu.fsf@gitster.siamese.dyndns.org>
	<18377.2084.30531.202087@cargo.ozlabs.ibm.com>
	<7vejau6fvf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 11:59:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVPRe-00040y-GC
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 11:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbYCAK7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 05:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbYCAK7J
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 05:59:09 -0500
Received: from ozlabs.org ([203.10.76.45]:52854 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbYCAK7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 05:59:08 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 35E6DDDE10; Sat,  1 Mar 2008 21:59:06 +1100 (EST)
In-Reply-To: <7vejau6fvf.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75653>

Junio C Hamano writes:

> I think your "gitk passes the IDs" part is about the master...next part in
> the above example.  I do not think it really matters if they are converted
> to object names or kept symbolic when given to "git log".

The only time it would matter is if they were kept symbolic AND
somehow the user changed them between the git rev-parse (or git
rev-list) invocation and the git log invocation.

> Come to think of it, when you are told to "Update", you already know the
> positive tips you can use to optimize (4), don't you?  They are the
> commits you drew in (3) that do not have children.

It's possible the user could do "Update" before we had finished
reading stuff from the first git log, so I don't necessarily know all
the commits that have no children.  And in fact that's a reasonable
thing to do if gitk is being used on a really really large
repository.

I'm a kernel guy - I worry about race conditions. :)

Thanks for the tip about git rev-list --no-walk.

Paul.
