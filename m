From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Sun, 12 Jun 2011 14:29:07 -0700
Message-ID: <7v8vt6spr0.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <4DF10ADA.5070206@alum.mit.edu> <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
 <20110609200403.GA3955@sigill.intra.peff.net>
 <7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
 <BANLkTin_NYZ39s7gXbVrbAZU=+fzRCHdcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Sun Jun 12 23:29:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVsDq-0004r8-8Y
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 23:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab1FLV3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 17:29:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab1FLV3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 17:29:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C56B5444;
	Sun, 12 Jun 2011 17:31:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iGoFGf97u7YmQUIWOY1wXl7BCfA=; b=Nkw4B0
	gR1LVnbkDmKNx0n452nsvZZ/PVCWXBiPXh1WnRe34lP1S4pfnVwTxqb9jPSWbraJ
	S6Nzb+F9yA/+54hYttgG+7DT2OdyLp/fT1kBHuPo3jFKMVnIZp8Vq5ya1XliFn8k
	skAqUUCWDDSySZTL3PKLNF5ZKDJuQeP5RaGWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f3tUHoXn4+QZ4WllNjWB5pcFp6f6+wVZ
	Jvv1Ua2edUOtZReIeczFOd84mjx5r7KH59xhIEujh4yrSmf3ryQsIjThpwzYL+wQ
	p2QmDfzAg4K/kqE1dTTtM68Iko1A1YdCNektJwTAcmxs9FmeDY5SFSXGfOut7mpC
	sH6HFMP1RAU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C0E05440;
	Sun, 12 Jun 2011 17:31:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0CEEC543D; Sun, 12 Jun 2011
 17:31:18 -0400 (EDT)
In-Reply-To: <BANLkTin_NYZ39s7gXbVrbAZU=+fzRCHdcA@mail.gmail.com> (Michael
 Nahas's message of "Sun, 12 Jun 2011 09:30:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 543A0CB2-953B-11E0-BEC7-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175667>

Michael Nahas <mike.nahas@gmail.com> writes:

> It is clear that implementing NEXT/WTREE will worsen the performance
> of some commands ("git diff" under merge conflict).

It is not clear to me at all. I generally do not to base my first
objection on performance. When I have problems with proposals at the
design and concept level, I do not have a chance to even bother about
performance aspect, before questioning the proposal.
