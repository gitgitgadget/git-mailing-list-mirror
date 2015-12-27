From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/10] t5100-mailinfo.sh: use the $( ... ) construct for command substitution
Date: Sun, 27 Dec 2015 15:46:28 -0800
Message-ID: <xmqq7fjzbgkr.fsf@gitster.mtv.corp.google.com>
References: <1450798073-22811-1-git-send-email-gitter.spiros@gmail.com>
	<1450798073-22811-8-git-send-email-gitter.spiros@gmail.com>
	<567997E4.1000700@kdbg.org> <5679B3E2.7090406@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 00:47:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDL1p-0001U9-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 00:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbbL0Xqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2015 18:46:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752690AbbL0Xqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2015 18:46:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13390377F4;
	Sun, 27 Dec 2015 18:46:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e3gIRx4lwVCRgg917rAPayhdaQ0=; b=GNQma6
	Jn1TtQ4emwqpIgDgNvuLTi9zTyu+3v01qpGnaXcn1BhDP76w2HJIFxjdTdDhHx4O
	CkvxxsBJYA4u10WSKr3jGniZC1efIixI35iMAOq4dZKSj+T+AwivUeJYiCyckU7h
	y/wqGfb8fSaBjDqKVGB7pOCNgA1RjmhlfGfP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=anC60VobMD0v/WB29D3/FuBBTIrIhiik
	Ib7Chu+zRFQtmS0gneqWb3xhJjhWEWwMx24XUvhUwEiE/TiS7syVbrTq8Tf/kJp/
	dXGI2Tm2CfgXs3yXL9vggI5jT1Q/Am3G20ux8XuB1iOpadW2rwDu0dWd1a7PDBGZ
	QOU5+1r5cJs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 08AA2377F3;
	Sun, 27 Dec 2015 18:46:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6C34F377F1;
	Sun, 27 Dec 2015 18:46:29 -0500 (EST)
In-Reply-To: <5679B3E2.7090406@kdbg.org> (Johannes Sixt's message of "Tue, 22
	Dec 2015 21:34:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0CFCA866-ACF4-11E5-9112-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283023>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 22.12.2015 um 19:35 schrieb Johannes Sixt:
>> Am 22.12.2015 um 16:27 schrieb Elia Pinto:
>>> -for mail in `echo 00*`
>>> +for mail in $(echo 00*)
>>
>>> -for mail in `echo rfc2047/00*`
>>> +for mail in $(echo rfc2047/00*)
>>
>> True, these are equvalence transformations. But a better way to get rid
>> of the back-quotes is to write these lines as
>>
>> for mail in echo 00*
>> for mail in echo rfc2047/00*
>
> Ahem... both of these lines without the 'echo', of course!

Very true.  Let's leave that kind of things as separate clean-ups
after these patches settle, as mixing manual and mechanical changes
in a single patch makes it harder to review.

Thanks.
