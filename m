Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594CE1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeH0XYd (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:24:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54392 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeH0XYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:24:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so80475wmb.4
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=yY5cdlvhy/aE3xAgFzRRUNOn4nVLywtkj70ls9O5KJU=;
        b=siDHgnKLG+cUaiGJVrHErcC5XqwWFhHFuQTYKtYErCUgaWskzjb7WDOihtfk/ok5Nz
         L3nkKsW7QmsAZAdOmBHIduqpmpETxTmzcbSqvtvI8rN4a6SWaMSqRoc2jdw6R1eYJvnN
         7lVi/q0vB4S6cCeX26580LilBnp+W54crmC4IQm3KFiJzIOu9hEp0g1MPHgYXM2JGY1R
         6iFj0uEBY9Ksu0YiTVJ9nrcTsOd4CF6bgdgAgJTXNDFGhgO/EbovALnsukNC7Yml2ngb
         JMbBakqihDROgvoWMVW2gYAMvzeiaa/iWdrauSU3pmz/BMGvA/WX0FifbwXHVs+plfpr
         Ek/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=yY5cdlvhy/aE3xAgFzRRUNOn4nVLywtkj70ls9O5KJU=;
        b=rbulM6iWXGdOZRYSPjZ0cAJhJxX9m0whvk0O9JpMurxFH/N8IoM/dfC5/7Vr9OJiwS
         QT8oKbJ2DcCJxoE4aV4akSgDARKHy5iVdrH3db2liTieu8WN+HTnRmx6S7d+5rBhbJTT
         Lopqt5pG1LW7tvz2M27QxFToLjfU7inBp+vBBTR58ZE4em+X9MX6Tfgtk7/YBs7B5M2r
         ekpxwbLpnAAuEsfo2RG0dkWnzKIUZlMYPZG7cfyDU3kU+7sIknxGVOIsBpl8xNNLMP0g
         +7NZ4fh50iocKoQ5oZkzrsMZMqdW8FSkllKscPETH0pDhEQZZQBsf1s9M7I1i/ROorNc
         0vkA==
X-Gm-Message-State: APzg51AXoeymYGFtJiiEWo8qgH5R3lW0NyP48uepvB00GLOXdswoO5bc
        W1vVJ8DN/O0Ffa4iVUY7TU4=
X-Google-Smtp-Source: ANB0VdZroks7MYr2HXiFlqYffbt5QPR10hZ17LEvCkMk0dmek5tFK+JRL/l5AbxwIK2betqCSFNvNA==
X-Received: by 2002:a1c:5c4:: with SMTP id 187-v6mr6532491wmf.10.1535398593837;
        Mon, 27 Aug 2018 12:36:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o15-v6sm131155wru.23.2018.08.27.12.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 12:36:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 4/6] tests: use shorter here-docs in chainlint.sed for AIX sed
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
        <20180824152016.20286-5-avarab@gmail.com>
Date:   Mon, 27 Aug 2018 12:36:32 -0700
Message-ID: <xmqqpny3iou7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Improve the portability of chainlint by using shorter here-docs. On
> AIX sed will complain about:
>
>     sed: 0602-417 The label :hereslurp is greater than eight
>     characters

Remind me again not to forget doing s/here-doc/label/ on this patch
before queueing.  Other than that, looks good, together with 3/6 for
the the indented comment issue.

