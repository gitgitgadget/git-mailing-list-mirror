From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/2] bisect--helper: rewrite of check-term-format()
Date: Sat, 07 May 2016 19:25:23 -0700
Message-ID: <xmqq60up1e24.fsf@gitster.mtv.corp.google.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<xmqqtwia25qc.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOA9c8eQAacnuB1n=juOhN1zsMdzcupS3ijqwYFPRrW4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 04:25:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azEPX-0007uP-CN
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 04:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbcEHCZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 22:25:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751141AbcEHCZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 22:25:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DEA411964B;
	Sat,  7 May 2016 22:25:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h773drnbh4Ui2m2LC55peixEZE0=; b=RfFBFb
	hppHmsVu0M6VNIa2O8CRzibs/jbCM9kvq3yW8onGvqKtI8yb7A1Rso/JiR+/HLKS
	WZKgunjm/Dy5GT2RJf10ccFD5j5ImxdrKsDYgvTpFJhBegjsu75rCp3d2cPv/J6r
	UcIVf/xtnLTHujXXJtj/9DJ708LelizrSWC2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJ7PCgNJeMxg4+FgfXx/uhjxnQDWY9F6
	+XY7teTzeg3mPmXiENQmEBLVSKVzKxRb9hktcOQjdHD1JxL0Zod3Llyt1wRFfdm2
	6a8paBjFOZke4luDxSb4HaL/RWKK4UJ1i7zqeT11FhIBN6afDS8ThhejLrVhUnP5
	d82xn/xwgg4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D67BF1964A;
	Sat,  7 May 2016 22:25:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55EC419647;
	Sat,  7 May 2016 22:25:25 -0400 (EDT)
In-Reply-To: <CAFZEwPOA9c8eQAacnuB1n=juOhN1zsMdzcupS3ijqwYFPRrW4A@mail.gmail.com>
	(Pranit Bauva's message of "Sat, 7 May 2016 18:37:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1F662300-14C4-11E6-8A11-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293908>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> I completely missed your point and you want me to go the Eric Sunshine's way?

I am neutral.

When I read your response to Eric's "top down" suggestion, I didn't
quite get much more than "I started going this way, and I do not
want to change to the other direction.", which was what I had the
most trouble with.  If your justification for the approach to start
from building a tiny bottom layer that will need to be dismantled
soon and repeat that (which sounds somewhat wasteful) were more
convincing, I may have felt differently.
