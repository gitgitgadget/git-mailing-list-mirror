From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] t5520: test --rebase with multiple branches
Date: Mon, 04 May 2015 12:24:57 -0700
Message-ID: <xmqqmw1krvqu.fsf@gitster.dls.corp.google.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
	<1430581035-29464-6-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbSMbhW2FLK05CaQjJjSTqEurB8iyeEBgyA1wbWJ4g2vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 04 21:25:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpLzE-0006aM-Ih
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 21:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbbEDTZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 15:25:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751078AbbEDTY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 15:24:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB0664DCD0;
	Mon,  4 May 2015 15:24:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wk50zsXXvKm6qn/sbkjqmrx7W0k=; b=mahBFc
	Tr1BrfqdeJYyEG8IYywEtngAY7DBHJ4xF8mUTI1c2Xew1dH7X9vu+3T5swQ8mXyN
	BcB3GVUEm4+N7DdJ2sStseY5dtKqYoWIMdOBCd724ka4zMSp4hmSwx5V5flX+GhH
	bdLL0kVsJ3UNs9kspjzknso+MpWz8IkDvABSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DMhSZfaQBlxmTUatD5KBreJy01qZ3T6i
	ZMilwWHT3CTEqb+UWh5RGddWygtGEwCkXx5o5NOz1s6CJcnp6u1f6n5mKi9uhlAD
	z2IfR1gSvFtskfkjU1ZDSgIf+QaF852eMWU+3DDEtzjsQ61SOail0fIA6ykoDvLc
	SRRSN2xiofY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C2B104DCCF;
	Mon,  4 May 2015 15:24:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 376A54DCCD;
	Mon,  4 May 2015 15:24:58 -0400 (EDT)
In-Reply-To: <CAGZ79kbSMbhW2FLK05CaQjJjSTqEurB8iyeEBgyA1wbWJ4g2vw@mail.gmail.com>
	(Stefan Beller's message of "Mon, 4 May 2015 10:09:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4064F256-F293-11E4-A9F9-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268342>

Stefan Beller <sbeller@google.com> writes:

>> +test_expect_success '--rebase fails with multiple branches' '
>> +       git reset --hard before-rebase &&
>> +       test_must_fail git pull --rebase . copy master 2>out &&
>> +       test_when_finished "rm -f out" &&
>
> I think it would make sense to switch the previous 2 lines, because the
> test_when_finished should also be run if the test actually fails.

Excellent.  Thanks for carefully reading patches.
