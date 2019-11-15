Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF921F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 11:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKOLhm (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:37:42 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54075 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOLhm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:37:42 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C73B9D78B;
        Fri, 15 Nov 2019 06:37:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Be3uK1mudAgMMVhQbNCL+YIStqA=; b=LM9BEN
        xYhKHJYCISRj8SWODvcXu7pbFRbAdmXzOFwlmulhg0z/8fnpPYFlefseNABaV/wu
        F0laO/yV3T4obDUmoxkltKoK+qhm8l9M5kY4z8agXIWKjxvpOWXnF+87wK1S1hzV
        Fe+iyDuZct8Udd5qp8Nwo351xoiJfo8myWGgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SbRkCukfFZKTiCn+hTmw4hblAQykP2gj
        vqeKbaikoX48/wpMW/VHmBWyLyUS0VKhHQw0StYR5GAW2y0KHw4AElqF68Ps7HFJ
        ldXjIE8pyTVOUTzk+hfkICcn9+6XmbFBHfFi5mtym9k61tgoXdwl052hphlR9T14
        rOVTmlo4oe0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4507B9D78A;
        Fri, 15 Nov 2019 06:37:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BEAB9D788;
        Fri, 15 Nov 2019 06:37:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 15/20] parse-options: move doc to parse-options.h
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
        <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <3d1e7e72efca06d18606b6f9dd8c3b6771dfde06.1573034387.git.gitgitgadget@gmail.com>
        <xmqqh83bi10h.fsf@gitster-ct.c.googlers.com>
        <CACg5j27=t_tC4AqNz6tSdsgbDKECq1p+OwS=ydak7d94q2PHZg@mail.gmail.com>
        <xmqqblthfxho.fsf@gitster-ct.c.googlers.com>
        <CACg5j25ZO3+=EHYm5-Yp_LKEQA00EH=FAhOeP_TqHw8anCUDEg@mail.gmail.com>
Date:   Fri, 15 Nov 2019 20:37:35 +0900
In-Reply-To: <CACg5j25ZO3+=EHYm5-Yp_LKEQA00EH=FAhOeP_TqHw8anCUDEg@mail.gmail.com>
        (Heba Waly's message of "Fri, 15 Nov 2019 22:55:37 +1300")
Message-ID: <xmqqv9rl5q0w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52DA50E8-079C-11EA-A747-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

>> Note that the quality of the latter is quite uneven.  The one I
>> noticed perhaps is exceptionally well-structured (even if some of
>> the details of its contents may have gotten stale) ...
> ...
> Back to the main issue you raised in the beginning: lets look at two
> different scenarios before and after moving the docs, the first
> scenario is the one you've been through trying to look for
> PARSE_OPT_STOP_AT_NON_OPTION, luckily you found it in
> Documentation/technical/api-parse-options.txt and the doc was pretty
> useful for you. But if you were looking for PARSE_OPT_ONE_SHOT
> instead, which is not documented in the doc file, you'd have ended up
> in parse-options.h with no documentation, even searching for the enum
> parse_opt_flags itself won't lead to anything useful I assume.

That is a longwinded way to say that the Doc version is outdated.  I
am *not* advocating to keep it up-to-date just like the header (I've
given up on that), but if it were kept fresh, then those who looked
for ONE_SHOT would have the same ease to learn where in the larger
picture it fits, like I did with STOP_AT_NON_OPTION.

It is not like "In the header file, it is likely that we can keep
these up to date more easily.  A dedicated file in Documentation/
hiearchy may be able to offer you a much better structure, but may
not describe the option at all.  Which one do you want?"  At least,
it should not have to be.  That is what I meant when I responded to
your earlier

> So my proposal for this matter is to investigate the possibility of
> using a doc generators that'd extract the documentations from the code
> to a single doc file per library.

Extracting is just the necessary first step.  It would probably need
to let us leave notes (in the header file used as the source of the
documentation) to reorder things for ease of reading through.

> last version of this patch, if we're trying to look for either
> PARSE_OPT_STOP_AT_NON_OPTION or PARSE_OPT_ONE_SHOT, we'll find that
> it's a member of parse_opt_flags, searching for the enum will lead us
> to ....

... which is what I found to be a frustrating experience of being
forced to jump around to hunt for the necessary pieces of info
sprinkled in the header file to form the overall picture, that a
simple flat-file text document would have much easily given me
(i.e. go back to my original post).
