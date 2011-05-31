From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git global usage and tests
Date: Mon, 30 May 2011 22:19:47 -0700
Message-ID: <7v7h97la4s.fsf@alter.siamese.dyndns.org>
References: <754E784F-51C6-4B8D-B15D-3FF8B7AF1321@gmail.com>
 <20110530153620.GA24431@sigill.intra.peff.net>
 <B369AA28-DEF2-48F3-8E4E-F387E8A57D26@gmail.com>
 <20110530161230.GA25291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Romain Geissler <romain.geissler@gmail.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 31 07:20:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRHN9-0005j6-EL
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 07:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639Ab1EaFUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 01:20:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab1EaFT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 01:19:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2697F579B;
	Tue, 31 May 2011 01:22:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YCaD3B5ZXeSAJU4GZnnoBahWD40=; b=anNF3i
	L/hPT3Oi7fDL8mFxeZccf9a9gHqNb9heNlrujmyvZYtKPImI7TNyqmvM4oFZmIDU
	9syC/s40mGwQoLv+CRFDWazVhOPty5q3v1xgLZVNe5dC+OkMJ5fEBs104CgCLdfp
	dzUw+4EEW4MJCeRYBukfckgC7foO7rq5UrrxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LE4CEw67zPfv+ibo9dn/PBdoTK5EN4dK
	Nd3Aiq5fK3So7rUew2rSM6gUJotvN2KXDBd0WYg84Vhk/S8Js2lVGtdqwToldejt
	GJRwSjj6NLIrChA28MFpqnqXtji2mW8mLGNyF9IeZUAuEWiOozbuVqux8ztVcLcz
	JjOQdqak1vA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D71445790;
	Tue, 31 May 2011 01:22:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 95F26578F; Tue, 31 May 2011
 01:21:57 -0400 (EDT)
In-Reply-To: <20110530161230.GA25291@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 30 May 2011 12:12:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EAB74632-8B45-11E0-B9B2-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174792>

Jeff King <peff@peff.net> writes:

> On Mon, May 30, 2011 at 06:10:20PM +0200, Romain Geissler wrote:
>
>> > Have you considered pulling the parse-options parser from git into
>> > libgit2? It's one of the more modularized and lib-ified bits of code in
>> > git already.
>> 
>> Yes and No. We have already copied some code from git : parse-option,
>> the error handling functions, a part of the run-command block and a
>> part of the compatibility layer. To my mind, there is no reason to
>> pull it into libgit2 as it's only a client feature that works on
>> strings, and libgit2 does not aim at being a client, only a git
>> library.
>
> Yeah, good point. Definitely it should not be part of the libgit2
> library itself.

IIRC, libgit2 has a lot looser license than ours, and the core GPLv2 part
of C git cannot be directly copied without authors' consent; relicensing
of necessary parts of C git needs to be arranged.
