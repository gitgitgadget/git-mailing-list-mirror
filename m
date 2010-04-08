From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: respect log.shownotes variable
Date: Thu, 08 Apr 2010 09:55:50 -0700
Message-ID: <7v39z57ujt.fsf@alter.siamese.dyndns.org>
References: <20100407204536.GA32382@coredump.intra.peff.net>
 <201004081812.50112.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 08 18:56:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzv1T-0000iv-2D
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 18:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758728Ab0DHQ4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 12:56:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758286Ab0DHQz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 12:55:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BF89BA9F78;
	Thu,  8 Apr 2010 12:55:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=4qYLYqfmKk4CzWTlQ8hTDXMp5t4=; b=ZF4/Ksm5ERv8wmW58libFLm
	BJC3RVgF9D6jm+Aw+gCAs5IsiHK4N2IDpl2cn7RPAArlv4hyiJtN5/ZtBPSpsa1w
	lMk9S/SdzaBmpKIEpD6CNw6LVd77b/0n9B3KtrTTxzivZ/C0hWvj/AOSM/MHykrn
	NI8xrw1AhiFfBV7WAxho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=fdtq5HKcAmmNMU//g+ldADou+KsbLqjcGM0h6+V1b1K61/wEH
	floAYDTmGgADSov+tiO21qOAT7rX4q8p9xpzpSPIYUlvI6kUtjjw/QnhdOKAyu+r
	pGCVIRBvXjjLKhFZQ8JDoZOBvRlR2SkHBzjPD4yedO4BFQgSjSqsofc/rk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82B96A9F76;
	Thu,  8 Apr 2010 12:55:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B4FFA9F75; Thu,  8 Apr
 2010 12:55:51 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99104B08-432F-11DF-A36E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144362>

Thomas Rast <trast@student.ethz.ch> writes:

> Looks useful to me, and the patch looks obviously correct.

It looked obviously correct and "because we can" not "because we need" to me.

> I think it is a useful addition, *especially* in the case where the
> configuration departs from the default.  Typing --show-notes=email
> --show-notes=commits just to avoid showing a third set of notes in
> refs/notes/bulky will get old fairly quickly...

I initially thought so until I realized that notes.displayRef is already
there.  But you are the one who did 894a9d3 (Support showing notes from
more than one notes tree, 2010-03-12) to add that feature, so I suspect
I forgot something while reaching my conclusion in [*1*].

[reference]

*1* Message-ID: <7vljczapzt.fsf@alter.siamese.dyndns.org>
    $gmane/144286
