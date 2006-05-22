From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 02:13:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> 
 <20060520203911.GI6535@nowhere.earth> <446F95A2.6040909@gentoo.org> 
 <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org>  <446FA262.7080900@gentoo.org>
  <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>  <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
  <44713BE4.9040505@gentoo.org>  <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Donnie Berkholz <spyderous@gentoo.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 11:14:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi6Tv-0003kc-MS
	for gcvg-git@gmane.org; Mon, 22 May 2006 11:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWEVJNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 05:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWEVJNj
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 05:13:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750818AbWEVJNj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 05:13:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4M9DAtH026997
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 02:13:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4M9D9AP023827;
	Mon, 22 May 2006 02:13:09 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20493>



On Mon, 22 May 2006, Martin Langhoff wrote:
> 
> Or a slow leak in Perl? The 5.8.8 release notes do talk about some
> leaks being fixed, but this 5.8.8 isn't making a difference.
> 
> Working on it.

Thanks. Looking at what I did convert, that horrid gentoo CVS tree is 
interesting. The resulting (partial) git history has 93413 commits and 
850,000+ objects total, all in a totally linear history.

And that's just up to April 2004, so the full tree is probably a million 
objects.

The good news is that git seems to handle that size repo no problem at 
all. The repack did indeed take a long while, but it packed it all down to 
a 189MB pack-file (and 20MB pack index).

Considering that the bzip2'd tar-file of the CVS history was 157MB, and 
the actual CVS footprint was about 1.6GB, if git stays at under a quarter 
gigabyte for the whole archive once converted (which sounds likely, 
counting indexing), git would basically cut down the disk usage for a live 
repo by a factor of 7 or so.

_And_ I can do a "git log origin > /dev/null" in about 2.4 seconds. Take 
that, CVS.

		Linus
