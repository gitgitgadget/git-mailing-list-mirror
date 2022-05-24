Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50EAC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbiEXTSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEXTSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:18:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6C7644FC
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:18:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC76118C309;
        Tue, 24 May 2022 15:18:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ozKvAwUXDBD3pVUFIYEIibsU+WH+87zdZABotD
        hsK/g=; b=Y8YWiCOTS9e9hnkbZfYRCICcCt7v33RRn0yGBkZF1sDcKI2lKvR0E2
        nUsCoTb8JTvmoOZkC1snqBsCn2nGQNIhw8GxeRhLH+NEl/wguklXRYsuRs3OzHNF
        KWXDUNaxQI2k6RFXbwxhiHCgXdq24fJ4FKdJ9f0SkvacGH/iM2uTE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4B4418C308;
        Tue, 24 May 2022 15:18:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4BE9918C301;
        Tue, 24 May 2022 15:18:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carl Smedstad <carl.smedstad@protonmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] check-ignore: --non-matching without --verbose
References: <pull.1236.git.1653310466062.gitgitgadget@gmail.com>
        <xmqqilpwru9z.fsf@gitster.g>
        <hl3lllnkPVswb8IZoaMCS62N42epy97_8rLH8qrvSGCbKoovP5_qjtq4nrot5-h-q_7KOu-JpPX4nC0f74BXm6uWdtxosa6z5niHqAJKRUw=@protonmail.com>
Date:   Tue, 24 May 2022 12:18:10 -0700
In-Reply-To: <hl3lllnkPVswb8IZoaMCS62N42epy97_8rLH8qrvSGCbKoovP5_qjtq4nrot5-h-q_7KOu-JpPX4nC0f74BXm6uWdtxosa6z5niHqAJKRUw=@protonmail.com>
        (Carl Smedstad's message of "Tue, 24 May 2022 13:03:55 +0000")
Message-ID: <xmqqwneahh8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4060293A-DB96-11EC-B91E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carl Smedstad <carl.smedstad@protonmail.com> writes:

>> Not commenting on the patch itself, but ...
>>
>> > find . |
>> > git check-ignore --verbose --non-matching |
>> > grep $'^::\t' |
>> > sed -e 's/.*\t//'
>>
>> ... feeding grep output to sed caught my eyes. Isn't that equivalent to
>>
>> git ... |
>> sed -n '/^::\t/s/.*\t//p'
>
> That is indeed equivalent. TIL about regular-expression addresses in
> sed, thanks!

I however suspect that these "\t"'s should be spelled out as an
actual TAB in the final production version for portability.

Thanks.

