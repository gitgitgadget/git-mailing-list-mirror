From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 07:47:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
References: <20060420133640.GA31198@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 16:48:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWaRm-0003y0-O6
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 16:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWDTOrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 10:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWDTOrv
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 10:47:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750945AbWDTOru (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Apr 2006 10:47:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3KElktH014505
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Apr 2006 07:47:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3KEljic029009;
	Thu, 20 Apr 2006 07:47:46 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060420133640.GA31198@spearce.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18972>



On Thu, 20 Apr 2006, Shawn Pearce wrote:

> Apparently I have created a repository which v1.2.3 packs about 50%
> smaller than 'next' does:
> 
>   v1.2.3 (tag):
>    60M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
> 
>   1.2.3.gf3a4 (an older 'next'):
>   128M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
> 
>   1.3.0.rc4.g8060 (a fairly recent 'next'):
>   118M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
> 
> Repeated packing with 1.3.0.rc4.g8060 doesn't seem to change the
> size of the pack file, its pretty consistent at 118M.

First try "git repack -a -d f", where the "-f" is the magic one.

Without the -f, git repack will re-use old pack information, which is much 
much faster, but not as space-efficient.

If that doesn't help, it might be time to look at the actual repo, but try 
that first.

		Linus
