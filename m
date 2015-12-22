From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Tue, 22 Dec 2015 10:13:03 -0800
Message-ID: <xmqqd1tye4i8.fsf@gitster.mtv.corp.google.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
	<1450597819-26278-1-git-send-email-pclouds@gmail.com>
	<xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
	<CACsJy8A5AcRj2HiLe3PQijhYcHMzJ6eEuMyeVTMvPtXvMg_Sug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 19:13:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBRRV-0002aH-8H
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 19:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933267AbbLVSNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 13:13:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933145AbbLVSNG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 13:13:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CB1C362B3;
	Tue, 22 Dec 2015 13:13:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YGfJ/Dukl7Uy35amuM3ltshXDBo=; b=Qu/Vxe
	Lt4H6KbTnWl1HbkAl2fBsIqqab4njKWBS0aPmSOzVl/pftgiGJ4kCbaZketSBTmm
	7t4rOq8d0X9XvzYM2doolt7D5OjPcLtxFElY1zaNsyIBlyxhWRIWUtstLYB+dnKQ
	QRcW8OHKhhfTuO6f7wE+irq+uE2DIoslPO2eo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sK7LJ3jEHBlw8SZuB8qJs9HEYXFocgCR
	T+31RtZokw0dbyKzNRr11DEa+rU/qko1GCulzm2cO4XnaExIyheXlOYSKbfLFj/c
	HMJqdLe1ytEbdhLDmTzky1M8uswKLWqrru6zPbdxZmyUWcOASUqZU8hwpFjVR/VL
	akE6SkWSbuw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 64CFE362B2;
	Tue, 22 Dec 2015 13:13:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D2D51362B0;
	Tue, 22 Dec 2015 13:13:04 -0500 (EST)
In-Reply-To: <CACsJy8A5AcRj2HiLe3PQijhYcHMzJ6eEuMyeVTMvPtXvMg_Sug@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 22 Dec 2015 18:53:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A5439C72-A8D7-11E5-AEFD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282894>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Dec 22, 2015 at 5:57 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Dec 22, 2015 at 4:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Thanks.  I wiggled these three on top of the "Revert the earlier
>>> one"; while I think the result is correct, I'd appreciate if you can
>>> double check the result when I push the topic out later today.
>>
>> Looks good. "prove" passed too by the way.
>
> Another by the way, this "forcing aliases as external commands" now
> shows something like "error: git-log died of signal 13" when the pager
> exits early, for an alias like "l1 = log --oneline".

... and we do not show that when we directly call "git log" is...?

We do signal this with non-zero exit status like so:

	$ GIT_PAGER=true git log --oneline ; echo $?
        141

and it is not surprising that the one that is catching the exit
status of what was spawned and reporting "signal 13".
