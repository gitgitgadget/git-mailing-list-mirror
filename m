From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] add -p: optionally prompt for single characters
Date: Wed, 04 Feb 2009 12:40:57 -0800
Message-ID: <7v63jqorza.fsf@gitster.siamese.dyndns.org>
References: <7vljspjk8n.fsf@gitster.siamese.dyndns.org>
 <1233611191-18590-4-git-send-email-trast@student.ethz.ch>
 <20090203062437.GB21367@sigill.intra.peff.net>
 <200902042042.13787.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Suraj Kurapati <sunaku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 04 21:42:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUoZt-00035E-V3
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbZBDUlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbZBDUlI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:41:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbZBDUlH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:41:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 254742A713;
	Wed,  4 Feb 2009 15:41:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 148902A712; Wed, 
 4 Feb 2009 15:40:59 -0500 (EST)
In-Reply-To: <200902042042.13787.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed, 4 Feb 2009 20:42:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 253C2EA6-F2FC-11DD-BAF2-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108428>

Thomas Rast <trast@student.ethz.ch> writes:

> Jeff King wrote:
>> On Mon, Feb 02, 2009 at 10:46:30PM +0100, Thomas Rast wrote:
>> Minor nit: the name of this variable implies that it will be used across
>> all interactive commands (including any future ones). But the
>> description is intimately linked with perl. Maybe structure it like
>> "here is what this does in general, but here are some specific caveats".
>> Something like:
>> 
>>   interactive.readkey::
>>         In interactive programs, allow the user to provide one-letter
>>         input with a single key (i.e., without hitting enter). Currently
>>         this is used only by the `\--patch` mode of linkgit:git-add[1].
>>         Note that this feature is silently disabled for Perl programs
>>         (like git-add) if Term::ReadKey is not available.
>
> Junio indicates in the corresponding pu topic that he is of the same
> opinion, so I'll reroll with your help text.  (It's somewhat
> inaccurate since git-add is not really a perl program, but let's not
> tell the users about our implementation details.)

We could be even more vague and say "is silently disabled if the
underlying system software does not let it read just a single keystroke in
a portable way", or something like that.

And readkey would be a bad name.  You are doing singlekey, and use of
readkey *is* an implementation detail, no?
