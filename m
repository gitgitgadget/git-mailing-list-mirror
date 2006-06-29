From: Christopher Faylor <me@cgf.cx>
Subject: Re: CFT: merge-recursive in C
Date: Wed, 28 Jun 2006 20:49:22 -0400
Message-ID: <20060629004922.GG20940@trixie.casa.cgf.cx>
References: <20060626233838.GA3121@steel.home> <20060628150647.GA16935@trixie.casa.cgf.cx> <20060629003837.GB27507@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 29 02:49:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvkik-0003sc-Oi
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 02:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWF2AtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 20:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWF2AtY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 20:49:24 -0400
Received: from pool-71-248-179-197.bstnma.fios.verizon.net ([71.248.179.197]:64984
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S932103AbWF2AtX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 20:49:23 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id C0FAF13C01F; Wed, 28 Jun 2006 20:49:22 -0400 (EDT)
To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060629003837.GB27507@steel.home>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22831>

On Thu, Jun 29, 2006 at 02:38:37AM +0200, Alex Riesen wrote:
>Christopher Faylor, Wed, Jun 28, 2006 17:06:47 +0200:
>>>It still uses some calls to git programs (git-update-index,
>>>git-hash-object, git-diff-tree and git-write-tree), and merge(1) has
>>>the labels (-L) missing - I was unsure how to tackle this on windows -
>>>it has only argv[1].
>>
>>Actually, Windows should behave the same as Linux wrt argv handling.
>>You can use argv[1] ...  argv[n] modulo any differences in command line
>>quoting.
>
>which leaves us (without quoting) with exactly one argument.  argv[1],
>aka GetCommandLine.
>
>>On Windows the arguments are broken into individual components by the
>>runtime, e.g., MSVCRT.dll or Cygwin1.dll.
>
>And the rules for quoting are the same for ms and cygwin?

Probably not but I was the one who raised the issue of quoting, not you.
Quoting is irrelevant to the general assertion that there is only an
argv[1] on Windows.  If that is the behavior that you're seeing then
something is wrong in the way the program is being invoked.

Maybe I'm missing something here and you're talking about some specific
case in git.  It's hard to see how anyone could make this assertion
otherwise.

cgf
