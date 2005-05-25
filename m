From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: change of git-diff-tree and symlinks
Date: Wed, 25 May 2005 15:47:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505251544250.2307@ppc970.osdl.org>
References: <20050525111711.GA27492@vrfy.org> <Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org>
 <20050525183546.GA4241@vrfy.org> <7vzmujjdq4.fsf@assigned-by-dhcp.cox.net>
 <20050525222622.GA8552@vrfy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 00:44:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db4bA-0002JS-99
	for gcvg-git@gmane.org; Thu, 26 May 2005 00:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVEYWpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 18:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVEYWpU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 18:45:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:11664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261585AbVEYWpP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 18:45:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4PMj6jA032647
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 May 2005 15:45:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4PMj5NP020858;
	Wed, 25 May 2005 15:45:05 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050525222622.GA8552@vrfy.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 26 May 2005, Kay Sievers wrote:
> 
> If we introduce 'T', how is a content _and_ a type change represented
> if they happen at the same time?

A 'T' _always_ implies a content change, imho. 

Yes, that strange udev changeset actually had files that had the same
content as the symlinks, but from a patch perspective, that should
probably really still be a "file got entirely deleted" + "we created a
symlink with new content". Anything else just doesn't make any sense.

So in that way, 'T' really is different from 'M'. 'M' implies a patch
(which might be empty, of course), while 'T' implies that the old thing 
was deleted and entirely replaced with something totally different.

		Linus
