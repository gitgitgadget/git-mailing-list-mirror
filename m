From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
 mark
Date: Mon, 24 Aug 2009 14:48:55 -0700
Message-ID: <7vhbvw7uig.fsf@alter.siamese.dyndns.org>
References: <7v1vn2yklo.fsf@alter.siamese.dyndns.org>
 <20090824060708.6117@nanako3.lavabit.com>
 <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS>
 <7v7hwurwmu.fsf@alter.siamese.dyndns.org> <20090824041608.GC3526@vidovic>
 <7vk50tq0g5.fsf@alter.siamese.dyndns.org>
 <7vmy5pojsg.fsf@alter.siamese.dyndns.org> <20090824062141.GD3526@vidovic>
 <7v7hwtofys.fsf@alter.siamese.dyndns.org> <20090824073147.GG3526@vidovic>
 <20090824140223.GA22198@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Thell Fowler <git@tbfowler.name>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 23:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfhPo-0004kf-Al
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 23:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbZHXVtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 17:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbZHXVtO
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 17:49:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbZHXVtN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 17:49:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F32B717672;
	Mon, 24 Aug 2009 17:49:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gc4asTYlswrahLd7BrZN0UB7ndU=; b=OJBhMx
	zz8fVa6brFX7qJzeCvF54jZolQhWG7KDDeMyCUGyFGOhJF0alDdH5ZCw5J0syw+S
	G9U55OhSyvna20ERTZM9GRCmDGDqWMfLDx+SL9fXRkrONKJTskLlbFXUAeoy+rFZ
	Zi0+R4k00WcAusKJ+cibLJXyMq2g61ohxVHGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fP4zFt+4+JdWdoefqlww5UlkpsXJkbMG
	q9Xrs80OVeZJJy+AhdJjRaJa0pfjdg6UCSRZ8LzyZTjkgMT7mWtt2Xr/X9F1RshU
	O9UPCys2wPPPIfax3nG4z78A2uzyUtdZRTuDf4Ci6a/G3VTL21zJhtwk2kR1nmOE
	qwDzj7h0Yck=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 950921766F;
	Mon, 24 Aug 2009 17:49:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 885CE1766A; Mon, 24 Aug
 2009 17:48:56 -0400 (EDT)
In-Reply-To: <20090824140223.GA22198@redhat.com> (Don Zickus's message of
 "Mon\, 24 Aug 2009 10\:02\:23 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F266C2DA-90F7-11DE-A7E2-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126972>

Don Zickus <dzickus@redhat.com> writes:

> From what I remember, I used p_hdr to designate primary headers, ie the
> original mail headers.  s_hdr was supposed to represent the secondary
> headers, ie the embedded mail headers in the body of the email that could
> override the original primary mail headers.

Ah, p for primary and s for secondary.  Now it makes sense.

Thanks.
