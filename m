From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] builtin-remote: add set-head verb
Date: Fri, 13 Feb 2009 18:00:29 -0800
Message-ID: <7vab8p4w1u.fsf@gitster.siamese.dyndns.org>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-3-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-4-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-5-git-send-email-jaysoffian@gmail.com>
 <7vtz6yabsy.fsf@gitster.siamese.dyndns.org>
 <20090214002253.GA7769@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 03:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY9r6-00024V-6x
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbZBNCAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbZBNCAj
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:00:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbZBNCAi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:00:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D55A2B155;
	Fri, 13 Feb 2009 21:00:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EAE902AB4E; Fri,
 13 Feb 2009 21:00:31 -0500 (EST)
In-Reply-To: <20090214002253.GA7769@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 13 Feb 2009 19:22:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 45B37D10-FA3B-11DD-B623-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109797>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 13, 2009 at 02:09:01AM -0800, Junio C Hamano wrote:
>
>> The entire series looks sane from a very cursory look; especially the
>> earlier ones are obviously good.
>
> I also think it looks good. You raised a few style points below which I
> thought were sensible and won't bother repeating.
>
>> Hmph, what does "-a" stand for?  I would have expected to see "-u" that
>> stands for "update" here.
>
> It was immediately obvious to me as "auto" (I think I even suggested
> "-a" in another thread, so maybe that is why it seems so sensible to
> me).

Yeah, latest round has --auto in it.  Thanks, Jay.

> I thought it was obvious that you would do:
>
>   git remote set-head master
>
> in the same way that you would do:
>
>   git remote add -m master $remote $url
>
> But I suppose clarifying it doesn't hurt.

I do not care too deeply if an explicit request to "set-head --auto"
screws up and sets a HEAD that was pointing at the right branch to another
branch because the command is not taught to give preference to the branch
HEAD originally points at, so I do not think I have any more issues with
the series for now, even though I may notice things later.

I have this series queued to private topic branch but it still does not
pass tests (breaks #8 and #18 of t5505 at least) by itself; the previous
round was no better.  I think it is just the matter of updating the
expected output in the tests, but I didn't look further.
