From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] diff-cache buglet
Date: Tue, 26 Apr 2005 11:06:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261103550.18901@ppc970.osdl.org>
References: <7v7jippjky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504261005360.18901@ppc970.osdl.org> <7vy8b5o211.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:02:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQULw-00040r-IG
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVDZSFL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVDZSFL
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:05:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:27014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261505AbVDZSFD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 14:05:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QI4ns4009894
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 11:04:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QI4mZS030645;
	Tue, 26 Apr 2005 11:04:49 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy8b5o211.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Junio C Hamano wrote:
> 
> While I agree with you that we should somehow show the stage, I
> do not like your suggestion above very much.  How about adding
> one column for stage number before the filename when --unmerged
> is given, just like show-files --stage shows?  You'd soon get
> used to the pattern that has a single digit in between
> whitespaces to recognize which is merged and which isn't.

Well, except for the fact that that isn't machine-readable either, since 
the "1 " thing might just be part of the filename..

But you could use "/" to guarantee that it's unique, together with knowing
that git refuses to have non-canonical filenames.

Ie 1//filename.c _would_ be machine-readable, thanks to the "//" part,
which cannot be part of a valid canonical git filename.

		Linus
