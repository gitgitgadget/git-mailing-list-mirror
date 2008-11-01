From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Git/Mercurial interoperability (and what about bzr?)
Date: Sat, 01 Nov 2008 11:44:21 +0100
Message-ID: <87abcjpvy2.fsf@mid.deneb.enyo.de>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org>
	<alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
	<E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl>
	<20081028191234.GS24201@genesis.frugalware.org>
	<20081028213144.GC10862@mit.edu> <87ljw3zx8i.fsf@mid.deneb.enyo.de>
	<m3prlffzk2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 11:45:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwDzO-0000bL-LR
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 11:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbYKAKoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 06:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbYKAKoZ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 06:44:25 -0400
Received: from mail.enyo.de ([212.9.189.167]:47594 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbYKAKoY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 06:44:24 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1KwDxt-0003QQ-E4; Sat, 01 Nov 2008 11:44:21 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1KwDxt-0000xS-0m; Sat, 01 Nov 2008 11:44:21 +0100
In-Reply-To: <m3prlffzk2.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Sat, 01 Nov 2008 03:33:43 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99727>

* Jakub Narebski:

> Florian Weimer <fw@deneb.enyo.de> writes:
>> * Theodore Tso:
>> 
>> > In the past I've looked at the possibility of creating a
>> > bi-directional, incremental gateway between hg and git repositories.
>> > The main thing which makes this difficult is that hg stores tags
>> > in-band inside the change-controlled .hgtags file.  This means that if
>> > you cut a release, tag it, and then create a commit to further modify
>> > the repository, the new commit is descended from the tag commit,
>> > whereas in git, the tag is a "bookmark" --- perhaps signed via GPG,
>> > but not part of the revision history.
>> 
>> Couldn't you just keep the .hgtags file and have everyone interested
>> in the tags use special scripts?
>> 
>> (Admittedly, I'm horribly totally by Git's behavior in this area.  I
>> haven't figured out yet under what circumstances tags are pushed and
>> pulled, so I'm not totally opposed to the Mercurial model. 8-/)
>
> I think you don't understand the issue here.

Probably yes.

> Do you agree that global tags should be both non-versioned and
> trasferable?

Yes, I do.  In case of Git, I've got trouble with understanding how to
actually implement the "transferable" part with Git.  The Mercurial
way is easier to understand, but it means that tags may need some sort
of "tag at this revision" qualifier to disambiguate, which is rather
problematic.

> Now Mercurial has chosen to use in-tree '.hgtags' file to have global
> tags transferable.  Never mind the fact that it had to treat this file
> in special way to have it non-versioned

Oops, thought this file was versioned.  Things like

  <http://tycoon.hpl.hp.com/changeset/932:931d181e9f58/.hgtags>

suggest it was at some point.
