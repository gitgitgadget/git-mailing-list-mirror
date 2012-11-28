From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 p2 3/9] transport-helper: trivial code shuffle
Date: Tue, 27 Nov 2012 17:54:25 -0800
Message-ID: <7vwqx6jxv2.fsf@alter.siamese.dyndns.org>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
 <1353727520-26039-4-git-send-email-felipe.contreras@gmail.com>
 <7vk3t7nfql.fsf@alter.siamese.dyndns.org>
 <CAMP44s0fmt+bHN-ycza8b+y8Ep-Cyqmg1U1PVas267fTY5iPPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:54:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWrP-00079R-Rw
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274Ab2K1Byc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:54:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32921 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636Ab2K1Bya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:54:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7058A50A;
	Tue, 27 Nov 2012 20:54:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+rRAKecsANsEJ1l1t9Z5rqZObo8=; b=Hflbrt
	KHSaxP5V9Er9EUllWkVSRY4FEPJwnedIcp42iPjEWRS0OT1p8/mU2YFsyU8MmesP
	/NwzUORtRA89rwVSDd6ixiyvMNO3Zv5PdeFekjbL2la7G6sUKp1B8MPqQIPLMBQg
	NjUQQKM8lsIDm9GcEDyY4jvL7hPKXdjk0e+tA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k5ixNWXLSyDM342L0tgT77Foz1gq+M7C
	US8f/qIAaNQMfaTdJ7xzSg33AI9okMxF448t2NH6Uw68qI2KnG0dGyT5pGSqFxNt
	rcJNpMTW/Ojf0IFw/wFp5BwXJRRRLrQxNQGzvXx1Qg/WunLRoBGy/d5QwV38LKUb
	LZcFD1JE5aU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B50DCA509;
	Tue, 27 Nov 2012 20:54:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36BD4A506; Tue, 27 Nov 2012
 20:54:27 -0500 (EST)
In-Reply-To: <CAMP44s0fmt+bHN-ycza8b+y8Ep-Cyqmg1U1PVas267fTY5iPPQ@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 28 Nov 2012 01:05:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A9781D2-38FE-11E2-A8E3-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210661>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> This is not just "just shuffle the die to make it explicit" but it
>> does change the semantics; earlier ref->deletion was perfectly fine
>> as long as data->refspecs is not given, but the new code always
>> dies.
>>
>> If this semantic change is a good thing, please explain why it is so
>> in the log message.  If the change is "it does not matter because
>> when data->refspecs is not given and ref->deletion is set, we die
>> later elsewhere in the code anyway", then it needs to be described.
>
> refspecs are optional, but when they are not present the code doesn't
> work at all. This patch changes the behavior that was totally broken
> anyway.

In case it was not clear, I did not request/expect responses in the
discussion thread, but a rerolled series with updated description.

Thanks.
