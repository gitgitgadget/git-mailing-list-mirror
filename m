From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/72] t/test-lib.sh: add always-set NO_GETTEXT_POISON
 prerequisite
Date: Sun, 20 Feb 2011 22:56:30 -0800
Message-ID: <7vipwdlvtt.fsf@alter.siamese.dyndns.org>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <1298143495-3681-4-git-send-email-avarab@gmail.com>
 <20110220021031.GB17305@elie>
 <AANLkTik9ieR=pWLQ9JEabNm2trSsyfFuYgfKMojnbzfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 07:56:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrPhS-0004oZ-DF
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 07:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab1BUG4m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 01:56:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab1BUG4m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 01:56:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31A264821;
	Mon, 21 Feb 2011 01:57:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HwOiKdppdqeL
	7rpxHIs5oXDmKZw=; b=fN+Swz37jMAlQ+wxY06j73zdGGPlOCTroUTko8Ajy606
	I/i7bePaq9Wam3YveXnrKxanHv3pN/vqt99n6fvLqNEDXzweFesA/V85GXzAtaiF
	ZfHqFU+2R6sEHbubijCnp5/e6V8rszW0DUXXZKjWEqjyyBCYmQJR6pvN+so6GvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=D/+cYN
	FZzYCih9w3EL/hl0hhjJBcLBE92V+xqYINNWCRy3ZcPFGgW+hfdy3Y6FxCYmCLDJ
	pFMpUoYvUrhl8X7zmNfnZrDcRNFajuP01Ibvcl6/7OJiyh2whtRGzQoYf/3/FH49
	xplnkybDrFpLPUK0aOlDOr0czGOgVqJ1F2h+I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 014C14820;
	Mon, 21 Feb 2011 01:57:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B38FA481F; Mon, 21 Feb 2011
 01:57:43 -0500 (EST)
In-Reply-To: <AANLkTik9ieR=pWLQ9JEabNm2trSsyfFuYgfKMojnbzfb@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun\, 20 Feb
 2011 13\:42\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E434E65E-3D87-11E0-9885-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167443>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> You shouldn't worry about it for now. FWIW NO_GETTEXT_POISON is
> documented in po/README in a patch that I plan to submit later.
>
> NO_GETTEXT_POISON is only relevant to people such as myself who are
> adding new translations to the source. I.e. changing "foo" to
> _("foo"). It's a sanity check to make sure that by doing so you're no=
t
> changing some plumbing test, or at least have to realize what it is
> that you're changing.

I also had the same reaction to NO_GETTEXT_POISON as Jonathan, and your
above argument is not quite right.

GETTEXT_POISON _is_ relevant to people like you who are working on the
i18n part of the system.  It is a debugging aid to make sure that you a=
re
not marking plumbing messages that should never be translated.

But you cannot say NO_GETTEXT_POISON is not relevant to others; everybo=
dy
else who is not actively working on i18n needs to be aware of it, and
needs to be careful when writing his tests.  When your test depends on
output from Porcelain (which is not something we should encourage, but
that is a separate matter), you need to mark that test as "this test wi=
ll
be broken under GETTEXT_POISON build".

"This test requires NO_GETTEXT_POISON pre-requisite, which is only true
when git is built without GETTEXT_POISON" makes logical sense as a
statement, but it feels somewhat a roundabout way to explain it.

This is somewhat a tangent, but I've been wondering if it might be a
better design to make GETTEXT_POISON a runtime thing.  When git is run
with GIT_LOCALE=3DPOISON, "_(msg)" will all result in gibberish or rot1=
3,
and instead of building a special test-only binary, always compile i18n
version of git that way.
