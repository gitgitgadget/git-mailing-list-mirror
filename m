From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: is gitosis secure?
Date: Thu, 5 Feb 2009 08:52:43 +0100
Message-ID: <20090205075243.GA29080@cuci.nl>
References: <200812090956.48613.thomas@koch.ro> <1228813453.28186.73.camel@maia.lan> <873afgsul8.fsf@mid.deneb.enyo.de> <200901180650.06605.bss@iguanasuicide.net> <20090203213135.GA1970@eagain.net> <20090204121204.GA12393@cuci.nl> <20090204182650.GC1970@eagain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: Tommi Virtanen <tv@eagain.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 08:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUz4C-0006oX-Lh
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 08:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756466AbZBEHwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 02:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756065AbZBEHwt
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 02:52:49 -0500
Received: from aristoteles.cuci.nl ([212.125.128.18]:44936 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbZBEHws (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 02:52:48 -0500
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 51474542D; Thu,  5 Feb 2009 08:52:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090204182650.GC1970@eagain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108516>

Tommi Virtanen wrote:
>On Wed, Feb 04, 2009 at 01:12:04PM +0100, Stephen R. van den Berg wrote:
>> I installed gitosis a year ago.
>> Then I tried to audit the code.
>> I couldn't, the whole thing is too much spaghetti code.

>Huh. It's about 1000 lines of python, with about 2000 lines of unit
>tests. It has 3 top-level operations: init, serve, run_hook. That
>still counts as "tiny" in my mind. I'm sorry if following the code was
>too hard. I guess there's no accounting for taste.

It would help if there were a 10 to 60 line synopsis of what it does
in the critical cases.  I mean, I don't care about features, but I care
about the critical parts that interact with the shell and ssh.  In order
to audit that I need a concise 60 line max piece of code or text where
I can get all the info from.  1000 lines for that is too much.

>> Auditing gitosis turned out to be too painful to be worth the trouble,
>> so I reverted to a manually maintained git-shell solution which is so
>> simple that I can actually audit it, and therefore is provably secure
>> (which gitosis is not).

>This word, "provably", tends to mean something else than what you use
>it for. Definitely a simple audit doesn't prove anything. Most
>real-world software is complex enough to be practically unprovable for
>anything.

What I meant by "provably secure" in this context is that in addition
to basic security holes already/still present in the OS, /bin/sh and ssh,
my scripts do not introduce extra security holes.

As a matter of fact, I replaced gitosis by two shell scripts of 31 and
50 lines each (including empty lines).  I.e. the pieces of code needing
auditing are exactly 81 lines total.

I'm not saying that gitosis has security holes, it's just that it's rather
difficult to assure that it doesn't, given the size.
-- 
Sincerely,
           Stephen R. van den Berg.
Auto repair rates: basic labor $40/hour; if you wait, $60; if you watch, $80;
if you ask questions, $100; if you help, $120; if you laugh, $140.
