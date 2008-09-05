From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] add '%d' pretty format specifier to show decoration
Date: Thu, 04 Sep 2008 17:41:16 -0700
Message-ID: <7v3akf1l1v.fsf@gitster.siamese.dyndns.org>
References: <20080903191217.GA31195@coredump.intra.peff.net>
 <7v4p4xat3v.fsf@gitster.siamese.dyndns.org>
 <20080903203616.GB32223@coredump.intra.peff.net>
 <7vsksh9c9m.fsf@gitster.siamese.dyndns.org> <48BF0A5A.2040502@lsrfire.ath.cx>
 <20080904035139.GA28123@sigill.intra.peff.net>
 <48C002FB.9010401@lsrfire.ath.cx> <48C055B3.3030204@lsrfire.ath.cx>
 <20080905001133.GA17463@coredump.intra.peff.net>
 <7v7i9r1lnm.fsf@gitster.siamese.dyndns.org>
 <20080905003710.GA17731@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 05 02:42:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbPPE-000472-JU
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 02:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbYIEAl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 20:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbYIEAl0
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 20:41:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbYIEAlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 20:41:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 632E973D7A;
	Thu,  4 Sep 2008 20:41:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 353CE73D76; Thu,  4 Sep 2008 20:41:18 -0400 (EDT)
In-Reply-To: <20080905003710.GA17731@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 4 Sep 2008 20:37:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5DFC543C-7AE3-11DD-8C1A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94984>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 04, 2008 at 05:28:13PM -0700, Junio C Hamano wrote:
>
>> > The whole series looks good to me, and I am happy if it is applied
>> > as-is. The only question I might raise is whether we want to use "%d"
>> > for this, or use something longer to anticipate a collision with other
>> > "d" words (I think you mentioned "describe" at one point).
>> 
>> How about using "%d()" for this one, so that later enhancements can
>> specify their features inside parentheses?
>
> I am slightly opposed to that, just because it then is very inconsistent
> with the other formatting specifiers. I think it is worth introducing a
> new, consistent syntax, providing that syntax for all specifiers (e.g.,
> %(body), %(decorate)), and then saying "the existing %b, %d, et al are
> still available and will be available forever. BUT they will never grow
> the more interesting features like %(body:wrap=80) or
> %(decorate:delim=, ).

Ok, fair enough.  Then it will be between "%d" vs "%(decorate)" for
today's three patches.  If we do the former, then we will have one more in
the "existing %b %d et al" set when we do start working on extended
formats; if we do the latter, "existing" will have one less format, but we
have many "existing" ones already, and one more will not hurt that much in
the long run.

So let's take these patches as-is, unless somebody else have better ideas?
