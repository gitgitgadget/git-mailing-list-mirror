From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Thu, 31 May 2012 10:34:50 -0700
Message-ID: <7vtxyw6ypx.fsf@alter.siamese.dyndns.org>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com>
 <7vehq18c82.fsf@alter.siamese.dyndns.org>
 <20120531011911.GC5488@sigill.intra.peff.net>
 <7v62bc97w1.fsf@alter.siamese.dyndns.org>
 <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Lanny Ripple <lanny@spotinfluence.com>
X-From: git-owner@vger.kernel.org Thu May 31 19:34:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa9H0-0000mv-AV
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 19:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156Ab2EaRex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 13:34:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35996 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755131Ab2EaRew convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 13:34:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED77A8BBB;
	Thu, 31 May 2012 13:34:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gmHpz5A80Pd1
	kr6/sBUVhrwnfxw=; b=V4+SzIGFWNTjQ0MoKvIfZzK5jbeWp0Kf+HHVEaBSyemC
	c+/udsYmoogZnTSOhAVRoYqq0yFJrpwDGifK93rooBXZwhPbJ1Oh7Zl2VFUdT/Iy
	Zgz3Q/4YhtL05a1+b/sty5IexapkACe9vzJroCeflvJz2XsMpnD02XpvOmSW5B4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XWA1Bc
	odi/sxdIHP2jKuCtTHH8kBghuL2fLvRIGtAXAfP0i7SXPIU9N2xeA1tW1DVMW5NW
	PIJ4wWZ0FXKSW/T5yXfUZ+2bDy6MxoJkjuWEKDMN0oApG2yiuiuCGc685HY1nja6
	/+09N7181pSP26MEjorBoERGaqJKkYayYnQzI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3EE88BB8;
	Thu, 31 May 2012 13:34:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AA4A8BB7; Thu, 31 May 2012
 13:34:51 -0400 (EDT)
In-Reply-To: <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com> (Lanny
 Ripple's message of "Thu, 31 May 2012 08:36:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED4CFB04-AB46-11E1-AADD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198928>

Lanny Ripple <lanny@spotinfluence.com> writes:

> Bingo.
>
>   lanny;~> echo "R=C3=A9mi Leblond" | LANG=3DC LC_ALL=3DC /usr/bin/se=
d -ne 's/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p'
>   GIT_AUTHOR_NAME=3D'R=C3=A9mi Leblond'
>
> Just occurred to me that I'm using fink and that git-am doesn't use /=
usr/bin/sed but just sed.  My suggestion is to be explicit on the path =
in git-am.
>
> So it now stands at two bug-reports and one pebkac.

My impression from reading the older thread Peff mentioned is that
the other ones are also broken implementation of sed supplied by
third-party, so it probably is not two Xs and one Y.  It is three
something.
