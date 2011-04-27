From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] Use floating point for --dirstat percentages
Date: Tue, 26 Apr 2011 22:20:38 -0700
Message-ID: <7voc3s9snt.fsf@alter.siamese.dyndns.org>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-6-git-send-email-johan@herland.net>
 <7vpqo9ez03.fsf@alter.siamese.dyndns.org>
 <201104270402.29085.johan@herland.net>
 <7vipu0b8zy.fsf@alter.siamese.dyndns.org>
 <BANLkTikWhRiDaojR2NipcP0kpP49we5iUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 07:20:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QExBK-0004co-39
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 07:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab1D0FUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 01:20:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab1D0FUx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 01:20:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B42105CB2;
	Wed, 27 Apr 2011 01:22:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VGcSxnb5rIQywcyGf1KvMq0Pa/I=; b=kQ3WNK
	3CilrF3tHiLTk6HXjcQNqB8VG3s6egUCFuE5l7kzlS+uw7ruCJOyyXVPTUsNs9RD
	Xobb9bj/QmZwb0PJjjJrraS5qsoBMZnWuJhh1wscvodsKjJbd745x4JXjt90ePul
	6svLV+lCUodTL6ReqVn/6j3v1Nbmd/6LBfEVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MjdSd2fDq3OXMcjtJWwd0hFepn38lsvb
	ymwbt07zji0Y+IqrVUoBthaXsDMbTVyo7+voBpKVpgMYgl+AwRL56XeYdPAUflyJ
	dBYVenOiVKkU034au2NNQfLe+QdGd7sSVIPeC01ZF2BsYzbTmtoZ86e/9na6KN9w
	u+8YIM2cB0w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 81A885CB1;
	Wed, 27 Apr 2011 01:22:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 706C45CB0; Wed, 27 Apr 2011
 01:22:43 -0400 (EDT)
In-Reply-To: <BANLkTikWhRiDaojR2NipcP0kpP49we5iUQ@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 26 Apr 2011 21:53:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6347908E-708E-11E0-A446-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172173>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So instead of actually using floating point, just parsing a single
> digit worth of fractional percent would be beautiful. IOW, being able
> to say
>
>   --dirstat=1.5
>
> to give a 1.5% cut-off point would be really nice - but then
> internally just saying "15 permille" and using integers all the way?

Makes perfect sense to me.
