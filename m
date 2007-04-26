From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] bookmarks (was: Re: git-fetch and unannotated
 tags)
Date: Thu, 26 Apr 2007 09:19:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704260915130.9964@woody.linux-foundation.org>
References: <200704252004.45112.andyparkins@gmail.com>
 <200704252142.33756.andyparkins@gmail.com> <Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
 <200704260908.07108.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 18:19:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh6gr-0001Fm-Bt
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 18:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031331AbXDZQT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 12:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031332AbXDZQT0
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 12:19:26 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:60971 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031331AbXDZQTZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2007 12:19:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3QGJH2g000867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Apr 2007 09:19:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3QGJG2d000652;
	Thu, 26 Apr 2007 09:19:17 -0700
In-Reply-To: <200704260908.07108.andyparkins@gmail.com>
X-Spam-Status: No, hits=-3.519 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45640>



On Thu, 26 Apr 2007, Andy Parkins wrote:
> 
> Maybe I'm missing the point - what do people see lightweight tags as useful 
> for if not for marking revisions in a not-to-be-published fashion?

I think that's unquestionably _one_ valid way to use them, but I don't 
think it's at all necessarily the only way.

It's equally valid to just always use lightweight tags for everything. 
If you don't use the signing capability, the "real tags" (ie with a tag 
object) don't really buy you much anything at all apart from the message 
(which few enough people fill with anything relevant anyway), so why use 
them?

And yes, signing things is certainly a good idea for releases, but there's 
not really any reason to do it if you're using the tag to just communicate 
with other people (aka "look, here is the thing I want you to merge") 
inside a company or group.

So publishing lightweight tags makes perfect sense in that situation. I 
think it's probably a nicer idea to have some way to specify "don't 
publish" either per-remote or just generally (ie have a rule something 
like "refs/tags/local/" are not pushed or pulled unless explicitly asked 
for).

		Linus
