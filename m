From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Mon, 10 Jun 2013 12:17:27 -0700
Message-ID: <7vbo7dhj20.fsf@alter.siamese.dyndns.org>
References: <1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
	<7vd2rvqgra.fsf@alter.siamese.dyndns.org>
	<CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
	<7vy5ajozuj.fsf@alter.siamese.dyndns.org>
	<CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
	<7vfvwrowd0.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Qr54+8hbkZ+jmXB628SCPwg1zZo80UBhFe2PCrgQP4Q@mail.gmail.com>
	<20130610093904.GG2091@goldbirke>
	<7vppvuj6wl.fsf@alter.siamese.dyndns.org>
	<20130610172708.GH2091@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 10 21:17:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um7aw-0008BS-QT
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 21:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab3FJTRb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 15:17:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032Ab3FJTRa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jun 2013 15:17:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C3AB27A37;
	Mon, 10 Jun 2013 19:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Wks7LWsrVpoF
	Lue2sbg26KGFp4M=; b=je1ZEOF4cvVwGPC94kexNYKgSKIlbAZmhj6iLMGTfQBF
	0eolaxorE1bPjgtP0BXnsxn4SBb7P9cf0ZCu/SRU9HsdDCgvITh5whOw4Lk/dorc
	jPwjgAiPZJ9gBN7VNCNDu7n7CW4dOIw0QgQAxaSdZQTvwy8iGVKwF78gT3+9D28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KWf1Ys
	tezfjtAZ7n8/Y7lQBqb7kduStXOOUvX98dJgjhniHDdQb33GOWmunjyfHzZ32GfE
	/IAHC08A4JpfeTWQK0Ohq814+DFr7wOohMDXv7VMxBRxwpJ90GAJXVWl8Sj7N76r
	NpSXa2t6ntWd+9CWCge4FpZQ4o2oRRkAWI4X4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3061627A36;
	Mon, 10 Jun 2013 19:17:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A63A827A35;
	Mon, 10 Jun 2013 19:17:28 +0000 (UTC)
In-Reply-To: <20130610172708.GH2091@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Mon, 10 Jun 2013 19:27:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 642C5C6E-D202-11E2-95A4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227363>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> With such a helper function this could be reduced to a single line:
>
>   test_string_equal "(master)" "$(__git_ps1)"
>
> without loss of functionality or debuggability, because in case of a
> failure it would output something like this (bikesheddable, of
> course):
>
>   Error:
>     expected: "(master)"
>     got: "((deadbeef...))"

Yeah, that looks sensible.
