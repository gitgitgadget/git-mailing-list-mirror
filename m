From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: fixes for older versions of bzr
Date: Fri, 17 May 2013 11:45:12 -0700
Message-ID: <7vli7dxx6v.fsf@alter.siamese.dyndns.org>
References: <1368810619-18419-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s1-RdmM9vs=XSvN1KNOh92Zr=nJWHGR0MZZV9BFXG_3JQ@mail.gmail.com>
	<7v7gixzdsj.fsf@alter.siamese.dyndns.org>
	<CAMP44s0WbkaWsU+VOCsd2THEQJkTU-67_z5Kb37j=gS9U1MV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 20:45:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdPec-0002ID-1R
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 20:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab3EQSpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 14:45:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307Ab3EQSpP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 14:45:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B915E1D988;
	Fri, 17 May 2013 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aOHCM8Hd753PDs4GYYc/w0ZyzMw=; b=B6Kj9f
	1Vh1lyWMNTGfqOGA0Co/xipcGJLYpalJJmLo8Iiv+EH/r4VNQkOOX3163LyKYOKc
	KTNZJQwnVZ7kvIt3is1L6ezQi/uB57eN/1vcFfKkbU22F+NFaHq+6HvNKI652kPk
	5houl/wR9GzRCpYZK+8qeW9WghEkUWYFzKtPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jxEqANzVRm+EcN3WUZPBKm5OqDRUVFDd
	VlrJJpfOtP/W01m7h1q8VVAYA7PWC8TuTcsEEW05VQ1lLtrXFP55ZSbr0UffTzAr
	QgYUHgSbkpiW6cZsVRHS/8At9pic/6jpIFZgGS8b+mUSNeDjnjXdSAESRk53b0CU
	JAqlmyP4iy8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0DAF1D987;
	Fri, 17 May 2013 18:45:14 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E78B1D986;
	Fri, 17 May 2013 18:45:14 +0000 (UTC)
In-Reply-To: <CAMP44s0WbkaWsU+VOCsd2THEQJkTU-67_z5Kb37j=gS9U1MV2Q@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 17 May 2013 13:20:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E92C4148-BF21-11E2-9C86-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224730>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, May 17, 2013 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Fri, May 17, 2013 at 12:10 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> Up to v2.0.
>>
>> Is that "down to v2.0"?



Is that 'down to v2.0'?



>>
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>>  contrib/remote-helpers/git-remote-bzr | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> We want this for v1.8.3, otherwise it wouldn't work in older versions of bzr.
>>
>> I take it that somebody tested this with both new and old versions
>> so that the old way you rewrote the code with is still supported by
>> the more recent ones.
>
> Yeah. I wrote a script that tests in a bunch of versions.

Nice to know ;-)

>
> Also, I'm fiddling with travis-ci:
> https://travis-ci.org/felipec/git/builds/7258332
