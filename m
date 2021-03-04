Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E615FC433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 06:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA0864F04
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 06:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhCDGOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 01:14:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56653 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhCDGOm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 01:14:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EC4AA191F;
        Thu,  4 Mar 2021 01:14:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BHR72DooD7Vre9z2owjjQakcqkA=; b=wFKGNr
        mqm0lQq9yjvpb/4OlNNPgZMJRVc4lhP6TPCKBPX/CJZyxwIHdmbYTZJy/n3ZnuSE
        OHXaez519HI61OcRj0KsZppaRGarx94foai9GsCJjfdgzZ6lhuRN0kv24eA+Mip/
        yxsjf55F0pldUWjASe7/LsVR5kiDqLGd9bo5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yi3mpdOOKBsX3UrdkHf5dSks3JINf6Ky
        v6OVjCqUnWhRnoKluyamrYByoMB4Pa0ThQOwtki6R7FgqSEHCwqqEl37WI/ms1/U
        7dGH9dP9nm2JAsQXcik9w92O4WqiLuT8uqEwrhPnm7j/MpY62Abe+Pk2hzwChA3C
        pKh74luPdVM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04D49A191E;
        Thu,  4 Mar 2021 01:14:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27141A191C;
        Thu,  4 Mar 2021 01:14:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.31.0-rc1
References: <xmqqr1kwk0h9.fsf@gitster.c.googlers.com>
        <CAPig+cSC8uNfoAjDKdBNheod9_0-pCD-K_2kwt+J8USnoyQ7Aw@mail.gmail.com>
Date:   Wed, 03 Mar 2021 22:14:00 -0800
In-Reply-To: <CAPig+cSC8uNfoAjDKdBNheod9_0-pCD-K_2kwt+J8USnoyQ7Aw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 4 Mar 2021 00:14:06 -0500")
Message-ID: <xmqqmtvje993.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D01151E4-7CB0-11EB-BB6A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Mar 3, 2021 at 7:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Pratyush Yadav (1):
>>       git-gui: remove lines starting with the comment character
>
> Is there some way that this can be removed from v2.31.0 before final
> release? It badly breaks git-gui on macOS[1,2] to the point of making
> it unusable (Tcl throws errors at launch time and when trying to
> commit, and committing is 100% broken).

Thanks.

I could revert the merge with the problematic changes to git-gui,
i.e. 0917373 (Merge https://github.com/prati0100/git-gui,
2021-03-01), but if possible, I'd rather merge a revert made on the
git-gui side.  If b1056f60 (Merge branch 'py/commit-comments',
2021-02-22) is the tip of git-gui repository, and b9a43869 (git-gui:
remove lines starting with the comment character, 2021-02-03) is
what breaks, perhaps 

    $ git checkout b1056f60^2 &&
      git revert b9a43869 &&
      git checkout b1056f60 &&
      git merge @{-1}

would be what we want to have at the tip of git-gui until the
breakage gets sorted out.

Pratyush?
