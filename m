From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Skip writing out sha1 files for objects in packed git.
Date: Tue, 28 Jun 2005 08:45:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506280844190.19755@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
 <7vwtofi6jk.fsf@assigned-by-dhcp.cox.net> <7vr7eni6fy.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506271935260.19755@ppc970.osdl.org> <7vekanyx33.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 17:38:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnI9l-0005R4-1G
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 17:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVF1PoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 11:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVF1PoM
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 11:44:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27818 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262086AbVF1Pn4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 11:43:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5SFhcjA026905
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 08:43:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5SFhYdx009807;
	Tue, 28 Jun 2005 08:43:36 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vekanyx33.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 27 Jun 2005, Junio C Hamano wrote:
> 
> LT> And if we have a pack-file in .git/objects/ that already has
> LT> the object, that may not be the _same_ pack-file that we're
> LT> expanding at all, so if that pack file already has the
> LT> object, then not writing it out is actually the right thing
> LT> to do.
> 
> This I have to think about a bit.

The most trivial example is doing a "git pull" of a small pack-file 
update.

We probably don't want to leave it around as a pack-file (we'll re-pack 
everything at some later date, but we also don't want to expand the stuff 
we already have in our _real_ pack-file).

		Linus
