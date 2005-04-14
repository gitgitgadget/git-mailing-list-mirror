From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Yet another base64 patch
Date: Thu, 14 Apr 2005 01:17:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504140114260.7211@ppc970.osdl.org>
References: <425DEF64.60108@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 10:13:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLzSN-0003rU-L4
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 10:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVDNIP2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 04:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVDNIP2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 04:15:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:22232 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261453AbVDNIPW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 04:15:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3E8FLs4011197
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 01:15:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3E8FKlv015832;
	Thu, 14 Apr 2005 01:15:20 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <425DEF64.60108@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Apr 2005, H. Peter Anvin wrote:
> 
> Checking out the total kernel tree (time checkout-cache -a into an empty 
> directory):
> 
> 		Cache cold	Cache hot
> stock		3:46.95		19.95
> base64	5:56.20		23.74
> flat		2:44.13		15.68

So why is "base64" worse than the stock one?

As mentioned, the "flat" version may be faster, but it really isn't an
option. 32000 objects is peanuts. Any respectable source tree may hit that
in a short time, and will break in horrible ways on many Linux
filesystems.

So you need at least a single level of subdirectory. 

What I don't get is why the stock hex version would be better than base64.

I like the result, I just don't _understand_ it.

		Linus
