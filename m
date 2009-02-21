From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2.1 resend] rev-list: estimate number of bisection step
 left
Date: Sat, 21 Feb 2009 01:27:00 -0800
Message-ID: <7vy6w0qgwr.fsf@gitster.siamese.dyndns.org>
References: <20090221092601.45691c3e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 10:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaoA8-0006rr-Nk
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 10:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbZBUJ1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 04:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbZBUJ1Q
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 04:27:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbZBUJ1P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 04:27:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 058112B9B0;
	Sat, 21 Feb 2009 04:27:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A52ED2B9A3; Sat,
 21 Feb 2009 04:27:01 -0500 (EST)
In-Reply-To: <20090221092601.45691c3e.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat, 21 Feb 2009 09:26:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D19B80CA-FFF9-11DD-B4C4-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110934>

Christian Couder <chriscool@tuxfamily.org> writes:

> Here is a table to help analyse what should be the best estimate for
> the number of bisect steps left.
> ...
> So the algorithm used in this patch calculates 2^n and x, and then
> choose between returning n - 1 and n.

Two dumb questions about the math (because I suck at math).

 - Do you mean by "best estimate" the best case scenario, or something
   else (perhaps "the most accurate")?

 - Is computing based on linear history a good enough approximation?

I am not advocating to make things more precise nor saying your math is
flawed.  I'd prefer simpler code for things like this --- after all, my
understanding of this whole exercise is to give "this is more or less the
number you should expect" ballpack figure and nothing more (correct me if
that is not what you are aiming for).
