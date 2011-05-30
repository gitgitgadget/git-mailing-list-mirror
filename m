From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using really empty start prefixes for git-format-patch numbered
 patches?
Date: Mon, 30 May 2011 12:19:22 -0700
Message-ID: <7voc2km1xh.fsf@alter.siamese.dyndns.org>
References: <BANLkTikVQWN2kZ4gc8kd-kJWZhLXgkvTAA@mail.gmail.com>
 <20110530141905.GA31490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Delanoy <frederic.delanoy@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 30 21:19:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR804-0001Sl-Co
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 21:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757631Ab1E3TTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 15:19:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab1E3TTc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 15:19:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B37752B0;
	Mon, 30 May 2011 15:21:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NOxs5FYeRX98+oyUNPg4u6IOMqk=; b=wXjWQ2
	oe+Y1gvEOoEOe3LLNlQHZiiUh2HOnBgk51RdtA0Cnld7Rb9ep8AKpt1qcjhFvvrx
	lmNg0tfGP785JA6fmgSXTr7AvPhhIKWvABVqUW36oeiyFdUq5DaGBi82052Si50N
	Ga7bs7X3r7iHKf5oBCwh06RYLWw/DSixa7hVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SbCY9+62MMfnbAktfMuzwbHpKWCWFM5x
	Y3R5CCiJn2ja+glsM5rZUZHTC3Zz/KD5ZviFnzBlEKxDbKlSZO81/AwXCc96pxka
	yKyKxdbuzXdlozaClQ9doJKL9QxiShE8d/Z4hjQRAgZpS4XHkS69+VIFrvEqb6cL
	VmStEGrOH7E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1925852AE;
	Mon, 30 May 2011 15:21:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0813F52AD; Mon, 30 May 2011
 15:21:31 -0400 (EDT)
In-Reply-To: <20110530141905.GA31490@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 30 May 2011 10:19:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09147004-8AF2-11E0-BAE0-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174768>

Jeff King <peff@peff.net> writes:

> I don't think there is currently a way to do what you want short of
> post-processing the output of format-patch. You can use "-k" to preserve
> the subject, but then you don't get the "1/2" that you want.

You would unconditionally get "[" and "]" that you may or may not want and
there is no way to change it to "(1/2)" or "1 of 2: "; unless we shoot for
a completely flexible solution, we need to draw a line somewhere.

It was not optimal in the hindsight to draw the line where the prefix is
customizable, while always assuming that people would want some prefix,
perhaps.

> So I think we should do this:

Yes, ...

> ... under the assumption that nobody
> actually wants "[ 1/2]".

which I think is a reasonable thing to do.

Will queue; thanks.
