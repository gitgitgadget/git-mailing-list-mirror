From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 03/10] t4018: an infrastructure to test hunk headers
Date: Tue, 25 Mar 2014 21:07:18 +0100
Message-ID: <5331E1F6.1070506@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org> <52505977c20a480941ae1f85f50ffb7a0bbffedb.1395433874.git.j6t@kdbg.org> <20140324213659.GF13728@sigill.intra.peff.net> <20140324213913.GA14890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 25 21:07:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSXdD-0000j1-7I
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 21:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbaCYUHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 16:07:24 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:25615 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751877AbaCYUHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 16:07:23 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5D562130052;
	Tue, 25 Mar 2014 21:07:19 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D00AC19F405;
	Tue, 25 Mar 2014 21:07:18 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140324213913.GA14890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245148>

Am 24.03.2014 22:39, schrieb Jeff King:
> On Mon, Mar 24, 2014 at 05:36:59PM -0400, Jeff King wrote:
> 
>>> +How to write RIGHT test cases
>>> +=============================
>>> +
>>> +Insert the word "ChangeMe" (exactly this form) at a distance of
>>> +at least two lines from the line that must appear in the hunk header.
>>
>> The existing tests use -U1 to make writing cases simpler. Is there a
>> reason not to continue that (or if you found that porting the existing
>> cases was not a chore with -U3, I can buy that argument, too)?
> 
> I take it back. You did keep "-U1" in the result. Is this "two lines"
> rule necessary, then?

When we have

   one
   two
   three

how would you describe the distance between "one" and "three"?

Or do you have a wrong expectation how we determine the hunk header? The
hunk header is searched in the text *before* the pre-context. Therefore,
we need at least as many lines between the intended hunk header line
(with tag RIGHT) and the changed line (ChangeMe) as we request with -U
for the context.

So: yes, we need the rule.

-- Hannes
