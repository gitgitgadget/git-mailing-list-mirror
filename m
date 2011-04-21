From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 2/5] Pretty Print: show tz when using DATE_LOCAL
Date: Thu, 21 Apr 2011 15:34:49 -0700
Message-ID: <7vtydrutbq.fsf@alter.siamese.dyndns.org>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <acbcf231-e0a6-440e-be42-5f25da3e318d-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:35:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD2Sn-0007KR-Ok
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 00:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529Ab1DUWe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 18:34:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab1DUWe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 18:34:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC2584B9C;
	Thu, 21 Apr 2011 18:36:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=hKqgwoBzaYremWbNaXaNMW5Skss=; b=CrEarGRmdyC2MDhK6xRy
	oaQQTTT5PWupjeXK5Vj3B4zLpcodO2WY3PrwuIByKcnzPPnstTFhEyO7pIc3cm73
	Zp8csl+blpLOXrvYzPhT+cRn3OcG9jrcWwixU+ZgfYshfNPH9lBl1KAaqlvKMmRP
	mFVwlcOrF6X0L7YpgHLVCUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IR6KPU1DjAGtcfvu6GI6eRDxWPGxqBbjjYrRy3Ned6zRgF
	N6b1SlsZtV0KALRQUA7hYWfINz1OGaBQJvj5y1UsVCl5gz9TVkMtVBsg9PX6h17A
	GoVtEQHKvn6szL9aBmm2mQrJFQHrr88d/8vOJfCX1UhTwpmQ1KI7Wyr63qtyc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8D114B9B;
	Thu, 21 Apr 2011 18:36:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D0A4A4B91; Thu, 21 Apr 2011
 18:36:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC6E1B8E-6C67-11E0-AAA8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171924>

Michael Witten <mfwitten@gmail.com> writes:

> Date: Fri, 11 Feb 2011 16:06:36 +0000
> Currently, when the date mode is DATE_LOCAL, the
> time zone is never pretty printed;...

I am not opposed to have a new mode that shows timestamps in local
timezone with zone information, but this change is a regression to people
who have known and relied upon that asking for timestamps in their local
timezone will give everything in the local timezone and result in a short
output by the virtue of not needing to repeat the zone string, as they are
the same (this is not strictly true near your dst boundary, and that is
why I am open to the idea as a separate option).

This is a tangent but it is funny to see the unnecessary Date: in-body
header for a series about date display.  Please drop it.

Backdating the author timestamp will make it harder to find the related
discussion from the list archive; the only plausible benefit I can see is
that you may get "I thought of this much earlier than when I posted it to
the public for the first time" pee-in-the-snow value out of doing so, but
that is done at the cost to all others who need to inspect the history
later.  Please don't.

As a future reference, when you have a valid reason to override the
header information your MUA would give your message with an in-body
header, please leave a blank line after the in-body header to make the
result easier to read, like this:

        Date: Fri, 11 Feb 2011 16:06:36 +0000

        Currently, when the date mode is DATE_LOCAL, the
        time zone is never pretty printed;...

Also paragraphs that wrap lines at too narrow a margin is just as hard to
read as paragraphs wrapped at a margin that is too wide.  You seem to have
wrapped at around 50 columns?
