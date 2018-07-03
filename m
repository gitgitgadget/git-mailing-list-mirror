Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0180C1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 20:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeGCUdw (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 16:33:52 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41991 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752573AbeGCUcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 16:32:48 -0400
Received: by mail-wr0-f196.google.com with SMTP id p1-v6so3190213wrs.9
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+tY7Fvh+bgFeS/qYDEelZcz7+lun5naEONtQ4ODmBaM=;
        b=vXqqunz/u2FRstekC5zWAuC67cCnziDxzPGKwAtxVNbjFPwmGtyIzTj4KL6LpPObCR
         voeZ+vaP6j4Vt1S7ZUl0bBA9gxpvgJLJTcdgYbQ8h7GAkMkh6tAxI21sAwFvmQm7HMAU
         5zlso6Ekp/oUYrPV1UgBKV2mqjXlFHRZ1/biYytJfV7B82QhPt0S9AnoGEXVcidhKgVC
         RwgF5wHTLjA7b9WZTzBWiwxTSFlZFVnofhvAhxDOk/t0aBHENBvHU1Sz7CMaBkHeV5bT
         f1y8SKoDhNooAiqaWrm/fX89rap1Pc429D6mH/bkRJQ0sjAD75m8WISIeWcSEzfNPlml
         LabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+tY7Fvh+bgFeS/qYDEelZcz7+lun5naEONtQ4ODmBaM=;
        b=Z9VnLIkF2vKgrf/UOZAVOoQ+maowGmoQ1bZSeOrzooJUMum+BSJKUnRkoms+XFfKvs
         f2zeMzDBjCloQW/JTzUwfwI+SxeaCkG+cg1ECDCdyldLyBT0t0wRvUon3yHfCTQVLXli
         T4lV50Pcm0NinfSZyQIAoRPf5dkOe1hG6w3JKqHPYpLL1XFSmGzc8wy6B/pNTzep13R8
         1w6V0BfSJOzifLwy2ldyocwuWOYv/G2ndJQ5F4TBMEYXJyqM5rNYFXPgTcBA7/LBEyDw
         HlmqSAeipFJFEWNV6Er/1ADQYBpncp+Hm4nlDnhYl0T8ui4zxzMfz4IByyQAMplI2ldP
         v+Mw==
X-Gm-Message-State: APt69E3YmhixGB0j0HTVrcmRBZl7/3rImN2aAvlQZTQYtGmC0otCctKC
        6QLKWtqij3lSHtzuqhuEWyg=
X-Google-Smtp-Source: AAOMgpdhv6c38zAR7dZ4lsVU2SsJ9J8ZHxRcUAZDvbfIGbiM69t4tEBIBDQpjVFchm+0b/dIFPFXnQ==
X-Received: by 2002:adf:fe46:: with SMTP id m6-v6mr22941113wrs.171.1530649967272;
        Tue, 03 Jul 2018 13:32:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1947033wme.28.2018.07.03.13.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 13:32:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 3/7] editor: add a function to launch the sequence editor
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180702105717.26386-4-alban.gruin@gmail.com>
Date:   Tue, 03 Jul 2018 13:32:45 -0700
In-Reply-To: <20180702105717.26386-4-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 2 Jul 2018 12:57:13 +0200")
Message-ID: <xmqqh8lgoyaa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> As part of the rewrite of interactive rebase, the sequencer will need to
> open the sequence editor to allow the user to edit the todo list.
> Instead of duplicating the existing launch_editor() function, this
> refactors it to a new function, launch_specified_editor(), which takes
> the editor as a parameter, in addition to the path, the buffer and the
> environment variables.  launch_sequence_editor() is then added to launch
> the sequence editor.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---

Looks the same from the previous round, and the changes look good.

You can say "Unchanged from what has been queued on 'pu'" or
somesuch to save reviewer's time after the line with three-dashes

Thansk.
