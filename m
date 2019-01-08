Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AC31F803
	for <e@80x24.org>; Tue,  8 Jan 2019 17:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfAHRvh (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 12:51:37 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40468 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbfAHRvg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 12:51:36 -0500
Received: by mail-wm1-f42.google.com with SMTP id f188so5308641wmf.5
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 09:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dd3w5XSwQ7GS/u1S4aZeV2q/i1G14+4qCuPflCZ/rV4=;
        b=eLmLA2b6EIHzXS5XsAOm6thebDfi9UFZDaqmki1V5N95Ba3xyI8MJ/zglJrIzCK8LI
         Ti/Eb+8pwFMHWA0RaE7EpTei2cbVYGmn3pleClCZzST9leFCkfnw0gp8DSyNw+OiguDG
         vs3HIdWhYXToVdhoE0Rs3HPLVF5dN9YjpmM0f8lguJ8tCBa2zf8cc78aPeSQuT8a5Hqq
         NbQuvwsk1oto6Gw+udikWSABTWV+FmutwuyD1/F3QvvVccEudidjLnp7DcD/Bqhrf8nN
         AYmsxWqcyvOWlSwza3FwEUv+w/yTcVQEyqY354nyr1wgy3HDeooqa/5IYHep5J9EpECF
         lmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dd3w5XSwQ7GS/u1S4aZeV2q/i1G14+4qCuPflCZ/rV4=;
        b=cYHNMt5/EOhWSQm2x49va7Y01B3sGwBaFsnb0BGiAOSBf/VhdHgEGpe05qH0+3H9g4
         je/YWjwA3XwfKXTnTyve+y70SRL7O1gBuaN4GugIefV4VRdCodmRN7byZ/W9hqUsE/RN
         JK0t/UFG4wqA3DLilv7vmRie2wcKnn+7gTRzDdox5SE/GYxqXi0r+nEcvkyuinJ48QEg
         Tzk0tm/+lC3/1nmCdsDljpO3HvrtM1ga1221l8E1YoFy9tqBluJ2zjMmTzgbyRtSa2JP
         IGRToEUf5/jMUgm+mMLgEQfBTHaI0TschTJAQhzJ8Qr1xpO4AqcwykRAJ7V7Tkhsfv20
         sc8w==
X-Gm-Message-State: AJcUukdT3MNy1fbBMUfhfRhcrpoKSJSRlYUxAqvithdOHx6IPJ7flQ80
        g6eOJSpI8zfhWLhDNe60sBc=
X-Google-Smtp-Source: ALg8bN4jYYXoaJWoW1IscvWjW+Y8Nx4pKdZUZzXkrwjNsIVZL9FgrBWI2i5rYmgdggG6kbVLyyUVqw==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr2617879wmu.52.1546969894892;
        Tue, 08 Jan 2019 09:51:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x15sm52314586wrs.27.2019.01.08.09.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 09:51:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: tg/checkout-no-overlay, was Re: What's cooking in git.git (Jan 2019, #01; Mon, 7)
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
        <CALgYhfML6UBgG0fs+_hpc9k307ZtZCM-OmhVNcWvCKxSJO+e2g@mail.gmail.com>
Date:   Tue, 08 Jan 2019 09:51:33 -0800
In-Reply-To: <CALgYhfML6UBgG0fs+_hpc9k307ZtZCM-OmhVNcWvCKxSJO+e2g@mail.gmail.com>
        (Thomas Gummerer's message of "Tue, 8 Jan 2019 09:50:04 +0000")
Message-ID: <xmqqtvij597e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On Mon, Jan 7, 2019 at 11:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * tg/checkout-no-overlay (2019-01-02) 8 commits
>>  - checkout: introduce checkout.overlayMode config
>>  - checkout: introduce --{,no-}overlay option
>>  - checkout: factor out mark_cache_entry_for_checkout function
>>  - checkout: clarify comment
>>  - read-cache: add invalidate parameter to remove_marked_cache_entries
>>  - entry: support CE_WT_REMOVE flag in checkout_entry
>>  - entry: factor out unlink_entry function
>>  - move worktree tests to t24*
>>
>>  "git checkout --no-overlay" can be used to trigger a new mode of
>>  checking out paths out of the tree-ish, that allows paths that
>>  match the pathspec that are in the current index and working tree
>>  and are not in the tree-ish.
>>
>>  Will merge to 'next'.
>
> Please hold off on merging this to 'next'.

Thanks, will do so.
