From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Tue, 20 Mar 2007 08:45:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703200843270.6730@woody.linux-foundation.org>
References: <1174361424.3143.42.camel@dv> <200703200843.51473.andyparkins@gmail.com>
 <7vbqio7100.fsf@assigned-by-dhcp.cox.net> <200703200926.05176.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Pavel Roskin <proski@gnu.org>,
	Alexander Litvinov <litvinov2004@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 16:45:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTgWj-0000uQ-Ti
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 16:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbXCTPpa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 11:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbXCTPp3
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 11:45:29 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43110 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753364AbXCTPp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 11:45:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2KFjMcD010571
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Mar 2007 08:45:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2KFjLW5003960;
	Tue, 20 Mar 2007 07:45:21 -0800
In-Reply-To: <200703200926.05176.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42749>



On Tue, 20 Mar 2007, Andy Parkins wrote:

> On Tuesday 2007 March 20 08:49, Junio C Hamano wrote:
> 
> > >> noticed, because almost nobody uses it.
> > >
> > > I'm not sure that's going to be true for long - the 1.5.0 release notes
> > > recommended setting it (assuming you didn't need backward compatibility)
> > > - which is exactly what I (and I'm sure others) did.
> >
> > Well, it is fixed in 'master' to be in -rc2, and that validation
> > does not exist in 'maint', so no harm is done.
> 
> It wasn't the presence of the bug I was highlighting - it was the idea that 
> nobody uses that option.

Yeah, I'm actually happy that people seem to be using it, and it looks 
like the bug really was totally harmless apart from triggering a bogus 
error (ie it would never have corrupted anything, it just triggered an 
error that it shouldn't have).

And I think the only thing that could ever trigger it was really that 
special case of a zero-sized blob (or maybe an empty tree, but git doesn't 
generate those natively unless you do magic stuff by hand).

		Linus
