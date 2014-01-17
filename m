From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] diff_filespec: reorder dirty_submodule macro definitions
Date: Fri, 17 Jan 2014 15:50:50 -0800
Message-ID: <xmqq1u06w4kl.fsf@gitster.dls.corp.google.com>
References: <20140117011844.GA6870@sigill.intra.peff.net>
	<20140117011945.GA7249@sigill.intra.peff.net>
	<xmqqha92xx7g.fsf@gitster.dls.corp.google.com>
	<20140117194724.GA775@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 18 00:51:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4JC5-0007r8-FT
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 00:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbaAQXuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 18:50:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbaAQXux (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 18:50:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C76E662B4F;
	Fri, 17 Jan 2014 18:50:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v/lpbxidTNewq7naGc+y+O8cutU=; b=ax/cSD
	/tjaHPEW5bIjCMG6gw7BMrpD6dzYuSC6ygGi1b6DHdt1sCOB7RM2yw1hHuWCkgd1
	/MPdR2ZnZfwM50zhKOpNZreRmAX/uo09r1rEEgIM2GLXCZhqh5O9+w3PxAOK69xc
	P/qEoAX5V/P95X+J2xRCpIiBiz6dteCqqJiJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g3hyT5t8Lshe/NYVWLdXH3eerBm6s4YF
	gEhJS0Usc27rtLt3HYSVzsbjJrqI47R0bEjg8rsr3sGv4m1TAq8GnHNUL0UsBQea
	CoxgHuW0aDMw4R/fT5wCTqHCPTWCv/ABULedbPijVEnTiC220vLdNr9VTS8N2WrQ
	ECs9V10f6ec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B88E262B4D;
	Fri, 17 Jan 2014 18:50:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16AEC62B4A;
	Fri, 17 Jan 2014 18:50:52 -0500 (EST)
In-Reply-To: <20140117194724.GA775@sigill.intra.peff.net> (Jeff King's message
	of "Fri, 17 Jan 2014 14:47:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 32A911AE-7FD2-11E3-8703-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240638>

Jeff King <peff@peff.net> writes:

> I'm happy with it either way. I almost just pulled the macro
> definitions, including DIFF_FILE_VALID, out of the struct definition
> completely. I see the value in having the flags near their bitfield, but
> it makes the definition a bit harder to read.

Yeah, my thoughts exactly when I did those two conflicting changes.
I have a slight preference "Constants go with the fields they are
used in" over "fields and macros mixed together is harder to read",
so let's use your patch as-is.
