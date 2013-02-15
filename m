From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Veryfing signatures in git log fails when language is not
 english
Date: Fri, 15 Feb 2013 08:08:54 -0800
Message-ID: <7vip5twodl.fsf@alter.siamese.dyndns.org>
References: <20130214011837.04880b3e@hydra.devrandom.pl>
 <511CC288.30607@drmicha.warpmail.net>
 <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
 <7vliaq3kr0.fsf@alter.siamese.dyndns.org>
 <CAJ9Ak2oF+SiYjStJndRZqLfnzBisn3TyXr3U_E_42BHrKbKPfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Mariusz Gronczewski <xani666@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 17:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6Nqk-0004sL-6v
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 17:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976Ab3BOQI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 11:08:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536Ab3BOQI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 11:08:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C09A3CD4E;
	Fri, 15 Feb 2013 11:08:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q1wEh5THjGHMZKqfvGaYURSemZs=; b=HYvza9
	LZmc7jb8WdPdtRdH1P229eIdQz38gvGqdqSE8ZNH9gL8tWN5mRT0Zn6U7xAkW9kz
	Jy+FioFlkauomhLrFxCQnabtCZy8xLOQfIqcsno5sDuJJ/5qW+bOe/8sXDttUY1B
	0lYIZF2VO0j+NMG6nTE14erc6bJhe5aELRVok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EgYdcQQxEPEcnBiv7M0CzPmT61XE0nv6
	WNzz5e8Q973uXjR4FWmB0EQ9RnfV7y7D6derwoTn3EAE3kSpFeRVrc5Sm4UTzVeb
	/M7/Z1lNqxBa04b0c1OSLRDNXsOj0+la7uAnF1/GdB1ooc/vkDjX2Nxdw9uyLO+p
	vpHOxNiuzlo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6176CD43;
	Fri, 15 Feb 2013 11:08:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FA60CD42; Fri, 15 Feb 2013
 11:08:56 -0500 (EST)
In-Reply-To: <CAJ9Ak2oF+SiYjStJndRZqLfnzBisn3TyXr3U_E_42BHrKbKPfQ@mail.gmail.com> (Mariusz
 Gronczewski's message of "Fri, 15 Feb 2013 15:14:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFDC16A0-7789-11E2-B5A0-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216348>

Mariusz Gronczewski <xani666@gmail.com> writes:

> 2013/2/14 Junio C Hamano <gitster@pobox.com>:
>>
>>     - The "right" one you mention for %GS is easier than you might
>>       think.  If you just verify against the accompanying "tagger"
>>       identity, that should be sufficient.  It of course cannot be
>>       generally solved, as you could tag as person A while signing
>>       with key for person B, but a simple social convention would
>>       help us out there: if you tag as Mariusz Gronczewski, your
>>       signature should also say so.
> unless there is someone else with same name, which happens more often
> (so far i've seen it happen twice) than same GPG IDs.

Oh, I didn't mean to say "ignore email part", which of course will
make the result more likely to be ambiguous.

I thought you meant by "have to show right one" the following
scenario:

    The tag v1.8.1 has a GPG signature.  The key 96AFE6CB was used
    to sign it. The key is associated with more than one identities.
    One of them is "Junio C Hamano <gitster@pobox.com>", but that is
    not the only one.  I also have combinations of other e-mail
    addresses and names spelled differently (e.g. "Junio Hamano
    <jchXXXX@gmail.com>") that are _not_ associated with that key.

    GPG may say "good signature from A aka B aka C"; which one of A,
    B, or C should we choose?

I was suggesting that among the identities associated with the key
used to sign the tag, we should show the one that matches the
identity on the tagger field.

    object 5d417842efeafb6e109db7574196901c4e95d273
    type commit
    tag v1.8.1
    tagger Junio C Hamano <gitster@pobox.com> 1356992771 -0800

    Git 1.8.1
    -----BEGIN PGP SIGNATURE-----
    Version: GnuPG v1.4.10 (GNU/Linux)

    iQIc...
    =v706
    -----END PGP SIGNATURE-----

Because it is clear from the context where the signature appears
that that identity is what matters for me as a signer in the project
the tag appears in.

I may have other e-mail addresses that are not associated with that
key, but it would be insane to put that on the tagger field of the
tag, while GPG-signing with that key.
