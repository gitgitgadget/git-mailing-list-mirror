Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DAA01F453
	for <e@80x24.org>; Sat, 19 Jan 2019 01:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfASB0l (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 20:26:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42625 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfASB0l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 20:26:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so17165746wrx.9
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 17:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=I1gCXppwCiCtNgaW6ekLUcObCHo97tTdbTmhmd4qJg4=;
        b=UB0skAhPPozvt+vdEvGpp+MBezwGaYkHvG3gZMHiVCKdyJTdy26EPP+nVjxWjNEauK
         6h86DeXorgdRiJ1WeY8Oq9X/h6XfJjz5kCsBH/Anz7+Z+myMisATPougd0Yeu7Vuy9X+
         fCGkblWv+RVe+rv3jFPknAAAl+0pZ4INTMXCgqy5GqvTSQiTT3VdsqN0DSkxKDx4Q4tO
         faGgHL3OAXrKwRj0dB4jT0H2ey9XYyL1gwzGqylR71nQnZt1Cxt1cWfry1/WP+f8QBl7
         Z03eUk4dHJyNQS4lYTLfSxNvgafyKFtKJFfQRJ3BZflhJFQWCdfKJ925oSE7XNoCn6Qz
         88wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=I1gCXppwCiCtNgaW6ekLUcObCHo97tTdbTmhmd4qJg4=;
        b=ZJN+NZI6fIjAY6VPHd+bFdd6hOIHYUPXr6ifOlYkNg0AcNVClH4DkWbnvdBZpQba9e
         Q1TMXTE7rXiW7G1O01Ofz4/vDLgmyI6GCqkenAE+KST2zdkszUemXvOLdWsQCIVpexCO
         e2wzdL///Z4zv9h59pgNOklvIqh+SJ8f3ocweS8czUkFWn9m7awVS0JuyczHLsWelSH7
         /RC9ElQL/E6sWKsm8GnLx0hWKw+M4B+Le/KVTJi6+ezRTl0B+6P+mRH6nuv4UHYeUvPr
         952g6dmjgNAPPzzf7v5j3NS3Ytzm3vFCRvU9W39LzgotlKRAtShhNWESEC8eObXTbQZ2
         6YRg==
X-Gm-Message-State: AJcUukd59TzmFQcwRaIaKqhbYc42ia23r+sxmlXsvMUat+wIQekg/h4L
        WGXelnt5pErmhRZuBpMoDxSGqwrf
X-Google-Smtp-Source: ALg8bN52Q3xQaLiQ9vZ0u9ehyf9iSsTUW60jWk5mRD1Oa0n5p4d07eodWsvrTlsjuys/lSDO0YjcSw==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr19714354wrr.67.1547861198705;
        Fri, 18 Jan 2019 17:26:38 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h184sm28409187wmf.0.2019.01.18.17.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 17:26:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 0/9] commit-graph write: progress output improvements
References: <20181122153922.16912-2-avarab@gmail.com>
        <20190116132947.26025-1-avarab@gmail.com>
Date:   Fri, 18 Jan 2019 17:26:37 -0800
Message-ID: <xmqq8szhigj6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> This was reviewed & discussed shortly before 2.20 went out the door,
> but the changes deemed too significant during the RC period, and
> instead we had my much smaller 01ca387774 ("commit-graph: split up
> close_reachable() progress output", 2018-11-19) as a fix.
>
> That's now landed in master, and this version is rebased on top of
> that.
>
> The changes aren't significant, one patch was dropped because
> 01ca387774 did another version of it already, and 09/09 is rewritten
> v.s. what 10/10 was before due to being on top of 01ca387774.

Thanks for a well-written concise background and summary.
