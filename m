From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 13:23:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702081321040.8424@woody.linux-foundation.org>
References: <17866.27739.701406.722074@lisa.zopyra.com>
 <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
 <87fy9gz9vu.fsf@host94.eke.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Kalle Pokki <kalle.pokki@iki.fi>
X-From: git-owner@vger.kernel.org Thu Feb 08 22:23:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFGk5-0005dI-Eg
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 22:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423411AbXBHVXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 16:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423413AbXBHVXm
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 16:23:42 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39727 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423411AbXBHVXl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 16:23:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l18LNX3O001634
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Feb 2007 13:23:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l18LNWZc026740;
	Thu, 8 Feb 2007 13:23:32 -0800
In-Reply-To: <87fy9gz9vu.fsf@host94.eke.fi>
X-Spam-Status: No, hits=-0.443 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.115__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39096>



On Thu, 8 Feb 2007, Kalle Pokki wrote:
> 
> I usually undo a pull by throwing away just the merge commit by
> 
>         git reset --hard HEAD^

Don't do this.

If the merge just fast-forwarded, you'll do the wrong thing.

So yes, it _works_, but it only works if you actually ended up having a 
real merge. In contrast, the ORIG_HEAD thing always works.

ORIG_HEAD is also particularly useful for doing things like "ok, what did 
I get from that pull?" especially when you track somebody elses work (in 
which case it will basically _always_ be a fast-forward). So I do

	gitk ORIG_HEAD..

in git almost every time I pull from Junio's git thing, just because it's 
a wonderful way to see what has changed, if you're interested in that kind 
of detail.

		Linus
