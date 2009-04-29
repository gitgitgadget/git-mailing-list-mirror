From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] cleanups for git-send-email
Date: Wed, 29 Apr 2009 12:18:50 -0700
Message-ID: <7vws939skl.fsf@gitster.siamese.dyndns.org>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
X-From: git-owner@vger.kernel.org Wed Apr 29 21:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzFJI-0007pD-Bn
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 21:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722AbZD2TTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 15:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbZD2TTA
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 15:19:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939AbZD2TS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 15:18:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E0B8713988;
	Wed, 29 Apr 2009 15:18:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4AF1513987; Wed,
 29 Apr 2009 15:18:54 -0400 (EDT)
In-Reply-To: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu> (Bill
 Pemberton's message of "Wed, 29 Apr 2009 09:12:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 95E313BC-34F2-11DE-A102-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117928>

Bill Pemberton <wfp5p@virginia.edu> writes:

> The following are some code cleanups for git-send-email.perl.  They're
> based on suggestions by perlcritc.
>
> Bill Pemberton (6):
>   Remove return undef from validate_patch
>   Remove function prototypes from git-send-email.perl
>   Remove return undef from ask()
>   Add explict return to end of subroutines
>   Remove mix of high and low-precedence booleans
>   Remove bareword filehandles in git-send-email.perl

Perl styles are highly personal.

While I admit that the changes these patches bring in match my personal
taste more or less exactly [*1*], there was somebody (sorry I lost track)
who volunteered to take the maintenance responsibility of that program
over to clean up or even rewrite it, so I would rather have that person
have a say in the overall styles of the (rewritten) program.

[Footnote]

*1* ...except for the "and/or vs &&/||" bits, even though I prefer the
latter myself solely because I am old fashioned.

I think it is simply silly to say "precedence of ! and and/or does not
mix".  "!" and "&&" have different precedence and rewriting (A and !B)
into (A && !B) would not make things any better nor worse.  After all,
nobody would have problems with "$a + $b * $c" even though + and * have
different precedence.

Oh, I also do not agree with "always explicitly return".  If the change
and explanation were limited to the subs whose return values are _used_, I
would agree with the change, though.
