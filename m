From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 18:43:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 03:43:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FosVU-0000HT-2I
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 03:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWFJBnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 21:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWFJBnR
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 21:43:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750823AbWFJBnQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 21:43:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5A1hDgt012656
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 18:43:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5A1hBwJ005857;
	Fri, 9 Jun 2006 18:43:12 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21581>



On Fri, 9 Jun 2006, Linus Torvalds wrote:
> 
> That's like 20% of the original, with all the obvious distribution 
> advantages.

Btw, does anybody know roughly how much data a initial "cvs co" takes on 
the mozilla repo? Git will obviously get the whole history, and that will 
inevitably be bigger than getting a single check-out, but it's not 
necessarily orders of magnitude bigger.

It could be that getting a whole git archive is not _that_ much more 
expnsive than getting a single version, considering how well history 
compresses (eg the kernel git arhive isn't orders of magnitude bigger than 
a single compressed tar-ball of the sources).

At that point, it's probably a pretty usable alternative.

(Although, to be fair, we almost certainly have to improve "git-rev-list 
--objects --all" performance on that thing, since that's going to 
otherwise make it totally impossible to do initial clones using the native 
git protocol, and make git look bad).

			Linus
