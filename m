From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 16:20:46 -0800
Message-ID: <7v4ooinnkx.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <60F92BD7-6FFF-4D9A-B2F0-0858F4E90B59@wincent.com>
 <7vd436p339.fsf@alter.siamese.dyndns.org> <4B0DC8F7.1000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Wincent Colaiuta <win@wincent.com>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:21:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDS6d-00012F-L7
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbZKZAU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759997AbZKZAU4
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:20:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759790AbZKZAUz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:20:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6AB08A17F5;
	Wed, 25 Nov 2009 19:21:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+npexNbTzTRKaVSL0z97cFlwBzo=; b=BalPRL
	Okygwf71O7h6CAFvjivE0h1fl8MNte14p3h0uIFt+l+gvUGQtdzQNFD/qowd3wcK
	VJGmUVJzsYyIYZaXGnMzMTnqqabopR1Y5sRYQckXHZ4aSWb5vrxGUi3wo67MwAHU
	FSSHK9twQZ9J8bRuM5lVDcCreuQCl27ihaB0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BaR3wNCox3PyeO9t9KeRkmWHHbNwPnnt
	K/FoDe0Td+B7sEbVt1BsgF2Elrp74D9u727dMUi5v+XUtRU3aqofRTbVqCRGk55H
	z2fHqSQbv+P5FyfdcvaZ0/WiivnfVurlBV5idLV+lgZa6tmRMn/ait7WPfkR0fLq
	WVXqXtqZzb4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D2F8A17F1;
	Wed, 25 Nov 2009 19:20:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 00C6EA17EF; Wed, 25 Nov 2009
 19:20:47 -0500 (EST)
In-Reply-To: <4B0DC8F7.1000509@gmail.com> (A. Large Angry's message of "Wed\,
 25 Nov 2009 19\:16\:55 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 907FF4A6-DA21-11DE-88E8-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133714>

A Large Angry SCM <gitzilla@gmail.com> writes:

> But the users are almost always dealing with things (objects) that
> started as files, act like files and may be files again. Why should
> they not expect filesystem semantics.

Do you truly want to see this?

    diff --git a/var/tmp/git/Makefile b/var/tmp/git/Makefile
    index 5a0b3d4..e9b03a8 100644
    --- a/var/tmp/git/Makefile
    +++ b/var/tmp/git/Makefile
    @@ -1985,3 +1985,4 @@ coverage-report:
    ...

As long as you are talking about paths you communicate with git, your
root _is_ the root of the work tree, and it shouldn't matter where you
have your work tree.

That is what I meant by "the root _in the context_".
