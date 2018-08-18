Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FFB91F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeHRTKu (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:10:50 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40337 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRTKu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:10:50 -0400
Received: by mail-wm0-f48.google.com with SMTP id y9-v6so9995979wma.5
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=36JUBl/Znt0FqrDqnYxQeEk7sYEH1xrExYBqdKGnBTo=;
        b=YlogWXoWRaC7o9/dOzktSDGSxHDeX2VPc969b5TSyVhQdAnfwpeqW4OGUo387H2FvZ
         LH52c+smlsgjrLl3kZ7Ws2E+GPKmCE6tRAcJasJae3FkOuwqz96b3vSDTHj351qkvMzJ
         YVr5cG+WnNDKJlSW42xQ3j0EEEGOeoUzRZjBaf9+m7lTFCssedRTEiqJuHm0OTngeq2i
         luVz9Hl9fd8yI9r+yYgHviGmnezN4dNYCi0xGmCQLhs32V0hBHg6pvmc1tw7ymb5kuiM
         J22wkiU6Sn7lauJkgkubsejMmlDL2ovqox8kchBD31oGm3rWzx2vb6ChkuEid7rhtX1F
         Lo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=36JUBl/Znt0FqrDqnYxQeEk7sYEH1xrExYBqdKGnBTo=;
        b=qdXYK4424qWUskbSg9SdBrle1w8g+H2o5ezoX/nTy5zmsafQZxcjHDAKPIkyONg76w
         jUeTFhFplEpY6jX9srP6CnTeVU8/UozLRrmsBtDAJQNpjcJG5OnHF96AQk8Gj5jYTFc9
         wrMlZJmZZ9KGjvUM3pWK44pALhW1g7h9+J9CNnopl2lsAL2lrzJ1tm9RhlL/6NrEsucN
         ccLntfuepdinWByu9pRCiHSWOPtB4ADr5T/eZwOpuzIXWxZGwuYMPXFOPQtUs7NE3C41
         CFXPjqUTqui6mobsRRd68Keg9pTxkp8U+syGnQWH4gn8foqpgIqggYiwrwHNAJHstH25
         26Mw==
X-Gm-Message-State: AOUpUlFXEf5vSkDjIgcn0F2Dts049CdBBWwHoYkNk3izjdXL2+CoIsNl
        Wk37nnkLCwwWkBvG8M7o9SY=
X-Google-Smtp-Source: AA+uWPyOU+F/hBGM3KHrMC7tCPjCFZmxzgAAYXUindkMFB/DLQRFB8307A/WC/Mn0w8Bc8rcmc74oQ==
X-Received: by 2002:a1c:3545:: with SMTP id c66-v6mr21921645wma.120.1534608157628;
        Sat, 18 Aug 2018 09:02:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e141-v6sm12126478wmd.32.2018.08.18.09.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 09:02:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, sunshine@sunshineco.com,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v7 1/1] sideband: highlight keywords in remote sideband output
References: <20180807125108.104293-1-hanwen@google.com>
        <20180807125108.104293-2-hanwen@google.com>
        <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com>
        <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
        <20180818060911.GC241538@aiede.svl.corp.google.com>
        <xmqqmutjagc7.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 18 Aug 2018 09:02:36 -0700
In-Reply-To: <xmqqmutjagc7.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 18 Aug 2018 07:40:08 -0700")
Message-ID: <xmqqin47acir.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> -	strbuf_add(dest, src, n);
>>> +	if (0 < n)
>>> +		strbuf_add(dest, src, n);
>>
>> This check seems unnecessary.  strbuf_add can cope fine with !n.
>
> I was primarily interested in catching negatives, and !n was a mere
> optimization, but you are correct to point out that negative n at
> this point in the codeflow is a BUG().

Actually, let's just lose the conditional.  strbuf_add() would catch
and issue an error message when it notices that we fed negative
count anyway ;-).
