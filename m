From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 20:57:18 -0800
Message-ID: <7vve5zy72p.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	<7v3at42avd.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
	<7vbq7r28qo.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com>
	<7vejcnzu5z.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111825i644da598i7556ef700b870445@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 05:57:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDYRN-0003E8-UO
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 05:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbYALE50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 23:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756984AbYALE50
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 23:57:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962AbYALE50 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 23:57:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5375B4248;
	Fri, 11 Jan 2008 23:57:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AD8304247;
	Fri, 11 Jan 2008 23:57:20 -0500 (EST)
In-Reply-To: <9b3e2dc20801111825i644da598i7556ef700b870445@mail.gmail.com>
	(Stephen Sinclair's message of "Fri, 11 Jan 2008 21:25:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70262>

"Stephen Sinclair" <radarsat1@gmail.com> writes:

>> In a properly configured repository, telling you who git thinks
>> you are is _ALWAYS_ useless (that's the definition of "properly
>> configured").  Just admit it.
>
> Well, I'll admit that I don't really understand you here.
> Maybe I'm still too much of a git newbie on this.  (Fair enough.)
> Right now the only way to make sure I'm committing as myself with my
> proper email address is to:
>
> --  remember to "git-config --list", and check that my email is listed.
> --  "git-commit; git-log", and remember to check the last entry before
> doing a "git-push".
>
> Am I missing something?

They are both valid means to make sure you did not misconfigure.

You omitted the part that matters from the part you quoted
above, but this discussion was about "showing AUTHOR if it is
different from me", which was _one of_ the two conditions I
suggested in my counterproposal, and I was saying that it is
useless to expect that you would be able to find a
misconfiguration when AUTHOR is shown for this first reason.
This part is _not_ about catching your misconfiguration.

The other part is about the misconfiguration catching.

> Especially considering the default name is taken from the hostname
> anyway -- you're taking the local hostname and then checking with a
> rule to see if it might be localhost.

Yes, and earlier you said one of the undesirable ones was
"yourname@foo.local" (and others were "yourname@foo.(none)").
IOW, "localhost" is one of the things you want to catch as
unconfigured bogosity that you want to catch, isn't it?

And that is _the other_ condition in my counterproposal to show
AUTHOR.

To rephrase, you would show AUTHOR when one of the conditions
holds true, either:

 (1) "not me" (so that we can remind that other's commit is
     being amended); _OR_ 

 (2) "funny me" (so that we can catch misconfiguration.


The latter would not have to trigger once you configure your
~/.gitconfig (or .git/config) properly.
