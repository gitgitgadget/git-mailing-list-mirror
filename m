From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t5313: test bounds-checks of corrupted/malicious pack/idx files
Date: Thu, 25 Feb 2016 12:31:12 -0800
Message-ID: <xmqq4mcwo7lb.fsf@gitster.mtv.corp.google.com>
References: <20160225142004.GA17678@sigill.intra.peff.net>
	<20160225142112.GA17811@sigill.intra.peff.net>
	<56CF523A.8050208@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jacek Wielemborek <d33tah@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:31:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2ZJ-0006Cp-T2
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbcBYUbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:31:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751255AbcBYUbP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:31:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A4F6447A32;
	Thu, 25 Feb 2016 15:31:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vneiq2N74/MtGzzmu1FKF2BZv1o=; b=t60b1H
	jMlEtpSTR9JBVq/NdMKiuiosNXGwD+seVyrRMPv2KEFlLogCKDzgdDc2dwjzhjPL
	QnCuw9jWCbyzQ5k4mk3jabD+JIjIqgu52OWnX9qMEayNp5fIYhZcMxXwOdisip3r
	VgL4G0O9xfSU3hIl1P45t1SfiMjA2DHWXLgB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AWAs7FZ6TJOsBXmgJZpRalgcaz3l5jgs
	B/NGFXnsDc9uw1txC8o6aSzXVOOQBqptA2bDM6fCGLZYXDiPfw4N/G3Vugvkm8q3
	UW4OV7ih7jdoILhQVe89c+p2Sn16xvWsJGnJCfSLfKaHmLoNov7GXqSqjLtxHDjN
	Sc6VOHcPAX8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A83247A31;
	Thu, 25 Feb 2016 15:31:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 15A7047A30;
	Thu, 25 Feb 2016 15:31:14 -0500 (EST)
In-Reply-To: <56CF523A.8050208@kdbg.org> (Johannes Sixt's message of "Thu, 25
	Feb 2016 20:12:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6E11766-DBFE-11E5-AE4A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287433>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 25.02.2016 um 15:21 schrieb Jeff King:
>> +munge () {
>> +	printf "$3" | dd of="$1" bs=1 conv=notrunc seek=$2
>> +}
>
> Instead of adding another call of dd, would it be an option to insert
> the following patch at the front of this series and then use
> test_overwrite_bytes?

It would be an option, but I'd want to merge this to 'next' today
without waiting for a reroll.  Change from dd to custom script can
be done as a follow-up topic after the dust settles, if necessary.

Thanks.
