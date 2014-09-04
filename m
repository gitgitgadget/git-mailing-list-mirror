From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git format-patch --in-reply-to allows header injection. Intended?
Date: Thu, 04 Sep 2014 16:59:49 -0700
Message-ID: <xmqqd2bbq6mi.fsf@gitster.dls.corp.google.com>
References: <5408D7ED.9010203@nh2.me>
	<xmqqppfbqd9x.fsf@gitster.dls.corp.google.com>
	<5408DCC5.8000607@nh2.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, petr.mvd@gmail.com
To: Niklas =?utf-8?Q?Hamb=C3=BCchen?= <mail@nh2.me>
X-From: git-owner@vger.kernel.org Fri Sep 05 01:59:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPgwW-0002uE-Hi
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 01:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbaIDX7w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2014 19:59:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61357 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754308AbaIDX7v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 19:59:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5BF4B3847F;
	Thu,  4 Sep 2014 19:59:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nydUzhqd1hGe
	nfjfphCEJNgLinU=; b=Z7Ya2SFWtCnra83L9Gi2vFPWSbEnWX4z2XQYadKMtirq
	Se7tttp74Vu45MfXiGeu44aMEh6rr6CmNb5IAA1jSl/1Nvkkisa+7U7TTWSQ/cGD
	hMt8PodJE/0rrlWCWhQqXCFYcQ9pTsbNRgsxYzJq6Ogd7tHoW+a0LLDfy7vJoh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nP40f3
	ohRYdz01XMOw8qC/+PA42vPxrCA4B2V/lSbm871TsDzHsglkeibrtd7yeioGv/V0
	BYCuQPENF4RNLdF+k6wJBLsC1QaajPHHoUU51wu+O5HP9AZee1mCeM8Wzl5G3HJw
	A7fvzlhRQn5T0TL0yRM8wK3rVRss41apDGQW0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5372D3847E;
	Thu,  4 Sep 2014 19:59:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D15753847D;
	Thu,  4 Sep 2014 19:59:50 -0400 (EDT)
In-Reply-To: <5408DCC5.8000607@nh2.me> ("Niklas =?utf-8?Q?Hamb=C3=BCchen?=
 =?utf-8?Q?=22's?= message of "Thu,
	04 Sep 2014 23:42:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8ECBEFCA-348F-11E4-A666-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256492>

Niklas Hamb=C3=BCchen <mail@nh2.me> writes:

> On 04/09/14 23:36, Junio C Hamano wrote:
>> While I do not think of a reason to specify such a string to the
>> in-reply-to option (I'd rather edit the output in the editor if I
>> wanted to do anything fancy [*1*]), I do not think there is a reason
>> why you want to add a code to forbid such use, either.
>
> My question was to find out whether I can pass untrusted user input t=
o
> ...

Ah, in general, anybody who passes unvetted user input to any Git
Porcelain deserves what s/he gets, so perhaps you would want to at
least make sure that the input is a single line, or something.
