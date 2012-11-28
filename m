From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Third try at documenting command integration
 requirements.
Date: Tue, 27 Nov 2012 17:58:18 -0800
Message-ID: <7vobiijxol.fsf@alter.siamese.dyndns.org>
References: <20121126053557.E56434065F@snark.thyrsus.com>
 <7vzk24qgjx.fsf@alter.siamese.dyndns.org> <20121126214134.GA1713@thyrsus.com>
 <50B4A8E1.7050801@alum.mit.edu> <20121127175618.GA11845@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Nov 28 02:58:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWv5-0002DF-VN
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943Ab2K1B6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:58:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776Ab2K1B6U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:58:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33F29A5E1;
	Tue, 27 Nov 2012 20:58:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/A1ZASAu5B0QApBDPxV68W7Mfjw=; b=I0NElI
	Lmll3BY5T+7YU42HVWtj15SmvhJluX1MpK1kxzJtzSqkoKWYRT+LrqiUWnIDb0Xa
	GyFw96xzFL/fTO0vFACYkSoUBVxUGcRBosK4V2SsWBrB8FfeQ6dis2/yYcBCxWip
	uJ82JahIlhjnA5dL+YCvv3vOgn/SoT+788Tj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=itoKEZioO5sRBWO1/yvtQWvYMLGVXPsV
	2XZaOC6sS674mLqwNGNjFV8gmzeakuswJRX0n2zLj+SrMQ5Qn+Tq3/TujUhHJDk+
	z/qjvIu16nrxOtefaqnuE/ZkoXOxOxDYHhFIRKaIro2CEjOfalIOEPeVHsFjQMDr
	60g6/kMmQoM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21B28A5E0;
	Tue, 27 Nov 2012 20:58:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96314A5DF; Tue, 27 Nov 2012
 20:58:19 -0500 (EST)
In-Reply-To: <20121127175618.GA11845@thyrsus.com> (Eric S. Raymond's message
 of "Tue, 27 Nov 2012 12:56:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1517B26E-38FF-11E2-9B7B-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210665>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> I agree that 2.4 is still quite OK.  I'm a little concerned that dropping that
> far back might store up some transition problems for the day we decide to
> make the jump to Python 3.
>
> On the other hand, I think gating features on RHEL5 might be
> excessively cautious.  According to [1], RHEL will red-zone within 30
> days if it hasn't done so already ([1] says "Q4").  And RHEL6 (with
> Python 2.6) has been shipping for two years.

I won't worry about Python 3 yet; in what timeframe did Python's
i18n/unicode support become usable?  In 2.4, or 2.6?
