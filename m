From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] Split .git/config in multiple worktree setup
Date: Wed, 27 Jan 2016 14:23:34 -0800
Message-ID: <xmqq37ti7jbt.fsf@gitster.mtv.corp.google.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, max@max630.net, git@drmicha.warpmail.net,
	Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:23:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOYV3-0006zI-BS
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 23:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936257AbcA0WXi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2016 17:23:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934363AbcA0WXg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 17:23:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C96783E3F9;
	Wed, 27 Jan 2016 17:23:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Zwmc5anhvRjq
	0Il9N1iaNwljgRE=; b=N2ch4LRfREfDFEvUeB8n4XUpfByrh9/3cew/USJDHbqH
	Xyi4VPSHHrnPQqmIpb8m5+aMV0X6HL9D2MXHkmu1n0eiD1UYpsLXdNJgAwUlJnDy
	KgAyn+oa1iGoq4alCOe00FgHFi/0f07ufnj3wysPyWCciZ4K6YdfCfm3rFvj8Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aVYOqX
	ALBK35py8a1qCN/UklplrRx7Uutg6Qb/1WRAyALPnDZX+sKRKJKqXA+yv2Sb4Mme
	xFZ37Y+ryrHBOG+UyFhZB+bGIgUkGneoRpSTRWWnZSMWhHO16wE9ieoKBpZ834lf
	MwVimdWCTgrXofNQFUeZzibqC9LFLlMYwQ+XM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B13533E3F8;
	Wed, 27 Jan 2016 17:23:35 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0A5323E3F5;
	Wed, 27 Jan 2016 17:23:35 -0500 (EST)
In-Reply-To: <1453808685-21235-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 26
 Jan 2016 18:44:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9ADC6A64-C544-11E5-B22C-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> For any worktree, the new file .git/common/config is read first, then
> either .git/config or .git/worktrees/xxx/config is read after. There'=
s
> no special per-worktree var list any more. Which is great. You want t=
o
> add per-worktree config vars, use "git config --local". You want to
> add per-repo config vars, use (new) "git config --repo". You put a
> variable in a wrong file, you're punished for it (and it's the same
> today, say if you put core.worktree to /etc/gitconfig).

I think this is saner than the one before.
