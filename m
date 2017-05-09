Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E61961FC44
	for <e@80x24.org>; Tue,  9 May 2017 01:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbdEIB3O (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 21:29:14 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36512 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbdEIB3N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 21:29:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so11989633pfg.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 18:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vp+DSEwFREorWAg0L14Vvijom6UTxBc3cs7NlJsatow=;
        b=WhhrBjhJ0CyWSTqIgQEt5GrJt4MLwtMqQaHNsFB8xm2iREg/bKc/gYFGXqKoEdfKjk
         majDeXSrRk2d1rfnH7NtoDdxg9LKIbr0yVo4pf5MC8ZWBBRz8nduyBEu12u/3R2qDvdB
         TBFb6hsj6Q3r/V/HFmWGagaP3l59753k0jbfFXw+LHpOeDZoy5xzohiwP+x+erm86jTw
         i5AgFt1lYvfbzu1dPCyuMtT9ecEs9piKEoxoCYa4cj53Wz91a8iKAoy5Qn1+MGSkGF7x
         NtLqlEwzdU80VPZBVxrlu2DJPq/LWwjoJF2MUQqVrfOf2LBRvWGm38cj6iUzdqWAzy3j
         9wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vp+DSEwFREorWAg0L14Vvijom6UTxBc3cs7NlJsatow=;
        b=dgvOrHvroNdW7ZY/eeb0ac2O63LNc3E5ylp6sAd8rkZQg5QR7vcpd4w66Y14ZozNC8
         36lqa0e6Rmaiv94KwfwWTKC4Bh14kLc1QUAPCX/TLwQn0EXN7UU6r0BI7GKLbPdX6aZD
         pSU1pX/UvUB/9RrNaW984zzON6z8pY8HGgVTx6Ty0CZFjPxRLoF8+30Wjtyii4rlH+R/
         bQCco7jT+1I3C1bhVsK6OgcMg0hSgZxKiYlV53ktkhOXhlh9V8GsZEgw2cbJtao9DH8c
         wBob8jMdC/RiM40bxM/uj3P3DXTe3WgS+9fnux6ekztgNCAzWNI7qXT2iZITDaP+kVTC
         ka0Q==
X-Gm-Message-State: AN3rC/4VWIL97efcDs3p/4eUx8rbtE6IJ8lUwFe1JnyhozViLIyx3awQ
        Vlv80pbVNjLRiA==
X-Received: by 10.99.149.8 with SMTP id p8mr21858561pgd.154.1494293352678;
        Mon, 08 May 2017 18:29:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id t5sm19539598pgo.48.2017.05.08.18.29.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 18:29:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, larsxschneider@gmail.com
Subject: Re: [PATCH v2 1/1] t0027: tests are not expensive; remove t0025
References: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
        <20170502155631.24848-1-tboegi@web.de>
        <alpine.DEB.2.20.1705021809340.3480@virtualbox>
Date:   Tue, 09 May 2017 10:29:10 +0900
In-Reply-To: <alpine.DEB.2.20.1705021809340.3480@virtualbox> (Johannes
        Schindelin's message of "Tue, 2 May 2017 18:11:11 +0200 (CEST)")
Message-ID: <xmqq8tm67r89.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Recent "stress" tests show that t0025 if flaky, reported by Lars Schneider,
>> larsxschneider@gmail.com
>> 
>> All tests from t0025 are covered in t0027 already, so that t0025 can be
>> retiered:
>
> s/retiered/retired/
>
>> The execution time for t0027 is 14 seconds under Linux,
>> and 63 seconds under Mac Os X.
>> And in case you ask, things are not going significantly faster using a SSD
>> instead of a spinning disk.
>> 
>> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
>
> Thank you for this patch.
>
> Apart from the tyop, would it be possible to fix the formatting to look
> less strange? (Unless you use this to transport a super-secret message
> steganographically to an alien planet or some such, of course.)

Ping?

Thanks.
