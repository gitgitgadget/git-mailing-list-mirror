From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: Warn if clone lacks LICENSE or COPYING file
Date: Fri, 03 Apr 2015 14:26:34 -0700
Message-ID: <xmqqtwwwgayd.fsf@gitster.dls.corp.google.com>
References: <E1YZNn7-0002Lc-7O@rmm6prod02.runbox.com>
	<CACBZZX67igE67+y7Tme=_OC7JiT726qB4X18+8Mvg1ewssQ_ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dwheeler@dwheeler.com, git <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 23:26:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye971-00008B-FH
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbbDCV0m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2015 17:26:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752650AbbDCV0l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 17:26:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D38344DE4;
	Fri,  3 Apr 2015 17:26:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p0jHHdwM3WzO
	YLsX4ZdZttJISVA=; b=s0XBqExpqtg1lj4FUA5eOVEEDd/LlE2paUMZJkviDg9Z
	hSOraPS53bUQ9hAySA9ttnKafq/7SOd89NAWCsbaYMyBLkeVWfW/QvvePIoiHvsW
	RloI1wrPAY8j8u2PJO6MBF2/7mSOFT8mSUOr2KTUsXdpwMtdauKD4fLpCvUWV1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=U596lF
	QSw8xnfqhr6BIbi3Ll7H+Y4B0kLmSehs8zo97yeOc4nV5mhb1Ycg7RHLLJR5B4jH
	csztNLoiFNk8i7stuDtPoTCwHFgXPPBTsmF0TLIhI5c9m/EGMTE5EhCSq87fnBOS
	3PLdhPEnXdA1ktOwlG3S842b2FVC9dKqJiRjU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5033C44DE3;
	Fri,  3 Apr 2015 17:26:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C09CE44DE1;
	Fri,  3 Apr 2015 17:26:35 -0400 (EDT)
In-Reply-To: <CACBZZX67igE67+y7Tme=_OC7JiT726qB4X18+8Mvg1ewssQ_ug@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 22 Mar
 2015 18:56:52
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B45BA18-DA48-11E4-8030-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266730>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> As others have indicated here this feature is really specific to a
> single lint-like use-case and doesn't belong in clone as a built-in
> feature.
>
> However perhaps an interesting generalization of this would be
> something like a post-clone hook, obviously you couldn't store that i=
n
> .git/hooks/ like other githooks(5) since there's no repo yet,

Yes, and these things come from templates, and you can specify the
template source location when running "git clone".

So I do not think anything is needed on our side and it's all doable
with what the users already have, as long as we are talking about
making it only an opt-in feature.

Which means

> You could also just have a shell alias that wrapped git-clone...

is also perfectly acceptable, I would think.
