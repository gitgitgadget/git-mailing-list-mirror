From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow a single form feed in pre commit hook
Date: Tue, 18 Dec 2007 02:18:08 -0800
Message-ID: <7v4peg1f33.fsf@gitster.siamese.dyndns.org>
References: <5d2716640712180147x36aa3178ja8658e30842c4e52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Hannes Eder" <hannes.eder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 11:18:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ZX9-0005hk-9a
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 11:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbXLRKSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 05:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbXLRKSR
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 05:18:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbXLRKSR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 05:18:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FFE65792;
	Tue, 18 Dec 2007 05:18:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 06E725791;
	Tue, 18 Dec 2007 05:18:09 -0500 (EST)
In-Reply-To: <5d2716640712180147x36aa3178ja8658e30842c4e52@mail.gmail.com>
	(Hannes Eder's message of "Tue, 18 Dec 2007 10:47:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68725>

"Hannes Eder" <hannes.eder@gmail.com> writes:

> It's not uncommon to have a lines with a single form feed in it, e.g.
> the default GPL COPYING and also in .c files and others. Attached
> patch allows this in the pre-commit hook.

Hmm.  The current trend is to get rid of the whitespace checks from this
hook and enrich git-diff --check and git-apply --whitespace=error.

I've been planning to add a new whitespace error rule that allows ^M at
the end of line, post 1.5.4.  Another rule that allows a lone ^L would
match what you are doing here, and it would be a good addition as well.
