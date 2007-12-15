From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Fri, 14 Dec 2007 17:43:13 -0800
Message-ID: <7vr6hoohqm.fsf@gitster.siamese.dyndns.org>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0712031258460.9605@xanadu.home>
	<7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
	<m3fxy5qwbq.fsf@roke.D-201>
	<alpine.LFD.0.999999.0712140836140.8467@xanadu.home>
	<20071214215206.GB7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
	<20071214223957.GC7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
	<20071215004230.GF7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712142004480.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 02:43:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3M4I-0007YP-LV
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 02:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbXLOBnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 20:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbXLOBnb
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 20:43:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbXLOBna (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 20:43:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 03D7F95CD;
	Fri, 14 Dec 2007 20:43:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BC85595CC;
	Fri, 14 Dec 2007 20:43:15 -0500 (EST)
In-Reply-To: <alpine.LFD.0.999999.0712142004480.8467@xanadu.home> (Nicolas
	Pitre's message of "Fri, 14 Dec 2007 20:08:05 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68370>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 14 Dec 2007, Joel Becker wrote:
>
>> > Could you please give me a reference to such message, so to verify that 
>> > we're actually talking about the same thing?
>> 
>> 	The relevant message is:
>> 
>> Message-ID: <7vveaindgp.fsf@gitster.siamese.dyndns.org>
>> 
>> See the paragraphs at the bottom.  The thread, started by me, begins
>> with:
>> 
>> Message-ID: <20070910205429.GE27837@tasint.org>
>
> I don't have such emails in my mail folders anymore.

-- >8 --

Date:	Mon, 10 Sep 2007 13:54:29 -0700
From:	Joel Becker <Joel.Becker@oracle.com>
To:	git@vger.kernel.org
Subject: Remote branches and better documentation
Message-ID: <20070910205429.GE27837@tasint.org>
Sender:	git-owner@vger.kernel.org

Junio et al,
	Git is a fast moving target, so some of this obviously needs a
grain of salt.  However, I'd like to make a couple of humble suggestions
and ask one simple question.
	First, the question:  Is there a syntax to git clone that
creates the old-style branches?  That is, you get all the branches
locally, for people that either haven't learned "git branch -r" or have
existing scripts that expect the branch to exist?  I can't find anything
in the git clone manpage.
	The suggestions are pretty simple.  First, when behavior is
changed invisibly (as the remote branch stuff was), can we note it in
the documentation?  I don't mean the ChangeLog, I mean the manpage.  I
personally already knew about "branch -r" because I read this list.  A
coworker of mine, who just uses git, spent an hour trying to find his
branches after a clone with git 1.5.  He thought his clone had failed.
He read the manpage, and there was no big "Hey, those of you used to
the old behavior, it changed!".  The single sentence about "remote
tracking branches" clearly isn't enough for folks that don't follow the
development side.  If we're going to take the liberty of changing
expected behavior silently, we should be giving it its own section in
the manpage.
	The second suggestion is related.  When an invisible change has
made the repository incompatible with older versions, we should make
sure that things behave.  We had some repositories cloned via 1.4.2.  Do
some work with 1.5.0.6 (on a different machine), then go back to the
machine with 1.4.2, and 1.4.2 doesn't work.  In fact, it can mess things
up.  He was doing simple things: pull from Linus, switch branches, etc.
If this is going to be incompatible, then the newer stuff should at
least warn about it, if not outright prevent 1.4 from running.
	These sorts of things make fast-moving changes workable.

Joel

-- >8 --

Date:	Mon, 10 Sep 2007 19:27:34 -0700
Message-ID: <7vveaindgp.fsf@gitster.siamese.dyndns.org>
Sender:	git-owner@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> writes:

> On Tue, Sep 11, 2007 at 02:05:34AM +0200, Wincent Colaiuta wrote:
>> But that's precisely the group release notes are for; existing users who 
>> need to be informed of any changes to the way things work.
>
> 	No one reads the changelogs of 100 packages updated via "yum
> update".  Heck, they don't even see the list of packages.  They just
> switch to a different desktop while it runs.

Distros are not something under my control, so I cannot help you
much there.

> 	Then there's the user that doesn't administer the system.  They
> don't even know the version changed.  It Just Breaks, and they don't
> know why.

That's a valid concern, but I am not sure how you would want to
address that issue.  Design constraints are:

 - you cannot change the old software that is not updated on the
   user's box;

 - you cannot afford to write something to the repository to
   mark the latest version that mucked with the repository every
   time any operation happens;

We _could_ check presence of $HOME/.knows-git-version-X.Y.Z file
every time we run (that's just a single stat(2) call that cannot
be too expensive) and if there isn't one, ask the user if he has
read the release notes and understood the backward compatibility
issues if there is any, and refuse to run until getting a
satisfactory answer.

But I personally do not think that would be an improvement.

After reviewing Release Notes for v1.5.0, I do not think we
could have done much better, unfortunately.

    As of git v1.5.0 there are some optional features that changes
    the repository to allow data to be stored and transferred more
    efficiently.  These features are not enabled by default, as they
    will make the repository unusable with older versions of git.
    Specifically, the available options are:

     - There is a configuration variable core.legacyheaders that
       changes the format of loose objects so that they are more
       efficient to pack and to send out of the repository over git
       native protocol, since v1.4.2.  However, loose objects
       written in the new format cannot be read by git older than
       that version; people fetching from your repository using
       older clients over dumb transports (e.g. http) using older
       versions of git will also be affected.

       To let git use the new loose object format, you have to
       set core.legacyheaders to false.

     - Since v1.4.3, configuration repack.usedeltabaseoffset allows
       packfile to be created in more space efficient format, which
       cannot be read by git older than that version.

       To let git use the new format for packfiles, you have to
       set repack.usedeltabaseoffset to true.

    The above two new features are not enabled by default and you
    have to explicitly ask for them, because they make repositories
    unreadable by older versions of git, and in v1.5.0 we still do
    not enable them by default for the same reason.  We will change
    this default probably 1 year after 1.4.2's release, when it is
    reasonable to expect everybody to have new enough version of
    git.

     - 'git pack-refs' appeared in v1.4.4; this command allows tags
       to be accessed much more efficiently than the traditional
       'one-file-per-tag' format.  Older git-native clients can
       still fetch from a repository that packed and pruned refs
       (the server side needs to run the up-to-date version of git),
       but older dumb transports cannot.  Packing of refs is done by
       an explicit user action, either by use of "git pack-refs
       --prune" command or by use of "git gc" command.

So everything was opt in and clearly marked as such.  You may
not have read it, distros may not have shown it, but then that
is something we cannot do much about, unfortunately.

I think there was _one_ honest slippage though.  Fetching from
1.5.0 peer by 1.5.0 client could (after doing content
negotiation between both ends as a protection measure) create a
packfile that cannot be read by older 1.4 clients.  Obviously
you cannot expect that kind of "protection" to work across set
of machines with mixed versions sharing a repository over NFS,
and that probably is a mistake we can learn from.
