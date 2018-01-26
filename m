Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B283A1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 17:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeAZRoF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 12:44:05 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:46570 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbeAZRoE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 12:44:04 -0500
Received: by mail-lf0-f46.google.com with SMTP id q194so1643230lfe.13
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 09:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r8CswQYSb0p8/VRkz6fhjMMGNSoWPZLvoOjDprd3Rc4=;
        b=QvZyZXrYFO9g75JVghvuOKPch75Z3iNtbiP+CU3OCdfKoS7130yqq0XcvLkJ01BJUB
         uj417Jyfvoaz/VlB+dQjK5hmxrNquWMKUvz5gcXOF1xGx4x9GxPiLEBHgW0l9IA2ZIEw
         R4qQxGKqnl+lZzq1bKELQty4XtNV+C6p7mWCgZu8FJjV2Pg3urfhJ04nyWIoSrkCuQkm
         bgEHGykIKD8TBThjwJg50FDBpwxB3pEBahPL3vREBsIzbK0NPI/XDNRhnoKq8rsunk1I
         WnftngU97W+NkwDfY5KE4MqHQtPvfXRLja/m+mwj/X+nhAsQcmWCu4kNi8I5sRUI0JxJ
         DSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r8CswQYSb0p8/VRkz6fhjMMGNSoWPZLvoOjDprd3Rc4=;
        b=szLaBxgNncAPIZCqK77R9iJFz0mF279z8Z+t2N75rInWekr57DarZLaCpcKzJ54eMN
         hnBpu+V40qY+Ez5ITvxVrff1wbM9dzLpVjNhCg8Rc9F34vwiGnrA1dPA3d876uJ0VZyD
         7190mucPTR0dQjQebCKDks1I5HhPt21HapUKwH5T2Q9C/KdWroZx2iqhbmr9iQQ7mtKI
         rVXIeGtEUusIXWNZEyXL0PBBruFUknmTm0MAJNus4j/CnygPR9YA1I+KZjI+5pVR2t/n
         1D2vD3EyjEshoEPTQSkAZ/+5jJ7PolU413CP5OOsxznb3kVATZAOatxDC6SY+2884IW9
         9kjA==
X-Gm-Message-State: AKwxytcox7xuvf0xvja/cb/UMPtMJv/DvGmBmQIsWHhOGsuPc7bIEacR
        xszI0sOXGc+j90QULbNOpuc=
X-Google-Smtp-Source: AH8x226SC9Jo16ug/dqA7k58lCgAhzj997JlaDk6vd7agr5jOzjLgW36qSNSWIFJcUYgo/sy7j5D1w==
X-Received: by 10.46.65.154 with SMTP id d26mr2863542ljf.109.1516988643482;
        Fri, 26 Jan 2018 09:44:03 -0800 (PST)
Received: from [192.168.1.138] ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id c73sm1522744lfg.77.2018.01.26.09.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 09:44:02 -0800 (PST)
Subject: Re: [PATCH] setup: recognise extensions.objectFormat
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>
References: <66fb698096ed14ee58b2611f41f2e3e5dfa49059.1516798941.git.patryk.obara@gmail.com>
 <CACsJy8BFsXAMAGYjKp8EBrepqZwgKrAtqRKyiKLOydWbpzZWWA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801261002570.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Patryk Obara <patryk.obara@gmail.com>
Message-ID: <8c6b33fc-38e8-f617-0466-c282b3e2d61d@gmail.com>
Date:   Fri, 26 Jan 2018 18:44:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1801261002570.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/01/2018 15:41, Johannes Schindelin wrote:

> On Thu, 25 Jan 2018, Duy Nguyen wrote:
>>
>> This config is so sensitive I wonder if we should forbid changing it
>> via git-config. You can't simply change this and expect anything to
>> work anyway.
> 
> I don't think it makes sense to forbid `git config` from changing these
> values, as it is all-too-easy to change them via `git config -e` *anyway*.
> And we already have the repositoryFormat precedent with the exact same
> issue.
> 
> In my opinion, it would only complicate the code, for very little (if at
> all noticable) benefit.

That's my sentiment as well, but some measure of user protection might 
be necessary.

I was thinking about doing a sanity check: when objectFormat is set,
re-hash N (randomly selected?) objects, where N is sufficient to get 
3-sigma confidence.

This might be necessary to prevent object store corruption e.g. when
objectFormat is set in repo, that is cloned with reference from repo 
without extension.

-- 
| ← Ceci n'est pas une pipe
Patryk Obara
