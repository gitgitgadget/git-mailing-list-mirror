From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: About git pretty
Date: Sat, 23 Aug 2008 02:03:37 +0200
Message-ID: <20080823000336.GB14684@leksak.fem-net>
References: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 02:04:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWgcX-0002GV-GH
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 02:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbYHWADl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755058AbYHWADl
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 20:03:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:40797 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754291AbYHWADk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 20:03:40 -0400
Received: (qmail invoked by alias); 23 Aug 2008 00:03:38 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp068) with SMTP; 23 Aug 2008 02:03:38 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18AqvAsAYkAvgulrNTRygChnWaTX2RD9NvQ/rdHiJ
	SK8FLsGQzDcSdW
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KWgbR-0008Np-1S; Sat, 23 Aug 2008 02:03:37 +0200
Content-Disposition: inline
In-Reply-To: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93405>

Hi,

Felipe Contreras wrote:
> Hi,
> 
> Please read aloud the following commands:
> git log --pretty=short
> git log --pretty=full
> git log --pretty=format:%s
> 
> It is just me or 'pretty full' doesn't exactly convey the meaning of
> the action to execute?

But "pretty short" and "pretty format" is. :)

> How about:
> git log --format=short
> git log --format=full
> git log --format=custom:%s
> 
> If you like the idea I can work on a patch.

Because --pretty=<format> is an option taken by many git commands including
git plumbing (e.g. rev-list), many scripts will rely on "--pretty" and they
all would have to be changed. And --pretty exists since Jan 2005 (see
9d97aa64).

Also, --format is an option available to git-archive and git-for-each-ref
with a different intention for each. --pretty exists for several git
commands with the same intention for all (I think) -- pretty-printing
commit objects.

And, btw, I also do not think that your idea does really solve the 
"problem" that it always will make sense when you read it aloud.

Thus it seems that --format has no benefit over --pretty at all. :-)


Ahh, another thought:
If a new git user is looking for an option to _format_ git-log output,
she will surely search the git-log manual page for the word "format", finding

 1. --raw
 2. --shortstat
 3. --abbrev
 4. --full-index
 5. --pretty
  STRIKE!

This makes me wonder if it could make sense to move --pretty up in the
git-log manual page, but I do not think renaming it is worth the
trouble.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
