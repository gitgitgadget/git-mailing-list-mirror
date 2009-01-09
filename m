From: <4jxDQ6FQee2H@dyweni.com>
Subject: Re: Assertion Failed when importing svn into Git
Date: Fri, 9 Jan 2009 13:43:07 -0600
Message-ID: <20090109134307.435ed56f@family.dyweni.com>
References: <20090109133234.345dacb9@family.dyweni.com>
Reply-To: 4jxDQ6FQee2H@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: 4jxDQ6FQee2H@dyweni.com
X-From: git-owner@vger.kernel.org Fri Jan 09 20:44:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLNHS-0006w3-Vm
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 20:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbZAITnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 14:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbZAITnK
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 14:43:10 -0500
Received: from pl1.haspere.com ([208.111.35.220]:35459 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbZAITnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 14:43:09 -0500
Received: from family.dyweni.com (173-23-155-27.client.mchsi.com [173.23.155.27])
	by pl1.haspere.com (Postfix) with ESMTPSA id B79A8C800E;
	Fri,  9 Jan 2009 13:43:08 -0600 (CST)
In-Reply-To: <20090109133234.345dacb9@family.dyweni.com>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.11; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105035>

Hi,

For more testing, I setup a brand new SVN repository (using v1.5.4).

In the old SVN Repo, I checked out the problematic file
(.cache/.dataModel) from rev 288 and rev 289.


In the new SVN Repo, I added the problematic file (from rev 288) and
committed, which became Rev 4.

Then I copied the problematic file (rev rev 289) ontop of that file and
commited, which became Rev 5.

I'm successfully able to do a 'svn diff -r 4:5'.

Does this imply that I have corruption in my old SVN Repository?

Or is something being lost when checking out the file from Rev 289 that
does break SVN in my test?





> Hi,
> 
> 
> I'm trying to import my SVN repository into GIT and its throwing an
> Assertion Failed error message in text_delta.c  Can someone help me?
> 
> The assertion failed error occurs when running 'svn diff -r 288:289'
> which contains only one change - a change made to a binary file. That
> binary file is the Eclipse dataModel file, both revs (288, 289) have
> the file marked as application/octet-stream using the svn:mime-type
> property
> 
> 
> subversion - 1.5.4
> git        - 1.6.0.6
> 
> The SVN repository was started using 1.4.6, if that matters
> 
> Here's the exact error message:
> 
> -------
> $ svn diff -r 288:289
> svn: subversion/libsvn_delta/text_delta.c:609: apply_window: Assertion
> `window->sview_len == 0 || (window->sview_offset >= ab->sbuf_offset &&
> (window->sview_offset + window->sview_len >= ab->sbuf_offset +
> ab->sbuf_len))' failed.
> Aborted
> -------
> 
> 
> Thanks!
