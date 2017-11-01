Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A21C202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 19:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755169AbdKATiD (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 15:38:03 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:56976 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754714AbdKATiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 15:38:01 -0400
Received: by mail-qt0-f173.google.com with SMTP id z28so4048295qtz.13
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/x778EbfPKQpO3aRy4pY7u6DRAqL5Zfhu7SQoWiBjFA=;
        b=SdKV4nyWtIL+bkLQdnxhVZSTh4tShVCOFk2X+J/5diU3EGa7v3XgtTYs65XA86AF8L
         WGBXJr6Jyc6dnt4mon4/p+DTi9LmNz5IoOToutXp5dyqxnbftx7e0p/L08XZM2iSArFX
         aiCsWrQDuRyLVWcGc0lCDaw+ojOoKamP+hjSLjskUxddMUbZ+A3GQsUzjDp+LLdd6f2Q
         QuoHxALTWpqjdCL/xju8bOwN0VSqOtuDqC9bdooXLT8HVL1DH9Zuz1z5ina67F46uQPm
         o2Yb6Uz4PdailiflUfIFVwyLSpAQuxihvEANrcgJy0OtthNGDjHCALlZWLT12e/+4B/u
         WByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/x778EbfPKQpO3aRy4pY7u6DRAqL5Zfhu7SQoWiBjFA=;
        b=jryVFQY6XEU6bjwdv8uDw5xZE9XHzM7U1SHkvjxApVkLeQKBKFbgmzvVs/HUaGMXEX
         jstyV/JBCb0yA0nejurekYAFHYNTHClzgY6rWGfLjHxVocILESXzNIW9Tjxi0KAIqN0U
         WxjIG51WEcScEDOpOa82QiY8vAk130Z2lVRKr4cLS/4dKD2y08s7w9jvjrWttjImWNE9
         mZGfaQXOCDBfYBDXdmseU6vnPCG96agZfirX7O+5sEZtic35gTbSuVFSKSC/zbfV5qbj
         n/WR5HaoSpA/bCMERDT1/L9aZBzHfg+tBjdaytRYVgEWIH0dAkw6c/VWc54GfDV3RkEQ
         7vfQ==
X-Gm-Message-State: AMCzsaWQgF8r6USKPvB8x5Q2hlCmFN3xQ6CGxN6neFmdqGhGcuDMnJ5K
        mf9Qjwv3uuDjC/TiSFdPw0IbzigPhOEc2m/fEd0qAg==
X-Google-Smtp-Source: ABhQp+SmugVQW0OcSAs/P0Pfcq7YeCO928+7J9jLmO0ZJPaicdF09Z+vA6VjQ4gMo8yC1tKK3VPKtgaj/hbI92xLe68=
X-Received: by 10.237.37.132 with SMTP id x4mr1514217qtc.224.1509565080284;
 Wed, 01 Nov 2017 12:38:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 12:37:59 -0700 (PDT)
In-Reply-To: <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-3-sbeller@google.com> <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011316590.6482@virtualbox> <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 12:37:59 -0700
Message-ID: <CAGZ79kY-yooE4cZK0Sxh3AL32wi66PRh1LzB8e3djq=bnLDHFg@mail.gmail.com>
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order of
 the commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>, Kevin D <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 1, 2017 at 5:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Nov 1, 2017 at 9:26 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>>         ...
>>         (
>>                 for x in four three
>>                 do
>>                         git rm $x &&
>>                         git commit -m "remote $x" ||
>>                         exit
>>                 done
>>         ) &&
>>         test 0 -eq $? &&
>>         ...
>>
>> Ugly? Yes. Correct? Also yes.
>
> I think returning non-zero with "return" is how other tests avoid an
> extra level of subshell.
> Ugly? Yes. Correct? Questionable but it seems to work for those who
> wrote them ;-)

I think I'll go without the extra subshell and with s/return 1/false/ as
the exact value doesn't matter.

Thanks for hinting at correct implementations
