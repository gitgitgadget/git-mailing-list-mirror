Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC4C20401
	for <e@80x24.org>; Tue, 27 Jun 2017 22:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbdF0WYe (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 18:24:34 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38232 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbdF0WY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 18:24:27 -0400
Received: by mail-wm0-f48.google.com with SMTP id b184so40739813wme.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pm2+7vu7n5gZdCIhO6FKn87Rw2rM5VUsW2zeWrIjUVI=;
        b=qUZZkvDL8Xxl1o1a6Dr3z991eJa2Dzl/TXknv5VV/ZjhTju2lw21K9NczByGSZ7WKQ
         IhllJ1XAdxm6YEcO3SOjOYyC3didYb2u6wCA02bqfGuErFuJefz9szs+lXY6e2lZNpXz
         /LMgw+ZpJo6B+QNWmZodLv8A6c97ytxRvAv4EQP+HYIjLKBHCh0jOyJ5iwwNf0juEQ7N
         36qJgiJuLL6Y/y8ehikMha9r7miGF4P1J8ixFjYoUUuPScgSnDnmVapRh0eevUMVfDrT
         hLU5eI5k9uY0alR/NYL5Fhol285RiP60/Ntj9BMVyXfS0qJppKDAKD+pGZzHBwWrao82
         THww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=pm2+7vu7n5gZdCIhO6FKn87Rw2rM5VUsW2zeWrIjUVI=;
        b=iOt5N4xQAdC1FbFNm7E5BbwCs327HaMqi8OGbdCVuy7ShfZNDYWMGeE+3T4N/9R0bh
         0Pbo4mLVhTg0L2PZeOXg5xPr1fO6x3FEmxCkSJVKCY5zoJBcBHukmxnunrUPydHGlopB
         vVNjeuaN2g5xJk4Dg3P9miZ5Qm/hqwEL3kQhPmGg99wmb1p1XLDAMOlnX42e/rBC+E6U
         HoCfcEw6DvrLZo9ra3biF8pljqjT3qiGIsD3aqrSmF7WnpKcy/mhwl97djwg22GkOD6+
         DvjHk3STcn2BmnfS/sQuG7qeNEOeShHwihFhE+COXQRMuvFx/crvHr32uhWGFfia7HB+
         IzAQ==
X-Gm-Message-State: AKS2vOwXb12ZAeEFfIFs8hhJvHHhH+Cvk0u4j1dIblyciXFH46CDo5p7
        Yq6BiYXruh4fkA==
X-Received: by 10.80.176.102 with SMTP id i93mr5556870edd.116.1498602252089;
        Tue, 27 Jun 2017 15:24:12 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id i42sm213366ede.5.2017.06.27.15.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 15:24:10 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPyu1-0000jM-JG; Wed, 28 Jun 2017 00:24:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/3] update sha1dc from PR #36
References: <20170627121718.12078-1-avarab@gmail.com> <20170627203348.19827-1-avarab@gmail.com> <xmqqfuelyuuu.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqfuelyuuu.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 28 Jun 2017 00:24:09 +0200
Message-ID: <87mv8tjchi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 27 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> A v2 addressing comments to the v1, tbdiff below. Just fixes the
>> subject line on 1/3 & gets rid of the redundant _BIG_ENDIAN detection
>> for Solaris, we can just use __sparc (and indeed we did before this).
>
> Thanks.  Let's have this tested by minority platform folks to help
> the upstream digest your pull request.  The change since the last
> round makes perfect sense to me.

I got someone on #cygwin on Freenode to test this for me (compile git +
t0013-sha1dc.sh), it passed, ditto for 2x people testing on Solaris
SPARC.

Updated a comment on the PR with that:
https://github.com/cr-marcstevens/sha1collisiondetection/pull/36#issuecomment-311502713

I'm pretty sure this un-breaks everything & doesn't regress on cases
where we fixed things earlier.
