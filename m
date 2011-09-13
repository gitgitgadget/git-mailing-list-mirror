From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated
 submodules
Date: Tue, 13 Sep 2011 10:34:58 -0700
Message-ID: <7vpqj4wdkt.fsf@alter.siamese.dyndns.org>
References: <20110912195652.GA27850@sigill.intra.peff.net>
 <CAP8UFD3ULs9YLCaaJYGo-_A=KqO4yFy3WHJmO5b_hyRSPzA-Vg@mail.gmail.com>
 <20110913171506.GA32251@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 19:35:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Wt8-00079T-0h
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 19:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771Ab1IMRfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 13:35:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755763Ab1IMRfC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 13:35:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2AD043F9;
	Tue, 13 Sep 2011 13:35:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bpGMNCMosElA/iX0KUowrMhJ3OI=; b=w0JJQn
	mvp22PgOQTa3TmxWEZkwAKGIhsDFyiuG2Fnv9Rx3Bq7U7blsGDdWonkSChxKgYMF
	T050eWmncAlo1eA+5NN6gioBm6f+eYUof7hC7DUxs8AN+CBKJCKLPhaJzomhp8DF
	hkwbMtIlbl3n0tzNiS4fw2Nyiep2lBY/tRxsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjdWYCX9rAfAVdfdm3F1Vw0rlWcRm0WA
	ASlInR7mPk6TiKE7d6fVGO8zEiw5bXqHBNVs8x+D/7VZKfgxcLPOTDPjxpsTFrNa
	n6wIRW2qpNYsvg7Odye85uGpo0yh0d2UrkTJZirxqZUL3wlmRpwNUK3B27K6jKnh
	2cmVG6kVNDI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9FE343ED;
	Tue, 13 Sep 2011 13:35:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EC5F43EC; Tue, 13 Sep 2011
 13:35:00 -0400 (EDT)
In-Reply-To: <20110913171506.GA32251@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Sep 2011 13:15:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4B43766-DE2E-11E0-ADA1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181299>

Jeff King <peff@peff.net> writes:

> Will do. Junio, do you want me to re-roll the quadratic fix, or just
> build the refactoring on top?

The latter would be fine and it probably is not even urgent.

Thanks.
