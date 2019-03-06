Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C35320248
	for <e@80x24.org>; Wed,  6 Mar 2019 23:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfCFXqM (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 18:46:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38372 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFXqM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 18:46:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id a188so7483107wmf.3
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rOzZ4w6NXcaFgtzYL6l3vgujQwygcAy5ys3kUyv8xOw=;
        b=XqOzw8H8YJ93zWBwC30WNGGsAHLJLfbbLIW9Lxaiyp+KyhpdaoaccpAUEPzToLlPQq
         wxmlDYMOxYZOzkxh0e2dN5PKIK3s7o9tDWmE29I6k1vZl5KlObYQwoLU9IzCoHaoxQ7c
         sioDLRK98luScmjaJ1zWfe1rWgQ7JOnXnFf8Pk7oebNsdwokzraeDLpQS/DvNH42Zdln
         hM/hp/ztrHRD/59iBHpYNCY7qhjth5r7KZ+PR1RgFyv7Un76jXbNIKSTnf1EsRwbRK1t
         3nbDXsNr4NDQYL0MCH+sUtzoidkfRTVREBHEOaUh5XASjtvoCOKY1axw3PC2I/NXguBv
         awvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rOzZ4w6NXcaFgtzYL6l3vgujQwygcAy5ys3kUyv8xOw=;
        b=f8WhpzRGydpqNCu/teM7uleJx+xfbvGAMLuMfyV+CFzn2frUJxi9mJSnzrZ7f505Pb
         FKoeC2QXt2OLwBY7XV2zPZlrL2WA/+x9Z1Zo7O0SmnS0Z2LurZ1etkP9z3SjcAb1zmBn
         0mPDIEn/1PC6rUfjZ9sH0ZNsK2IeHf3zpskrlL032QMHlIPq/HeYXE6cwQL7xCZZENfc
         R+Ak1DNn8uOcBp+e7S2RrjLIw5FDLpRIvEuOFRWVUzXM5BTFTJU7ZAO3Ui4sydpaE97e
         mX5Lmm5qVufgu4ZgNdppEFibEyumNClSpE6Poz+O52tB+/MS/Vl8C6i8TJe4ZI1BdjEu
         YV7Q==
X-Gm-Message-State: APjAAAXPSm/yMsDrMW9YxwDPS26qB7gu7Sv+ripStmsd9N3d+J1S3EX2
        PRKeGSGzzi7ypB/H+VrKcBo=
X-Google-Smtp-Source: APXvYqx0wytdccOhs9ZU2lC9JU4Hpz5/HnqTQZAUfj/aTnvOX8TwHBseVS6B9fJLItqXkuJc3KIe0Q==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr3766327wmc.7.1551915969855;
        Wed, 06 Mar 2019 15:46:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z1sm3569595wrw.28.2019.03.06.15.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 15:46:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
        <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
Date:   Thu, 07 Mar 2019 08:46:08 +0900
In-Reply-To: <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 6 Mar 2019 16:44:24 +0700")
Message-ID: <xmqqh8cfpnwf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Mar 6, 2019 at 8:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>> * tg/checkout-no-overlay (2019-02-04) 9 commits
>>   (merged to 'next' on 2019-02-04 at 9968bcf4fb)
>>  Will hold.
>
> If it's ready for master, I'd love to see it merged. Either that or
> topic is rebased on 'master'. There are separate checkout changes in
> 'master' (mine, sadly), and because switch/restore moves lots of code
> around, I need to create a merge of this topic and master as the base,
> or you'll get horrible conflicts.

Yeah, that would make it easier for me ;-)
