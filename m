Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B65E201A4
	for <e@80x24.org>; Mon, 15 May 2017 02:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754188AbdEOCSV (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 22:18:21 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36723 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdEOCSU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 22:18:20 -0400
Received: by mail-pg0-f50.google.com with SMTP id x64so33268274pgd.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 19:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CmxVEe6RWgnUC2MjAJdv/wTMIbJ1gVM/zp2sndXweWY=;
        b=jdfB25JTDN690iaVcM4JZUuQOE9FaxW6Q1mefsp7yY1GMGcsz+wyBrceGYg4r5En0Z
         RHwLFtDTcb/R7dIwyR49JdLzoTe8/AhUDJ0KrLeFUUkmYlplMsLio65N3wKnNzYuUtOY
         qsD8WfmvoxopFpZ9009nlwBBzcPyprWAunOx1R+rhtgyFOuDly4hhkYSArIDDxP2AAYY
         YEUp2/koLLZxzZ9oSjT/UQa0FwxKtzfjedwtJRt/khmR0ensNDGsI/B0GHEeo1NA3XoG
         EBlJhCMUurGBE5pUd0AFSAWcmvaXu7HFqIcDZ0FQkmGxfyl0IQ9LBGtXMH5aIgzIv+GV
         19tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CmxVEe6RWgnUC2MjAJdv/wTMIbJ1gVM/zp2sndXweWY=;
        b=kvYZsqI56AfprFvVvYpUrfXDS6Pg+sWuV9zD4W8AHsR0GTswXnudCfZ6pwcjEetkvK
         kARBZxGjlaOL37lad3Cwfx5S7+DHQVJ3Fyf/t8kqmEVdEXBHCBXZnuf6JG0LR8tjw1qd
         FDtnAWWOUUUrhh1x8GW0RFaxBclc/EpYk5DXatjMNwVfghwLbTDIFJ19sO/nRIrMY8i+
         NBbh6y9b52p2fsHDE1Ak+WB2jD+PBQMmcSbD0AFiqRPLk0tY6rST5BcJ6gtZLA7BDaN4
         UZVKWJaromTPO5OUexmgbsLi/ZRdvtAtZpBAvFuYc8HsjYcDpULMQ8oqR7rVkOZziPWY
         Q5nw==
X-Gm-Message-State: AODbwcBGaNb4BXKsJA+hplWoVl/B6H0qGcKfSunM8H5nEcgJhjf9zwlI
        KvFiGi3ELbwa82esQw0=
X-Received: by 10.99.188.9 with SMTP id q9mr3736842pge.178.1494814699416;
        Sun, 14 May 2017 19:18:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id x198sm14531200pgx.28.2017.05.14.19.18.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 19:18:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fixup! log: add exhaustive tests for pattern style options & config
References: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
        <CACBZZX7MXh_9mG1EROZVEEGapBwjzRWzr3S57f6rWLnQe9L+XA@mail.gmail.com>
Date:   Mon, 15 May 2017 11:18:17 +0900
In-Reply-To: <CACBZZX7MXh_9mG1EROZVEEGapBwjzRWzr3S57f6rWLnQe9L+XA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 13 May
 2017 15:20:17
        +0200")
Message-ID: <xmqqbmquyiae.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Thanks for the hotfix. I'll fix this in my v2, but do it differently
> in such a way that I can still run these tests on windows.
>
> I.e. the actual test here just needs these odd characters in the
> commit message. It's just an unintended implementation detail of
> test_commit that a tag is being created.

My knee-jerk reaction matched Dscho's, but grep is about contents,
and we should be able to test this if we used a sensible tagnames or
didn't use any.  Glad to see somebody can step back and think ;-)
