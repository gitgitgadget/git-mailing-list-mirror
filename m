Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944D42018E
	for <e@80x24.org>; Mon,  8 Aug 2016 20:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbcHHUJu (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 16:09:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932163AbcHHUJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 16:09:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FAAF33A77;
	Mon,  8 Aug 2016 16:09:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oflQYANtv0IV5U0m3skQ0HgdSEI=; b=a2j820
	o4GOFHyaSFMvG4tph0AGjzcH2BiPxIFti+Hqq7DNzBiEYiOSvWAqERxjLAYqO9eS
	fv5fvUOusc9WR4lw3J2qhaB2AevgxX+M7NgMnMV7eTQc/gH2m8EAKFZROEJ7m8av
	HpfX4tRSae2NBl2xqIxmQ3gB2Ic7kFECbxSTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wj9FwlGmTwHcPNIQCMHo4bbN6q+HKfLG
	P8N5j5dAM3Ago5GLFqpiLkS2ZSn1hH9E9SJboIgBZecfS2fTuT5Sv2AYtrHNmbd1
	X5qA1RRga5VdrOTL7Fjz3H0uUQvaWFS8ttq28F54KRBFSlrg3E3l70Dcgfvvy4F7
	VsZUIWHhv8k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 78D0933A76;
	Mon,  8 Aug 2016 16:09:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAD5633A75;
	Mon,  8 Aug 2016 16:09:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: storing cover letter of a patch series?
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
	<CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
Date:	Mon, 08 Aug 2016 13:09:46 -0700
In-Reply-To: <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
	(Stefan Beller's message of "Mon, 8 Aug 2016 10:27:18 -0700")
Message-ID: <xmqqk2frdnud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E71A0A0-5DA4-11E6-88F6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Sep 10, 2015 at 9:28 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Hey,
>>
>> does anyone know of any tricks for storing a cover letter for a patch
>> series inside of git somehow? I'd guess the only obvious way currently
>> is to store it at the top of the series as an empty commit.. but this
>> doesn't get emailed *as* the cover letter...
>>
>> Is there some other way? Would others be interested in such a feature?
>
> Being late to this thread, but I think
>
>        branch.<name>.description
>            Branch description, can be edited with git branch
>            --edit-description. Branch description is automatically added in
>            the format-patch cover letter or request-pull summary.
>
> is what you want. Maybe we want to see a patch that adds the reverse
> functionality as well, i.e. git-am will store the the cover letter as the
> branch description and git-merge will propose the branch description for
> the merge commit.

Yes, but... ;-)  It is a bit too weak to be called a proper part of
a "version control system", in that the description, even though it
can be edited with "--edit-description", is not versioned.

It is consistent with the fact that rerolls of your branch by
rebuilding with "rebase -i" or "checkout --detached && until
satisified; do cherry-pick && commit --amend; done" is not versioned
and you may resort to the old-fashioned my-topic, my-topic-v2,
my-topic-v3, ..., but being consistent with a bad part of the system
does not deny the fact that it is a weak feature.
