Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DC5C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbhL3X4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:56:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59731 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbhL3X4r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:56:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EC01181687;
        Thu, 30 Dec 2021 18:56:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=JEP9wMQ4X5YLYwG+Jgs2ILvEHIqKBcY9+hJH/2wYqNk=; b=aOEL
        1IkWGyy24LHhPO8PV76ZQm189JfkvFdfBL31hrC1V5ncZlCibN91bo4YYkDFXHBI
        vOKZtghPX8Ir2VDLDNrOmIFsfpNqO5vcx87bKG/OPQGjom7VyOyzynNP6hKTPc0T
        LsWdjdvMxy5nX9BCpzpys6ECCMeqyZFhxPMv+pE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77A3C181686;
        Thu, 30 Dec 2021 18:56:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CD81D181682;
        Thu, 30 Dec 2021 18:56:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2021, #06; Mon, 27)
References: <xmqq7dbpvb0q.fsf@gitster.g>
        <CABPp-BFR29S-Pwq9LZEOjaCxozTV9mkUBpd2SLGwh7jNW+On4w@mail.gmail.com>
Date:   Thu, 30 Dec 2021 15:56:42 -0800
Message-ID: <xmqqk0flmyth.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23EC4E32-69CC-11EC-A197-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Dec 28, 2021 at 3:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * ds/sparse-checkout-malformed-pattern-fix (2021-12-25) 4 commits
>>   (merged to 'next' on 2021-12-27 at c410caf527)
>>  + fixup! sparse-checkout: fix OOM error with mixed patterns
>>  + sparse-checkout: refuse to add to bad patterns
>>  + sparse-checkout: fix OOM error with mixed patterns
>>  + sparse-checkout: fix segfault on malformed patterns
>>
>>  Certain sparse-checkout patterns that are valid in non-cone mode
>>  led to segfault in cone mode, which has been corrected.
>>
>>  Will merge to 'master'.
>>  source: <pull.1069.v4.git.1639671222.gitgitgadget@gmail.com>
>
> Eek, this was merged with the "fixup!" commit to next.  I think that
> was a mistake...but what's the plan now?  Merge to master as-is...or
> revert from next, then squash, then re-merge?

If the fixup turns out to be unnecessary (which I suspect may become
the case), we can just revert it at the tip the topic branch.

