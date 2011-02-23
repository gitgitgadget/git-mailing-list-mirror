From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] format-patch: rfc2047-encode newlines in headers
Date: Wed, 23 Feb 2011 13:47:53 -0800
Message-ID: <7vhbbu7792.fsf@alter.siamese.dyndns.org>
References: <20110223094844.GA9205@sigill.intra.peff.net>
 <20110223095917.GC9222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: xzer <xiaozhu@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 22:48:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsMZA-00056q-8e
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 22:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab1BWVsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 16:48:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756046Ab1BWVsF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 16:48:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 618D837F3;
	Wed, 23 Feb 2011 16:49:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NjwrTV5mupGcxqoDGZzWq6nByeY=; b=Z2YqeY
	Z45GeGmwV7KSEFO8GCcQ/3h+7ngXraZEVC+ncFGNCo1EcWvfWAgBDvDKsp3W9DEB
	XnV3PtijJNYKz+BmbD6iladT1FQDUuEOpjgHe14XPfoDv67zfzbAONIiux56K15Y
	xAnzOUpRmdCWXBwVW/H2d8bdRR4HxNhkL+UmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UgqS72whk3acNLTDfZfDFe1u2dhm6H/w
	x9Nt4dGmffMgz0BHQXukEHv2YafOPxqWRiKbM7jWKlbfYbbz+gD5sE9nUgSOFHHF
	VHFX0dAcj/B5AU8M6qxY8cAy5Jkw9ogfu53YbW3AqEtKWY/LwAIyXHbWRC/lIc+a
	2wSKBkN7bPc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D28137F2;
	Wed, 23 Feb 2011 16:49:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F082037F1; Wed, 23 Feb 2011
 16:49:07 -0500 (EST)
In-Reply-To: <20110223095917.GC9222@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 23 Feb 2011 04\:59\:18 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0073910-3F96-11E0-BD82-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167729>

Jeff King <peff@peff.net> writes:

> These should generally never happen, as we already
> concatenate multiples in subjects into a single line. But
> let's be defensive, since not encoding them means we will
> output malformed headers.

In this particular case, wouldn't it be more conservative and defensive to
produce malformed headers so that the patch won't leave the originator?  I
have a suspicion that mailinfo would choke on the output of this one, even
though I didn't try.
