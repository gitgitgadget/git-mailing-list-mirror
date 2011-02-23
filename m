From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/73] No-op gettextize core Git C programs
Date: Tue, 22 Feb 2011 17:37:36 -0800
Message-ID: <7vwrkra5un.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-1-git-send-email-avarab@gmail.com>
 <7v1v2zbmn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 02:37:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps3fs-0005By-9a
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 02:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815Ab1BWBhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 20:37:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab1BWBhq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 20:37:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B99944E0E;
	Tue, 22 Feb 2011 20:38:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jJdnoN565+gU
	2FqsKCA244dqbOM=; b=Wv3JNQanDRwPnUq8axOsWfBjPUZUIYeZ6dVHWh7kFwGr
	SDUj92heLHwaXDaz+yXR2BgAkmTt3HwLQmsLZ6bAdTqLz2baeuRHmN4QQG7EjXt/
	QQckG8HNeoYfyFRoBqIOGXwc3R1eDiwJcasOfK9Rw1yC44g/e2yYAkJToKu9GuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nU+jvv
	ZX+wJRjot/Pld2BupRv9a4Sv1LiIM+D1gfbs28ONLFPJf3P/JABquomkRWsPQCls
	guByb8b3lvoo7AY2ZyiXMbiVAmNYVgiFhN2r2GJypobASyFt34YVC8WuoaEvLJGA
	JV1P/bHLIor3jOc3ClOAo9noQPFSGR9QZAT+0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 875BA4E0B;
	Tue, 22 Feb 2011 20:38:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 677434E09; Tue, 22 Feb 2011
 20:38:50 -0500 (EST)
In-Reply-To: <7v1v2zbmn9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 22 Feb 2011 16\:49\:30 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC9B749E-3EED-11E0-9613-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167671>

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>   * Reverted back to using the "gettextize" patch subjects I
>>     originally used. I'm using these consistetly so I can later git
>>     log --grep=3Dgettextize: to find them. I'd like to preserve that
>>     attributed.
>
> Can we make that shorter, perhaps just "i18n:"?  In this series, your
> first three and Jonathan's are oddballs that do not have "gettexize:"
> anyway.
>
> Will give it a whirl.  Thanks.

It was a slightly unpleasant experience to merge this round to 'pu' (af=
ter
excluding the earlier round from it, of course), as a few topics in fli=
ght
that reorganized existing functions into smaller helpers had to conflic=
t
with this patch.  I tried to be careful but please double check the res=
ult,
perhaps with:

    $ git show --first-parent origin/pu

when it is propagated to mirrors.

Thanks.
