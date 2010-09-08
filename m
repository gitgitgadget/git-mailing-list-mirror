From: Junio C Hamano <gitster@pobox.com>
Subject: Re: combined diff seems to ignore diff attribute
Date: Tue, 07 Sep 2010 21:32:28 -0700
Message-ID: <7vvd6gonxf.fsf@alter.siamese.dyndns.org>
References: <AANLkTinbaQbS=pU44sSCf7+_3bLrREpehYQCiV5CFuVB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 06:33:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtCLC-0004Is-Rm
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 06:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946Ab0IHEcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 00:32:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0IHEci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 00:32:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3763AD48F1;
	Wed,  8 Sep 2010 00:32:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8t0R0fHMHHUYXfZMYGf5iJ9eyDc=; b=DTitlN
	yEZ/U07E1cjAEcysV3cOofgGZYCWaIwBSNTl1AHlz2e4NjBXdgv0HMXTf5+pI3Xw
	/WVSzNT7Ag3fkyGVyAGSX7bsqcQQTHWKao61QSXcPEmY5nuLweAZnc0yRZyXyQ5J
	6BOwhIbA12mjsHJ7on8W/W2uKBHwSZVpSbFb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pn5cVzUZyBb9EtIXvP7mYSAFkTbVH/xh
	MHElnyMGv3v/gf8MOGG96R0P/8km9yyX4GA4yecgXgPEyuGfmXTRmAzkgt3EEUXR
	ASAbZt7wJpm4RBcR3Grihs5g+Ss+sQoJz6wJdTHn+dQQPd3XX32bK1ubkRYxEoaX
	VG35sS58CaA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BABADD48F0;
	Wed,  8 Sep 2010 00:32:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF0F2D48EF; Wed,  8 Sep
 2010 00:32:29 -0400 (EDT)
In-Reply-To: <AANLkTinbaQbS=pU44sSCf7+_3bLrREpehYQCiV5CFuVB@mail.gmail.com>
 (Jay Soffian's message of "Tue\, 7 Sep 2010 20\:33\:02 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 18F3D73C-BB02-11DF-93B1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155766>

Jay Soffian <jaysoffian@gmail.com> writes:

> which works fine except for --cc output. Is this a bug, oversight, or
> my stupidity?

It is "meh"; when we wrote -c/--cc we weren't interested in "-diff"
attribute at all.

It shouldn't be a rocket science to come up with a patch that skips such a
path before running --cc, I would think.
