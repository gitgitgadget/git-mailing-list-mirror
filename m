From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Fri, 06 Sep 2013 11:17:41 -0700
Message-ID: <xmqqfvthyfui.fsf@gitster.dls.corp.google.com>
References: <20130906155204.GE12966@inner.h.apk.li>
	<6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Andreas Krey" <a.krey@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Sep 06 20:17:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI0bT-0002rj-Oe
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 20:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645Ab3IFSRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 14:17:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199Ab3IFSRt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 14:17:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 301543F6A4;
	Fri,  6 Sep 2013 18:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EYrqHCIAjewwbw+Nlux5aQLYdUg=; b=YA1B11
	V332okxfGCAs1CC1tt5fScj9thCQxy3HcaNG+fu3jSgZMR6mr3YMCgtII5FCb6i5
	Vi0V5Ut7bxM95uZvEiOXDnDaxfhRPmaieM9X57HDnMLP+46PoHqbMHJ9sMWSbgSA
	V9xAXUmd2eCBohj1FpRpIhw9MIYmRmXE8aSDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iNiHjsVWe83EJXdiRkYlH15CnzkSpGi3
	/m0Q4Un/VLjtm5Bk7xlBksuw206KJfN6sUWwSns91eFMOBpxq6k5PrhlO6Co8a/Y
	bSeAhFJwxA5kgimRvgIsohJV/5TeRMlpOOUEGd4jThBqHoXdi0ssYPuh6m7nd/PS
	neIuDaNktPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AD943F69D;
	Fri,  6 Sep 2013 18:17:47 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D44F3F67D;
	Fri,  6 Sep 2013 18:17:44 +0000 (UTC)
In-Reply-To: <6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley> (Philip Oakley's
	message of "Fri, 6 Sep 2013 18:29:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A0CA6A86-1720-11E3-A44A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234081>

"Philip Oakley" <philipoakley@iee.org> writes:

> Does this have any impact on the alleged bug in `git bundle --all`
> (which can then be cloned from) where the current HEAD ref wasn't
> included in the bundle? Or am I mis-remembering?

Not "current HEAD ref", but "git clone" will fail to check out from
a bundle that does not include HEAD ref (it is easy to just say
"reset --hard master" or whatever after it, though).

I think I suggested to update "git bundle" to include HEAD when
there is no HEAD specified some time ago, but I do not think anybody
was interested, so this may be a non-issue.
