From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Sun, 09 Jun 2013 15:56:19 -0700
Message-ID: <7vehcaopv0.fsf@alter.siamese.dyndns.org>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
	<20130607000006.GA25731@goldbirke>
	<CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
	<7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
	<20130607191643.GA31625@goldbirke>
	<7vwqq5snzi.fsf@alter.siamese.dyndns.org>
	<20130607204430.GD31625@goldbirke>
	<7vk3m5si4h.fsf@alter.siamese.dyndns.org>
	<20130608001147.GA32350@goldbirke>
	<7v1u8bouam.fsf@alter.siamese.dyndns.org>
	<20130609214833.GE2091@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 10 00:56:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UloXD-0000A7-La
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 00:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab3FIW4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 18:56:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311Ab3FIW4W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 18:56:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDF3B261F4;
	Sun,  9 Jun 2013 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gX39fc9GIYRy
	1FVtD9g3tRcnB7k=; b=pf60Dtio4UKmvVgA3vaNwHPn0IHVyhXJCm9N5ADWKJf0
	iDXtjTFsNJaJfOsc9HnMSec6XYB4oQxlHirQSqSPGWFgqnD7BjnOMcLotPOkHGla
	V+hIp84DAAmvVdYm6ynSZVyF+G1/+7CX0IeRemzhC/nATaV4FXhQS0Gd6Lgvqc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Xk/9Lk
	lC6dd8hQvRlZMi/S0Ygyg1yPDOOP1COp/B0yyFLf+YyiZMP0nB1EpSgCi7NE6v1W
	1w7PU5vicgogLLiloM2mVQFFW7mz8fcDj7tcvv/KquZ/StfZXfCF3i3rm6AvVU3M
	NZPSJpyj5zs0aJZ5g3JOeplpOesGhY2DQknj4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4C4D261F3;
	Sun,  9 Jun 2013 22:56:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69B9A261F0;
	Sun,  9 Jun 2013 22:56:21 +0000 (UTC)
In-Reply-To: <20130609214833.GE2091@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Sun, 9 Jun 2013 23:48:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD7D2168-D157-11E2-979E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227205>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> There still remain two users of __git_complete_file, completions for
>> "archive" and "ls-tree".  As these commands do not take range
>> notation, and "git show" no longer uses __git_complete_file, the
>> implementation of can be updated not to complete ranges, but that is
>
> "the implementation of" what?  A word missing perhaps?

it.

Thanks.
