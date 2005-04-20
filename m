From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 09:41:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504200939290.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <200504201122.35448.mason@suse.com>
 <Pine.LNX.4.58.0504200833580.6467@ppc970.osdl.org>
 <Pine.LNX.4.58.0504200931020.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 18:36:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOIAf-0004uG-Rz
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 18:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVDTQjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 12:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVDTQj0
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 12:39:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:35506 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261721AbVDTQjX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 12:39:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KGdJs4009929
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 09:39:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KGdHB6012967;
	Wed, 20 Apr 2005 09:39:18 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <Pine.LNX.4.58.0504200931020.6467@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Linus Torvalds wrote:
> 
> NO! Don't see if this works. For the "sha1 file already exists" file, it 
> forgot to return the SHA1 value in "returnsha1", and would thus corrupt 
> the trees it wrote.

Proper version with fixes checked in. For me, it brings down the time to
write a kernel tree from 0.34s to 0.24s, so a third of the time was just
compressing objects that we ended up already having.

Two thirds to go ;)

		Linus
