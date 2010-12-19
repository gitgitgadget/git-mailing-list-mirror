From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not
 valid
Date: Sat, 18 Dec 2010 19:23:29 -0800
Message-ID: <7vk4j6fnta.fsf@alter.siamese.dyndns.org>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru> <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru> <20101218161337.GB18643@sigill.intra.peff.net> <20101218205514.GA21249@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Sun Dec 19 04:23:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU9sH-0002VS-6I
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 04:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab0LSDXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 22:23:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab0LSDXr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 22:23:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3BF6A2D2A;
	Sat, 18 Dec 2010 22:24:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+5M3Ic3Pgh+e97SsXraBIx6RUe0=; b=Q+SnqJ
	ou+ig3l3M4zdjk7qow8GkyMvImg9Z8FWqHZ2L7BufM08CEX99RNZr3/NILgJvhti
	KiioAVxdJp9+09AxtfKmLJITZ7GIcNHq6YFav6ZKuLqZZnfwXXPkuYUEVUIE/qfF
	2su3g9jTH9UgvDEkNmj2MMQbYQMjO8zB5+Di0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ee/WATWsj8L7joj89vXUNffNXb3H9Jpu
	KVvWmw0I20XgBjf8zu6qyoQws8Wm2oIntrSgEDiwZLtTef6jMaL7gYrZHUI/lUxc
	hUzvxzHJZbWir8FsPITfeW5t/QAugmSMO6K8amUBl99z5yMBG0doOl+OVPNyMN/l
	F6eUtcWiTmg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB0D62D28;
	Sat, 18 Dec 2010 22:24:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 225CD2D27; Sat, 18 Dec 2010
 22:23:59 -0500 (EST)
In-Reply-To: <20101218205514.GA21249@landau.phys.spbu.ru> (Kirill Smelkov's
 message of "Sat\, 18 Dec 2010 23\:55\:15 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70596628-0B1F-11E0-A025-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163950>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> Thanks for your ACK and for the explanation.
>
> My last patches to git were blame related so semi-intuitively I knew
> that invalid sha1 are coming from files in worktree. Your description
> makes things much more clear and I'd put it into patch log as well.
> What is the best practice for this? For me to re-roll, or for Junio to
> merge texts?

Re-rolling to explain changes in your own words is preferred; thanks.
