From: Marcus Karlsson <mk@acc.umu.se>
Subject: Re: Arguments to git hooks
Date: Sun, 6 May 2012 23:11:21 +0200
Message-ID: <20120506211120.GC5725@moj>
References: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
 <20120506191202.GB5725@moj>
 <CAH-tXsBpfXkr-qWdSBhPu6CcSZbm3f=3i1xJVtk6OkHz1NKCfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 23:11:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR8k3-0006JB-Ur
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 23:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab2EFVLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 17:11:40 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:54114 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509Ab2EFVLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 17:11:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id CC5E22C6;
	Sun,  6 May 2012 23:11:37 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from moj (c-0971e155.122-2-64736c10.cust.bredbandsbolaget.se [85.225.113.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mk)
	by mail.acc.umu.se (Postfix) with ESMTPSA id E398C2C5;
	Sun,  6 May 2012 23:11:36 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <CAH-tXsBpfXkr-qWdSBhPu6CcSZbm3f=3i1xJVtk6OkHz1NKCfA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197214>

On Mon, May 07, 2012 at 12:48:35AM +0530, jaseem abid wrote:
> On Mon, May 7, 2012 at 12:42 AM, Marcus Karlsson <mk@acc.umu.se> wrote:
> > As far as I can see that's the only argument that git-commit passes on
> > to the commit-msg hook. Can't you just call something like git-status
> > from the hook or do you need the information passed specifically as an
> > argument?
> 
> I can always get last commit from `.git/COMMIT_EDITMSG'` - a fixed
> file. Isn't passing that as an argument a bit pointless?

That's a good question. I don't know. If someone else knows the reason I
sure would like to find out.

> I want files I tried to commit specifically passed in as an argument.

There are many different reasons to use hooks. If everything that a hook
could potentially need was passed to it as an argument then a lot of
data would often end up unused. Better to supply as little as possible
and only do more work when it's actually needed.

> Are you suggesting me to run some plumbing command, parse the result
> and get the required data ? Is there an easier way to get this done?

I wouldn't go as deep as the plumbing, I think git status --porcelain
should work just fine, the output is fairly easy to parse.

	Marcus
