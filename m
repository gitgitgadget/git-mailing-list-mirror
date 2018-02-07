Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF34D1F576
	for <e@80x24.org>; Wed,  7 Feb 2018 08:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbeBGIHy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 03:07:54 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33300 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeBGIHw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 03:07:52 -0500
Received: by mail-wr0-f178.google.com with SMTP id s5so7006wra.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 00:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qqYgirrBCC6c0/ltMpx84Wn3PoZ0tZ9AfwGg9W5sgys=;
        b=qDQYKSJPj5Ixp9RbYEDMwo9Ms3lrrgM9R34DuyDcMHUVOYIkVZXDRHFmi99NfpguMA
         WzhLABkW33Zh/h6Q1kmvfA2ymLStAAg/aDgAQAN6qalrDkcmPp587yNWk1S5gprX+YJS
         dfh0Di0nHxEi3VkyX7vTdful4Ba8AxeeU0nUys0IMmpICt5+7sIzLqRbyB1bWtEEwkmV
         3FWNdpjYLVobQ3WAGh5M/hUNaNTSZyseReL+eQ4qN/m2r0IqdUplcvVHzsl0VM1m8/Fy
         +gBCr5ENArl4bByjKp2fWRelZd+WgIumyzM0OJczdx+nYGccRnUxrAONy68gp1ULPaCI
         eu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qqYgirrBCC6c0/ltMpx84Wn3PoZ0tZ9AfwGg9W5sgys=;
        b=P3+AQAdKu9CRjQb2/NyF401rahpVQHr5o8Iwzk1zFk5nuW20CFm0U3jEZUcEKjlXpn
         nsOFHCDG1tEW9k6svCLlJMopxNYfLPeGAr+fF4Df8cXsEQp+vVeQ/9sGxG9tJ68BKdwF
         QM58xitssbNun0yWh13IuTymiq3UGNNNwpwsCrVdHMRxEYPHoXcnusdvjT9KaUiJ560J
         fvCy/ylPAV+0uD4TEA/8FlQRWyZ59MmrY85qkAgd3Mz0bBBzanqlauUXpWiOYSmumrrN
         gaN9XFLaQtiOGD0ABooZkCO9iRoLFkMUpYy6+flIghnvEO9r7Oyhw9MmMcD70QTnbQF4
         AJjQ==
X-Gm-Message-State: APf1xPAdN6d7M187e+y42dg+orBPOtH08n8+h6CFPo52u30WSN9rpi3H
        OnxEO6yaX4HyT85S4hxMNAE=
X-Google-Smtp-Source: AH8x225XRSCnyBpnDy1inJmUmQEvrbB3GK9myw+L01l89T8Sx/MKpIWn7GuIe+juWi78HXhXURGYnA==
X-Received: by 10.223.158.132 with SMTP id a4mr4592954wrf.236.1517990871526;
        Wed, 07 Feb 2018 00:07:51 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 123sm1474106wmt.31.2018.02.07.00.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 00:07:50 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] t0050: remove the unused $test_case variable
References: <20180206231303.8483-1-avarab@gmail.com> <bf3ad52d-4aa3-8678-9466-3996f6cba11c@kdbg.org>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <bf3ad52d-4aa3-8678-9466-3996f6cba11c@kdbg.org>
Date:   Wed, 07 Feb 2018 09:07:49 +0100
Message-ID: <87fu6dz0h6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 07 2018, Johannes Sixt jotted:

> Am 07.02.2018 um 00:13 schrieb Ævar Arnfjörð Bjarmason:
>> The $test_case variable hasn't been used since
>> decd3c0c28 ("t0050-*.sh: mark the rename (case change) test as
>> passing", 2014-11-28) when its last user went away.
>>
>> Let's remove the "say" as well, since it's obvious from subsequent
>> output that we're testing on a case sensitive filesystem.
>
> Am I misunderstanding the message? I think it reports properties of
> the test environment. And the tests do run on case-insensitive
> filesystems. IMO, the message should be kept.

It's obvious from subsequent output whether the FS is case sensitive or
not, so I thought it was redundant to keep this report at the top since
we didn't have the variable setting anymore.
