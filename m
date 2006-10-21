From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 19:39:41 -0400
Message-ID: <453AAFBD.7020009@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <87irie1wvv.wl%cworth@cworth.org> <453A7D7E.8060105@utoronto.ca> <200610212248.37935.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 01:40:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbQRl-0002FC-0k
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 01:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWJUXj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 19:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbWJUXj7
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 19:39:59 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:27571 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1161158AbWJUXj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 19:39:58 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GbQRQ-0005Sq-00; Sat, 21 Oct 2006 19:39:49 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610212248.37935.jnareb@gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29689>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
> Aaron Bentley wrote:
>> Carl Worth wrote:
> 
> No, there is no such thing like local ordering of revisions.

> You can have (in git repository) also reflog, which records values
> of branch-as-reference, or branch tip of branch-as-named-lineage.
> But for example fetch and fast-forward 5 commits in history is
> recorded as single event, single change in reflog.

That must be what I was thinking of.

>> A Bazaar branch is a directory inside a repository that contains:
>>  - a name referencing a particular revision
>>  - (optional) the location of the default branch to pull/merge from
>>  - (optional) the location of the default branch to push to
>>  - (optional) the policy for GPG signing
>>  - (optional) an alternate committer-id to use for this branch
>>  - (optional) a nickname for the branch
>>  - other configuration options
> Erm, wasn't revno to revid mapping also part of bzr "branch"?

It's not part of the conceptual model.  The revno-to-revid mapping is
done using the DAG.  The branch just tracks the head.

The .bzr/branch/revision-history file is from an earlier model in which
branches had a local ordering.  Nowadays, it can be treated as:
 - a reference to the head revision
 - a cache of the revno-to-revid mapping

>> This layout is an imitation of Git, as I understand it:
>> Repository:
>> ~/repo
>>
>> Branches:
>> ~/repo/origin
>> ~/repo/master
>>
>> Workingtree:
>> ~/repo
> 
> Workingtree:
> ~/
> 
> if I understand notation correctly.

The notation was that ~/repo would contain the .git directory for the
repository.

>> While "bzr merge ../b" is a minor inconvenience, I think that "bzr merge
>> http://bazaar-vcs.org/bzr/bzr.dev" is a big win.
> 
> Gaah, it's even more inconvenient. Certainly more than using name
> of branch itself, like in git.

Of course if you have a copy of bzr.dev on your computer, you don't need
to type the full URL.  it's just like the 'merge ../b' above.

But how can you use the branch name of a branch that isn't on your
computer?  I suspect git requires a separate 'clone' step to get it onto
your computer first.

> Is there a command to list all branches in bzr?

There's one in the 'bzrtools' plugin.

> Is there a command
> to copy (clone in SCM jargon) whole repository with all branches?

No.

>> My understanding is that ^ is treated as a special metacharacter by some
>> shells, which is why bzr revision specs are more long-winded.
> 
> Which shells? If I understand it '^' was chosen (for example as
> NOT operator for specify sub-DAG instead of '!') because of no problems
> for shell expansion. And considering that many git commands are/were
> written in shell, one certainly would notice that.

Sorry, it's been quite a long time since people complained at me for
using ^, so I don't remember.  Perhaps Edgar is right about it being the
pipe character in old shells.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFFOq+80F+nu1YWqI0RAp/KAJ9Bw1q9/nd3gUAjcX3c+24aoEifeQCYlbD0
tUZ01ra11vkQ7V3RzarXeg==
=oFIC
-----END PGP SIGNATURE-----
