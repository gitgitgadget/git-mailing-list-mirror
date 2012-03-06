From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] Document the --histogram diff option
Date: Tue, 6 Mar 2012 21:42:50 +0100
Message-ID: <87fwdl1mwl.fsf@thomas.inf.ethz.ch>
References: <f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch>
	<a8d07a8e3860196053da7595f040707d3a3723ef.1331039505.git.trast@student.ethz.ch>
	<7vd38psdt4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 21:43:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S51Do-0006Tc-SM
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 21:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031060Ab2CFUm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 15:42:56 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:2668 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031036Ab2CFUmz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 15:42:55 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 21:42:53 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (213.55.184.242) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 21:42:53 +0100
In-Reply-To: <7vd38psdt4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 06 Mar 2012 11:57:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [213.55.184.242]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192390>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>> ---
>>
>> This is only the minimal update.  I think in the long run, we should
>> add a note saying why we support all of them.  But off hand I didn't
>> have any substantial evidence in favour of patience that could be used
>> as an argument.
>
> Isn't the main argument made by proponents of patience diff is more
> readable output, and not performance?  That line of argument relies
> on a fairly subjective test "which one is easier to read?", so it is
> hard to come up with a substantial evidence, unless somebody invests
> in A/B test.

Well, I was just too lazy to look up what I dimly remembered people had
posted at some point: examples where patience beats Myers for
readability.  E.g.,

  http://article.gmane.org/gmane.comp.version-control.git/104316

I don't think you need a blind test to justify that the patience result
is more readable.  So I think in the long run, the docs should say
something like:

--diff-algorithm={histogram|myers|minimal|patience}::
       Choose a diff algorithm.  The variants are as follows:
+
--
histogram::
        This is the fastest algorithm, and thus the default.

myers::
        The classical Myers diff algorithm.  <state a reason why myers
        would be useful>

minimal::
        Like 'myers', but spend extra time making sure that the diff
        is the shortest possible for the set of changes performed.

patience::
        The patience diff algorithm, which first matches unique lines
        with each other.  This sometimes results in more readable (if
        longer) patches than the other algorithms.
--

Or whatever -- magic is required to have a nested list in asciidoc.
I can't be bothered to twiddle with that right now.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
