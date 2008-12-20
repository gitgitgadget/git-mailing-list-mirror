From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Introduce commit notes
Date: Sat, 20 Dec 2008 00:17:46 -0800
Message-ID: <7vk59vz2dx.fsf@gitster.siamese.dyndns.org>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
 <alpine.DEB.1.00.0812200034450.30769@pacific.mpi-cbg.de>
 <20081220065337.GA2581@coredump.intra.peff.net>
 <200812200855.14915.robin.rosenberg.lists@dewire.com>
 <20081220080546.GA4580@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 09:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDx3Q-0001yf-Aw
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 09:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbYLTISA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 03:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbYLTISA
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 03:18:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbYLTIR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 03:17:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BFFD91AB25;
	Sat, 20 Dec 2008 03:17:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2D1E41AB1E; Sat,
 20 Dec 2008 03:17:48 -0500 (EST)
In-Reply-To: <20081220080546.GA4580@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 20 Dec 2008 03:05:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B57F7B24-CE6E-11DD-B58B-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103632>

Jeff King <peff@peff.net> writes:

> No. git apply is intentionally much more strict about applying under the
> assumption that it is better to force a conflict than to silently apply
> something that has a reasonable chance of being completely wrong.
>
> And usually it is not a big deal because falling back to the 3-way merge
> is a much nicer way of handling any conflicts _anyway_ (I find .rej
> files so much more useless than conflict markers, personally).
>
> In this case I was able to:
>
>   1. git am /the/patch
>   2. patch -p1 <.git/rebase-apply/patch
>   3. manually inspect the results for sanity, and fix up the cache.h
>      bit that failed totally
>   4. git add -u && git add notes.[ch]
>   5. git am --resolved

I usually skip 2-4 and edit .git/rebase-apply/patch in place instead, and
run "git am" instead of step 5.

Why was the patch, that was based on something that is clearly different
from what other people work on, sent to the list in the first place?  IOW,
what good does it do to show your patch if other people (plural) need to
spend a lot of time and head-scratching?
