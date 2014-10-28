From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/15] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Tue, 28 Oct 2014 11:40:14 -0700
Message-ID: <xmqqtx2ojawh.fsf@gitster.dls.corp.google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-2-git-send-email-sahlberg@google.com>
	<xmqqy4s6smwz.fsf@gitster.dls.corp.google.com>
	<CAL=YDWm0-6rNrmm2xG18qf9DrAoEOVdtE_o0onQUGu14AwTRxQ@mail.gmail.com>
	<xmqqh9yusmd3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 20:12:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjCBr-0003y1-6l
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 20:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbaJ1TMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 15:12:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750722AbaJ1TMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 15:12:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86AE0189B1;
	Tue, 28 Oct 2014 15:12:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Atp24UAxxUpnjx0B+XqLeeDebqA=; b=xT0vhb
	ln59jBaxzGfjAo3nozciufP9cP6arlVpJm2DA3ZlEkp3UNXcybDe4NzQBDxUZmVN
	fq9ZrX053xI99QCNW/3ueKNlKvcuW3jkiKDmGDVV5Crq9VGJuIzdzctOz6S6SfJW
	Dssl1wJgEWP/YLOTnU3qlllzADbdD+BS7lrnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IiVm5ArsJpwR++aIeIk1vGXxPlu4aWkD
	uCv7G3jtHKsKKW7AhBuWJddsYnFn2FVscz5sEgdm+F2XTpYYKuTz2OvHQNuQAHki
	64pLkMEMu5CN7UskJv0OusPcZuR2VHMQ54fhy/c++MzgCPRRkvnunve/WhggzMpu
	cwcTqJAFE8Y=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D9C8189AF;
	Tue, 28 Oct 2014 15:12:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57684181B5;
	Tue, 28 Oct 2014 14:40:16 -0400 (EDT)
In-Reply-To: <xmqqh9yusmd3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 23 Oct 2014 10:54:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC3D0638-5ED1-11E4-996F-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> On Thu, Oct 23, 2014 at 10:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Ronnie Sahlberg <sahlberg@google.com> writes:
>>>
>>>> Subject: Re: [PATCH 01/15] refs.c make ref_transaction_create a
>>>> wrapper to ref_transaction_update
>>>
>>> Missing colon after "refs.c"
>>> ...
>>>> Change-Id: I687dd47cc4f4e06766e8313b4fd1b07cd4a56c1a
>>>
>>> Please don't leak local housekeeping details into the official
>>> history.
>>
>> Ah, Ok.
>>
>> Do you want me to re-send the series with these lines deleted ?
>
> When the series is rerolled, I'd like to see these crufts gone.
>
> But please do not re-send the series without waiting for further
> reviews and making necessary updates, if any.  Otherwise it will
> only make extra busywork for you and me.

I've read thru 01/15 (i.e. this first series out of the three) and
have no further comments so far.  There are a few questions I asked
that haven't been answered, and hopefully others will help to move
this series forward by lending eyeballs further.

Thanks.
