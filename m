From: cmn@delego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Thu, 21 Feb 2013 15:29:51 +0100
Message-ID: <87wqu1zqn4.fsf@centaur.cmartin.tk>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
	<20130218174239.GB22832@sigill.intra.peff.net>
	<51252877.5000808@schu.io>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Vicent Marti <vicent@github.com>
To: Michael Schubert <schu@schu.io>
X-From: git-owner@vger.kernel.org Thu Feb 21 15:36:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8XGO-0008Fg-1v
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 15:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792Ab3BUOgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 09:36:20 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:53722 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab3BUOgT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 09:36:19 -0500
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2013 09:36:18 EST
Received: from cmartin.tk (p57A1F6E7.dip.t-dialin.net [87.161.246.231])
	by hessy.dwim.me (Postfix) with ESMTPA id CC92E8067D;
	Thu, 21 Feb 2013 15:29:41 +0100 (CET)
Received: (nullmailer pid 19414 invoked by uid 1000);
	Thu, 21 Feb 2013 14:29:51 -0000
In-Reply-To: <51252877.5000808@schu.io> (Michael Schubert's message of "Wed,
	20 Feb 2013 20:48:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216776>

Michael Schubert <schu@schu.io> writes:

> On 02/18/2013 06:42 PM, Jeff King wrote:
>> 
>> I will do it again, if people feel strongly about Git being a part of
>> it. However, I have gotten a little soured on the GSoC experience. Not
>> because of anything Google has done; it's a good idea, and I think they
>> do a fine of administering the program. But I have noticed that the work
>> that comes out of GSoC the last few years has quite often not been
>> merged, or not made a big impact in the codebase, and nor have the
>> participants necessarily stuck around.
>> 
>> And I do not want to blame the students here (some of whom are on the cc
>> list :) ). They are certainly under no obligation to stick around after
>> GSoC ends, and I know they have many demands on their time. But I am
>> also thinking about what Git wants to get out of GSoC (and to my mind,
>> the most important thing is contributors).
>
> Speaking of libgit2:
>
> Git provided the libgit2 project with a slot each of the last three GSOC.
> The contributions made by the former students (Disclaimer: one of them
> speaking) have been quite important for libgit2 and all three students
> are still involved. Each project was an important push towards building
> a new, feature complete Git library.

Right, speaking of libgit2. GSoC has been very successful (as Michael,
I'm also somewhat biased) for libgit2. This happens outside of the git
ML so it probably hasn't gotten as much visibility here.

I believe it's partly because there were still larger parts where most
of the work was technical and the goal was quite clear, as git had
already set the standard and expectations and the decisions had to be
mostly about how to implement it in a way that makes sense for a
library, rather than it living inside of git, which is not always easy,
but you can experiment with different uses of it.

It's also possible that part of the success was the fact that we were
already acquainted with the "release often and early" policy, as we'd
been involved with FLOSS for a while already.

The current gaping hole in libgit2 is the lack of merge support, which
is the last hurdle to a stable 1.0 release. There is already some work
by Edward Thomson that needs to be reviewed and merged. I'm not sure
that there's enough for a whole summer there, but you could throw in the
review and merge of another missing feature, which is making the
reference storage generic, as it currently only supports the
git-compatible file-based one. There's other nice-to-have things like
thin-pack support that you could use to fill up a summer, though I'm not
sure that goes with the spirit of the programme.

Something else that needs love is Git for Windows. I believe both git
and libgit2 would benefit a lot from a project to take some parts of git
that are implemented in a scripting language and port them to use
libgit2. As Git for Windows needs to ship a ton of dependencies anyway,
using a pre-1.0 library wouldn't be an issue and it can be used to
experiment with an eventual porting of git to be one user of libgit2
rather than a completely different implementation. The more immediate
benefit for Git for Windows would be less reliance on languages that are
awkward to use on Windows and need their own environment. Mentoring from
the libgit2 probably wouldn't be much of an issue to organise, though
I'm not sure if the GfW team would have time for the part that involves
its peculiarities.

So there's a couple of projects that could be done with some realistic
chance of being merged upstream, as they'd be technical, as long as we
do tell the student to send small units of work to be reviewed often.

Cheers,
   cmn
