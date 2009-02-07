From: david@lang.hm
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sat, 7 Feb 2009 00:55:18 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902070050490.8086@asgard.lang.hm>
References: <20090205204436.GA6072@diku.dk> <20090206191511.GD19494@coredump.intra.peff.net> <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com> <20090207071056.GB14856@coredump.intra.peff.net> <7vprhuzoxm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, Jonas Fonseca <fonseca@diku.dk>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 08:52:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVhzW-0007aZ-SI
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 08:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbZBGHvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 02:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbZBGHvE
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 02:51:04 -0500
Received: from mail.lang.hm ([64.81.33.126]:46950 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbZBGHvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 02:51:01 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n177op5v014492;
	Fri, 6 Feb 2009 23:50:51 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vprhuzoxm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108826>

On Fri, 6 Feb 2009, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> My impression is that tig is currently doing (1).  I think (2) will
>> suffer from the same problem, but in practice the margin of error will
>> be much smaller because your are rewinding through fewer changes. So if
>> that is what you were suggesting, I think it is probably worth trying.
>
> It has been quite a while since I did the "show previous" feature of
> "git-blame --porcelain" that has been forever queued in 'next'; if I
> remember correctly, it implemented (2).
>
> The reason why it never graduated from 'next' is exactly this issue.  By
> definition, there is no "previous" line number (if there were such a thing
> that says "This line was at line N in the parent of the blamed commit",
> then the commit wouldn't have taken the blame but would have passed it
> down to the parent), and we need to come up with a reasonable heuristics.
>
> So perhaps this discussion would motivate somebody to finish that part
> off, and tig and other Porcelains can just read the necessary line number
> from the git-blame output.

this sounds like the same basic problem I was having around the begninning 
of the year (thread subject 'how to track the history of a line in a 
file') what I ended up doing was to use git blame to go back and find the 
commit where a line was introduced, then use git diff to find the changes, 
then find the hunk of the diff that introduced the line, then find the 
lines that were removed and trace them back (repeating the process)

David Lang
