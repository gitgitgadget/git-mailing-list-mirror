From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Yet another base64 patch
Date: Thu, 14 Apr 2005 00:40:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org>
 <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org>
 <425E0D62.9000401@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christopher Li <git@chrisli.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 09:36:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLyt7-0006fM-Ec
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 09:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVDNHjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 03:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVDNHjE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 03:39:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:2250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261455AbVDNHjB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 03:39:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3E7cws4008581
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 00:38:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3E7cuDO014576;
	Thu, 14 Apr 2005 00:38:57 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <425E0D62.9000401@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Apr 2005, H. Peter Anvin wrote:
> 
> Actually, the subdirectory hack has the same effect, so you lose 
> regardless.  Doesn't mean that you can't construct cases where the 
> subdirectory hack doesn't win, but I maintain that those are likely to 
> be artificial.

I'll tell you why a flat object directory format simply isn't an option.

Hint: maximum directory size. It's limited by n_link, and it's almost
universally a 16-bit number on Linux (and generally artifically limited to
32000 entries).

In other words, if you ever expect to have more than 32000 objects, a flat 
space simply isn't possible.

		Linus
