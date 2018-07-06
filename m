Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 883701F85A
	for <e@80x24.org>; Fri,  6 Jul 2018 17:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933933AbeGFRBO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 13:01:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42813 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbeGFRBM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 13:01:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1-v6so4832141wrs.9
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OcoAn2o4C/Dol75xvLN1Cu2iANGCxjYmZeXFza67MUU=;
        b=hvDdjV7J2Q5S7L8XYzVng8L2kIICIQaKytgqqNMT+AKsF73ToC8MpuzKFc3XVlThg4
         YRavzbLqivDKuNy3WoY1ALoXQLvVtjJldauvwjgiKUj7KkKmI3ZqzLp0BDZ5LzVFdLUZ
         zvMU9CEe/pBLqb/XzPh1XLGzhf3DHuOEX8r94aI7ta5KcM873+jU+VImufbubUef79T0
         B6ZeaY6gOIt5eLypaIgPdRx1gJCs+h3RycB+J72Z2TSBwXHdScdvvI6gMTErv9mGeBLa
         LskE8DEacDK7mES/26DBYtPSf0+EHOA4H9Dbey/GUlbYN4rpFmWAzfoNCYlwv4narLHt
         afvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OcoAn2o4C/Dol75xvLN1Cu2iANGCxjYmZeXFza67MUU=;
        b=hIp4SJAuvjRQtKAwuz93Q+bPuRzepJV/sKgqO/d1o4FJjfQqJ7CxAa1apG+XfaK164
         i4eDS5iPh6xB9rXHd56JZCebR8kMQAL+HvallWqKBKsdMZwEc0oGXSNuqYjGjAMPCHa4
         ZA4zI6a/gZCc6vLmzLbHSkTy3DKLpBYNuO4h1Hc1UU/C9Bg+ldKC8dC2qmDDlx/F40ZA
         ciTi0sQXiZLjKLhy3dLAK2gEW9qrloBahvdV1vFUiYmWD/Or5Vwqz/qggIu6gTGFA68S
         NoJN5uU3kgHHlIcR4wAiKAErcDvyuVk1M5/8FDoH9TmlJayn3k5vTMOE1kWUmnKbOyiE
         6fiQ==
X-Gm-Message-State: APt69E2zgcZhxHsLlo+lTIsAWizM7Sr3b1SOFwte4TrHl4ZR8+WLx5G1
        jSRpbDOKa1HQmSAsjS05RAspfC8+
X-Google-Smtp-Source: AAOMgpcJnGs124oUraAFPsybVgcgMvr7eiq7xM/FYP006nflibcFaYSRBt5C81Nf3QbIYHmxoKYOCg==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr8321273wre.12.1530896470753;
        Fri, 06 Jul 2018 10:01:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f133-v6sm10064900wme.42.2018.07.06.10.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:01:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Joshua Nelson <jyn514@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] ls-tree: make <tree-ish> optional
References: <20180703035802.24060-1-jyn514@gmail.com>
        <CABPp-BFu+m-7Fyf4kj8hUO33vhAxKuAu5JnyL5Tzc7c6Kq+Hjg@mail.gmail.com>
        <xmqqbmbonff3.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGJjJGhOEBiJJ5J5rnMXfLndKgwU-4_JVqumBB81DUHpQ@mail.gmail.com>
Date:   Fri, 06 Jul 2018 10:01:09 -0700
In-Reply-To: <CABPp-BGJjJGhOEBiJJ5J5rnMXfLndKgwU-4_JVqumBB81DUHpQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 3 Jul 2018 15:55:16 -0700")
Message-ID: <xmqqh8lcmh7u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I'd prefer *not* to have such a DWIM in a command like ls-tree, aka
>> plumbing commands, where predictability is worth 1000 times more
>> than ease of typing.
>
> Fair enough.  However, what if no <tree-ish> or <path> are specified,
> though -- would you be okay with the HEAD being assumed instead of
> erroring out in that case?

If we wrote ls-tree to do so 12 years ago, then I wouldn't have
opposed.  Changing the behaviour now?  Not so sure if it is worth
having to worry about updating the code, docs and making sure we
spot all the possible typoes.
