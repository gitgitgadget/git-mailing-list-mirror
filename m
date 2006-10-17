From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 10:05:41 -0400
Message-ID: <4534E335.8070203@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <45348B5E.8000404@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 16:06:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZpa3-0006Fq-Kw
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 16:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWJQOFv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 10:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWJQOFu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 10:05:50 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:29114 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751040AbWJQOFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 10:05:49 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZpZf-0007K2-00; Tue, 17 Oct 2006 10:05:44 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <45348B5E.8000404@op5.se>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29076>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andreas Ericsson wrote:
> Aaron Bentley wrote:

>> When two people have copies of the same revision, it's usually because
>> they are each pulling from a common branch, and so the revision in that
>> branch can be named.  Bazaar does use unique ids internally, but it's
>> extremely rare that the user needs to use them.
>>
> 
> Well, if two people have the same revision in git, you *know* they have
> pulled from each other

No, you don't.  They may have each pulled from a different repository.

Take revision 00aabbcc, created by Linus.  Linus has it because he
committed it.  I have it because I pulled Linus' repository.  You have
it because Andrew Morton pulled Linus' repository, and you pulled Andrew
Morton's repository.

>> But tags have local meaning only, unless someone has access to your
>> repository, right?
>>
> 
> I imagine the bazaar-names with url+number only has local meaning unless
> someone has access to your repository too.

Yes.  That phrasing was from Linus' description of revnos.

> One of the great benefits of
> git is that each revision is *always exactly the same* no matter in
> which repository it appears. This includes file-content, filesystem
> layout and, last but also most important, history.

In Bazaar, a revision id always refers to the same logical entity, but
it may be stored in different formats in different repositories.

>> - - you can publish a repository without publishing its working tree,
>>   possibly using standard mirroring tools like rsync.
>>
> 
> Can't all scm's do this?

With most SCMs that store the repository in the root of the tree,
disentangling the tree and repository requires care.  OTOH, this is just
as easy with Arch, CVS and SVN as it is with Bazaar.

>> - - you can use a checkout to maintain a local mirror of a read-only
>>   branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).
>>
> 
> Check. Well, actually, you just clone it as usual but with the --bare
> argument and it won't write out the working tree files.

No, I *want* the working tree files.  I run bzr from a checkout of bzr.dev.

>> You can operate that way in bzr too, but I find it nicer to have one
>> checkout for each active branch, plus a checkout of bzr.dev.  Our switch
>> command also rewrites only the changed part of the working tree.
>>
> 
> Works in git as well, but each "checkout" (actually, locally referenced
> repository clone) gets a separate branch/tag namespace.

In our terminology, if it can diverge from the original, it's a branch,
not a checkout.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFNOM10F+nu1YWqI0RAvNUAJwN/QviOs+sUuN9ep4Otyrgax9SmwCfSH7t
XdxOxo7smshNlzU3qoxq6Nw=
=nxsM
-----END PGP SIGNATURE-----
