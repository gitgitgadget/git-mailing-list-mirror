From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add--interactive: respect diff.algorithm
Date: Sun, 23 Jun 2013 13:37:00 -0700
Message-ID: <7v4ncoftsj.fsf@alter.siamese.dyndns.org>
References: <20130610142825.GI22905@serenity.lan>
	<7v38sphiiw.fsf@alter.siamese.dyndns.org>
	<20130610211140.GD13333@sigill.intra.peff.net>
	<20130610214638.GK22905@serenity.lan>
	<20130610215656.GA28345@sigill.intra.peff.net>
	<20130612184410.GB23890@serenity.lan>
	<7v8v20fxee.fsf@alter.siamese.dyndns.org>
	<20130623195017.GI4676@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 23 22:37:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqr2U-0000z4-NT
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 22:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab3FWUhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 16:37:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100Ab3FWUhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 16:37:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8B612A852;
	Sun, 23 Jun 2013 20:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5o6k7zoDWzO6SwFv3MfDcTe+8vw=; b=GEQ9ny
	IdeGCbf5WtJ37twSUjNml8qUpby7jDoZg7DF8k5M9zIZrkyg1r0aYjHHxO6tqEz6
	oL859Moq5EIQja8QG26r+zephajqEyrOUjZ3moaK3k/LtR0KcnqW3Bgf3VWcZi6g
	21AjMIO/tNmXz40CXNjy9GNA08xaFdwPwXivc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TQRJiRyuyE1FVvhyGq1h/O5EWpvCBVsV
	Dgw2eNrY8XR9Ev7LZ9KkhIYvSuBnjPO3Qn2D3bjoHcpvVpgzH/k7tiFSo1eB8jTL
	85OrnQscmQZOO2GzO+FQT0+ZUHe6VahRLiHM058EPiXsz5TZDmiWTRRWdXEfChdu
	hrWFwfjMNlk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFC372A851;
	Sun, 23 Jun 2013 20:37:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 537F02A84F;
	Sun, 23 Jun 2013 20:37:02 +0000 (UTC)
In-Reply-To: <20130623195017.GI4676@serenity.lan> (John Keeping's message of
	"Sun, 23 Jun 2013 20:50:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8DD888C-DC44-11E2-8715-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228759>

John Keeping <john@keeping.me.uk> writes:

> The patch below involves deeper Perl magic than I fully grok, but
> wouldn't it be simpler to simply use the fact that the string is
> "command --options..." and use:
>
>     splice @diff_cmd 1, 0, "--diff-algorithm=${diff_algorithm}";

That inserts the extra options as the first thing on the command
line, which is also fine.
