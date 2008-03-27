From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add--interactive: ignore mode change in 'p'atch
 command
Date: Thu, 27 Mar 2008 11:29:58 -0700
Message-ID: <7vprtg9g0p.fsf@gitster.siamese.dyndns.org>
References: <cover.1206602393.git.peff@peff.net>
 <20080327073043.GB22444@coredump.intra.peff.net>
 <7v7ifob0et.fsf@gitster.siamese.dyndns.org>
 <20080327171022.GA27189@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	Wincent Colaiuta <win@wincent.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 19:31:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JewsN-0004EN-CP
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 19:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbYC0SaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 14:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757316AbYC0SaQ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 14:30:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565AbYC0SaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 14:30:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 56D1311ED;
	Thu, 27 Mar 2008 14:30:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 65F2511EC; Thu, 27 Mar 2008 14:30:07 -0400 (EDT)
In-Reply-To: <20080327171022.GA27189@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 27 Mar 2008 13:10:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78358>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 27, 2008 at 09:24:10AM -0700, Junio C Hamano wrote:
>
>>     similarity index 90%
>>     rename from gostak
>>     rename to doshes
>>     Stage the name change [y/n/a/d/j/J/?]?
>
> I hadn't thought about renames. But I wonder if it really makes sense in
> the context of a single path.

Yeah, but the user is really into microcommits, like "separate mode
change" thing really matters, maybe the user would want to make three
commits (1) chmod +x, (2) pure rename, and (3) content changes.

I personally think that is not worth it, so I am agreeing with you on the
"rename" one.

Even though your two patches make perfect sense at the philosophical level
and I very much like it, I doubt "separating mode change" is so useful
from the practical point of view for that matter.

I would even imagine that, if we did not have "add -p" before, and the
very initial implementation of it had started from the behaviour your two
patches bring in, and then a patch came to make it the current "not asking
about mode change separately and if the user chooses to add anything from
the patch hunks, stage the mode change along with it" behaviour, people
might even think that such a patch is an improvement in usability by
asking one less question.  I dunno.

>> By the way, why was it done as a new sub called from parse_diff() and not
>> as a part of parse_diff() itself?
>
> Code clarity.

That I'd agree with very much.  Thanks for clarificaiton.
