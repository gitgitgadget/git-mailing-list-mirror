Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBDA71F404
	for <e@80x24.org>; Tue, 20 Feb 2018 17:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbeBTRkD (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 12:40:03 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42998 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeBTRkC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 12:40:02 -0500
Received: by mail-wr0-f196.google.com with SMTP id k9so16728927wre.9
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 09:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vHoRhjuzEVJNf9iGgDU12sGz3ftQNyJHxdxTDmVMU2U=;
        b=VvzoSLJTAJuqNl+LCyIvHyjdM4sM/sK7oL2TincwMIXf2mbisd/fi2TnwZzqYKT1OE
         VA0+x9lb2vHPcsIOvUDULMcP4OtXbOIIj5ao0+dutH9FTzhBJHm0Ks1btlvJXcVbLEIp
         xj/bWAeH8zz0Yb7ZrPTKX45KMjXeHBZTSG61WVQJCgTEMN1BS1lCPJ1ll9xtD5A6yOiA
         t/sXTgBvQN/k5LsLCjhcOvaAqiqzVTL34nlTft17p06CgjjVkfpX6as6gxG3k+BzVt85
         jqk4Sqqo0ZgZYFIIxCpn5WnZl3yVkUj7qTwQoWoKdtXjjxXrcX11mUKwsIjUlnyoq4d+
         6gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vHoRhjuzEVJNf9iGgDU12sGz3ftQNyJHxdxTDmVMU2U=;
        b=X/G7BbYbl3EtHy4ax+7cfvZKg2HX6wYFEOHRgk7VXpka6hzFUFU5F9mzbvLZ0S9qMx
         8vloICI1g87JI5HOmvlnuKAMGJsP9iRrUUW3i4uyzDreDd3oRUcDRRSlicIM7RaPcGZ1
         /zAk/uOsxaRF10AVMbgVkY+KQXG4+UvLyYir7H6wLkdXqgXWN7HywGz0Weghvm7MWilY
         Dmwl2tD4ETDCGbZkLdf98yBKTZCBsPFezOyL3DQQTCiNcRnuN/I33yWN4ZLqcfegX+Yn
         TLcFtg0TOC47dGKQK09VpJabXJd7bfyiFMSYuUyLaalciGxyCAAnfO1EoTVq2rVmUPVf
         dalg==
X-Gm-Message-State: APf1xPBYDj0XXcVOr+CksNB7g6xRtilmzXX5KaWZ+UXHHEqk4jxKI366
        d0Di6ZscsSeoy6xN/wT3HdI=
X-Google-Smtp-Source: AH8x225QVQ/EDP+cXW3rFCh0pMCbV0/ymCXhXqt8cUur2etLipmwedc8Ccv5OzThO4l4O78E/84W0g==
X-Received: by 10.28.147.15 with SMTP id v15mr812576wmd.91.1519148401141;
        Tue, 20 Feb 2018 09:40:01 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s81sm15633360wma.45.2018.02.20.09.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 09:39:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 4/9] t3701: don't hard code sha1 hash values
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180219112910.24471-1-phillip.wood@talktalk.net>
        <20180219112910.24471-5-phillip.wood@talktalk.net>
Date:   Tue, 20 Feb 2018 09:39:58 -0800
In-Reply-To: <20180219112910.24471-5-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Mon, 19 Feb 2018 11:29:05 +0000")
Message-ID: <xmqqk1v74l1t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Purge the index lines from diffs so we're not hard coding sha1 hash
> values in the expected output.

The motivation of this patch is clear, but all-zero object name for
missing side of deletion or creation patch should not change when we
transition to any hash function.  Neither the permission bits shown
in the output (and whether the index line has the bits are shown on
it in the first place, i.e. the index line of a creation patch does
not, whilethe one in a modification patch does).

So I am a bit ambivalent about this change.

Perhaps have a filter that redacts, instead of removes, selected
pieces of information that are likely to change while hash
transition, and use that consistently to filter both the expected
output and the actual output before comparing?

