Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FF1A1F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 07:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeCZHol (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 03:44:41 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:40569 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeCZHol (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 03:44:41 -0400
Received: by mail-qk0-f178.google.com with SMTP id o64so19129543qkl.7
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=l3NN206BbULEO4nBV6SpmiT5m4fgzaVXCM1/pujw9ew=;
        b=ca4Wq+8zf75QfbJ7rj70SN+Qc3VugKguwZb8qGMKBSkPpCEBn+LKve5jumF5b3GqHz
         FNpdrj+WhN1nH9WbzpJoSZLtOitOI6/qZLpGIFetpxOz6Z0yHSRKJnovuXALst1uXeaI
         kJzcRsd/OVk5oVYH8oeDmKaVKcoOrWKi1PI/AZ+FYhIXGmNiYvcqb4URstTTD701gWeh
         M8QD5CJNq3F1j70i1Vcn5NYrmMzcchAX+pXx+ttyhSYSlWb1HhRIgiVwROTLPT41CWBr
         BWmNt1882iQMcXd+uV4xby80HRxVz/VL/LrrTF49rcyhNlf9QXM1IPw4qmxVocf0MCME
         L3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=l3NN206BbULEO4nBV6SpmiT5m4fgzaVXCM1/pujw9ew=;
        b=JBCrmUTy+XaMBgfQkj+ruhfOGHApRtXgowOgGbY+XTHiP5D0ZkLHrrQkD3oqXFUKzS
         CzlM2aENC3QNtx6PexkdMqbG80XWhpn5hcxZik1Vwa0dEu0ZXCEqIwqYVbALDD6XrzI9
         gJjNfsV3+tF8I8uHbtilOG3cZN3KDi/Oj2OPsSV9+6mWJsZV2S10vJFg11uzxQ6itYdu
         MHwTkOFmXIzve17hxaHvYQpVbRbIw0rcIBuov0sFIgQyG0xPatdsYBSv548RmUVop4Go
         Ohg4doznrEmO3alB4KOQyjG8rnGZlaIu7zYiVKDJfLGJeersJkk/rG9VDrUzquH6xaQ/
         Xszw==
X-Gm-Message-State: AElRT7E1H72O8MISOQbn+ZvtKY6g1VatABHN11ZqU9PD0NUi3Z6HhQr6
        GdazdUMJEBbduTw5UnWBizhNdb9RgD7S0L6bC8s=
X-Google-Smtp-Source: AIpwx48t1U+/0PmOOmxiPnXFRyNRR+IiGK00+hIyPAwlIcSqjbD+chW+a9lubd0tWltgkSnL/lEUlsXvDqnIR4xMXtQ=
X-Received: by 10.55.182.70 with SMTP id g67mr14367104qkf.314.1522050280323;
 Mon, 26 Mar 2018 00:44:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 26 Mar 2018 00:44:39 -0700 (PDT)
In-Reply-To: <20180326072505.GA12436@sigill.intra.peff.net>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com> <20180325041056.GA22321@sigill.intra.peff.net>
 <CAPig+cRe9AmFv=GCxPOo5vcLGFuT1qdM60M4KV5P6UN+Ai-QoQ@mail.gmail.com>
 <20180325043337.GA32465@sigill.intra.peff.net> <CA+P7+xr2-OidiX9ve6GwOR4pSOe4Gn=A3Aow5L=oLZgZE+XqMQ@mail.gmail.com>
 <20180326072505.GA12436@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Mar 2018 03:44:39 -0400
X-Google-Sender-Auth: hkF20AeX87MmNlsrNnwDRF5nlkk
Message-ID: <CAPig+cTcqSa6AfeMQivnSdL=y2+WWw2MtSavDciMc84RcKURMA@mail.gmail.com>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local branch
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 3:25 AM, Jeff King <peff@peff.net> wrote:
> OK, so here's some patches. We could do the first three now, wait a
> while before the fourth, and then wait a while (or never) on the fifth.
>
>   [1/5]: t3200: unset core.logallrefupdates when testing reflog creation
>   [2/5]: t: switch "branch -l" to "branch --create-reflog"
>   [3/5]: branch: deprecate "-l" option
>   [4/5]: branch: drop deprecated "-l" option
>   [5/5]: branch: make "-l" a synonym for "--list"

The entire series looks good to me. FWIW,

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
