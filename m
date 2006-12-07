X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Thu, 7 Dec 2006 11:58:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612071152410.3615@woody.osdl.org>
References: <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org>
 <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org>
 <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org>
 <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
 <457868AA.2030605@zytor.com> <Pine.LNX.4.64.0612071121410.3615@woody.osdl.org>
 <20061207193903.GE12143@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 19:59:13 +0000 (UTC)
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061207193903.GE12143@spearce.org>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33624>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPOf-0002ga-DP for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163252AbWLGT7G (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163248AbWLGT7F
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:59:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33633 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1163252AbWLGT7E
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 14:59:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB7JwOID013228
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 7
 Dec 2006 11:58:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB7JwNxg023614; Thu, 7 Dec
 2006 11:58:24 -0800
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org



On Thu, 7 Dec 2006, Shawn Pearce wrote:
> 
> AFAIK it doesn't have such an option, for basically the reason
> you describe.  I worked on a project which had much more difficult
> to answer queries than gitweb and were also very popular.  Yes,
> the system died under any load, no matter how much money was thrown
> at it.  :-)
> 
> > That said, from some of the other horrors I've heard about, "stupid" may 
> > be just scratching at the surface.
> 
> It is.  :-)

Gaah. That's just stupid. This is such a _basic_ issue for caching ("if 
concurrent requests come in, only handle _one_ and give everybody the same 
result") that I claim that any cache that doesn't handle it isn't a cache 
at all, but a total disaster written by incompetent people.

Sure, you may want to disable it for certain kinds of truly dynamic 
content, but that doesn't mean you shouldn't be able to do it at all.

Does anybody who is web-server clueful know if there is some simple 
front-end (squid?) that is easy to set up and can just act as a caching 
proxy in front of such an incompetent server?

Or maybe there is some competent Apache module, not just the default 
mod_cache (which is what I assume kernel.org uses now)?

