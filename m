From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Mon, 16 Oct 2006 18:26:27 -0400
Message-ID: <45340713.6000707@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 00:26:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZauq-0007xM-HA
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 00:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422840AbWJPW0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 18:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422855AbWJPW0d
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 18:26:33 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:32429 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1422840AbWJPW0c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 18:26:32 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZaui-00058N-00; Mon, 16 Oct 2006 18:26:28 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <egr3ud$nqm$1@sea.gmane.org>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28989>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
>>Does it accurately reflect the current status of git? Is their
>>assessment of git's rename capability correct?
> 
> 
> For example simple namespace for git: you can use shortened sha1
> (even to only 6 characters, although usually 8 are used), you can
> use tags, you can use ref^m~n syntax.

Bazaar's namespace is "simple" because all branches can be named by a
URL, and all revisions can be named by a URL + a number.

If that's true of Git, then it certainly has a simple namespace.  Using
eight-digit hex values doesn't sound simple to me, though.

> I'm not sure about "No" in "Supports Repository". Git supports multiple
> branches in one repository, and what's better supports development using
> multiple branches, but cannot for example do a diff or a cherry-pick
> between repositories (well, you can use git-format-patch/git-am to
> cherry-pick changes between repositories...).

That sounds right.  So those branches are persistent, and can be worked
on independently?

> About "checkouts", i.e. working directories with repository elsewhere:
> you can use GIT_DIR environmental variable or "git --git-dir" option,
> or symlinks, and if Nguyen Thai Ngoc D proposal to have .gitdir/.git
> "symref"-like file to point to repository passes, we can use that.

It sounds like the .gitdir/.git proposal would give Git "checkouts", by
our meaning of the term.

> Partial checkouts are only partially supported as of now; it means
> you have to do some lowe level stuff to do partial checkout, and be
> carefull when comitting. BTW it depends what you mean by partial
> checkout, but they are somewhat incompatibile with atomic commits
> to snapshot based repository.

Yes, I'm very much aware of that tension.  It will be fun when Bazaar
tries to support that... :-)

> Git supports renames in its own way; it doesn't use file ids, nor
> remember renames (the new "note" header for use e.g. by porcelains 
> didn't pass if I remember correctly). But it does *detect* moving
> _contents_, and even *copying* _contents_ when requested. And of
> course it detect renames in merges.

You'll note we referred to that bevhavior on the page.  We don't think
what Git does is the same as supporting renames.  AIUI, some Git users
feel the same way.

> Git doesn't have some "plugin framework", but because it has many
> "plumbing" commands, it is easy to add new commands, and also new
> merge strategies, using shell scripts, Perl, Python and of course C.
> So the answer would be "Somewhat", as git has plugable merge strategies,
> or even "Yes" at it is easy to add new git command.

It sounds like you're saying it's extensible, not that it supports
plugins.  Plugins have very simple installation requirements.  They can
provide merge strategies, repository types, internet protocols, new
commands, etc., all seamlessly integrated.

What you're describing actually sounds like the Arch approach to
extensibility: provide a whole bunch of basic commands and let users
build an RCS on top of that.

As the author of two different Arch front-ends, I can say I haven't
found that approach satisfactory.  Invoking multiple commands tends
re-invoke the same validation routines over and over, killing
efficiency, and diagnostics tend to be pretty poorly integrated.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFNAb90F+nu1YWqI0RAvRDAJ9HHHdbhT1+aA3wOGeuUDkjRIr7BQCcDBKB
cL+DAy5GdTDk8Iz9TUkQ//M=
=AJAu
-----END PGP SIGNATURE-----
