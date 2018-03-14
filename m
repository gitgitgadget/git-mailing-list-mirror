Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE381F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeCNTq6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:46:58 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34861 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbeCNTq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:46:56 -0400
Received: by mail-wr0-f193.google.com with SMTP id n12so6001297wra.2
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tLn3GTTnqNHT6YknPAMdevv2bUuEMjmZXDV1Q3yBG0E=;
        b=oYc40lEiTQTw7uNL3RBM99s/dntw1jHWWvuRG8r58vo3ewRT7iy7bVVMdQ8+Dm05xf
         IWvVnvCbuejm25jtFZWmeNWaC7C1OMI14y7a4bUkp7dx7tyHxA+fORxZ4+KMb5FVMNZg
         LZaMMuh+/meD7r5wob28EtoWKBpeEit4baOjud5FKPxmmgkcRb6wExsl6gLbSODUcYvX
         FRjLW4pgxuUPEMW+M23aqBGl3e7RbLz3IiwEASFbwBRkKdGlL7OQrRDaXUdDPorgDLaY
         pF04T6GHs5KIzaEx20S253rE46YmLtzCz6xmIVCz6U5+8t2oYrkZ5faT0cBo6cGTQCmz
         YfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tLn3GTTnqNHT6YknPAMdevv2bUuEMjmZXDV1Q3yBG0E=;
        b=ock222Ef7yt5Oy406OqvDSsQy/Uy/TBB8lkl7fq2DF1EU5BZGVvDA7VzngKsvaqKCZ
         996qaaPCI9hVb7CnaMvQmLedK61kQPBtddOn/fnxApLv20WEfSIoj1VqsXCO+jI0i/ny
         xEUORkEnTtnFMHgd6vv4+GpKcCVcaIjNPTeVOUNsnHv85fsfoMaAlvAyp5Lh96V+1AP1
         1DV0/ByVCrrAAlEC8ghU1Me/h0WcTavNEhDidAzdnaM467jV8SkzuGwvCvQPsXhpNT4n
         F7W1YG98krTEb+6HAfJKz3W8sFAfUJ0CZPsttZDLbNdZXUXIg1DtrthzllWtYWfin5WX
         NJUw==
X-Gm-Message-State: AElRT7F6epUXgOPwCtEKlaiNeoHOd/JZl+s4SuB86Mh3Tnemr/kF3LN/
        lIyA6ARBo0IZAfEqmgt/bkM=
X-Google-Smtp-Source: AG47ELvcn9+ttuMNOUyfYiqs+xQJ/PflwBaIi3Hdam+CHqiRLoP5lJL6VCs6cXzdxsSketgLZ774BA==
X-Received: by 10.223.160.42 with SMTP id k39mr5182659wrk.138.1521056814926;
        Wed, 14 Mar 2018 12:46:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k14sm2907791wrc.62.2018.03.14.12.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 12:46:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/36] object_id part 12
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
        <xmqqtvtizjq9.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 14 Mar 2018 12:46:53 -0700
In-Reply-To: <xmqqtvtizjq9.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 14 Mar 2018 09:48:30 -0700")
Message-ID: <xmqqd106zbgy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> This is the twelfth in a series of patches to convert various parts of
>> the code to struct object_id.
>>
>> brian m. carlson (36):
>>   ...
> As always, thanks for working on this.  

There are a few topics that add new callsites to functions that are
updated (e.g. find_unique_abbrev()), so I'll need to do a bit of the
usual evil merging to coax this topic in.  Please holler if you spot
my screw-up in what I'll push out in a few hours.

Thanks.
