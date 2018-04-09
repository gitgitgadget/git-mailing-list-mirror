Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 576B71F424
	for <e@80x24.org>; Mon,  9 Apr 2018 09:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDIJri (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 05:47:38 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:45412 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbeDIJrh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 05:47:37 -0400
Received: by mail-wr0-f179.google.com with SMTP id u11so8823782wri.12
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=250OETlu1EiWZKCUNdW4Iu9+aofs7ysa6Z5iBqRjE1g=;
        b=DAdDKtP/Nlnr0OHJr6R1xbwf+wY+PKlSQG46t+gu1c7+JhINpVX8XB7Gk0pbVG7RSw
         FrvommhEx4mcuVy4hBdDWk17lmhfV+dlUDkVEIiwer8yeXz/3OqHFW7ZRwDbqm+eqXtE
         4AuAZlzQ7fmY5jcZx6YO98Tku9E+FEBmtGze0a/BIKu2qwwjlgm4462kZ0npQIswOkTO
         rT2j5r4QnIEd2PQj3VPdirm86MnHydI1hcK2w30ws1r71cY/BltN0DiTHCpL17t+JXwW
         YCKvtSdqCKQYi2Qi44GrjaPU0/M+JBdCFURH1m0A86tew4S0QhpTmPrWjGMba4Ui7Xo8
         ns+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=250OETlu1EiWZKCUNdW4Iu9+aofs7ysa6Z5iBqRjE1g=;
        b=Fe+7JzLFDItJMtD6kXgOl/4z3d0Qm3aDlc1pzWZGgCvAXuO0RvoGIhFPGynKJDkLB0
         xyyYg9attBmgSjaUpKzR04YOojdwB8BLpGTW8Jl+HlUxA5+Wn1UGba7uVI2g352ByFPm
         SklUibKnlqyaCSzEqIhmt2kqrVGM0B8ErJj2RGnofhEpEjjZ2s2lIgb0VfyCPfTEX2Au
         x7h95q2AFPP8bS54L9OVMHROhP7WxbJUF0qIbSCw7QR8thkWYYT8nS9nKdlLQZLxRymu
         n6tL/6zL9vhm7v4X5JR6uO4/cyhpeHuJRW3Z4AkO4nveHyjrq4z6w1PoBTAyjMwqpqDW
         /UwA==
X-Gm-Message-State: ALQs6tBUq7rQWwQL32w84GymS6HLBeGUVQL9j+6xczIMNjoi1iYB4YJQ
        e1BYhH94aqjus5WbvOGntEk=
X-Google-Smtp-Source: AIpwx49P+P9g1SowIDdjd9fy4pZqjy/BnqBOJZPdpjd1vY4xiKof+R3TVvWPDF9SQlEXYJi3HajxJQ==
X-Received: by 10.223.171.94 with SMTP id r30mr242698wrc.41.1523267256235;
        Mon, 09 Apr 2018 02:47:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y6sm368094wmy.16.2018.04.09.02.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 02:47:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH/RFC 5/5] help: add "-a --verbose" to list all commands with synopsis
References: <20180326165520.802-1-pclouds@gmail.com>
        <20180326165520.802-6-pclouds@gmail.com>
        <CAPig+cR-WP5z1u-9KG-mNOF0mEUcguMET93O21nfzYixEFWaYw@mail.gmail.com>
Date:   Mon, 09 Apr 2018 18:47:34 +0900
In-Reply-To: <CAPig+cR-WP5z1u-9KG-mNOF0mEUcguMET93O21nfzYixEFWaYw@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 9 Apr 2018 01:08:14 -0400")
Message-ID: <xmqqh8ok679l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Mar 26, 2018 at 12:55 PM, Nguyễn Thái Ngọc Duy
> <pclouds@gmail.com> wrote:
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>> diff --git a/help.c b/help.c
>> @@ -282,6 +282,67 @@ void list_porcelain_cmds(void)
>> +static const char *get_category_name(unsigned int category)
>> +{
>> +       switch (category) {
>> +       case CAT_ancillaryinterrogators: return _("Ancillary interrogators");
>> +       case CAT_ancillarymanipulators: return _("Ancillary manipulators");
>> +       case CAT_foreignscminterface: return _("Foreign SCM interface");
>> +       case CAT_mainporcelain: return _("Main porcelain");
>> +       case CAT_plumbinginterrogators: return _("Plumbing interrogators");
>> +       case CAT_plumbingmanipulators: return _("Plumbing interrogators");
>
> s/interrogators"/manipulators"/
>
>> +       case CAT_purehelpers: return _("Pure helpers");
>> +       case CAT_synchelpers: return _("Sync helpers");
>> +       case CAT_synchingrepositories: return _("Synching repositories");
>> +       default:
>> +               die("BUG: unknown command category %u", category);
>> +       }

Somehow this screams "an array of strings" at me.  Aren't this
CAT_things small and dense enum?
