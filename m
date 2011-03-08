From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jk/strbuf-vaddf] compat: fall back on __va_copy if
 available
Date: Tue, 08 Mar 2011 12:09:12 -0800
Message-ID: <7v62rte5nb.fsf@alter.siamese.dyndns.org>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142647.GA15477@sigill.intra.peff.net>
 <AANLkTin7NBx5NVRkHpgymcZfnaZaJehMMpPv=zD+cKtV@mail.gmail.com>
 <20110308083344.GD26516@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 21:09:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px3Ds-0006Qb-Jn
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 21:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab1CHUJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 15:09:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab1CHUJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 15:09:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 307ED36CD;
	Tue,  8 Mar 2011 15:10:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Qtnixor4IPq5y/g5xeeLfmyFd8=; b=J/3Yfn
	SWAKt87VAfcB+e8jCELFd2qs0B9h9rwsVi/SZA33Bcj/ccx1y8BppXXgRlmXJsKd
	4n2cL9775eBHYZcRYWmJVlZkqg3iqGoUZPZXyLgyRgdiNilzlQypVVQ9/N2wtq/8
	GvxZwmkt0KayDcobHk/Xhqx63L9EAdh5sOgkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tsI2srky9B38DQva8N7SolySwChTU26x
	bwInjfNy3TexMski6w9ZhcrQGYwRfre+UVWqd7MQ9r5IGzwYjUGlMKRbkAiAhQxV
	onO1M/CQ4caVjInsuDoXaj7kkmoUOOg/a+1FZt92DPxAwgCPwHt3s/MGGhDrqNwu
	51KIB/UOrbA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3B3536C9;
	Tue,  8 Mar 2011 15:10:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5337D36BF; Tue,  8 Mar 2011
 15:10:41 -0500 (EST)
In-Reply-To: <20110308083344.GD26516@elie> (Jonathan Nieder's message of
 "Tue, 8 Mar 2011 02:33:44 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 282E8FBA-49C0-11E0-8926-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168685>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Discovered by building with CC="gcc -std=c89" on an amd64 machine:
>
>  $ make CC=c89 strbuf.o
>  [...]

>  strbuf.c: In function ‘strbuf_vaddf’:

This is a tangent but when you quote from compiler output could you be in
C locale so that it would be easier for everybody to get the same result?
It will have the added benefit that we won't have to deal with these fancy
matching quotes I personally hate to see in commit log messages.

Thanks, the patch looks good.
