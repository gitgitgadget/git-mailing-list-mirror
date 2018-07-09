Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 972081F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 18:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbeGISNb (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 14:13:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44926 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933703AbeGISNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 14:13:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so11942759wrt.11
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9Xij+9NcboDXIkzqMjxjiwjcGEaD//IHfBUoqdPDinM=;
        b=oQqqJehaf1RwiaVkUSIMyerp613mAbgDE/I1lxmxM/uIvIaNLQmBZucvJa4V4jdMKH
         H6V57UfT5NLej3VdiIBl2vRGHsVjIBA19sYR8MWED4unbTLB1QjDq+ja1WYiN+e15xC5
         QVfvtVDq9UTN2HB8xAa7Mt/NzD0dKFcoYJzUIAvMVeMxU790xN5Dkrhh/LN2N0Sc2cDc
         Mco8u6zcAHG6LVopBUNmgnY3Z/ffUFDRhM7cON9AG588eSvb6yND8nGwrJ0Ch2d9oXtx
         4XrDtYk0m0qsEv5Riw30uXQUExPZlE7E2epbYcOgqBlNRRLx8+JnKdxyWewFZWqwKpR+
         YXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9Xij+9NcboDXIkzqMjxjiwjcGEaD//IHfBUoqdPDinM=;
        b=TPtqGsN9uif3pYTYfeqKESiQ+fbL2CEjGMLp0geEbtBolS9tD9iG00jESurtOroMLf
         nB1dDy6kwwedWBLLuQE/lpaAmBaR699B/mvD5AMFdG5zeZCQDcIdCfWjpo4aVEGPF1Iu
         SSMBqlVyW79aR40i2hG+ooT6ruGCILMU2ose3sdsdGN31mTVWe9Bbh4AoBwp5+QuUzhc
         Ry3vjPa4BEB89hI4ZYsS/jrfTHX8UkliVm0RG/Oz3A6qCXOrFql8g2irv4Z49pVVT2Oo
         LlMbNBW+yKqkj/P+iayzO0r9DPRw00EEjKx5kSc1i1cRFkMk1lA/dyCJFX5oDur4PP6t
         Nhiw==
X-Gm-Message-State: AOUpUlGDMFCji+Sf55J1gQkDvO9+buey4D3K4d8M/GUDaXnErLVDf1CU
        /rzWsllfPDlOMFsSOKyCrKk=
X-Google-Smtp-Source: AAOMgpfC9jGtw8OXlUTPIadgjguOnszgiKqZ+P4i8FMGkLpj4ZtlBBjmgOMz9/eB3HQQ9+Xnv9Hang==
X-Received: by 2002:adf:ed8e:: with SMTP id c14-v6mr7732673wro.264.1531160009519;
        Mon, 09 Jul 2018 11:13:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r194-v6sm24918843wmd.36.2018.07.09.11.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 11:13:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
        <20180709173131.58704-1-jonathantanmy@google.com>
Date:   Mon, 09 Jul 2018 11:13:28 -0700
In-Reply-To: <20180709173131.58704-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 9 Jul 2018 10:31:31 -0700")
Message-ID: <xmqqk1q4e0qf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> * jt/fetch-pack-negotiator (2018-06-15) 7 commits
>>  - fetch-pack: introduce negotiator API
>>  - fetch-pack: move common check and marking together
>>  - fetch-pack: make negotiation-related vars local
>>  - fetch-pack: use ref adv. to prune "have" sent
>>  - fetch-pack: directly end negotiation if ACK ready
>>  - fetch-pack: clear marks before re-marking
>>  - fetch-pack: split up everything_local()
>>  (this branch is used by jt/fetch-nego-tip.)
>> 
>>  Code restructuring and a small fix to transport protocol v2 during
>>  fetching.
>> 
>>  Is this ready for 'next'?
>
> Sorry for the late reply - I think that this is ready for "next". I have
> addressed all the comments that you, Jonathan Nieder and Brandon
> Williams have given, and Brandon has given his OK [1].
>
> [1] https://public-inbox.org/git/20180625182434.GE19910@google.com/

Thanks, I've re-read it over the weekend and agree that we are in a
good shape here.
