From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-http-fetch: Allow caching of retrieved objects byproxy servers
Date: Mon, 19 Sep 2005 15:35:08 +0200
Message-ID: <20050919133508.GA2903@pasky.or.cz>
References: <20050913153858.GB24405@master.mivlgu.local> <43285B24.7050907@b-i-t.de> <Pine.LNX.4.62.0509181720290.14003@qynat.qvtvafvgr.pbz> <432E91ED.7050605@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 15:35:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHLnv-0001AV-UZ
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 15:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVISNfS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 09:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVISNfS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 09:35:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1200 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932371AbVISNfQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 09:35:16 -0400
Received: (qmail 8309 invoked by uid 2001); 19 Sep 2005 15:35:08 +0200
To: sf <sf@b-i-t.de>
Content-Disposition: inline
In-Reply-To: <432E91ED.7050605@b-i-t.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8858>

Dear diary, on Mon, Sep 19, 2005 at 12:24:45PM CEST, I got a letter
where sf <sf@b-i-t.de> told me that...
> >remember that git objects are identified by their sha1, if the sha1 is 
> >what you want (and the file matches the sha1 after you decompress it) 
> >then it really doesn't matter what it's on-disk representation is.
> 
> You are arguing on the git tool level but we are talking about HTTP 
> which knows nothing about the uncompressed sha1.
> 
> The OP assumed that "files in a GIT repository are immutable" which is 
> not true. If you consider the sequence
> 
> pack -> prune -> update zlib or git -> unpack
> 
> you can end up with different files if the new zlib implementation 
> changes imcompatibly (with respect to byte-by-byte compression results) 
> or if git suddenly does not use the default compression level any more.

Yes, but why should this matter? It shouldn't matter if you get the old
"version" or the new version of the file over HTTP, the actual object's
contents is still the same, and GIT shouldn't care.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
