From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: Add http.savecookies option to write out HTTP cookies
Date: Tue, 23 Jul 2013 15:27:28 -0700
Message-ID: <7vk3kg7vzj.fsf@alter.siamese.dyndns.org>
References: <1374613676-20889-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: dborowitz@google.com
X-From: git-owner@vger.kernel.org Wed Jul 24 00:43:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1lIv-0000iT-Um
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 00:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934707Ab3GWWnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 18:43:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37996 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934669Ab3GWW1d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 18:27:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74553334BD;
	Tue, 23 Jul 2013 22:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CFzB32xS4Sp9vOQ+jGty8Fzjg0Q=; b=SRXS4a
	J3XpzxaBjOmw2GaIPlJ9krS0Hi1h/1Bi0GrMtoiqcyBrkoiytq8Tl3V1aptnzR2w
	YvgHHrXHsJ5Je6HQJ4JNmHtP10+5aqwXimWC3TKd9IDQFpu76Gen4r6BAjQOj/zS
	b0QQ1vPokfu5mbT1hnNn2XWHZfPLouKA2K8rU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CsS/4t/rGUkihH4PhAkKhG7blt7iC+8w
	IwRs+H80dBV81k4z49PhYq2qFWZVRTLSGwBP+qx9rxqZ+cO5gLlaoaGeaf1zCzIo
	e0zn0ictRA5B9zeNeRnjkSwcyJFGr4iT9QjvI6uUahQwHh7IX66wOcmYLBVsjjAB
	t0mk8Vbebx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61CE8334BC;
	Tue, 23 Jul 2013 22:27:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7329334B6;
	Tue, 23 Jul 2013 22:27:30 +0000 (UTC)
In-Reply-To: <1374613676-20889-1-git-send-email-dborowitz@google.com>
	(dborowitz@google.com's message of "Tue, 23 Jul 2013 14:07:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1018A644-F3E7-11E2-B379-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231069>

dborowitz@google.com writes:

> From: Dave Borowitz <dborowitz@google.com>
>
> HTTP servers may send Set-Cookie headers in a response and expect them
> to be set on subsequent requests. By default, libcurl behavior is to
> store such cookies in memory and reuse them across requests within a
> single session. However, it may also make sense, depending on the
> server and the cookies, to store them across sessions. Provide users
> an option to enable this behavior, writing cookies out to the same
> file specified in http.cookiefile.
> ---

Makes sense.

I briefly wondered if users want to be able to selectively store
cookies only from certain sites but not from others.  But if we are
going to build this on top of Kyle J. McKay's "Per URL http.<url>.* 
configuration" series, that will fall out as a natural consequence,
I think.

Please sign-off your patch.  Thanks.
