From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2013, #06; Fri, 25)
Date: Mon, 28 Oct 2013 09:41:35 -0700
Message-ID: <xmqqwqkxfiv4.fsf@gitster.dls.corp.google.com>
References: <xmqqeh79hr3o.fsf@gitster.dls.corp.google.com>
	<CACsJy8A3s4TUmUOC+i-k97GxxvBQ7mQmdoPJizfy1yS3rqLEkA@mail.gmail.com>
	<xmqq61shgzvn.fsf@gitster.dls.corp.google.com>
	<CAFFjANSnuS6_+uAd43AayojJyK-wj2wMxQ6DBD6JyN=A7xh2_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, Karsten Blees <blees@dcon.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Vicent =?utf-8?Q?Mart=C3=AD?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 17:41:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vapst-0006Wv-IZ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 17:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669Ab3J1Qlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Oct 2013 12:41:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab3J1Qli convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Oct 2013 12:41:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7B204E810;
	Mon, 28 Oct 2013 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JXz+XPS+/UEi
	58PPoTCxdfkUDak=; b=BhS+47e3kSTHQ8GVYnjOSA6KMOX9HTGdsm6UjFgE1MSc
	Ke+zTKf0GmA3KFDuXSCYAUSf4+CIpY/B4zBIzvXnVf1p7NbrqKK+STyHsLGzw4W+
	08UGYLBehJa6ASe/Bn/YScc5G+FxeI5a5sUDzsR8trDf+cKuLGPWUls12HLmHA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xh2uZA
	r+YioipevD72QBhCeU66H0y75pU8oEU5YZ6mbUOrmSfIZgb7Ta0KHDJierswyfgY
	JcKz/i7GlZbBz1PuBem00vOxDrN2+mxYvaefEEHsBnPCSNn+AIiGoGcSnkiPHjIi
	oIs1rIhHo6noVB5FaCeGNJJ9FumHp5HNcNXJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B45684E80F;
	Mon, 28 Oct 2013 16:41:37 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0523F4E80D;
	Mon, 28 Oct 2013 16:41:36 +0000 (UTC)
In-Reply-To: <CAFFjANSnuS6_+uAd43AayojJyK-wj2wMxQ6DBD6JyN=A7xh2_A@mail.gmail.com>
	("Vicent =?utf-8?Q?Mart=C3=AD=22's?= message of "Mon, 28 Oct 2013 17:16:02
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CFFB8036-3FEF-11E3-B0EC-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236839>

Vicent Mart=C3=AD <tanoku@gmail.com> writes:

> On Mon, Oct 28, 2013 at 4:48 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> jk/pack-bitmap adds khash.h, which from a first glance looks like y=
et
>>> another hash table implementation. I was just wondering if kb's new
>>> hash tables can cover the need of pack-bitmap.c too so we can remov=
e
>>> khash.h later..
>> ...
> khash on the other hand is capable of storing the position values as
> part of the hash table itself (i.e. `int **buckets`), and saves us
> from thousands of bytes of allocations + indirection.

My "Good thinking ;-)" comment was primarily meant as "somebody
needs to at least think about the possibility and consider pros and
cons", and you thought about it already ;-).

In short, kb's hash table does not cover the need for pack-bitmap,
so we should keep two at least for now, until (and/or unless) either
side can be shown (and/or extended) to cover the need for the other
one as well.

Thanks.=20
