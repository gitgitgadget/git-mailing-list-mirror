Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F305D2027C
	for <e@80x24.org>; Mon, 29 May 2017 06:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbdE2Gfw (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 02:35:52 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33320 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdE2Gfv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 02:35:51 -0400
Received: by mail-pg0-f68.google.com with SMTP id s62so5504120pgc.0
        for <git@vger.kernel.org>; Sun, 28 May 2017 23:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=beHK2zLY5EhRGJ57mzLPaOmyIvR662C321nxlQggVO0=;
        b=ddBGfJp7Wth9JZnniaz0WWlBk94NezmSrbxNUFgXDm8OpM4O1UM1/WIqMmQy31+fwr
         GAbX14leR9lQaUh7VHWpg11x4qlKz+4wCjo3WezmTvOtE/OqcaOqTTK7IKp9MWNjaJzx
         CprLg8qkV9/fVtxd6lUdIxhLebpx+oIcD23976jxqsdsQwelat1Lmkignj/seVci00Td
         fiw6nZW4AU2p08KFSCHMppqSqmKxWd7OvALNWD82LEL8kIV8dlPfkI454B6P5X78MpC7
         Yfu+GDUmsgJR7becCol1VK/2a69se/12WHht6EmaspfOBwz6m8/e/VmzzgTIElg4kV6z
         6znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=beHK2zLY5EhRGJ57mzLPaOmyIvR662C321nxlQggVO0=;
        b=HykqT2VWBdgDkmVn7GpYLkW/3qRaHdITOdqp2pgSnmdC+XyXPyvXNl2b8x011jH/I8
         MIskBAnZNv+zCwDUmY2w1UUugi5EECcJp1S0Uhwuuntf1QNCtQqW7/N8pq7WUgviu88k
         PB/tZUu3L2tIRG6P/CAkW8mT8t/7CN2XRPALp4jqnKP9zzyExB8KV0czZw45Z9UxMHMi
         RBkgdEhLqUUd84ZeYOTyZiTejexNW21QGL4QFxqPISjzjiCE9dG6e/gfgabq7f2U7Tu6
         A/07cvbO7C9pAYtpD/emsfh5Ty2aTepXRIhhZsTozPk4T5BxUFYdqjc/MWZqre/frY2f
         QC0Q==
X-Gm-Message-State: AODbwcAvBYgYCfENz7Env4ZyZXj8XlB2qNsIPs7BiYhqgJqWv9c29HkF
        pMb/ijrWh4EHHA==
X-Received: by 10.99.137.194 with SMTP id v185mr16945489pgd.206.1496039750709;
        Sun, 28 May 2017 23:35:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id i68sm14334993pfi.72.2017.05.28.23.35.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 23:35:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>,
        Git Mailing List <git@vger.kernel.org>, t.gummerer@gmail.com,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/4] stash: add test for stash create with no files
References: <20170528165642.14699-1-joel@teichroeb.net>
        <20170528165642.14699-2-joel@teichroeb.net>
        <CACBZZX7vsz9fRg6bggMETqfcK_WWFijQ1+YbLcfFauqa1s1KpQ@mail.gmail.com>
Date:   Mon, 29 May 2017 15:35:48 +0900
In-Reply-To: <CACBZZX7vsz9fRg6bggMETqfcK_WWFijQ1+YbLcfFauqa1s1KpQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 28 May
 2017 19:45:16
        +0200")
Message-ID: <xmqqwp906ugr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> +       git stash create > actual &&
>> +       test $(cat actual | wc -l) -eq 0
> ...
> Although I wonder in this case whether you don't actually mean:
>
>     [...]>actual &&
>     ! test -s actual
>
> I.e. isn't the test that there should be no output, not that there
> shouldn't be a \n there?

Good suggestion.  There is "test_must_be_empty" you may want to use.

Also, we do not leave SP between the redirection operator and the
filename.  Your example ">actual" is good; the original goes against
our style.

Thanks.
