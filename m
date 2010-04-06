From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: move -Wall from CFLAGS to BASIC_CFLAGS
Date: Mon, 05 Apr 2010 23:06:54 -0700
Message-ID: <7v6345ktc1.fsf@alter.siamese.dyndns.org>
References: <1270523660.3648.7.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Tue Apr 06 08:07:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz1wY-00062Z-8d
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 08:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757120Ab0DFGHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 02:07:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575Ab0DFGHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 02:07:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C0DAA7EE4;
	Tue,  6 Apr 2010 02:07:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U5zrksdzk5Teg3Dn+9q+vFYOT2I=; b=jhpMsh
	FATTyOPyXxme02wHmUW94qFrxMuBfGKpyWBgQxvMwaWOS//N0IpMeOc7UkTiBGhh
	/ulF2Bp03uVtx8YA/7I+KFjeH7aL0duRjR/yzLoNTHuO1sJjKP9huTqbFJx5ifEE
	Vn//X/leFw5zArb4ouz3cgcn5o3GZ5lWDRZCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RihDvPQXQ9WM8cVgmpF7YvvCTpDZRNXG
	z+5lcz2F5aO8G4q6TPEBYNQ9cPf0nQsYulQ9bxrKoBb8m9rgYYckkNAoaHrNBKMS
	sHABKk5qOPFIL9ysCAQJBVfOb4ISRl+3vPuVqeKpq+67Ci32RBBVKUP48mq+lZ1b
	0/AVb83ba80=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46881A7EE3;
	Tue,  6 Apr 2010 02:06:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4495A7EDF; Tue,  6 Apr
 2010 02:06:55 -0400 (EDT)
In-Reply-To: <1270523660.3648.7.camel@mattlaptop2.local> (Matt McCutchen's
 message of "Mon\, 05 Apr 2010 23\:14\:20 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9BD6E642-4142-11DF-9A30-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144103>

Matt McCutchen <matt@mattmccutchen.net> writes:

> -Wall cleanliness is an intended property of the codebase, so -Wall
> should be on by default even if the user's CFLAGS doesn't include it
> (e.g., the AC_PROG_CC configure test won't include it).
> ---
>
> Thoughts?  Is there a problem with -Wall being GNU-specific?

I think you answered yourself very well.

> @@ -308,7 +308,7 @@ SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
>  # Those must not be GNU-specific; they are shared with perl/ which may
>  # be built by a different compiler. (Note that this is an artifact now
>  # but it still might be nice to keep that distinction.)
> -BASIC_CFLAGS = -I.
> +BASIC_CFLAGS = -Wall -I.
>  BASIC_LDFLAGS =

It still talks about perl/ back from the days when we used to have some .xs
stuff, but the principle still should apply.
