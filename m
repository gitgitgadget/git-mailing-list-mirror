From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Fix a signal handler
Date: Wed, 24 Feb 2010 11:38:24 +0100
Message-ID: <4B8501A0.3060805@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de> <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net> <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net> <7vsk94qfuy.fsf@alter.siamese.dyndns.org> <4B7D6B7A.1090004@web.de> <7veikib96d.fsf@alter.siamese.dyndns.org> <4B82744B.4060805@web.de> <7v1vgdgm02.fsf@alter.siamese.dyndns.org> <4B839811.6040109@web.de> <7vmxyzfwt7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:38:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkEdY-000509-L9
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 11:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab0BXKid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 05:38:33 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:52583 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574Ab0BXKia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 05:38:30 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id D1BC7148D89F2;
	Wed, 24 Feb 2010 11:38:28 +0100 (CET)
Received: from [78.48.224.82] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NkEdQ-0003jW-00; Wed, 24 Feb 2010 11:38:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <7vmxyzfwt7.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX19G2ywhDPn+efFhZNiNsNQ5dsbH0zsxCk4I2357
	RUzmdXRlWUmdlUTVulaItnWD2F5179LO9Nf6NlA/mDe803MTzZ
	JAlfh9LHdIC+13fsY/PA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140924>

> Name one platform you tried to port git to and had trouble with because
> the platform did not initialize variables in bss segment to zero, or
> perhaps on that platfor NULL had a bitpattern different from all zero, and
> after you initialized them explicitly to zero or NULL, you managed to make
> everything work perfectly.
> 
> Name one platform you actually got a segfault in the early-output codepath
> on it, because a function pointer on that platform is not of an atomic
> type, and the assignment from show_early_output to show done in
> limit_list() picked up a pointer half-written by the signal handler, and
> we ended up calling a garbage address, and you managed to make everything
> work perfectly with your fix.

Thanks for your feedback.

Which is the name for this specific software environment where the "unexpected"
behaviour was observed?

Does the mentioned improvement justify the integration of my intermediate update
suggestion that works without a "static" flag so far into your source code
repository?

Regards,
Markus
