From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: kernel cherry UN-picking?
Date: Fri, 11 May 2007 14:55:09 -0700
Message-ID: <20070511145509.09f3c354.akpm@linux-foundation.org>
References: <4644E0A2.90008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri May 11 23:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmd57-0004ms-Tx
	for gcvg-git@gmane.org; Fri, 11 May 2007 23:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbXEKVzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 17:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756781AbXEKVzQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 17:55:16 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:60529 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756142AbXEKVzO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2007 17:55:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4BLt9cF007842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 May 2007 14:55:11 -0700
Received: from akpm.corp.google.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l4BLt9Vv027804;
	Fri, 11 May 2007 14:55:09 -0700
In-Reply-To: <4644E0A2.90008@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
X-Spam-Status: No, hits=-2.993 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46987>

On Fri, 11 May 2007 17:31:14 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> So, I merge the next batch of net driver patches.  After I merge a PPP 
> patch, deep in the pile-o-patches, Andrew says "I shouldn't have sent 
> that to you, don't apply it"  ;-)

I'm bad.

> Right now, my process for reversing this damage is to start over: 
> create a new branch, manually double-click the mouse on each commit in 
> the "damaged" branch, and git-cherrypick it.  Very, very time consuming 
> when you have more than a couple commits.
> 
> Is there a better way?
> Is there any way to say "cherrypick all commits except <these>"?

Let me refactor your question more usefully.  What we want is quilt-export
and quilt-import.  And I really mean that: commands called git-quilt-export
and git-quilt-import.

coz then, your problem becomes

	git-quilt-export
	<delete one line from the series file>
	git-quilt-import


Because git-quilt-export and git-quilt-import would be useful for lots of
other things.
