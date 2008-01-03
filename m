From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] Working files created in bare repository when pushing to a rewound bare repository
Date: Thu, 03 Jan 2008 13:29:46 -0800
Message-ID: <7v3atepph1.fsf@gitster.siamese.dyndns.org>
References: <46dff0320712302242m34b5267dlb3f26488293d5d51@mail.gmail.com>
	<20071231064741.GA4250@coredump.intra.peff.net>
	<46dff0320712302302p4c125ee1n2abc1561ba10c47e@mail.gmail.com>
	<20071231070749.GB4250@coredump.intra.peff.net>
	<20071231071352.GC4250@coredump.intra.peff.net>
	<20071231072632.GA11451@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 03 22:30:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAXeA-0003X2-Ug
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 22:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbYACVaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 16:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYACVaA
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 16:30:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbYACV37 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 16:29:59 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CEBD194D;
	Thu,  3 Jan 2008 16:29:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 74817194C;
	Thu,  3 Jan 2008 16:29:53 -0500 (EST)
In-Reply-To: <20071231072632.GA11451@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 31 Dec 2007 02:26:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69537>

Jeff King <peff@peff.net> writes:

> And then on top of this (plus one-liner fix I posted), as Ping Yin
> suggested, we can do:
>
> -- >8 --
> git-reset: default to --soft in a bare repo
>
> --mixed doesn't make sense, since we don't generally have an
> index.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is a bit more contentious. There's no reason you can't have an
> index in a bare repo, and this is changing the behavior of those who do.
> They can always explicitly specify --mixed (since we haven't disallowed
> that), but it might break some scripts.

I'd prefer to error out if something does not make sense rather
than defaulting differently depending on the bareness of the
repository, but that is probably the matter of taste.

Please re-raise the issue post 1.5.4
