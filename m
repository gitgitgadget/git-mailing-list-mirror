From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/2] commit: add a commit.verbose config variable
Date: Wed, 23 Mar 2016 13:43:31 -0700
Message-ID: <xmqq37rhc4cs.fsf@gitster.mtv.corp.google.com>
References: <010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
	<010201538b98aaa4-ad08c159-4935-48f1-acdb-7c376da2c368-000000@eu-west-1.amazonses.com>
	<CAPig+cShT2aPkoRK0pXPzbRbQqCU+O5uEqEr4oMkZ8LTwREaAA@mail.gmail.com>
	<CAFZEwPMZk9jDpi4F9WiYhv4aTqFqn3127i1AUKtNJXwG-11tyw@mail.gmail.com>
	<CAPig+cSCrdxYb=0WOiAARrrPK07PeyTKsopPfwDOLAO4m3scnQ@mail.gmail.com>
	<CAFZEwPNKozf+owtJtaE27MqQb3koL0L=HDnErVoWrTnQpieGgw@mail.gmail.com>
	<xmqq7fgtc88i.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPM1tukRCewKCgvYMQNDRMWh4MXcrXAbdn4S3Hg8c1R+hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 21:43:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aipcy-0006gu-94
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 21:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625AbcCWUng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 16:43:36 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752640AbcCWUnf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 16:43:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 625AD5049E;
	Wed, 23 Mar 2016 16:43:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eV4ensYUqzm21eAturPUPPmzNwU=; b=W4x2cz
	rlB5p/lGeu+5giHDtutqNSfa4np6OtKWFbcF8XH25TErXp4EcQ3+l4rqg/8nbWse
	xlASE3grFr5qzAmBJ2AmpzyMl9sJrCaaNG7CGtzrgpr+utT+kM5vngJLXopR8c5U
	d3vbT9b6wlg/0qGbHfgnxhyqmiRE51+cNdi08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ARgyqidf+9fNfPWtC3ELgtHRSvyP6j1R
	/7EGhB6XhW+IytSELDAH6/iLDUYpxcGIALzdlZYkYyC5lBXbC/OnkXUuxbIBxLBH
	+qXvOw/pku4Enw3VG4IOuxmw2rElTUBO43VgG5Nqs47du6DYEL1fgUzLi1i+bizl
	Z+gMU2qQ7rs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A5605049D;
	Wed, 23 Mar 2016 16:43:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C3C7E5049C;
	Wed, 23 Mar 2016 16:43:32 -0400 (EDT)
In-Reply-To: <CAFZEwPM1tukRCewKCgvYMQNDRMWh4MXcrXAbdn4S3Hg8c1R+hA@mail.gmail.com>
	(Pranit Bauva's message of "Thu, 24 Mar 2016 00:53:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E856EBF6-F137-11E5-A9AF-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289680>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> On Thu, Mar 24, 2016 at 12:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>
>>> On Sun, Mar 20, 2016 at 11:04 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> ...
>>>> Alternatively, combine #1 and #2 into a single patch which drops the
>>>> global test_set_editor() and, as an aside, also does "while here,
>>>> let's use write_script() to create 'check-for'diff' rather than doing
>>>> so manually".
>>>
>>> These changes seem nice. I will update and send the patch.
>>
>> So, has anything happened to this topic or has it been abandoned?
>>
>> I am not in a hurry, just wanted to see if I need to keep the old
>> one in my tree as a reminder to myself.
>
> Sorry for that! Actually I am bit caught up with writing my proposal
> for GSoC 2016. I would be able to complete that in around an hour.
> Then will work on this. Then on the shell function -> C function
> porting patch. Please bear with me for a little while.

Oh, no worries. Naturally the application/proposal should take
higher priority.

Thanks.
