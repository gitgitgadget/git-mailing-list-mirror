From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] docs: stop using asciidoc no-inline-literal
Date: Thu, 26 Apr 2012 15:09:51 +0200
Message-ID: <87obqe8wrk.fsf@thomas.inf.ethz.ch>
References: <20120426085156.GB22819@sigill.intra.peff.net>
	<87d36uomlq.fsf@thomas.inf.ethz.ch>
	<20120426125014.GB25067@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 15:10:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNOSO-00032h-3v
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 15:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556Ab2DZNJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 09:09:56 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:41084 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756214Ab2DZNJz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 09:09:55 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 26 Apr
 2012 15:09:52 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 26 Apr
 2012 15:09:52 +0200
In-Reply-To: <20120426125014.GB25067@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 Apr 2012 08:50:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196369>

Jeff King <peff@peff.net> writes:

>>  Here `<name>` is the person's display name (for example
>> -``Com M Itter'') and `<email>` is the person's email address
>> -(``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
>> -and greater-than (\x3e) symbols.  These are required to delimit
>> +`Com M Itter`) and `<email>` is the person's email address
>> +(`cm@example.com`).  `LT` and `GT` are the literal less-than (`\x3c`)
>> +and greater-than (`\x3e`) symbols.  These are required to delimit
>>  the email address from the other fields in the line.  Note that
>>  `<name>` and `<email>` are free-form and may contain any sequence
>>  of bytes, except `LT`, `GT` and `LF`.  `<name>` is typically UTF-8 encoded.
>> 
>> On my box (asciidoc 8.4.5) the preimage renders as
>> 
>>   `Com M Itter''
>
> Sorry, do you mean that it is screwed up only after my patch, or that in
> reviewing, you noticed that it is always screwed up?

The markup has always had this form, but I can't tell if it's just my
version of asciidoc that makes a mess of it, or a general problem.  [1]
has a correctly formatted copy so that would suggest a narrower problem.

> Yeah, I ran into some weird stuff, too. The gitweb.conf doc behaves
> oddly with `$projname`; I solved it by using "+" to use a teletype face
> without making it literal (since it doesn't actually have any asciidoc
> metacharacters).
>
> Even though I carefully reviewed the output before and after my patch,
> it makes me slightly concerned that somebody with a different asciidoc
> version will get different results. On the other hand, it's nice to
> clean up a mess, so I'm willing to try it and see if we get any bug
> reports.

Your change should _reduce_ the number of places it can break, since the
interpretation of `..` becomes _simpler_.  If it really turns out to
vary wildly afterwards, I'd suggest changing to some other markup
format.


[1] http://cs.swan.ac.uk/~csoliver/ok-sat-library/internet_html/doc/doc/Git/1.7.8.4/Documentation/git-fast-import.html

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
