Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB852027C
	for <e@80x24.org>; Tue, 30 May 2017 22:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdE3Whj (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 18:37:39 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33499 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdE3Whi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 18:37:38 -0400
Received: by mail-pf0-f182.google.com with SMTP id e193so84734794pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 15:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nhDKTW0b3wy4CY5ZLJZyGj7++1am+2m0XFMj3SeGlGE=;
        b=TZApJhgrnevujQoFlJ3rxSFiCVtkEnASC3VOJf1bgbbZquYelQYE/w99fvDLhRzN+5
         vpfG1je3KwQ+eZLRe9nkvgN9T/sg6JOlBeXpxSeTpFAv/kL/NAvVoXkkLawOCB2kZxYj
         HPM5pWNVTvPTNEqLcB+XSlxt75cgtOzgTeTnOHn6DBAD63UxhpDF/c5LlT3KR8n/wONG
         cT/yyGr/zyJZAg2x6+a50d+OV8X0l6CCAo7Xnd+wMWhWg5k5WEcu4P4f5ZEzksr9MxI0
         CSHV4Ozfvkh/hcLUW/DUU2IxCDOKOcP7LmjS4PmI6ma9xSq8ur0oJ1MMRmKDqkUI33nZ
         IT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nhDKTW0b3wy4CY5ZLJZyGj7++1am+2m0XFMj3SeGlGE=;
        b=LfzL3ysHwAiimT4ExDhFB6ZNFC7DMSSX3I++aIFoKP8DSNcarLDuuBg2uJfg1zuSKj
         mLQ48J/ls4mV8ABGdp8Kr7B0EIEn4rc7PcNMNv2Lj3rCwEIPQOkIQwxdWkJBmJpznm5b
         LySgHZj7/AVKR8JAnS+4J5iZjNm8l7BYy6tZIfR0jc+H/K3fHSvqcMSgADbFWNEpS9X8
         L+b4M9ug3FMy6gd7A8j8f6Eb28SmWDmDv2oQTxyDbJBRvc7sWNGiVs4p2IihOJ0YXBN/
         zwZYYLqbIzevjm/0/pGnv8tErhd1dsi5HOUA/HasjxkyPYCmXhgX0uQ76j6R9y7hN7He
         f1fQ==
X-Gm-Message-State: AODbwcA5TDLRgZ5g7E3eohI+KPOQuBp1CTQOaj8spyxNVXSsMWg9lD7J
        4kkH/Mm9hO831A==
X-Received: by 10.99.112.3 with SMTP id l3mr27919716pgc.13.1496183857155;
        Tue, 30 May 2017 15:37:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id t3sm20516127pfl.60.2017.05.30.15.37.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 15:37:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/6] fsmonitor: add test cases for fsmonitor extension
References: <20170525183612.3128-1-benpeart@microsoft.com>
        <20170525183612.3128-5-benpeart@microsoft.com>
        <CAP8UFD0OEUogQYL5Eo1kBy_1B=dBcdEJyc4B_qAUOU=2XnrxxA@mail.gmail.com>
        <bfab707a-7f3a-ca7d-1f67-66dcb6ab2ea6@gmail.com>
Date:   Wed, 31 May 2017 07:37:33 +0900
In-Reply-To: <bfab707a-7f3a-ca7d-1f67-66dcb6ab2ea6@gmail.com> (Ben Peart's
        message of "Tue, 30 May 2017 17:21:51 -0400")
Message-ID: <xmqqa85uas42.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> I did a quick search through the existing test scripts and the
> majority do not link commands together with && when they are in a sub
> function like this.  I find not having them linked together is easier
> to write, maintain and is more readable.

I had an impression that it is true only when the series of commands
are not about Git.  When testing git commands, we should expect any
of them to be broken (by somebody else ;-) and prepare to notice it.
