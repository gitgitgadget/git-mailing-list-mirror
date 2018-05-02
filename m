Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA7221841
	for <e@80x24.org>; Wed,  2 May 2018 10:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbeEBKlZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 06:41:25 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:38020 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeEBKlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 06:41:25 -0400
Received: by mail-wr0-f169.google.com with SMTP id 94-v6so12151118wrf.5
        for <git@vger.kernel.org>; Wed, 02 May 2018 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3DWXb0UkRcNoJB5vY+xit6SQayrDZ3X70PWCIWPV57Y=;
        b=dC96thOcw2VazH40ZVsJ4aLmIbDH2ddQHPi1V3DfRIGj+fQPAPQBVuuPCMjV9Jtxdl
         iEH43UFahmx2IDMVQ+lRJwkJuFRCYCVnQzM8IxmgaZ7ptGC2ktmBLPjTojYFLcsDlMp1
         W2fenWSJcyqhTy9xCq3Qx5lJYwxjFlAxyjEARU4vlmAWOsj/JwuvG8conrj5tupwcwgf
         2v+JXiO6ws8qKc6z6lv2kbKwV9qh6GMc7C4FyQeKot+Ce9bBazCOzEuId24aEgp0XthG
         PgrNhGThZn2ONIgJgTzViodxhUiZ/8t6v3Od0UnyxkkY2JYOaYBPiTEzg/rc7igY3C3c
         KDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3DWXb0UkRcNoJB5vY+xit6SQayrDZ3X70PWCIWPV57Y=;
        b=nowNe92/O6AW6sUdRPE8dcYgLd7kd1HUCzapYUx4l5d0MzOPUfYEFFRfmqtBax9Fd8
         0w6JHa+XFK9FYE3X2FY9QEomUscIFRyz6Cl5B1MxeWutaKq85IgdMbJ4UZZ6BT52roHt
         qeJCeq1+rlvElK1wQUuPccrIPOSYeKT3vtGFMjFOPU2HmhUPSAu8H9YhBt3CM7LZ4En5
         hCMk5EqRpdd7icoMLPCqK654kbYyID6e49mA2uXFfLZrFMr/pxyhPFVbxsv6ZU4JjG3k
         a0xiwI5KED1hcik6dchaPDmdacQRUAi5q8xTNsW+G3qP3FInG/1xlmaCeQz6y7hi6L1w
         htPA==
X-Gm-Message-State: ALQs6tCB7mXWACCyYesUjhP1ZRi+xOT8RRvvDyY2QCyd5Qr0p3YgRNft
        MmkndxYcV1L+Pc1NMLy+/xY=
X-Google-Smtp-Source: AB8JxZpS1TCKTxfQTyzTvjYRTetY0t6meluC9x9ZX7w5XoPpwXNz/49AV0qEuXl1bJapyCNX4YhSMg==
X-Received: by 2002:adf:c4c3:: with SMTP id o3-v6mr14363480wrf.108.1525257683554;
        Wed, 02 May 2018 03:41:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q7-v6sm11070809wrf.49.2018.05.02.03.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 03:41:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t1406: prepare for the refs code to fail with BUG()
References: <cover.1525040253.git.johannes.schindelin@gmx.de>
        <9bbfd73a8e03a888a5e9e8800d853ece518a8bf5.1525040253.git.johannes.schindelin@gmx.de>
        <CACsJy8A7K6-W=H_08JcJgtziz3aQ4B1WgOcsoMSMuSvEQDW8=A@mail.gmail.com>
        <xmqqvac6wwrw.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1805020930340.73@tvgsbejvaqbjf.bet>
Date:   Wed, 02 May 2018 19:41:21 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1805020930340.73@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 2 May 2018 09:41:39 +0200 (DST)")
Message-ID: <xmqqpo2euypa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> As discussed in this thread, tests that use t/helper/ executables
>> that try to trickle BUG() codepath to ensure that these "should
>> never happen" conditions are caught do need to deal with it.  If
>> dumping core is undesirable, tweaking BUG() implementation so that
>> it becomes die("BUG: ...") *ONLY* when the caller knows what it is
>> doing (e.g. running t/helper/ commands) is probably a good idea.
>> Perhaps GIT_TEST_OPTS can gain one feature "--bug-no-abort" and set
>> an environment variable so that implementation of BUG() can notice,
>> or something.
>
> I think we can do even better than that. t/helper/*.c could set a global
> variable that no other code is supposed to set, to trigger an alternative
> to SIGABRT. Something like

Yes, I agree with that solution for t/helper/ part.

But we also need to arrange a way for things outside t/helper/ to
set the BUG_exit_code at runtime, so that those like Duy who causes
BUG() to trigger in some "git cmd" under development when running
tests for himself, where he does not want his BUG() to dump core and
contaminate global core storage.
