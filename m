Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77C22018B
	for <e@80x24.org>; Wed, 22 Jun 2016 23:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbcFVXNF (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 19:13:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751305AbcFVXNC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 19:13:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94CA827104;
	Wed, 22 Jun 2016 19:12:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p5grTjNCnMgxRCscM9+SHCrjKkY=; b=mjCT4c
	IVW8uxjAEN3SyqsxX0rdL+/p3SypM0/07tS3vHr7mchjjaFVul476La7ZhHID3bg
	AR8eb0g4e7IU98anpSM1N4LSM4gnlg1NtG3+pcHRuyBV7y/GTLO2VS9B4s6OhvXn
	Y1ozsqgFxmdJyYAyKeIdN8yiauMa0MwDMFySA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cu46gKSGKMG1rsSDAHU8k7E3eHFbFQgy
	VjQGUVCbQoPl3HrON89SfSYuOL0PnBB+7L6pAJBmDJwr6bMAp+wo7DRkIS26X9pb
	WNTq+kWeW4LNpmfscU4wXA3AUptd+ITDbmoLIQRPRGw8OM0QXJG6fMyrNF7/NxrW
	35OSd31XwDY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C67027103;
	Wed, 22 Jun 2016 19:12:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1373427102;
	Wed, 22 Jun 2016 19:12:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Emily Xie <emilyxxie@gmail.com>
Cc:	git@vger.kernel.org, novalis@novalis.org
Subject: Re: [PATCH] pathspec: warn on empty strings as pathspec
References: <20160622230024.24034-1-emilyxxie@gmail.com>
Date:	Wed, 22 Jun 2016 16:12:52 -0700
In-Reply-To: <20160622230024.24034-1-emilyxxie@gmail.com> (Emily Xie's message
	of "Wed, 22 Jun 2016 19:00:24 -0400")
Message-ID: <xmqqmvmckebv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9DCAE88-38CE-11E6-B598-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Emily Xie <emilyxxie@gmail.com> writes:

> The fix for this issue requires a two-step approach. As
> there may be existing scripts that knowingly use empty
> strings in this manner, the first step simply invokes a
> warning that (1) declares using empty strings to
> match all paths will become invalid and (2) asks the user
> to use "." if their intent was to match all.
>
> For step two, a follow-up patch several release cycles
> later will remove the warnings and throw an error instead.
>
> This patch is the first step.
>
> Signed-off-by: Emily Xie <emilyxxie@gmail.com>
> Reported-by: David Turner <novalis@novalis.org>
> Mentored-by: Michail Denchev <mdenchev@gmail.com>
> Thanks-to: Sarah Sharp <sarah@thesharps.us> and James Sharp <jamey@minilop.net>
> ---

Looks sensible.  I personally do not think warn-only-once matters in
practice, but now you have implemented it, it is an additional nice
touch ;-)

Will queue.

Thanks.
