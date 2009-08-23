From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 (v3)] reset: make the output more user-friendly.
Date: Sat, 22 Aug 2009 19:33:07 -0700
Message-ID: <7vmy5r1cpo.fsf@alter.siamese.dyndns.org>
References: <vpqljlipcs6.fsf@bauges.imag.fr>
 <1250845079-30614-1-git-send-email-Matthieu.Moy@imag.fr>
 <1250845079-30614-2-git-send-email-Matthieu.Moy@imag.fr>
 <7v3a7k767j.fsf@alter.siamese.dyndns.org> <vpq8whc8euu.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 23 06:15:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf4UC-0002VH-96
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 06:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbZHWEIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 00:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbZHWEID
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 00:08:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZHWEIC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 00:08:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B1F815597;
	Sat, 22 Aug 2009 22:33:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gxMM9uhh0U1naJHfRiBEQT10zJI=; b=U30jGZ
	3fZCmwiSPVpQ589ZaYmycPFblKydO5WFu8CKOXe5cjeD7qvJlXBml4Db7itEJhkK
	dNpa0u4rSt1Qeyz1kvROQ/Y3VeDsrBo/BwzRlbpB+YozDiTIErGZIztP+PoRJor6
	vV0+QxJdmsLPCpaW3rljCNPdjmG2aKSnt2U/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vxcdodu+XFE4DPR7Y9+OL/thgn/q0ONz
	Ssr4L9bUDHYrd3vcPBLDmGyPHWCHM8mxiffQOyLH5+musQPh4vVxcEfsXGS40D8A
	r6g9Uo23jQW5qdAJibC2oaOCVrvGZ1Zmh+63VCipl78VnEWFSpPUgQhdfvm2vagX
	rR54cHcFcSo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22F0A15596;
	Sat, 22 Aug 2009 22:33:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 628B115595; Sat, 22 Aug
 2009 22:33:11 -0400 (EDT)
In-Reply-To: <vpq8whc8euu.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sat\, 22 Aug 2009 09\:52\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50787B6E-8F8D-11DE-A4CF-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126841>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Intuitively, I would have thought that "git reset" was reporting what
> it was doing, as it was doing it. So to me (before experimenting a bit
> more and looking at the source code),
>
> M	foo.txt
> M	bar.txt
>
> would mean "I've just reseted foo.txt and bar.txt, which were locally
> modified", while actually "git reset" can very well show this message
> after reseting only foo.txt, just informing the user that bar.txt is
> also modified. So, at least to me, the semantics was very unclear, and
> while I would have understood immediately with the one-liner message.
>
> In short: no strong objection to remove this message, but to me it is
> usefull.

Thanks for sharing the reasoning.

Two conflicting/competing thoughts come to mind:

 1. Perhaps we should add a similar "explanation" for the list of paths
    with changes upon switching branches with "git checkout" for
    consistency.

 2. Such an "explanation" of what the output means would help the first
    time people, but would everybody stay "first time" forever?  Would the
    explanation become just another wasted line in valuable screen real
    estate after people gain experience?

I am leaning towards #1 right now.
