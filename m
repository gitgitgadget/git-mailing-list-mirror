From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 12:19:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201218360.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504201323.05447.mason@suse.com>
 <Pine.LNX.4.58.0504201040400.6467@ppc970.osdl.org> <200504201504.59541.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 21:15:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOKeN-0004r2-Tp
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 21:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVDTTSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 15:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVDTTSK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 15:18:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:48001 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261743AbVDTTSB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 15:18:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KJHts4024775
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 12:17:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KJHs5t022775;
	Wed, 20 Apr 2005 12:17:55 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504201504.59541.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Chris Mason wrote:
> 
> Well, the difference there should be pretty hard to see with any benchmark.
> But I was being lazy...new patch attached.  This one gets the same perf 
> numbers, if this is still wrong then I really need some more coffee.

I did my preferred version. Makes a big difference here too.

It would be nicer for the cache to make the index file "header" be a 
"footer", and write it out last - that way we'd be able to do the SHA1 as 
we write rather than doing a two-pass thing. That's for another time.

		Linus
