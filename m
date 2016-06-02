From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mark remote `gc --auto` error messages
Date: Thu, 02 Jun 2016 14:59:51 -0700
Message-ID: <xmqqmvn3s148.fsf@gitster.mtv.corp.google.com>
References: <146489432847.688.11121862368709034386@typhoon>
	<xmqqinxrtmgi.fsf@gitster.mtv.corp.google.com>
	<146489800609.1944.4398103814754920753@typhoon.lan>
	<CAPc5daXVx1=ptsKJEfEzXbjCNvwYxjAPyp_pob9CeR+Qr3tG_g@mail.gmail.com>
	<20160602214834.GB13356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 00:00:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8aen-0008Nn-T8
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 00:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbcFBV74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 17:59:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932240AbcFBV7z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 17:59:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CCC8210BB;
	Thu,  2 Jun 2016 17:59:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pY35Rpcmr+xw4Ogu5I2XbtXzKGY=; b=HUGdOY
	xGsOEi2NACEzUPfvbirjc+l8Bc/atcCCgnL5rV1UipQ6/h/2x8IIoolNTsfA1ED1
	Jsvdm0yPasTHJE0AjR3SFVx2RCpzIfPIOllhXnLIsCy0WSqy/D75I0zTHU+4L2Bw
	NMcm2o9+i4mVswBwOMT0BYi9mTpEhxiyvxr/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pV9U8pTbm+I7a9YLWsROhAjHtuH+7hY4
	cE9IP66UxX8spx3SYlNQTlJ/GLszI09RpwWpy1414yo8KdW+9l9b5IaSxilVoifE
	2Qv6HMfPPKLppgd6IqouxY6xjZsUAdqd6ePn3KVfUWqGEekvSqsPdOADgYw+SKOJ
	XFS1qaqdUtY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4577B210BA;
	Thu,  2 Jun 2016 17:59:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6D04210B8;
	Thu,  2 Jun 2016 17:59:53 -0400 (EDT)
In-Reply-To: <20160602214834.GB13356@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 2 Jun 2016 17:48:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 562981EA-290D-11E6-ACE6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296245>

Jeff King <peff@peff.net> writes:

> So the greater question is not "should this output be marked" but
> "should auto-gc data go over the sideband so that all clients see it
> (and any server-side stderr does not)". And I think the answer is
> probably yes. And that fixes the "remote: " thing as a side effect.

Thanks for stating this a lot more clearly than I could, and I agree
that sending this to the other side regardless of the protocol is
the right thing.  I somehow doubt that server operators would check
Apache logs to decide when to do a proper GC, so I do not consider
it a true loss ;-)
