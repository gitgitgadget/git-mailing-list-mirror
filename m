From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/resend] add--interactive: allow diff colors without interactive colors
Date: Sat, 05 Jan 2008 03:11:41 -0800
Message-ID: <7vd4sga5n6.fsf@gitster.siamese.dyndns.org>
References: <20080104083521.GB3354@coredump.intra.peff.net>
	<7v3atdi0na.fsf@gitster.siamese.dyndns.org>
	<1199530684.6209.6.camel@futex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthias Kestenholz <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Sat Jan 05 12:12:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB6wv-000531-59
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 12:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbYAELLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 06:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbYAELLw
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 06:11:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbYAELLv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 06:11:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 17F2C77A9;
	Sat,  5 Jan 2008 06:11:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 60A7E77A8;
	Sat,  5 Jan 2008 06:11:43 -0500 (EST)
In-Reply-To: <1199530684.6209.6.camel@futex> (Matthias Kestenholz's message of
	"Sat, 05 Jan 2008 11:58:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69666>

Matthias Kestenholz <mk@spinlock.ch> writes:

> I managed to throw something together which works and passes all
> the tests. Documentation included. :-)

Is it because we do not usually test colours and the tests run
without terminals to make sure "color.* = auto" does not kick
in?

> I would be happy for feedback and suggestions.

 * Shouldn't "color.git = true" with "color.diff = false" mean
   "I want colour for everything by default but I do not want to
   see coloured diff"?

 * git_foo_config() callback from git_config() returns 0 on
   success; the API change needs to be documented to warn
   others.

I haven't studied your patch very deeply so I may have misread
what you tried to do, regarding the first point, though.
