From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] upload-pack.c: use parse-options API
Date: Tue, 31 May 2016 10:16:54 -0700
Message-ID: <xmqqlh2q5erd.fsf@gitster.mtv.corp.google.com>
References: <20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<20160530145347.15643-1-antoine.queru@ensimag.grenoble-inp.fr>
	<xmqqd1o38i0m.fsf@gitster.mtv.corp.google.com>
	<vpqbn3mxy9v.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, peff@peff.net,
	sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 31 19:17:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7nHq-00025r-DU
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 19:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbcEaRQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 13:16:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750730AbcEaRQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 13:16:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 88F1C1DFEC;
	Tue, 31 May 2016 13:16:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=12EvfE1jEMrp9gtOUQhBxbXE45A=; b=IIEtG/
	B76KqVx0MkJFDz+85dXXok00EgcjLBfJUxaxDaEuo1Nr1WGWo6DG+bgmqtyfWkTO
	cSSCMcATZB4UoyvJkq3vvNTurM0ykbrSmK0H66SniyD/wbYQ1BBabAg998JZRSPO
	4yWLFnsp0u8PjHOpsKk1QicTyLnNDfLtkDguo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tUj4CymKSiUPtNiagba4sq7OvR4zsBBS
	WuLlAX+yAt5MHn+kBvB8dHzUVV3Pdd9AE7jz2z9r/KniX3X5tVo2DnMeh/Ol3Las
	B5VBNfT4Hn1e3ZwEV/G08hfpyVuPx8gLKd5ee6NgvBM0mD44+ajsQWbPK3TKXiNT
	UqQMUlXmKi8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 80B5C1DFE9;
	Tue, 31 May 2016 13:16:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D3E91DFE8;
	Tue, 31 May 2016 13:16:56 -0400 (EDT)
In-Reply-To: <vpqbn3mxy9v.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	31 May 2016 13:27:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 79D75754-2753-11E6-B577-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295997>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Actually, that's even: don't you want to use a valid email address in
> your Signed-off-by: ? ;-)
>
> @ensimag.grenoble-inp.fr => student's current adress
> @grenoble-inp.org => students lifelong address. If not already done,
>                      students can already set it up to redirect to their
>                      current address.
> @grenoble-inp.fr => only for staff (i.e. me but not students).
>
> I have a preference for the @grenoble-inp.org in the From and
> Signed-off-by as the Git history will remain after the current adress
> become invalid.

I was wondering about that "ensimag." part myself as I had a vague
recollection of your mentioning it in your class projects in
previous years.

Antoine?  I can munge the author and sign-off in your v6 to name you
as

    Antoine Queru <Antoine.Queru@grenoble-inp.org>

if you want locally, or I can queue it as-is.  What's your
preference?
