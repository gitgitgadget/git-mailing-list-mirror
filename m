From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 20:23:45 -0400
Message-ID: <45357411.20500@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <Pine.LNX.4.64.0610171448150.3962@g5.osdl.org> <45355EEE.3060105@utoronto.ca> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:24:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzDv-0004qV-VO
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWJRAXx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWJRAXx
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:23:53 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:8902 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751314AbWJRAXw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 20:23:52 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZzDo-000613-00; Tue, 17 Oct 2006 20:23:48 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29147>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Tue, 17 Oct 2006, Aaron Bentley wrote:
>>> Excuse me? What does that "throws away your local commit ordering" mean?
>> Say this is the ordering in branch A:
>>
>> a
>> |
>> b
>> |
>> c
>>
>> Say this is the ordering in branch B:
>>
>> a
>> |
>> b
>> |\
>> d c
>> |/
>> e
>>
>> When A pulls B, it gets the same ordering as B has.  If B did not have e
>> and c, the pull would fail.
> 
> Sure. But that doesn't throw away any local commit ordering. The original 
> order (a->b->c) is still very much there.

After the pull, it's no longer the mainline ordering for the branch.  c
is represented a revision that was merged into the branch, while d is
represented as a commit on the mainline of the branch.

> The fact that there was a branch 
> off 'b' and there is also (a->b->d) and a merge of the two at 'e' doesn't 
> take away anything from the original local commit ordering.

It means the the order that revisions are shown in log commands changes,
and the revision numbers can change.

> But that's a totally specious "record". It has no meaning in a distributed 
> SCM. There is absolutely zero semantic information in it.

It records the committer, the date, the commit message, the parent
revisions.

> The fact that you _locally_ want to remember where you were is a total 
> non-issue for a true distributed system. You shouldn't force everybody 
> else to see your local view - since it has no relevance to them, and 
> doesn't add any information.

Nobody is forced to use your local view.

> In other words, the empty merge is totally semantically empty even in the 
> bazaar world. Why does it exist?

It exists because it is useful.  Because it makes the behavior of bzr
merge uniform.  Because in some workflows, commits show that a person
has signed off on a change.

It's not something special-- it's just another commit, like regular
commits, and merge commits.  It would be harder to forbid than it is to
permit.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNXQQ0F+nu1YWqI0RAnxDAJ4hbuLkEK1eBlyoEOz7NAlqLVth9gCfed4w
nfeiR2KVvN+N9zdSrC8MKcY=
=et73
-----END PGP SIGNATURE-----
