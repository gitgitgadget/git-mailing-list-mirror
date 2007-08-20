From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: Git Questions
Date: Mon, 20 Aug 2007 13:23:31 +0200
Message-ID: <87bqd2bgb0.fsf@morpheus.local>
References: <1187603749.11595.10.camel@tom-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 13:23:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN5ML-0002RN-6L
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 13:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091AbXHTLXq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 20 Aug 2007 07:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbXHTLXp
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 07:23:45 -0400
Received: from main.gmane.org ([80.91.229.2]:57462 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbXHTLXp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 07:23:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IN5M9-00021O-5h
	for git@vger.kernel.org; Mon, 20 Aug 2007 13:23:37 +0200
Received: from c83-253-22-183.bredband.comhem.se ([83.253.22.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 13:23:37 +0200
Received: from davidk by c83-253-22-183.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 13:23:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-183.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:oTgRg400fmNMUlfeRMsPlYzEjRQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56208>

Tom Schinckel <gunny01@gmail.com> writes:

> Hi all,
>
> I've just started using git to run a repository on my local machine. =
I'm
> wondering about the following questions:

You seem to have a very strange use case that you need to explain
better.

> Is it possible to change the revision numbers from long hashes to nor=
mal
> numbers (i.e, 0001 for first, 0002 for the second)

There are no "revision numbers" in git.  There is only content.  The
history of commits is created by having one commit point to its
"parent" commit.  And in git, everything is addressed by its content,
by using hashes.  So the long hash is a universal identifier for what
it refers to.  It is not a revision number in your repository, it is
something that can be used by someone else who hasn't even heard of yo
to refer to exactly the same thing.

So, no you can't change that.  But there might be something else that
you can do if you explain what you're actually after?

> Can I set up Git to:
>
> a) Automatically commit a file to the repository every time it's save=
d

Probably, but remember that git doesn't track individual files.  It
tracks the whole tree, so you would be creating a new revision of the
whole tree every time you saved that single file.  Which would not
create a very nice history if you are using git for something it
usually is used for (tracking source code etc).

> b) Automatically use the default hashed-out bit:
>
> 	# Please enter the commit message for your changes.
> 	# (Comment lines starting with '#' will not be included)
> 	# Updated but not checked in:
> 	#   (will commit)
> 	#
> 	#       modified:   TOK/bce.abw
> 	#
> 	# Untracked files:
> 	#   (use "git add" to add to commit)
> 	#
> 	#       TOK/bce.abw.bak~
>
> as the commit message? (i.e, remove the hash signs and not bring up v=
im
> in the first place?)

Why on earth would you want to do that?  That comment doesn't contain
any information about what change you committed?  The list of files
that were modified by the commit is already in git.

--=20
David K=C3=A5gedal
