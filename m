From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit: make the error message on unmerged entries
 user-friendly.
Date: Wed, 06 Jan 2010 12:05:19 -0800
Message-ID: <7vy6kbt2ww.fsf@alter.siamese.dyndns.org>
References: <1262783414-23101-1-git-send-email-Matthieu.Moy@imag.fr>
 <7veim3yx5o.fsf@alter.siamese.dyndns.org> <vpqtyuz86ny.fsf@bauges.imag.fr>
 <7v8wcbw14f.fsf@alter.siamese.dyndns.org> <vpqocl76mdo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 06 21:05:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSc8J-000512-Kl
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 21:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200Ab0AFUF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 15:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755973Ab0AFUF1
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 15:05:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755952Ab0AFUF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 15:05:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE62E8E61D;
	Wed,  6 Jan 2010 15:05:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TXMlTd48xmYEYu4cXlQpdJAr34o=; b=WH2Ysh
	OKdBpLU4Oxs5T9+wrWNhu11K55VLmmrE+/GUp+sDu+dzeeass3QPOJffXT+qy8Sr
	FoohK0Mw4vmY0C4fNn/3id/snvrXWzjmkIj8Ncdh3UnbF7sXY1mKXV0mo/8PJJte
	Z1doCCGjvNVSyVykS3aRQ1e9RJCZ7LQrRBpvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FcwqjSBE3nZQJwgfdze65l04hW+Hpam6
	NTFA78DNhZ+M3ssb/3lhWaPcrvFLa0bIitWuyJ4+8NdGIGP9S3UiYqOkWwC6eA+i
	YC53xLP51c7mDcZICud7tz4WXKkq6p27OGRXyI1H5iseV7IRfLOkCG0OpSiPZAqm
	KHOxyo63LS8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B723A8E61C;
	Wed,  6 Jan 2010 15:05:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 147208E617; Wed,  6 Jan
 2010 15:05:20 -0500 (EST)
In-Reply-To: <vpqocl76mdo.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed\, 06 Jan 2010 20\:53\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D30D2462-FAFE-11DE-A033-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136292>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> They'd use "pull", not merge. Anyway, I did it for commit, merge,
> pull, revert, cherry-pick. I guess we covered the common cases.
> The patch seems to have a lot of redundancies, but I think trying to
> factor this into helper functions would be much more effort than the
> few cut-and-paste that I had to do, since each instance is a slight
> variant of each other ...

I'd be more worried about longer term maintainability than one time
expediency of producing your single patch to add these messages.  If the
messages are cast in stone, we can just verify they are consistent _now_
and forget about them, but I suspect not even you are perfect to predict
that we won't come up with different/better ways to resolve and mark them
resolved in the future and write a set of messages that won't have to
change.
