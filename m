From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 17:51:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505231747300.2307@ppc970.osdl.org>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org> <7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org> <7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net>
 <87bcada447378d0173a3c5f165c70b38.ANY@taniwha.stupidest.org>
 <7vhdgt1ncz.fsf@assigned-by-dhcp.cox.net> <046ec1d00820537103092ed264f81f65.IBX@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 02:49:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaNbE-0001ln-2q
	for gcvg-git@gmane.org; Tue, 24 May 2005 02:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVEXAuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 20:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVEXAuG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 20:50:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:2456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261265AbVEXAty (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 20:49:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O0njjA002790
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 17:49:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O0nfgB030658;
	Mon, 23 May 2005 17:49:42 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <046ec1d00820537103092ed264f81f65.IBX@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Chris Wedgwood wrote:
> 
> Sure, I guess I meant to what would happen when not using '-z'?  Will
> something notice this early on barf and tell me to use '-z' or will
> BadThings(tm) just come bite me at some (possibly) later stage?

Well, normally you'd not use the faw format, and the worst that can happen 
is likely that the pathnames in the diff are screwed up.

Side note: files with spaces/tabs in the names have serious problems in
diffs anyway, because parsing the name ends up becoming largely random at
that point. Sad. The problem there is that the format for filenames in
diffs is not very well-specified.

THAT is a much bigger problem than the raw diff format, since that 
actually ends up interfering with interoperability.

The same goes for broken DOS CR-NL text-files, btw. If anybody ever ports
git to the crap that is DOS/Windows (and I assume NT does it too), they'll
have endless problems with interoperating with sane systems.

		Linus
