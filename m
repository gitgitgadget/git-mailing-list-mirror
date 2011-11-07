From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: introduce a pull.rebase option to enable
 --rebase
Date: Mon, 07 Nov 2011 08:44:24 -0800
Message-ID: <7v39dz3ms7.fsf@alter.siamese.dyndns.org>
References: <7v8vnt7kvd.fsf@alter.siamese.dyndns.org>
 <1320573010-12296-1-git-send-email-avarab@gmail.com>
 <4EB6E5AD.7060605@kdbg.org>
 <CACBZZX5Lq7vunx-QnsrufQVWJ6xYPoMXnv+tMwhOC3XbrZO11A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Eric Herman <eric@freesa.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 17:44:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNSJF-0003aJ-6J
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 17:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726Ab1KGQo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 11:44:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51279 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755625Ab1KGQo1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 11:44:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98C1E4204;
	Mon,  7 Nov 2011 11:44:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=h+qdhl3DzxT2
	ZkEeHobXgWQaHow=; b=XcbfXNIVcSSvyfCZBV92rkjC8KZEI+Sb8YlYMlflLxTF
	yuqBLEZBeQftfn924omkVa9axg9WC534awyWm7TCR3sfOIHF4XaYBZhmA+dTdGq8
	M8G1xX1mUIebAhDrhd30nlGbvvTbartEVsyg4wze0+eyYURjvEhlfkKv9+VWftk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UUHpWf
	icDQLLQ0PudHBRST3/giutR1jfxgkTH7wu2rcDEnOKwA+hL/7MYqph3Qw1WRaEmv
	zAQyLx+qlKf02OVjK5mqqwUcjzmzmEkyEn1JyccKrXnz389pndfULfcioS/fBsQr
	VCjYUniQw54Q+vOkp/MsHdN7XqF6DGmIvvEj4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E6334203;
	Mon,  7 Nov 2011 11:44:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 250AE41F8; Mon,  7 Nov 2011
 11:44:26 -0500 (EST)
In-Reply-To: <CACBZZX5Lq7vunx-QnsrufQVWJ6xYPoMXnv+tMwhOC3XbrZO11A@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 7 Nov
 2011 13:44:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0F4DF6A-095F-11E1-93F5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184995>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Nov 6, 2011 at 20:53, Johannes Sixt <j6t@kdbg.org> wrote:
>> When you continue an indented item in a separate paragraph, then you
>> must not use an empty line, but have line with '+' and un-indented
>> continuation paragraphs. See examples in this file.
>
> Thanks for spotting that.
>
> Junio: Should I spam you with another patch or is something you'd
> prefer to just fix up?

It is about the same amount of work for me; I've just dedented the two
paragraphs that start with "*NOTE*:" and replaced the blank lines befor=
e
them with a single "+". Is that what you wanted to resend, or is there
anything else?
