From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 11:48:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504141145220.7211@ppc970.osdl.org>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
 <425EB4AE.4010700@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:45:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9KR-0001Py-34
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 20:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVDNSrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 14:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDNSrj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 14:47:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:19155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261437AbVDNSq5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 14:46:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3EIkos4029475
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 11:46:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3EIkjra012351;
	Thu, 14 Apr 2005 11:46:48 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <425EB4AE.4010700@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, H. Peter Anvin wrote:
> 
> Although Linus is correct in that an SCM doesn't *have* to handle this, 
> it really feels like shooting for mediocracy to me.  We might as well 
> design it right from the beginning.

No. git is not an SCM. it's a filesystem designed to _host_ an SCM, and 
that _is_ doing it right from the beginning.

Keep the abstractions clean. Do _not_ get confused into thinking that git 
is an SCM. If you think of it that way, you'll end up with crap you can't 
think about.

And at a filesystem layer, "rename" already exists. It's moving an object 
to a new name in a tree. git already does that very well, thank you very 
much.

But a filesystem rename is _not_ the same thing as an SCM rename.  An SCM 
rename is built on top of a filesystem rename, but it has its own issues 
that may or may not make sense for the filesystem.

		Linus
