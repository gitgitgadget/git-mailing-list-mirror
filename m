From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/2] commit: add a commit.verbose config variable
Date: Wed, 23 Mar 2016 12:19:41 -0700
Message-ID: <xmqq7fgtc88i.fsf@gitster.mtv.corp.google.com>
References: <010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
	<010201538b98aaa4-ad08c159-4935-48f1-acdb-7c376da2c368-000000@eu-west-1.amazonses.com>
	<CAPig+cShT2aPkoRK0pXPzbRbQqCU+O5uEqEr4oMkZ8LTwREaAA@mail.gmail.com>
	<CAFZEwPMZk9jDpi4F9WiYhv4aTqFqn3127i1AUKtNJXwG-11tyw@mail.gmail.com>
	<CAPig+cSCrdxYb=0WOiAARrrPK07PeyTKsopPfwDOLAO4m3scnQ@mail.gmail.com>
	<CAFZEwPNKozf+owtJtaE27MqQb3koL0L=HDnErVoWrTnQpieGgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 20:19:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aioJp-0007tc-U5
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 20:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbcCWTTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 15:19:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753534AbcCWTTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 15:19:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6256C4F0BB;
	Wed, 23 Mar 2016 15:19:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wnPUR0rdstAW0Keqavh/USrbZnE=; b=SGcm84
	7ihPVrS8L68+w5iL0xF8aYDXryc8ScI9ZJc9Yy24BzzJssbsEcx/G5iYlnIekpmE
	D6VQL4hnHnjge21XhZtL689+LTD3h2dwhTuga/We2c8f0vejZYHcpf/RE4foMdXy
	DgFJfr0Rh9LmHQI6EHHRaPiFOJNm6bva5M9n4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sKF0q2KViicpz0Jp9Yeo1J03ti2fe0eQ
	VY6nVyEfBzW9/BYDu1Q3yK79i4MhQFno9a7Xi6BRHTsJ+iBLMA5m6OUNGLgys8na
	v7Zgfr0n9AqKUUknCRLDAlHvGZyQ/gFmJ5OATjacyJtuO2CfYV+YZkBBz4hitZ6y
	7DTHIeabkV4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 594CB4F0B9;
	Wed, 23 Mar 2016 15:19:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B674B4F0B8;
	Wed, 23 Mar 2016 15:19:42 -0400 (EDT)
In-Reply-To: <CAFZEwPNKozf+owtJtaE27MqQb3koL0L=HDnErVoWrTnQpieGgw@mail.gmail.com>
	(Pranit Bauva's message of "Sun, 20 Mar 2016 23:32:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32327602-F12C-11E5-B475-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289677>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> On Sun, Mar 20, 2016 at 11:04 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> ...
>> Alternatively, combine #1 and #2 into a single patch which drops the
>> global test_set_editor() and, as an aside, also does "while here,
>> let's use write_script() to create 'check-for'diff' rather than doing
>> so manually".
>
> These changes seem nice. I will update and send the patch.

So, has anything happened to this topic or has it been abandoned?

I am not in a hurry, just wanted to see if I need to keep the old
one in my tree as a reminder to myself.
