From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Geolocation support
Date: Mon, 09 Feb 2015 11:13:42 -0800
Message-ID: <xmqqlhk6c2zd.fsf@gitster.dls.corp.google.com>
References: <87mwrncfkh.fsf@ethzero.com>
	<CALkWK0kHEDn4Wt3Y+XUE59_9ZDf504yopMp9QtBUk49Sd+EXbg@mail.gmail.com>
	<CALWbr2w3=DTAMkFtJoLF1_X46fefpEq2WtTb7HGiTiOExFHG3w@mail.gmail.com>
	<7vhahtfuzm.fsf@alter.siamese.dyndns.org> <87h9uwvtm2.fsf@ethzero.com>
	<CAPc5daW5jYAj5z6UMJAQLoWS4L6OH-NSvbGBMd3LO0qCV40a4A@mail.gmail.com>
	<CACBZZX5rgah7Ucek8dicaDeqvjdkR5ybBC5O7PUxE8+KBwrpgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alessandro Di Marco <dmr@ethzero.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:13:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtmK-0002na-1R
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 20:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933783AbbBITNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2015 14:13:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933111AbbBITNr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 14:13:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4537A3554D;
	Mon,  9 Feb 2015 14:13:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Tbxpa4zUfnHP
	CRDcDMj4/5bUyZc=; b=gYjdJyL7iq5JwC5se0xjy/MJvnWtHPliEqB/wXdS4KnJ
	TCsBpV/UdYzY0XBnVsP3QbLiZd8H3MNNEQB0y45+QZSrezA4VL1SDmSrmPlO+Pxg
	vToAyrbWD96fXVmXTZJJG5zyajld481ZrjN/33kHhQZ0RbjKvF9hFkDnAWjzAL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jUjDPP
	JYn8gkFgomFf3/QXtCO7aO23pvPPvvqMBOYLHhFRV/Wn00kXZcJyaaeXlVuXsufI
	xX0gq3AzDVrWcmhUmBnfv2rdnYkBNadJzYSmy8alEt+J5z60NEqOujgEadVzGtCt
	bHibzw1RCNKN/TZoZO0J92UMjkqZF7nMisJ1s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C4993554C;
	Mon,  9 Feb 2015 14:13:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB8B73554A;
	Mon,  9 Feb 2015 14:13:45 -0500 (EST)
In-Reply-To: <CACBZZX5rgah7Ucek8dicaDeqvjdkR5ybBC5O7PUxE8+KBwrpgA@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 9 Feb
 2015 14:57:02
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4D619B6-B08F-11E4-8895-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263586>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Feb 9, 2015 at 2:24 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> In case I was not clear, I do not think it is likely for us to accep=
t
>> a patch that mucks with object header fields with this information.
>> Have them in the log text and let UI interpret them.
>
> We've already told clients for a long time to ignore fields they don'=
t
> know about,=20

Yes, but the reason that mechanism is there is not because we want
to add random cruft Git does not have to know about.  It is to avoid
older Git from suddenly stop working when we really need to add new
essential things.

This was discussed in great length on this list already.

cf. http://thread.gmane.org/gmane.comp.version-control.git/138848/focus=
=3D138852

More importantly, adding non-essential stuff left and right will
force third party Git reimplementations to pay attention to them and
also will leave room for them to make mistakes when deciding what to
propagate, what to drop and what to update when rewriting commits
via rebase, cherry-pick, etc.

> why would we not store what's intended to be
> machine-readable key-value pair data in the commit object itself,

I think this sentence gets it backwards.  The question to ask is if
it is an arbitrary cruft that the end users are better off if they
can easily typofix in the commit message log editor, or is it
essential for Git to operate correctly and end users shouldn't be
allowed to muck with in the editor?

>> The expected location format is "CITY, COUNTRY (LAT, LON)".

I would expect that I can typofix "Les Angeles" to "Los Angeles",
if I were using this feature.
