From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Fri, 12 Jan 2007 20:11:36 +0100
Message-ID: <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <7virfct737.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 12 20:11:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5RoF-0002o1-OE
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 20:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbXALTLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 14:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbXALTLY
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 14:11:24 -0500
Received: from main.gmane.org ([80.91.229.2]:43648 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964843AbXALTLX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 14:11:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H5Rny-0002YO-9v
	for git@vger.kernel.org; Fri, 12 Jan 2007 20:11:10 +0100
Received: from p54aa89f5.dip0.t-ipconnect.de ([84.170.137.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 20:11:10 +0100
Received: from Peter.B.Baumann by p54aa89f5.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 20:11:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54aa89f5.dip0.t-ipconnect.de
User-Agent: slrn/0.9.8.0 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36694>

On 2007-01-12, Junio C Hamano <junkio@cox.net> wrote:
> "Chris Riddoch" <riddochc@gmail.com> writes:
>
>> I suggest calling it something like update-index.  ;)
>
> Exactly.
>
> People new to git need to learn that the next commit is prepared
> not in the working tree but in a separate entity (staging area),
> and there are ways to update what it consists of.  If that
> concept is new for people coming from other SCM, renaming
> "index" to "staging area" only reduces potential confusion
> (because "index" is too generic word that can mean anything) --
> it does not remove the need to learn the new concept.
>
> And we have called that staging area "the index", and the act of
> updating what it consists of has been called "updating the
> index" for a long time.  The primary command to do so has been
> "git-update-index" plumbing, but we added some sugarcoating and
> now "git-add" and "git-rm" (also "git-merge", "git-am" and
> friends "updates the index" for automatable cases) are two most
> visible ways for the users.
>
> The logical name for the operation, if we _were_ to have only
> one command for "updating the index", is "git-update" or
> "git-update-index".  I do not have anything against "git stage"
> but I simply do not see the point, other than "git update" would
> imply something entirely different to people coming from other
> SCM so we would want to avoid the word, and "git update-index"
> is too long to type every day.

I already proposed it but I like "git refresh". It describes precisely
whats happening - the previous content of the file known to git is
refreshed. AFAIK "update" isn't such a good choice because people from
other VCS would expect something else(think e.g. of cvs update).
>
> In any case, there are valid reasons that update-index has --add
> and --remove options to force callers to specifically say "Yes I
> know I am talking about unusual things, please".  If we _were_
> to do a single command (be it "git-update" or "git-stage"), it
> needs the same --add/--remove safety, which makes "it's too long
> to type every day -- let's have a single Porcelain-ish" argument
> somewhat moot.  We can have "git-add" and "git-rm" instead.
>
> And indeed we do.  That's where we currently stand.
>

Me doesn't really like the new semantics of "git-add", because it does
two seperate things - it adds new files and it refreshes the content of
previously known files. These two are, at least for me, two seperate
operations. And reading "git add" only suggests to me the first - adding
new files.

-Peter
