Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F21A20248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDAKp6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:45:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51130 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAKp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:45:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so9933561wmi.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=EaaX3ueoigdgDjYIDrVWu9bDkQszviffxKKsawxXjp0=;
        b=S45bVFysjtJHSVvsKyweUU9D2hgNb9u7/nDzBnMEliLz7Ph3I/njdaozPSqV7O+rbV
         oFL0cv6w9Egxo84gkWioM5ucnW4yzRKylqaU5GgM8UWwTlD0FkK5vrgo/wLRBi8v6CKh
         TrrarRLeJvyTD51aZ85EzfMhixAUNCrRL4rddYQti/m/d01Rfwryh3No7JDE+vqw3VVL
         cNGaJF07afa4EeyBUhRGMfS2hplSyaDTEsQ+n0xrGwAR5ktZFQ4h2sr7HgmDx4e+a+Ye
         U+dEV6SJTl9fPK4mBMXtfoy1SnWrHYXxDozSzmsX/lRNBx2Z0eO5tBe4uYWE9GAbl0EP
         VjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=EaaX3ueoigdgDjYIDrVWu9bDkQszviffxKKsawxXjp0=;
        b=JVAU7s7dP+ZEg/vO4KePmpfwfuUda0h02kNn4hgGT+HfdjDKC7eQLKCGlMCc1xbesA
         eesYQmc8EWwNq/ULkeCo8Mbo0+E7haV798+qw+YZ71CcmFlgw7RUVWoNDHPbfH3K8GqH
         GySFNQH3e+uy43XXX5MXLczxkQ56GwXLc2E7lgRUUtPDCxsmLJ7G8iMMP96aRy1L/F13
         HTxrKzRaU4N2w6JpayEdAEodsCBsg7isYTv7IVJnqsAaRceqsWnVTQV0fQG4HBg8jBoh
         Y/bdZp5J+zxKL4YjDrLQUzL8WF63Cl6hzPW7gezrMM9wUviVL6ZNw41BdxyeW3tI4Xqf
         RJ+Q==
X-Gm-Message-State: APjAAAU0vtWRooFfh3RC+El6QOyOAFdTqn76MsHrBDHWzzkThwiZMGOT
        Y9qsVeg43i0hea1warvPrMc=
X-Google-Smtp-Source: APXvYqz4bLo5gOSsene7mIGFPCQhdeEOZ+llPXONEEH7tCDRNA9kHiNjinSHRsRwzNIU9cW0/MA3Jg==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr11687004wma.2.1554115556275;
        Mon, 01 Apr 2019 03:45:56 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b9sm14772396wmc.9.2019.04.01.03.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:45:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] rebase: learn --keep-base
References: <cover.1553354374.git.liu.denton@gmail.com>
        <xmqqy354o1l8.fsf@gitster-ct.c.googlers.com>
        <20190325000427.GA9384@archbookpro.localdomain>
Date:   Mon, 01 Apr 2019 19:45:55 +0900
Message-ID: <xmqq8swuvw9o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> I suspect that such a rebase will become no-op without "-i".  Am I
>> mistaken?  I am not sure if "--keep-base" is useful without "-i".
>
> It's useful in the case of "-x", although that is a grey area since "-x"
> uses interactive machinery internally. Aside from "-x", I can't really
> think of a situation where we would use "--keep-base" without "-i".

I consider "-x" is a mere sugar-coat around "-i".  What I was
getting at was if we need some mention of the fact in the
documentation (e.g. "the option is accepted but fairly useless
unless you are doing the rebase '-i/-x'").

