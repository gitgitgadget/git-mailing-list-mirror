From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Thu, 23 Dec 2010 09:17:52 -0800
Message-ID: <7vfwto2ytb.fsf@alter.siamese.dyndns.org>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
 <AANLkTinH0h5euL=_wMpGirVEEYgoA9hXGhKGja9oPa2j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 18:18:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVonp-0000Rn-68
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 18:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424Ab0LWRSD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Dec 2010 12:18:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab0LWRSB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Dec 2010 12:18:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25B55321B;
	Thu, 23 Dec 2010 12:18:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tU6+jGMqZhHU
	KfPS3zLDOZI/zEk=; b=dWoZ3lBsUSDzQlvG0aX+LT7fLfUZF6mPWPdcukiDD18X
	9GT/pCQKUq5EHLdUAAFKyrXVqzQykXgfUBN4x/kNRCvrskMp6lUItlk7rigonkmi
	qPyO0Gts9jf3G3wTsIi/wThhG5Qh0oPonI1uU02SpjiXELdJmtI+Va6Sl0UcwUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YBbWzC
	ivcrfU//WSX3DgEnab28WMnd1Ioq2FYmEWkExc143vJcL8tzsPHH91Cjjj5APdkr
	rjOooBxZUlAyTNU0Tysm2dmUIVSer6OX6WqFxVu8PE8EgVv/eN3uT2+uP+qPW6zK
	Aayi8mn8REbTT92LzjbdU3hVboN9+IOzkpiDk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 038183219;
	Thu, 23 Dec 2010 12:18:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 212A93218; Thu, 23 Dec 2010
 12:18:23 -0500 (EST)
In-Reply-To: <AANLkTinH0h5euL=_wMpGirVEEYgoA9hXGhKGja9oPa2j@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Thu\, 23 Dec 2010 23\:32\:42 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A799C8CA-0EB8-11E0-A391-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164132>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Dec 22, 2010 at 8:59 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> * nd/struct-pathspec (2010-12-15) 21 commits
>> =C2=A0...
>> =C2=A0(this branch is used by en/object-list-with-pathspec.)
>>
>> Rerolled again. =C2=A0Getting nicer by the round ;-)
>
> With jj/icase-directory merged to master, match_pathspec() and
> match_pathspec_depth() now diverse again.
>
> When I wrote match_pathspec_depth(), I assumed that match_pathspec()
> would not change much and I would have more time for converting the
> rest of git to use match_*_depth(). Looks like I need to add case
> insensitive matching to struct pathspec and friends then remove
> match_pathspec() in this series too. At least if somebody changes
> match_pathspec() again, it would cause a conflict so I can catch it.

While this topic is something I have long wanted to see, I have started
feeling that this needs to cook a bit longer than be in the next releas=
e.
So perhaps the best course of action might be to rebase the series once
after the 1.7.4 feature freeze, cook it in 'next' for a while and make =
it
part of the release after that.  I think at that point we may probably
want to have other changes that are not strictly backward compatible bu=
t
their incompatibilities do not matter in practice (e.g. cquoting pathsp=
ecs
in the attributes file comes to mind, but I am sure there will be other
changes that people wanted to have but we held them off due to worries =
on
compatibility).

What do you think?
