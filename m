From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 12:05:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> <7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
 <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
 <20050522184237.GG18500@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 21:03:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZviD-0004HT-E5
	for gcvg-git@gmane.org; Sun, 22 May 2005 21:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVEVTD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 15:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVEVTD2
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 15:03:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:46256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261213AbVEVTDY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 15:03:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4MJ3JjA014142
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 May 2005 12:03:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4MJ3IFH024565;
	Sun, 22 May 2005 12:03:19 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050522184237.GG18500@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 22 May 2005, Thomas Glanzmann wrote:
> 
> >  - in all other cases: if the file is new, prepend a "+", if the file is 
> >    old, prepend a "*", and if the file goes away, prepend a "-". In other 
> >    words, the actual pathname (if it exists) always starts at the second
> >    character and is always prepended by _something_ (ie there is no 
> >    ambiguoity with pathnames that start in -/+/*).
> 
> I guess that this is only on human readable but not on the machine
> format, right?

The machine readable format has the same issue: it needs to be able to 
distinguish between a "copy" (where the source remains) and a "rename" 
(where the source is removed). So you still need the "*/-" thing, and then 
you're better off doing "+" and "/" too in the machine-readable format, to 
make the differences be as small as possible _and_ to avoid confusion if a 
pathname starts with '*' or '-'.

		Linus
