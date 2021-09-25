Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F06C433EF
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 04:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8858E601FA
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 04:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhIYEJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Sep 2021 00:09:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62234 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhIYEJM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Sep 2021 00:09:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B76A1D480F;
        Sat, 25 Sep 2021 00:07:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0zbSNKTuSDBpZi/2S18P5FK3U7UzxTsC5AbBpZ
        g8E0o=; b=WUajJ/6LMy5yQsYg0qgU7k5jVaa24DDGUWuRMuuDgRL9GJAmogKos7
        MuMh1CJOSaPXb0tjPLo9ARok1R6aB7CKehBf42JxwLB4eA5ryrxzeEzENlYS/jIZ
        99ZUElDVr05tiewIOiOCJXbs7F7TNtJDpTBdBQjn7G8yNuLS1OX9E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B42BD480E;
        Sat, 25 Sep 2021 00:07:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E65BBD480C;
        Sat, 25 Sep 2021 00:07:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Thiago Perrotta <tbperrotta@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] send-email docs: add format-patch options
References: <87zgs34ccx.fsf@evledraar.gmail.com>
        <20210924024606.20542-4-tbperrotta@gmail.com>
        <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com>
        <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
        <xmqqzgs2vvim.fsf@gitster.g>
        <CAPUEspiSh91a8MvhqhKm=DAn5_u-HoRBuL6-gBRMUtSshqpf=g@mail.gmail.com>
        <xmqqo88hspvv.fsf@gitster.g>
        <d9114e0a-cb6e-1791-51f8-6e57f313e8d5@gmail.com>
Date:   Fri, 24 Sep 2021 21:07:35 -0700
In-Reply-To: <d9114e0a-cb6e-1791-51f8-6e57f313e8d5@gmail.com> (Bagas Sanjaya's
        message of "Sat, 25 Sep 2021 10:03:01 +0700")
Message-ID: <xmqq5yups3g8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E33E296-1DB6-11EC-9EAE-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 25/09/21 03.03, Junio C Hamano wrote:
>> Ah, thanks for explanation.
>>      git format-patch -2
>> would be options-only way to "indicate some sort of revision", so
>> perhaps
>>      . git send-email <send-email options> files|directory
>>      . git send-email <send-email options> <format-patch options>
>> (where "options" is used to refer to both --options and arguments)
>> would illustrate the differences better?
>> 
>
> But we can also directly specify revision range (commonly <common
> ancestor>..HEAD or HEAD ^<common ancestor>).

That is exactly why I have the parenthetical definition of what
"options" mean in my explanation.  

	git format-patch -2
	git format-patch master
	git format-patch master..HEAD

Everything after "git format-patch", i.e. -2, master, master..HEAD,
are usable, and there isn't much point in singling out revision
ranges.  FWIW, I think you can even give "-- <pathspec>" at the end,
which are not options or revision ranges.
