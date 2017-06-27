Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99FAA20401
	for <e@80x24.org>; Tue, 27 Jun 2017 15:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbdF0Pzq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 11:55:46 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35975 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbdF0Pzo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 11:55:44 -0400
Received: by mail-pg0-f67.google.com with SMTP id u36so4780718pgn.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=duPjbwHSPichbkuEj2F6zYSvvar5KjRCowiaVXJTfiw=;
        b=D8q1JyrMNkG5gsqRr5lputEYPqrBLbdhxbXbd0pRDejK57R5+0HVQceIBezd7crw7V
         Kbf1aXeyCfC6QqSu3ED1TWMLmBeTGuC+M7Pb9lkM8ut4nqqeoUYvNw8o1Q2N51DcgD8N
         iCJV/42s0WSwLnY85QBLoN973rauYa/cMomfCNVHx9hMMhlVGIMvu3s8srQzrupaDZy/
         WXoixrwtrYXQ5N3mBpSQbA9hKwft5ltETgbjcLzw3IdIY36t0HhNl1XvHREKk+temNYG
         LT5CHNiNIIZ0WQPsCMsQdFkajVui+9CiPA0RzgRDs9MTBSvkWgQjpkahAaJd0kwrrs5Q
         zBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=duPjbwHSPichbkuEj2F6zYSvvar5KjRCowiaVXJTfiw=;
        b=r0qJr/2hrpNM2uDEPRC6WOyUlmhr9gEojxveLCkMaZyIjhd5FujNH2EFikoF9QrY4F
         UQTBmt9k+nmA7z6zMiPJcPhTaZi8+jBS28bwNNaa4BlkPfyecnbT7a63F7X/O1+5/6Rr
         dfudYfTNLITfk/b+Lvkt3uG/VesnrACwsmNMcWK8VtH49UMUMlBtNRKf86SCPctFD2lm
         MtRDF3ot+b7/VV1OHfsjC8BXGTsckPDRfERytCYKL4DfoYyS8msEKCozvqZ4jl02iFbb
         SpDaKL/J1f1M7WzuUhr+YPdlRxFTAL3HgnOhgyd9qD3vdoln7TUjS9+edvKmhG+4MaSA
         EiAg==
X-Gm-Message-State: AKS2vOy5RYryWvYWrTMfLx9amjgyQcXRpaRLY4DJOBcv34TvctyAHLdK
        3RNbjWwGEw+4Aw==
X-Received: by 10.99.177.78 with SMTP id g14mr6101960pgp.131.1498578944058;
        Tue, 27 Jun 2017 08:55:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id f70sm7865416pfk.27.2017.06.27.08.55.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 08:55:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com>
        <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
        <20170627121718.12078-2-avarab@gmail.com>
        <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 08:55:42 -0700
In-Reply-To: <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 27 Jun 2017 08:22:15 -0700")
Message-ID: <xmqqefu52znl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +#if (defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
>>       defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
>>       defined(__sparc))
>> +/*
>> + * Should define Big Endian for a whitelist of known processors. See
>> + * https://sourceforge.net/p/predef/wiki/Endianness/ and
>> + * http://www.oracle.com/technetwork/server-storage/solaris/portingtosolaris-138514.html
>> + */
>>  #define SHA1DC_BIGENDIAN
>
> These look sensible.

By the way, I wonder why this didn't catch the sparc running
Solaris.  What does Michael's system use to let the software know
that it is targetted for a Sparc, if not __sparc?

