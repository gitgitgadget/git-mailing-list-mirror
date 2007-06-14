From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log -p file.c
Date: Thu, 14 Jun 2007 16:16:09 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706141611090.14121@woody.linux-foundation.org>
References: <20070614090217.GA8271@informatik.uni-freiburg.de>
 <f4shn6$r6q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 01:16:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyyYd-0005Gt-7c
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 01:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbXFNXQu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 19:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbXFNXQu
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 19:16:50 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46497 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751965AbXFNXQt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2007 19:16:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5ENGFAc017856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2007 16:16:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5ENG9N7005334;
	Thu, 14 Jun 2007 16:16:10 -0700
In-Reply-To: <f4shn6$r6q$1@sea.gmane.org>
X-Spam-Status: No, hits=-2.583 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50226>


[ Nit-picking. Not really important. But I reacted to a part of Jakub's 
  explanation ]

On Thu, 14 Jun 2007, Jakub Narebski wrote:
> 
> > And is it intended that (clean) merges are shown?
> 
> Path limiting simplifies history, and might linearize it (i.e. merges
> become non-merges).

Actually, path limiting, when it simplifies merges, will *only* simplify a 
merge when one of the parents was identical to the end result (which 
implies that the other parents were obviously not interesting as far as 
the end result is concerned!).

But that has a secondary effect: such a merge will then (by definition) 
always be simplified away, since the simplified merge no longer makes any 
changes to the set of files in question!

So "merges become non-merges" is not really true (except in a very 
internal sense that will be invisible to the outside). They either stay as 
merges (end result is different from any of the parents on their own), or 
they go away entirely (end result is identical to one of the parents and 
the merge ends up not containing any change atr all).

This explanation may, of course, be more nit-picking than anybody really 
wanted to hear.

			Linus
