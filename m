Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3FCC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 16:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350002AbiCOQ3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 12:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347087AbiCOQ3I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 12:29:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1AFB5D
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 09:27:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E44B191CF4;
        Tue, 15 Mar 2022 12:27:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o0+Luai6stWL3c9KvhP94VROSDKnUC9pHCM+sM
        6thqI=; b=YTlj8xBewZCQo43cG+0oRRXwYo2MmuAcDhS59P7c8eEfLqG96VFhF5
        Hkn25P7Pcj9wfF4DkSP2RYCWnsT+5GjrdAmpbu9dRu07vrVB0LKXA3Joi5z1sjFm
        q7LZE3N4SYAHnhFi3gn4rzM/AXnoqbXoKpzpogdwMRXOgKfnfKu3c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 681F7191CF3;
        Tue, 15 Mar 2022 12:27:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6593191CB8;
        Tue, 15 Mar 2022 12:27:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, David Cantrell <david@cantrell.org.uk>
Subject: Re: [PATCH v2 0/2] Improved bash tab completion for 'git restore' -
 adds support for auto-completing filenames
References: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com>
        <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
        <xmqq8rtbh320.fsf@gitster.g>
Date:   Tue, 15 Mar 2022 09:27:48 -0700
In-Reply-To: <xmqq8rtbh320.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        15 Mar 2022 04:23:51 -0700")
Message-ID: <xmqqr173faez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DAF8BB20-A47C-11EC-A4C4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This adds tab-completion of filenames to the bash completions for git
>> restore.
>>
>> David Cantrell (2):
>>   tab completion of filenames for 'git restore'
>>   if a file has been staged we don't want to list it
>
> Why two patches?  The second separate patch makes the topic look as
> if "oops, the first step designed a wrong behaviour and here is a
> brown paper bag fix-up".

Sorry, I forgot the obligatory clarification for new contributors.

This project gives all contributors a chance to pretend to be a
"perfect human".  When sending an updated patch (or patch series),
contributors are encouraged to hide^W correct their earlier mistakes
and present a perfect logical progression that they (would have, if
they were perfect) followed to arrive at a perfect end result.

So, instead of having step 1 that uses --committable without
justifying why it was chosen, and then change mind in step 2 to
replace it with --modified, have a single patch that uses
--modified, and explain in the proposed log message that
--committable and --modified may be possibilities, and why the patch
chose to use the latter.  The resulting history without a flip-flop
in the middle is easier to use by future developers to understand
the reasoning behind each change.

Thanks.
