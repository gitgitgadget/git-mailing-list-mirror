From: David Kastrup <dak@gnu.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 11:02:02 +0200
Message-ID: <86k5r5cwol.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <7vsl5tk1r8.fsf@gitster.siamese.dyndns.org> <200709051013.39910.johan@herland.net> <vpqtzq91p5z.fsf@bauges.imag.fr> <20070905085158.GC31750@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 11:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqmI-0008R5-Ue
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 11:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbXIEJCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 05:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756110AbXIEJCW
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 05:02:22 -0400
Received: from main.gmane.org ([80.91.229.2]:57344 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104AbXIEJCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 05:02:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISqmB-0001m6-NU
	for git@vger.kernel.org; Wed, 05 Sep 2007 11:02:19 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 11:02:19 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 11:02:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:olXShGrQQddGvqPTzcbNM7jouuo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57694>

Pierre Habouzit <madcoder@debian.org> writes:

> On Wed, Sep 05, 2007 at 08:39:52AM +0000, Matthieu Moy wrote:
>> Johan Herland <johan@herland.net> writes:
>> 
>> > When git-fetch and git-commit has done its job and is about to exit, it checks 
>> > the number of loose object, and if too high tells the user something 
>> > like "There are too many loose objects in the repo, do you want me to repack? 
>> > (y/N)". If the user answers "n" or simply <Enter>,
>> 
>> I don't like commands to be interactive if they don't _need_ to be so.
>> It kills scripting, it makes it hard for a front-end (git gui or so)
>> to use the command, ...
>
>   There is absolutely no problem here, as it can be avoided if the
> output is not a tty.

Which output?  stdout?  stderr?  Where is the question appearing?
What if the command has been started in the background?  What if stdin
(not stdout) is from a pipe, maybe for taking a commit message?  What
if stdin is from a pseudo-tty because the commit has been started with
an internal shell command inside of Emacs, and the command/message
will only get echoed once git-commit completes?

> It's not _that_ hard to guess if you're currently running in a
> script or in an interactive shell after all.

Oh, it is not hard to _guess_.  Just throw a die.  What is hard is to
_know_ 100% sure that one is doing the right thing and not breaking
any legitimate use.

-- 
David Kastrup
