From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-config: case insensitivity for subsections
Date: Thu, 25 Aug 2011 14:32:17 -0700
Message-ID: <7vpqjti3dq.fsf@alter.siamese.dyndns.org>
References: <20110818063528.GH13342@hal.rescomp.berkeley.edu>
 <20110825205849.GA10384@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: milki <milki@rescomp.berkeley.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 23:32:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwhXF-0001BO-3Z
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab1HYVcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:32:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab1HYVcT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:32:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D4CB4E04;
	Thu, 25 Aug 2011 17:32:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3tsOh+gj1RO6D34ZlAPLx+8+3OY=; b=nS9Jcy
	XIS0EVhsBUxGEfq3lrteSjGYKNClZH79yzGVJPHKlZtY6wukWAFNqZ8fDN2zXQvN
	SvNs28RLWjLl0S8xtecrgHkVRWspWGhZ3cAEvyVTdIw/OJ0+kopzN+HjqWItanfC
	fNj1VpHZPVAzaQuN3hXg/BpHByxHFHL7Js9U0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HIH9qi16eDkgUjDi+ixNT9SeoT7ptxMI
	Wp9lfXYYp/UKff43ZqKE7vwLEF8X+v1uAij4AmWMoDs21rtrc+yj9sNmeCBCkuCJ
	c37MzFWncq5UK0xkNGoeLn0Ms2kqkVDuVWMjwoyRM3xpIWAcvV5NocM8BtJBu0wk
	zswowtAC5S8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C394E03;
	Thu, 25 Aug 2011 17:32:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1E1C4E02; Thu, 25 Aug 2011
 17:32:18 -0400 (EDT)
In-Reply-To: <20110825205849.GA10384@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 25 Aug 2011 16:58:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5AF427C-CF61-11E0-A712-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180122>

Jeff King <peff@peff.net> writes:

> I'm not sure it makes sense to do so. I can see how:
>
>   [section.SUBSECTION]
>
> and
>
>   [section.subsection]
>
> should be merged. But isn't:
>
>   [section "SUBSECTION"]
>
> conceptually a different section entirely?

I still recall getting scolded by Linus after writing [sec.tion]; this was
way back when he was still active on this list. I essentially was told
that [sec "tion"] is _the_ only supported way, and [sec.tion] may work but
it purely does by accident, not by design.

Do we still even list the bogus [section.SUBSECTION] syntax anywhere in
our docs? If so, we should remove them and if not we simply just should
deprecate the code to read such input.
