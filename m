Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64C2C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 04:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E999206A1
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 04:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eW8xMWEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgGIEt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 00:49:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64599 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGIEt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 00:49:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15149E1B31;
        Thu,  9 Jul 2020 00:49:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jMsHuIR1dNkHM2LWpFWhz+nbnOs=; b=eW8xMW
        EhymHz64MJT7+Z9MaOjnG/CBR9NGcOEmUcpb0hNbxEyrqTCKZ2Swz84NnCs3lx/0
        k8m1UXGZmKnHNQp7kkmGgRCoqQLHhnSUUW4iCXwnQrAg+LSAN6svp/shnmrBdvAc
        G/SadxJZ8wEsQ4VnRe3My37rv9wdyYSctsesk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DNJm676IK7GVBmKYEZ80tbS9+jQpmL+3
        jd2V+S9JCZuGTtzwn99ysjXACCWVgqvfaiRV+yQWWuNPX2eMWOEnYC1GkLZ+OPYj
        pDrUMhDMyHRWpCIqlkYyLSi0mLEhDbZ9e+y8fG4LEqhNAZSgbycDj+QCV7V0A0Tl
        iGowJ1P750w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B9F6E1B30;
        Thu,  9 Jul 2020 00:49:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 50967E1B2F;
        Thu,  9 Jul 2020 00:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <lin.sun@zoom.us>
Cc:     "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
Subject: Re: [PATCH v13] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com>
        <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com>
        <xmqqh7uhz98q.fsf@gitster.c.googlers.com>
        <261a01d655a0$71077210$53165630$@zoom.us>
Date:   Wed, 08 Jul 2020 21:49:50 -0700
In-Reply-To: <261a01d655a0$71077210$53165630$@zoom.us> (lin sun's message of
        "Thu, 9 Jul 2020 11:24:20 +0800")
Message-ID: <xmqqd055z40h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0694F18-C19F-11EA-9E08-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<lin.sun@zoom.us> writes:

> Hi Junio,
>
> I'll add SP on both side of  '|', and remove the backslash, thank you.
>
> This line assign value with `git config --bool...` is over 80 characters, so there is a break. 
>
>>> +			else
>>> +				meld_use_auto_merge_option=false
>>Why? Shoudln't we loudly complain to let the user know of a misspelt value in the configuration?
>
> The command line `git config --bool ...` without "2>&/dev/null" will print error message, just passthrough to user.
> $ git config mergetool.meld.useAutoMerge hello 
> $ git mergetool --tool=meld 
> fatal: bad numeric config value 'hello' for 'mergetool.meld.useautomerge' in .git/config: invalid unit

Yes, but you do not exit(1) here, so the user will keep going
without having a chance to stop, think and correct the misspelt
value in the configuration file, no?

>
> I'll upload the changes soon.
>
> Regards
> Lin
