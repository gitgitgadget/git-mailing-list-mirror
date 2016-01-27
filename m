From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/6] worktree: new repo extension to manage worktree behaviors
Date: Wed, 27 Jan 2016 14:12:52 -0800
Message-ID: <xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, max@max630.net, git@drmicha.warpmail.net,
	Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:13:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOYLO-0000AI-SU
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 23:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966263AbcA0WNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2016 17:13:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966569AbcA0WMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 17:12:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C1483E171;
	Wed, 27 Jan 2016 17:12:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WMS6ZKBAChUM
	ylOetGB+QsiZskk=; b=psQZ1VVx5vWVqwrEFIU4vellD/H+M+s9iejMwKfOHmR4
	fCWneULakZfDVz1VfsIytbVOhcmjg3qthtEj0XKVAy/8SuSivODmj+vHexRLl7Tz
	zJU1oh5vnq2i+cstMPEvqaLl7+3lCtl2ySpFFq6+r4R1+Za6uLNHzhQZyHHEugQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=m298ym
	J6LKb7HRBuF8h7newZlTNELDRfwthNhZEdyqaq4hp4BsGUsvVuCpLiXXW9G8A54Q
	Iopi8VhtPD9CyG54HhiY3B4EU6MBb2wLPoeU+heIU3Gs84KTXcjR8bbKnEnYVJqf
	vLQad6s0Gqfm6+lFG5lCqgOknYnkt9L2C1i9A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 135BA3E16F;
	Wed, 27 Jan 2016 17:12:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6ED493E16E;
	Wed, 27 Jan 2016 17:12:53 -0500 (EST)
In-Reply-To: <1453808685-21235-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 26
 Jan 2016 18:44:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C7179F4-C543-11E5-9714-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Multiple worktree setup is still evolving and its behavior may be
> changed in future. But we do not want to break existing worktree

s/be changed/change/

> setups. A new set of extensions, worktree=3DX, is recognized to tell =
Git
> what multiple worktree "version" is being used so that Git can
> behavior accordingly.

s/behavior/behave/

> +WORKTREE VERSIONS AND MIGRATION
> +-------------------------------
> +Multiple worktree is still an experimental feature and evolving. Eve=
ry
> +time the behavior is changed, the "worktree version" is stepped
> +up. Worktree version is stored as a configuration variable
> +extensions.worktree.

s/stepped up/incremented/

More seriously, are we confident that the overall worktree support
is mature enough by now that once we add an experimental feature X
at version 1, we can promise to keep maintaining it forever at
version N for any positive integer N?  I hate to sound overly
negative, but I am getting an impression that we are not quite
there, and it is still not ready for production use.

It would be beneficial both for us and our users if we can keep our
hand untied for at least several more releases to allow us try
various random experimental features, fully intending to drop any of
them if the ideas do not pan out.
