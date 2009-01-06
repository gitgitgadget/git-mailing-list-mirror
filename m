From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: JGit vs. Git
Date: Tue, 6 Jan 2009 12:12:07 +0100
Message-ID: <200901061212.07240.robin.rosenberg.lists@dewire.com>
References: <a55cfe9d0901052249v1461c70cp1d89e184cfc05eb9@mail.gmail.com> <a55cfe9d0901052250k2be203dfvb0b437a523f2cecc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Vagmi Mudumbai" <vagmi.mudumbai@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 12:13:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK9sR-0005zR-Cd
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 12:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbZAFLMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 06:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbZAFLMN
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 06:12:13 -0500
Received: from mail.dewire.com ([83.140.172.130]:5687 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbZAFLML (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 06:12:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D38C380321E;
	Tue,  6 Jan 2009 12:12:08 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8KLTYEyGv7Vm; Tue,  6 Jan 2009 12:12:07 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id BF6E58006A1;
	Tue,  6 Jan 2009 12:12:07 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <a55cfe9d0901052250k2be203dfvb0b437a523f2cecc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104676>

tisdag 06 januari 2009 07:50:11 skrev Vagmi Mudumbai:
> Hi,
> 
> I am a git and a jgit noob. Be gentle. :-)
> 
> 1) Is JGit a drop in replacement of Git? In sense, if I were to pack
> in an SCM with my app, Can I pack jgit instead of C Git?
Short answer: No. JGit is a library for implementing access to a Git
repository. It does not have nearly all functionality and the command
line interface is mostly for testing the internals and so it only has
what's needed for that purpose or because we like to. The command
set will become more complete over time.
> 
> 2) I noticed that there are no 'add' and 'commit' commands (at least
> from the source) in the org.spearce.git.pgm project. I am looking at
> the repo.or.cz/egit.git repo. I had a brief look at the
> lib/GitIndex.java and lib/Repository.java. GitIndex has the add
> methods to add files/entries to the index. I am still stumped on how
> commits can be done with JGit. Any help is hugely appreciated.

With the Eclipse plugin. If you want to implement the add and commit
commands, please do. You won't need much code for it. The class that
does adding in Eclipse is called Track, btw. You can also take a look at
unit tests for how to do things and the other commands for how to
write commands. It's very easy actually. Then submit your patch.

What is most apparently missing from the internals is handling patches.
We have patch reading (but not application), now, plus candidate for
creating diffs (it works, but needs to be libified, byte[]-ified and we want
to make it faster).

> I am working on Windows with msysGit behind a HTTP Proxy. (Life cant
> get worse, I guess.) . I planned on using grit via JRuby but grit uses
> fork which is not available on funny platforms like windows. And JRuby
> guys do not have any plan on supporting fork even on platforms on
> which for is supported. If JGit is a pure Java based implementation of
fork isn't really supported on Windows. Cygwin goes to great lengths to
emulate it. Trying to do that within the context of an arbitrary JVM seems
like a daunting task. Consider submitting patches to make grit not use fork...
just kidding.., please help us improve JGit instead :)

> Git with more or less the same functionality, then my work becomes a
> lot easier.

The intention is to be able to do anything useful with JGit too.

-- robin
