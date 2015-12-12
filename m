From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/16] refs: add methods for misc ref operations
Date: Fri, 11 Dec 2015 16:23:01 -0800
Message-ID: <xmqqegescy6y.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-3-git-send-email-dturner@twopensource.com>
	<xmqqmvtgd06p.fsf@gitster.mtv.corp.google.com>
	<1449877765.1678.2.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 01:23:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Xxu-0003fu-UR
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 01:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbbLLAXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 19:23:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752633AbbLLAXE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 19:23:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6FF5F34627;
	Fri, 11 Dec 2015 19:23:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5IhBd+qbA6O+QT0UyXdVo7mqh+w=; b=ZCv3En
	P3dwFsZhcZ0qqsGQ4SDeFo4DlnEgrPmrHxMeXDfSnQOhQ2UjLbcLt1AyTXP5sv04
	fRrBVosGwv9ONg7gVNTLs5zbGOtabQFgknu0ydsxCnYogTEpJVV1UqzXO2gGBVFc
	7qY9V8dg20xW2ziguuxDgDyDWZ+alT3upg+mE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n9YQgy2PR0pv6AzCbwVYInEa+uqM5pBG
	Erx7ljW2bJxPXgwMqUghrqYze2PlRGxavGELrAtL00Gh8wgsWk7JTXQkpRNfdmZG
	BMNjWqvSbi3kmXb0wA3kZnuLJ9OPkNljwmNa+s+vjIvK7Q8Ia6xwYI74HEk+I9X4
	KXYQ19fDMqU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6329A34626;
	Fri, 11 Dec 2015 19:23:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D4D5234625;
	Fri, 11 Dec 2015 19:23:02 -0500 (EST)
Importance: high
In-Reply-To: <1449877765.1678.2.camel@twopensource.com> (David Turner's
	message of "Fri, 11 Dec 2015 18:49:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81C363DC-A066-11E5-9BFE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282293>

David Turner <dturner@twopensource.com> writes:

> The previous review was here:
> http://permalink.gmane.org/gmane.comp.version-control.git/279062
>
> Michael wrote:
>> Hmmm, I thought our convention was to define typedefs for functions
>> themselves, not for the pointer-to-function; e.g.,
>>
>>     typedef struct ref_transaction *ref_transaction_begin_fn(struct
>> strbuf *err);
>>
>> (which would require `struct ref_be` to be changed to
>>
>>         ref_transaction_begin_fn *transaction_begin;
>
> And you agreed.  So I changed it.  Do you want me to change it back?  

Sorry about that. I was agreeing to my mistaken understanding of
what was pointed out X-<.

We do prefer fn(args) over (*fn)(args) and somehow I mixed that up
with the declaration style.
