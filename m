From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git.git object database at kernel.org?
Date: Mon, 25 Apr 2005 17:32:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251729080.18901@ppc970.osdl.org>
References: <7vhdhvstb2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504241553580.18901@ppc970.osdl.org> <426D3B01.8060408@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 02:26:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQDtR-0000Rh-5y
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 02:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVDZAa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 20:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVDZAa3
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 20:30:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:1516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261224AbVDZAaY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 20:30:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3Q0UIs4017520
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 17:30:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3Q0UHvp016988;
	Mon, 25 Apr 2005 17:30:17 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426D3B01.8060408@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, H. Peter Anvin wrote:
> 
> No, mktime() always uses the local time zone.  It's the inverse of 
> localtime().

Note that this still doesn't make any sense.

A true inverse of "localtime()" should still take the GMT offset from
"struct tm", and it would work fine, assuming that localtime() set that
offset correctly.

So _I_ think it's incredibly stupid that mktime() looks at the local 
timezone. 

Oh, well.  Not a big issue except for the date conversion, and since there 
hopefully aren't any old repo's left, we can leave it behind us.

		Linus
