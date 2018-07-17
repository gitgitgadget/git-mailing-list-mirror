Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256BC1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 18:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbeGQTNq (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 15:13:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44318 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbeGQTNq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 15:13:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so2194164wrt.11
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yshov4u2Dr/G/sUcJSz4liprDEWJpU2lQ7bIIPfm6rc=;
        b=UpqrfJ5umuCaDErleuy5tfy5lYXxqEWGld/D8ekzP4LTFmpJYcjCQHU5YS4ATjJT5l
         8I/qE6hGGa0snIwfBaVitoChY5GqDJ+PMiFhs3XcOF2oyuZQyVH8pvjh81r7aZEBK2CE
         JgU5KCl3i9K6G9WWcnzsAaOsojPXlZDl8YeOmbXbMr7PXUAmEKnYQ4gx9159crTB8UXy
         uP1d5+284dMSJvnrlOTgD4gEYIMwemzVMsjRf3ceF55iVM9wIA1gxB/Oc8brz5FLjANW
         SwU0D4H2lzPe3PgIB3w05xTcWY4amB2+YYGHScJr96Jg7nZ+1MSEiz9FmelqsC2euWQ2
         tXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yshov4u2Dr/G/sUcJSz4liprDEWJpU2lQ7bIIPfm6rc=;
        b=PtJBcPmgJRUBJmivW4zljXXDMTRrjFKlDMkKQYuovIfClgaeNkWmMSWHWfirZef8SA
         9IwBbbEOP2G4BPfDL6Ow2CewaiDGtYLCvMJ0f26GIB2QEPxtL3Eic5GO3lccpJ+b0MEC
         1iEWGi7/NQb7Qx6ZH8CIDpe330Nr6v1/eqIVLmPsH2IDGUwUsKXprkUJLo0SUGHWq2bI
         9fw9iLKiW51aBK/GT0K/sCIcwR65k8oVlVHG74fcvCT+7YUQ/bhUd06Kdy/3fyQC1Eo8
         ISorBU+NV8FxC5Bra9XFkmfPCuW/BPU66B8cAL3+EBr8fWFMTZF5+5QvoRPe2NtnDaZS
         zWtw==
X-Gm-Message-State: AOUpUlHdgqapkhHV7KnHhCVj0EIA0xZ+BC7u4Mg2PNH7Sqpae+KcBnvs
        d/w/frTvyxfZD1kbASE3b7Y=
X-Google-Smtp-Source: AAOMgpfS3JrwiKcSFmA0QxF2sU4z7ZDjkC8TWp8vQQRK5SituhwHx3KVV631e4J5b7DzhTpXXmT8cQ==
X-Received: by 2002:adf:e405:: with SMTP id g5-v6mr2251962wrm.96.1531852790335;
        Tue, 17 Jul 2018 11:39:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q11-v6sm3676001wrp.58.2018.07.17.11.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 11:39:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to C
References: <20180717002654.120375-1-sbeller@google.com>
Date:   Tue, 17 Jul 2018 11:39:49 -0700
In-Reply-To: <20180717002654.120375-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 16 Jul 2018 17:26:48 -0700")
Message-ID: <xmqqmuupogei.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> v2:
>> addressed review comments, renaming the struct, improving the commit message.
>>
>> v1:
>> https://public-inbox.org/git/20180712194754.71979-1-sbeller@google.com/
>> I thought about writing it all in one go, but the series got too large,
>> so let's chew one bite at a time.
>>
>> Thanks,
>> Stefan
>>
>> Stefan Beller (6):
>>   git-submodule.sh: align error reporting for update mode to use path
>>   git-submodule.sh: rename unused variables
>>   builtin/submodule--helper: factor out submodule updating
>>   builtin/submodule--helper: store update_clone information in a struct
>>   builtin/submodule--helper: factor out method to update a single
>>     submodule
>>   submodule--helper: introduce new update-module-mode helper
>>
>>  builtin/submodule--helper.c | 152 ++++++++++++++++++++++++++++--------
>>  git-submodule.sh            |  22 +-----
>>  2 files changed, 122 insertions(+), 52 deletions(-)
>>
>> -- 

A tangent.

Because this "-- " is a conventional signature separator, MUAs like
Emacs message-mode seems to omit everything below it from the quote
while responding, making it cumbersome to comment on the tbdiff.

Something to think about if somebody is contemplating on adding more
to format-patch's cover letter.

>> 2.18.0.203.gfac676dfb9-goog
>>
>> 1:  d4e1ec45740 ! 1:  bbc8697a8ca git-submodule.sh: align error reporting for update mode to use path
>>     @@ -6,7 +6,6 @@
>>          on its path, so let's do that for invalid update modes, too.
>>      
>>          Signed-off-by: Stefan Beller <sbeller@google.com>
>>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>      
>>      diff --git a/git-submodule.sh b/git-submodule.sh
>>      --- a/git-submodule.sh

This is quite unfortunate.  I wonder if it is easy to tell
range-diff that certain differences in the log message are to be
ignored so that we can show that the first patch is unchanged in a
case like this.  This series has 4 really changed ones with 2
otherwise unchanged ones shown all as changed, which is not too bad,
but for a series like sb/diff-colro-move-more reroll that has 9
patches, out of only two have real updated patches, showing
otherwise unchanged 7 as changed like this hunk does would make the
cover letter useless.  It is a shame that adding range-diff to the
cover does have so much potential.

