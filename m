Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AED61F597
	for <e@80x24.org>; Sun,  5 Aug 2018 06:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbeHEIL3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 04:11:29 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:33109 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeHEIL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 04:11:28 -0400
Received: by mail-wr1-f50.google.com with SMTP id g6-v6so9230786wrp.0
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 23:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4AyBUeSMFtwHP8KNt7MG1XO0LO9SdTCqxjjKna1z11s=;
        b=E+omw6vh+6yjGajbu638yiPVV+6hLHmsGZcO5xbiir5kyUyin5s/VMmfui+XEmaP53
         7qyIQy1PTzxMpiu9f13YTxgApzTIXDbMJSK5cwWeZc6gLc4dldcNU7ESL5+JFOUMEbGu
         /QbjC1wUYgrmTCLzTxkWgodoZtK2GsZHZ7DmFBFFk51RhEswAu3eNH26tu7o3c02c8/J
         lAGggwLrUrmAUxgZMVoaKz10s25YYfxNOZeP3ChgCzjoiwuDSEKvH7mwTcoQsLKn1E1F
         q0xRdNKRC3thMwab2EVBrmLvGEi42ApkYZfJlSv3BQPod7e4oNg5kNxkX5UBfbCm3Pn5
         lNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4AyBUeSMFtwHP8KNt7MG1XO0LO9SdTCqxjjKna1z11s=;
        b=b4PBMca+An25vJNDw2MHiXF7xl5Vr0CAPjNElucYncxT7WEtr8py8j/3rkvis+teN9
         ouVC7r7O7IEUmm/amwVUnnv0ZzaiIRaKmn31Gcv1rNTgIJ8ZPJ9PmcCXBiT23YStSZ7r
         NulF27VbPJhbViksYqDtc+cZ+KPKp4/c9nAZY9APaPtEP6Nmni5/D5nWiDSiGMVbXJvJ
         1AgspVnkTeiQSBAjH5Gd5ZZ9l8T8cU0UALXO5X9l74K9pY994GSPyEuc4NoT1PTjAmpM
         d9PgcDcoN9DqLd88QJPy4s48X3UjHu8QHRZHunwjFRnI2uOyQlHVlC9dybrWR8OLA7e1
         iY7w==
X-Gm-Message-State: AOUpUlFTwpn8hbDthkUs0QDnDEPDQat36GhB7SKrHDvz0bb7oVE0J0wN
        48D/Mk6iPFEXzSZS7QGJ560=
X-Google-Smtp-Source: AAOMgperMaCcMMO+Spnr/VlrsATY4LLF9qOzDYmPiArmwDFFV6UTnreBULCDlpZIydnf3tpfV32fzg==
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr6374498wrh.148.1533449283044;
        Sat, 04 Aug 2018 23:08:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z14-v6sm2856743wma.18.2018.08.04.23.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 23:08:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: pk/rebase-in-c, was Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1808050229210.71@tvgsbejvaqbjf.bet>
Date:   Sat, 04 Aug 2018 23:08:02 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808050229210.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 5 Aug 2018 02:30:12 +0200 (DST)")
Message-ID: <xmqqbmahs5vh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 2 Aug 2018, Junio C Hamano wrote:
>
>> * pk/rebase-in-c (2018-07-30) 3 commits
>>  - builtin/rebase: support running "git rebase <upstream>"
>>  - rebase: refactor common shell functions into their own file
>>  - rebase: start implementing it as a builtin
>> 
>>  Rewrite of the "rebase" machinery in C.
>> 
>>  Will merge to 'next'.
>
> Please hold. I found several bugs in the third patch, and it will need to
> be fixed before sending another iteration.

Thanks.  I think the author already corrected/stopped me on this one
and it is now marked as "hold" in my working draft.



