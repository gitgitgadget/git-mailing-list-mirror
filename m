From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Sun, 16 Nov 2008 16:16:37 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811161609340.3468@nehalem.linux-foundation.org>
References: <823128.71540.qm@web37902.mail.mud.yahoo.com> <20081115035743.GA19633@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gary Yang <garyyang6@yahoo.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 17 01:18:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1roW-0000hB-RN
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 01:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbYKQAQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 19:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbYKQAQp
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 19:16:45 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35086 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751859AbYKQAQp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Nov 2008 19:16:45 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAH0GcbF024165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Nov 2008 16:16:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAH0Gb3E026013;
	Sun, 16 Nov 2008 16:16:38 -0800
In-Reply-To: <20081115035743.GA19633@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.431 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101184>



On Fri, 14 Nov 2008, Jeff King wrote:
> 
> You need to tell git who you are, since it is unable to deduce it from
> doing host lookups. Try:
> 
>   git config --global user.email garyyang6@yahoo.com
> 
> or whatever email address you used when you created the key, and then
> gpg should find it appropriately.

Side note: sometimes you might want to use a different key than the one 
you use for authorship. Then you can use

	[user]
		SigningKey = key

(or "git config user.signingkey xyz" if you don't want to edit the 
config file manually). 

This can be especially useful if you use different keys for different 
projects, even if you want to be known under the same name in both. Or 
because you want to have the local hostname in your commit logs, but your 
gpg key is using some externally visible "official" email address.

			Linus
