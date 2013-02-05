From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Should "log --cc" imply "log --cc -p"?
Date: Tue, 05 Feb 2013 07:51:00 -0800
Message-ID: <7vobfyvjx7.fsf@alter.siamese.dyndns.org>
References: <7vmwvl6lj9.fsf@alter.siamese.dyndns.org>
 <510F95D7.6010107@drmicha.warpmail.net>
 <7vfw1c3ujo.fsf@alter.siamese.dyndns.org>
 <CACBZZX7FJ39sereptAQ40Q4MwEpf15v0H=++WvB7+BpMknxoYw@mail.gmail.com>
 <20130205112249.GE24973@sigill.intra.peff.net>
 <CACBZZX7JNwZYHn--Cp4g1rLPratJ9nEa-Q8HsYk65jjDYAkFqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:51:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2knx-0002uq-0q
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 16:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851Ab3BEPvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 10:51:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754742Ab3BEPvD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 10:51:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1526DC2FD;
	Tue,  5 Feb 2013 10:51:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TpoSVETos4Nz
	xj7Udru1anQD1M0=; b=S2EP5Z85eFFajWzrK04PHK2wTiyLkKuZUwiP7Ut9e3lS
	19UBLt6n/GyGaxJe5sQkM+qZulbUB8mIXkMU5VSHdwwVAcIBJ3biOCfRcI0ZFUUV
	+hTOKXYdvVyEYntGIs37l9y+Yaln5pkGUfsi2e2QPuEgVp+nKk1muk7Uesr/1v8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gVKuDu
	aXWxLPb1xzWxzSsaM8RgnMwTDdSS+3vWpLuU8sBsDRgHIU9xJGYYTewhgF6ELRV6
	RGuhcXZOAqKfB0sdOt8b5nXY2wSjnsEqZ9mfAbHZ+EUIUAISkhzHsbPUcyJRB5xT
	ovF4o3jRGMQW2TIFrer4Dc66b/SvAw0OEX5ng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0915CC2FC;
	Tue,  5 Feb 2013 10:51:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A04DC2F8; Tue,  5 Feb 2013
 10:51:02 -0500 (EST)
In-Reply-To: <CACBZZX7JNwZYHn--Cp4g1rLPratJ9nEa-Q8HsYk65jjDYAkFqA@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 5 Feb
 2013 15:27:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7C24CC4-6FAB-11E2-982D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215507>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On a related note then, it's a bit confusing that it's called
> "--full-diff" when it doesn't actually show a diff.

It is too late to change the name of the option, but we could add a
synonym if it makes easier to understand what the option is for.  It
is about saying "my pathspec are only to limit the commits to be
shown and do not limit the diff output".  In that sense, the current
name that asks to give me the diff output fully is not that wrong,
but I wouldn't be surprised if other people can come up with better
names.
