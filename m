From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] perf: make the tests work in worktrees
Date: Tue, 31 May 2016 14:24:35 -0700
Message-ID: <xmqqa8j553ak.fsf@gitster.mtv.corp.google.com>
References: <cover.1462955446.git.johannes.schindelin@gmx.de>
	<cover.1463145936.git.johannes.schindelin@gmx.de>
	<0f0bc7ac7b6eebed22b05c277cf7352122d164d2.1463145936.git.johannes.schindelin@gmx.de>
	<574B1C3D.3000706@web.de>
	<alpine.DEB.2.20.1605301026430.4449@virtualbox>
	<xmqqr3cjo23d.fsf@gitster.mtv.corp.google.com>
	<574C8571.6080607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue May 31 23:24:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7r9X-00028P-75
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 23:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbcEaVYj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 17:24:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750813AbcEaVYj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 17:24:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9959D1F71D;
	Tue, 31 May 2016 17:24:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WGguxkR5+j6X
	zT0q+aawJieoYJo=; b=tn+elnE8SDeRXh/JorLp8e2dve7ltW1Oa+vYAf8oRLfB
	ChNFfLmi0tLrHjdiYY2fOvp7qMs63qrwmcPRjDVw/V2xj822sbz3NxyZfNrAVSFd
	DXbA+4nxGaOQQLbnfG4+LQTOPYGI77BZHRKNC/1GNCeGGNTbZ5ivFWoO2P4AKp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jMLS5F
	X+7tGaaFHzSHKQ0ebAnSNX/ZxKhaMaXvc4n1q6zkmXhy85BnKXs7COrbsq5cdBlT
	oNZYxdOx2s6NArznLCi0lKAde2028DiIse5LRRD8L3r5d+CZMGYKhZzNdoLLoFwZ
	4EOA3f5ZNxGtDXX+7IuWDEqmSZ8u4Po1rcpFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 927111F714;
	Tue, 31 May 2016 17:24:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D6791F712;
	Tue, 31 May 2016 17:24:37 -0400 (EDT)
In-Reply-To: <574C8571.6080607@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Mon, 30
	May 2016 20:24:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13AFF2E2-2776-11E6-B190-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296016>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> I fear that interacts badly with the `cd "$repo"` I introduced late=
r
>>> (replacing a `cd ..`)...
>
> Oh, right, it does if $repo is a relative path.
>
>> What do you want to do then?  For now before -rc1 we can revert the
>> whole thing so that we can get a tested thing that works in both
>> layouts.
>
> Put it in its own subshell, e.g. like this?

OK. I've squashed it and merged the result to 'next'.  We'll see if
anybody screams and merge it to 'master' before -rc2.

Thanks.
