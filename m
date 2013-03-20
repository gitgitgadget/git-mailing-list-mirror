From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jk/pkt-line-cleanup] t5700-clone-reference: send trace to
 fd 2, not 3, to please Windows git
Date: Wed, 20 Mar 2013 10:30:31 -0700
Message-ID: <7va9pyf07c.fsf@alter.siamese.dyndns.org>
References: <5149724C.3060105@viscovery.net>
 <20130320093313.GA9482@sigill.intra.peff.net>
 <51499DE7.2030404@viscovery.net>
 <20130320170607.GB10752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:31:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIMqy-000521-MU
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069Ab3CTRaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:30:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56842 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755882Ab3CTRad (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:30:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05F88A89A;
	Wed, 20 Mar 2013 13:30:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=935qJ5hdZBAH9FJNwuNEnz9cyH8=; b=mTMLwF
	exDptrQlfTuoctpfkjAzE1tRrgqd/MkIrZU1gK0OSRjb6aPw8LzlhFevAH8NrAcO
	VTeg8nqOsW8k/wUaDp4BCUGebv9pm7TClVq28dyzygNIygAN4IbtjKxRIGE11H5I
	VELh+qq2LQ6FOOqJAvV7RWMq1qQmuMupk8iFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fV5r0PcTcFfbP+Whz240IQG92pkIl2Pn
	ZBPn9SFC/EBiL6sELTCgYpkYvO+3qFwusRF2Ngu6wquB5Ue3brF2u609Oe0MPPPZ
	nKoaLn6YUM2DGX20TbYSLdOd4JgHvwLCOaEiTA6gpKLIbgRFDX0NY918Lvvv1uXH
	76o1rFV5PBk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE1D1A899;
	Wed, 20 Mar 2013 13:30:32 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73D2EA898; Wed, 20 Mar 2013
 13:30:32 -0400 (EDT)
In-Reply-To: <20130320170607.GB10752@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Mar 2013 13:06:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDF0BD34-9183-11E2-9B11-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218625>

Jeff King <peff@peff.net> writes:

> Also, though I think your use of stderr is probably OK, might it be a
> little more robust against future output changes to use:
>
>   GIT_TRACE_PACKET=$PWD/$U.D git clone ...
>
> to write directly to the file. The original GIT_DEBUG_SEND_PACK did not
> support such niceties, but GIT_TRACE gives them to us for free.

Sounds very sensible.
