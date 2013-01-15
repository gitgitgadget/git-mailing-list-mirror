From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] config: add helper function for parsing key names
Date: Tue, 15 Jan 2013 09:07:44 -0800
Message-ID: <7vehhm4bof.fsf@alter.siamese.dyndns.org>
References: <20130114145845.GA16497@sigill.intra.peff.net>
 <20130114150012.GA16828@sigill.intra.peff.net>
 <7v8v7veixc.fsf@alter.siamese.dyndns.org>
 <20130115160422.GC21815@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 15 18:08:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv9zc-0006hc-4r
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 18:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483Ab3AORHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 12:07:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756114Ab3AORHq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 12:07:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B995A960;
	Tue, 15 Jan 2013 12:07:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KHWWc0YXXWYCJtg4izZ/Q4oB2FA=; b=q8N2GT
	Ahw/PsoUB4OZvLkJ4ug+aYJOQ1YwCY3+Bq7zU8gfHiFf6WlYqpXyigfCoHw/eqdM
	iptExxJeuNyuPULqSOye8xq+cCucISWwmBwTKVYKHZmw3xd3fpGL43GhTjUVD1DI
	65gbN74HrV29f+Ie2LedEAoRzVIc39GksMuAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xGbRAWz7pmyAWYGEANDRl+bDEeNZ66jw
	iuinJQHdWQJB804txDDg5U0m/WtaUQsq+jCW0VTnOcdoTNXT1z9k6eICaE3gyrko
	ScwD4o1KHy5pzjWUIitMaMva2qd/aNwENMuClwCoYNbOcy1tdP45TXbhTezOKRRc
	efT3x50ayYU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F99CA95F;
	Tue, 15 Jan 2013 12:07:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFFCAA95B; Tue, 15 Jan 2013
 12:07:45 -0500 (EST)
In-Reply-To: <20130115160422.GC21815@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 15 Jan 2013 08:04:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14F8ACAE-5F36-11E2-8EB4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213651>

Jeff King <peff@peff.net> writes:

> ... did you have any comment on
> the "struct config_key" alternative I sent as a follow-up?

I did read it but I cannot say I did so very carefully.  My gut
reaction was that the "take the variable name and section name,
return the subsection name pointer and length, if there is any, and
the key" made it readable enough.  The proposed interface to make
and lend a copy to the caller does make it more readble, but I do
not know if that is worth doing.  Neutral-to-slightly-in-favor, I
would say.
