From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] stgit: allow spaces in filenames
Date: Wed, 13 Jul 2005 12:51:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507131250060.17536@g5.osdl.org>
References: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local>
 <pan.2005.07.13.16.54.18.709929@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 21:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsnJy-0008Tj-J8
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 21:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVGMTyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 15:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVGMTwb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 15:52:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262711AbVGMTvn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 15:51:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6DJpHjA013740
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Jul 2005 12:51:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6DJpGg4032316;
	Wed, 13 Jul 2005 12:51:16 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.07.13.16.54.18.709929@smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Jul 2005, Matthias Urlichs wrote:
>
> Hi, Bryan Larsen wrote:
> 
> > +	r=os.spawnvp(os.P_WAIT, args_l[0], args_l + args[i:min(i+1000, len(args))])
> 
> The max length for argv is 32k IIRC, so 1000 is 28-byte file names.

I think 32k may be the posix-mandated minimum. Linux does 128kB, so 1000 
should likely be ok for most projects.

That said, xargs should do things like that right.

		Linus
