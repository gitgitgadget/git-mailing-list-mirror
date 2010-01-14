From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 15:50:42 -0800
Message-ID: <7vmy0g5jql.fsf@alter.siamese.dyndns.org>
References: <op.u6g8jnixg402ra@nb-04>
 <20100114154154.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.1001141130210.4985@pacific.mpi-cbg.de>
 <20100115072741.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 00:50:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVZSr-0007PQ-Uc
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 00:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757735Ab0ANXuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 18:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756961Ab0ANXuy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 18:50:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787Ab0ANXux (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 18:50:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49B599119C;
	Thu, 14 Jan 2010 18:50:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7rTN973jI6orYyVyZu1lm7WWBlY=; b=vW4Ny9
	oypyyIkCUvI8fTQ0OIBxJBI/VaLA1iqUbuxsmU01uiy1lJQaiOCeKpX9efsxyT36
	o3FFIcn5Erm2oYmuurhjCvkGI+Bo14x6++R/cd4hLYiDjXfebUWuC7zMDUjvuUU4
	YUpmmvpu7mnjPcMAGdG7IYcE2h3vXvoLJbHJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QoTTBAhCEdSvg4Yj6MWr9HbMh/fp+HsR
	+ERoQKUgUWKicKij6ZTvOX49rEd8i5Cl51CEQ5wPoGnKOgRFDF/Uf0pFIVl2UKo5
	NE4cjmDnAX3aznZzRCZesiXxjvCPENmmvNhLZMUGfPnxBgzX9ctj8jVzZOTAduae
	qYOo4uKQ1xQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04E839119B;
	Thu, 14 Jan 2010 18:50:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E62791192; Thu, 14 Jan
 2010 18:50:43 -0500 (EST)
In-Reply-To: <20100115072741.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri\, 15 Jan 2010 07\:27\:41 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A40B8428-0167-11DF-B7EA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137041>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I summarized it when I reminded Junio on this topic last time and it is in the same discussion thread: http://thread.gmane.org/gmane.comp.version-control.git/135325/focus=136216

Please wrap your lines for readability.

> 'git pull --remember' that remembers...

Although I admit I was the one who suggested it, and I think that it is
the most natural way to do this from the end user's point of view, from
the implementation point of view, it is the most difficult one in its
current form.  "git pull" does not interpret refspecs and delegates all
the hard work to "git fetch".
