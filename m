Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF991FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 13:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbcLFNzs (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 08:55:48 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33331 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbcLFNzs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 08:55:48 -0500
Received: by mail-io0-f173.google.com with SMTP id j65so653373611iof.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 05:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KR6bUg34J/RcdV2IsaDlw++K+/NO1nBFvPAZ8+xvWb4=;
        b=Faok0PVw8S6ouV3AxDTTPS4X+8Ybq2ZAFnOxFwhiS2AqDtC50/neYmxEnKlVVvbDBW
         g2Eyoe1GHJh+RydCRCZC5I/tc+/FmNK/AKiIv/+YkWREyBN0lGAfl8ADE4QLxMpQH8SV
         reHJZEkYvobS8qvOkazmdUSGdwvAqZLkqQKEbXMlDCSatDTFCIWvCS4NFV/gUk5j/+Kt
         IYDa+SBQmGXnZtp0yM28kV4XdocqVOyfjAmOqt88CKXDrTdhJ8XGo2Ug0i5AV44eCbfc
         zu8BvA3kz1OCHQ18HMtNsQHusEwmTgIKlA2qjPF/D3PWJooKXpS7Mh8v7mpKnwMbjdFV
         G5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KR6bUg34J/RcdV2IsaDlw++K+/NO1nBFvPAZ8+xvWb4=;
        b=FmJfgEBPGMIY2lBjyq5FQ3hWvvSTU+MgYvg6HfZHw/QTpZTJ1RQ//cOqSLlhy5aj6S
         ml0KUI7/vBEQrg7vV6rj/DTfXczb5EHVi3y18TG5bThDRMi+O/VTFyFwtY9OId60hUpC
         YFKRMqNj9bIxcntIf+CPQNqEkuqopcLdFL5rhOuhy1uDCchVhd842KExbZmevgxS2JZi
         0r43Z0UEDOcb3kd4+qfEzSJVljy5f8FMQAVIvjby3/DDZGGNIfxJKgN2q5jaa6/YNY34
         Ktm1Z5MYuPzkZvRmXFarpu1EydowuZqV6lPL+5ce8FCJfZys54Y3YcgYBC130exr2mW1
         IQDg==
X-Gm-Message-State: AKaTC01thQI22hrt8Vjsr1+5Li7ySuS1hhB8LF490skfVUpG6HnMPDdyZ6n2NQgjDWz5jiM1J23LSqPBbsVGcA==
X-Received: by 10.107.59.9 with SMTP id i9mr55407026ioa.176.1481032087470;
 Tue, 06 Dec 2016 05:48:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Tue, 6 Dec 2016 05:47:36 -0800 (PST)
In-Reply-To: <20161206134212.mttcb75dov2jvqu5@sigill.intra.peff.net>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
 <20161206125339.16803-1-pclouds@gmail.com> <20161206134212.mttcb75dov2jvqu5@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Dec 2016 20:47:36 +0700
Message-ID: <CACsJy8A=KeGsXAt6ZR-eOkTurSsnYPkt3yTfkYT9aZ86rV1rYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] shallow.c improvements
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 6, 2016 at 8:42 PM, Jeff King <peff@peff.net> wrote:
> The final one _seems_ reasonable after reading your explanation, but I
> lack enough context to know whether or not there might be a corner case
> that you're missing. I'm inclined to trust your assessment on it.

Yeah I basically just wrote down my thoughts so somebody could maybe
spot something wrong. I'm going to think about it some more in the
next few days.
-- 
Duy
