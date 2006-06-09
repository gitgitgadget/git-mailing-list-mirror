From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 10:49:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091047080.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <9e4733910606082028k37f6d915m26009e0d5011808b@mail.gmail.com>
 <e6b798$td3$1@sea.gmane.org> <Pine.LNX.4.64.0606090745390.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606091127540.19403@localhost.localdomain>
 <Pine.LNX.4.64.0606090926550.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606091326550.2703@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 19:49:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fol7B-0004AS-LO
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 19:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWFIRtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 13:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWFIRtm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 13:49:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030276AbWFIRtm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 13:49:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k59HnTgt021203
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 10:49:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k59HnStD023169;
	Fri, 9 Jun 2006 10:49:28 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606091326550.2703@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21535>



On Fri, 9 Jun 2006, Nicolas Pitre wrote:
>
> Maybe that single pack would instead be under the 512MB limit?  I'd be 
> curious to know.

Possible, but not likely, and with "git repack -a -d" running out of 
memory, we clearly already have a problem in checking that.

That is most likely git-rev-list, though. Which is why I'd like to just 
rsync the repo, and run git-rev-list on it, and see what else I can shave 
off ;)

> > So we're starting to see archives where single packs are problematic for
> > a 32-bit architecture. 
> 
> Depending on the operation, the single pack might actually be better, 

Absolutely. Which is why I said we probably need to do a LRU on pack 
fragments rather than full packs when we do the pack memory mapping.

		Linus
