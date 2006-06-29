From: fork0@t-online.de (Alex Riesen)
Subject: Re: CFT: merge-recursive in C
Date: Thu, 29 Jun 2006 02:38:37 +0200
Message-ID: <20060629003837.GB27507@steel.home>
References: <20060626233838.GA3121@steel.home> <20060628150647.GA16935@trixie.casa.cgf.cx>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 02:39:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvkYf-0000Zs-6T
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 02:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWF2Ai6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 20:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWF2Ai6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 20:38:58 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:725 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932075AbWF2Aix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 20:38:53 -0400
Received: from fwd31.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1FvkYS-0004Jj-00; Thu, 29 Jun 2006 02:38:48 +0200
Received: from tigra.home (G5N+F8ZQoeaL4NtLO5w6J5ICMb3GQfEhkzNW-36sHbvtJt4mnqUNEL@[84.160.100.234]) by fwd31.sul.t-online.de
	with esmtp id 1FvkYI-29Uy6y0; Thu, 29 Jun 2006 02:38:38 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 85038277B5;
	Thu, 29 Jun 2006 02:38:37 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FvkYH-0002Go-CO; Thu, 29 Jun 2006 02:38:37 +0200
To: Christopher Faylor <me@cgf.cx>
Content-Disposition: inline
In-Reply-To: <20060628150647.GA16935@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.6i
X-ID: G5N+F8ZQoeaL4NtLO5w6J5ICMb3GQfEhkzNW-36sHbvtJt4mnqUNEL
X-TOI-MSGID: b10fe1ec-8306-4208-8277-1895416d1cc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22829>

Christopher Faylor, Wed, Jun 28, 2006 17:06:47 +0200:
> >It still uses some calls to git programs (git-update-index,
> >git-hash-object, git-diff-tree and git-write-tree), and merge(1) has
> >the labels (-L) missing - I was unsure how to tackle this on windows -
> >it has only argv[1].
> 
> Actually, Windows should behave the same as Linux wrt argv handling.
> You can use argv[1] ... argv[n] modulo any differences in command line
> quoting.

which leaves us (without quoting) with exactly one argument. argv[1],
aka GetCommandLine.

> On Windows the arguments are broken into individual components by the
> runtime, e.g., MSVCRT.dll or Cygwin1.dll.

And the rules for quoting are the same for ms and cygwin? It's just
passing arguments between cygwin programs and windows natives never
works as one might them expect. Try passing "^" to a batch script (to
a perl script with cmd wrapper around it).
