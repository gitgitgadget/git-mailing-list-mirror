From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add an optional argument for --color options
Date: Sun, 14 Feb 2010 22:02:06 -0800
Message-ID: <7vsk93nijl.fsf@alter.siamese.dyndns.org>
References: <1266098475-21929-1-git-send-email-lodatom@gmail.com>
 <20100214064408.GB20630@coredump.intra.peff.net>
 <ca433831002140658r30aa539fy5480cae8298d6d6c@mail.gmail.com>
 <20100215052139.GH3336@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 07:04:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngu3u-0003jD-4z
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 07:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab0BOGCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 01:02:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab0BOGCU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 01:02:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77B289A810;
	Mon, 15 Feb 2010 01:02:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bspPSSAb4W1nBV4s6lCcL6uwk1s=; b=s6wrBL
	dNl+1QRVamwn0DS2HmL1ENj1mgEpa4QWwsZWp5K9v2DUDgOslK3H8AZU70UbAZki
	2sLy1bGi1Szr0+C6p/02SsfYiexCzVu25In6AOMPzWGBrU5UZleLytEVTwM3ttyX
	FJTTOHfdiOCK6ddNfwlv1+Te0tSwp7S1Ja+24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lRj4yWM/rpov37RP0E0tc6NBVPFNe0KY
	iZwA+LBsarPKoGKhmCSGIVxSaUshe0GhdJJa3VUA1oI3pV7hSPxKv8t4+P8OLzwl
	l59Sk4lEAaWEtdgiLa9Lp/lWg0WEs4zb5ij+cO2RUWMy9DR5aDtxGmmUoLzo7pLg
	tEiwxFx2wMY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 324029A80F;
	Mon, 15 Feb 2010 01:02:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21A6C9A80E; Mon, 15 Feb
 2010 01:02:07 -0500 (EST)
In-Reply-To: <20100215052139.GH3336@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 15 Feb 2010 00\:21\:39 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A942EA64-19F7-11DF-ACD4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139986>

Jeff King <peff@peff.net> writes:

> It's historical. The diff option parser predates parse-options by quite
> a bit, and was never converted. Pierre made some attempts at converting
> it and the revision parser some time back, and we ended up with the more
> iterative approach (you can step through each argument with
> parse-options, and then alternatively feed it to the revision and diff
> options parser).
>
> I don't remember if there were any technical limitations,...

I think one of the biggie we didn't solve was what to do with the
cascading options table (e.g. log family use both diff and revision in
addition to their own).  The design needs to cover both parsing and also
the help text.
