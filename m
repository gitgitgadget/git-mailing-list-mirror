From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/5] notes-utils: handle boolean notes.rewritemode correctly
Date: Tue, 18 Feb 2014 10:36:07 +0100
Message-ID: <87mwhosqyg.fsf@fencepost.gnu.org>
References: <cover.1392565571.git.john@keeping.me.uk>
	<be9b384ec77fc39b939b8c5505862a6e1c641faa.1392565571.git.john@keeping.me.uk>
	<87txbzvxgq.fsf@fencepost.gnu.org>
	<20140218074632.GA29804@sigill.intra.peff.net>
	<87vbwcstgw.fsf@fencepost.gnu.org>
	<20140218090156.GC2692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 18 10:36:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFh6d-00089H-4p
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 10:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbaBRJgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 04:36:33 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:60888 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566AbaBRJgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 04:36:25 -0500
Received: from localhost ([127.0.0.1]:59926 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WFh6F-00018K-UV; Tue, 18 Feb 2014 04:36:24 -0500
Received: by lola (Postfix, from userid 1000)
	id 071B4E0505; Tue, 18 Feb 2014 10:36:07 +0100 (CET)
In-Reply-To: <20140218090156.GC2692@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 18 Feb 2014 04:01:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242291>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 18, 2014 at 09:41:51AM +0100, David Kastrup wrote:
>
>> gcc's flow analysis works with the same data as humans reading the
>> code.  If there is no information content in the function call, it makes
>> more sense to either making it void.
>
> The point of error() returning a constant -1 is to use this idiom:
>
>   if (something_failed)
>           return error("this will get printed, and we get a -1 return");

    if (something_failed)
        return error("this will get printed"), -1;

Not much of an idiom, no insider logic hidden to both compiler and
reader.

>>From a code perspective it's pointless. You could "just" write:
>
>   if (something_failed) {
>           error(...);
>           return -1;
>   }
>
> which is equivalent. But the point is that the former is shorter and a
> little more readable, assuming you are familiar with the idiom.

Assuming that.

>> One can always explicitly write
>> 
>>   (config_error_nonbool("panic-when-assailed"), -1)
>
> Yes, but again, the point is readability. Doing that at each callsite is
> ugly and annoying.

I consider insider semantics ugly and annoying.  To each his own.

> You are the first person to ask about it, so there is no stock answer.
> However, everything I told you was in the commit messages and the list
> archive already. We can also avoid questions being asked by using
> those tools.

It's further raising the barriers for contributors if they are expected
to have studied the last few years in the mailing archive.  And the
skills needed for that kind of study are mostly unrelated to good
programming skills.

So I am less than convinced that this is among the coding practices that
can be expected to attract/scare away potential contributors in
proportion to their expected capability of advancing/hindering the
project.

It's not me running the shop, so it's nothing more than an opinion.

-- 
David Kastrup
