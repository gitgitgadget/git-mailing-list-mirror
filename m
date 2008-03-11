From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Tue, 11 Mar 2008 12:24:35 +0000
Message-ID: <80r6eho3cs.fsf@tiny.isode.net>
References: <20080311093553.23191.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: hvammen@gmail.com, git@vger.kernel.org
To: colin@horizon.com
X-From: git-owner@vger.kernel.org Tue Mar 11 13:31:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ3de-0005AE-Iw
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 13:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbYCKMaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 08:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbYCKMaj
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 08:30:39 -0400
Received: from rufus.isode.com ([62.3.217.251]:60266 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177AbYCKMaj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 08:30:39 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Mar 2008 08:30:39 EDT
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <R9Z6AwBKvSEn@rufus.isode.com>; Tue, 11 Mar 2008 12:24:35 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Tue, 11 Mar 2008 12:24:35 +0000
X-Hashcash: 1:20:080311:colin@horizon.com::itxlo/UH0afTD+h2:000000000000000000000000000000000000000000002BH6
X-Hashcash: 1:20:080311:hvammen@gmail.com::1s9DNu3lXXA6YqgT:000000000000000000000000000000000000000000001LUC
X-Hashcash: 1:20:080311:git@vger.kernel.org::YhQ8NWrPMQBrDbC+:000000000000000000000000000000000000000000ECTW
In-Reply-To: <20080311093553.23191.qmail@science.horizon.com> (colin@horizon.com's message of "Tue\, 11 Mar 2008 05\:35\:53 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76833>

colin@horizon.com writes:

>> What's lacking is "why this is a good idea".

[...]

> .. and it never ends.  All of the merged commits are identical trees, but
> if you insist on creating a new commit object each time, you can generate
> an infinite number of bogus commits, and more to the point, A and B will
> never actually agree on the current HEAD commit.
>
> With more developers, you can make even more of a mess.
>
> What use does the "--ff=never" option have except to generate this cruft?
> Flexibility is useful only as long as it provides the ability to do
> something desirable.  There's no point to having a button that should
> never be pushed.

IIUC what the new option is about is (optionally) forbidding merges.
So it's orthogonal to the existing --no-ff and --ff merge options.

So you *don't* get that kind of criss-crossing: if you've got a local
commit, the merge fails.  So you have to use rebase.  So it's not
making the history more complex, it's linearizing it.

Now surely you don't always want to do that, but it seems like a very
convenient option that you can generally have on, and switch off when
you intend to do a merge.
