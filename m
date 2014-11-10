From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/5] builtin/notes: Add --allow-empty, to allow storing empty notes
Date: Mon, 10 Nov 2014 12:18:14 -0800
Message-ID: <xmqqr3xa95dl.fsf@gitster.dls.corp.google.com>
References: <1415351961-31567-1-git-send-email-johan@herland.net>
	<1415351961-31567-4-git-send-email-johan@herland.net>
	<xmqq1tpehopp.fsf@gitster.dls.corp.google.com>
	<CALKQrgdFDHUc8JzH3XnwvnHdEZOhUN=EmrWXKKDLd+6MG7jMKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:18:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnvPq-00071F-Az
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 21:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbaKJUSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 15:18:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750923AbaKJUSR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 15:18:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBACC1CA82;
	Mon, 10 Nov 2014 15:18:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fsCR0t2Fv+PxJHGRyroHzEjTftU=; b=PRmJdJ
	f33hVpCKq9XRQJNp+Bgks2EO2NKn7ye1/WCijeDy8aY+C7dp7KgGZH3GJfoEgdBM
	XFQHRXx76fQkuLLoxqJFINKMSs96I2SQuPM6wq5iplhS2IFvfEd/MEKAuK8SLtSY
	wKFBuNZ+akrdOqHdjh2Y8XXcW0xAkSumif2VM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NaulnoqMfGABsV6Cs8FNtASDe1Gu+84h
	5oBwyipmDCs2gCdp5W4NL7sZEf3G3PpT4+pE3AMfKFfiEbi+nAnKEFr69jht+BHd
	Oh5Vagwi+Ebt/eEnKwPaymD/Gu0Sv531YZSz+yeyTZ/9wQQmkPXBQEUtJDYXTfiA
	H14FXQPc15c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF0571CA81;
	Mon, 10 Nov 2014 15:18:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 506291CA7F;
	Mon, 10 Nov 2014 15:18:15 -0500 (EST)
In-Reply-To: <CALKQrgdFDHUc8JzH3XnwvnHdEZOhUN=EmrWXKKDLd+6MG7jMKw@mail.gmail.com>
	(Johan Herland's message of "Sun, 9 Nov 2014 13:31:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B3B94934-6916-11E4-8A44-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> On Fri, Nov 7, 2014 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> In other words, I have this suspicion that create_note() that
>> removes is a wrong interface in the first place, and giving it
>> a new allow_empty parameter to conditionally perform removal is
>> making it worse.  No?
>
> I agree, and it's fixed in the re-roll. It turned into a slightly
> larger rewrite than anticipated, but I'm fairly happy with the result.

;-)
