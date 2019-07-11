Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2398B1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfGKR2f (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:28:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46453 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfGKR2f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:28:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so7129760wru.13
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=x+KaemgUVKyxGdWikjeZcCwmxXj480feW2ukSLj4NT0=;
        b=ReFyVe3kzgQbiDmETdK3bw+lL3VV4v5dQ78VTDSfozW1ASt3m5hkB/6X8emiR+9cHq
         9iPBqSmUuw8iegecXLAxjgReSl1/lC2xbiPt8YgWWFS+O6VPx9SBhD+yDAIOoqti3Q8M
         89RAcFJptwo/RE6nSbzo0xEo3/tiHUBlJOB31bt8LCCVX/zkb2kmisOcB3tfyRl6IgNX
         P2Vjxt5g+NXrtVT3wskjEbQac3Ogg0NTnqiY3j75IbrrHX4lKHnhDdmvG4Qrl6OsitZc
         QE47JqR82Y4jfvzjvQcx5h4l3bdBEpmboF6l6shwwL5dXZM2rYS3UB8a8ry5pUJo35hE
         9crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=x+KaemgUVKyxGdWikjeZcCwmxXj480feW2ukSLj4NT0=;
        b=IJJrzay+dCS35kME6GdPTcJZlXBA89z7dMd4dru1phAWB0D8RZlBr9szTKH1LgmiyV
         bQG9+cCRo26QFz6fqRMh3xMO5Hz8+5hx9ilLuQIPLWFy1L7Yi6zOQFfSx1saEbkIG0KV
         y5E8PFvCRN8eVoTFUH7LbCDz5KhYDAgxCbwE1UlnPJxpTc6/39kfupwW6On55pB5fvI/
         Qd9UroqhQk2fN4G27s3wEFebsdQsyiA5DyPEChgMuPtx9pH4lcW/5VrAhhFxIXQuxoX1
         4LRZzQMOsGJ8njIer4TNB1o/Z7pHFh5zqsEZhvTSDOVCmP+BnDNq8ZiSqi2927nnebMA
         kYog==
X-Gm-Message-State: APjAAAXMl1p/Do3EsJSAjXaxXUA89VTKbHOcysb0YxlLrsLqZ5PAmnOd
        Koj+MudTyxPkHwn4bF9BYQyMUY9v+Ig=
X-Google-Smtp-Source: APXvYqzqjw52ll1PV13G1gZ4flUAT6shjlcWPHHVbuigZlsEKfxqMGmscogQHReem7Yw9zZYqJ/USg==
X-Received: by 2002:adf:e446:: with SMTP id t6mr6402437wrm.115.1562866113340;
        Thu, 11 Jul 2019 10:28:33 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egd227.neoplus.adsl.tpnet.pl. [83.21.67.227])
        by smtp.gmail.com with ESMTPSA id f204sm6982534wme.18.2019.07.11.10.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 10:28:32 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
Subject: Re: [Question] Diff text filters and git add
References: <009201d5369f$4da5d030$e8f17090$@nexbridge.com>
        <20190709215104.GA20936@sigill.intra.peff.net>
        <00bb01d5371d$453a8520$cfaf8f60$@nexbridge.com>
Date:   Thu, 11 Jul 2019 19:28:29 +0200
In-Reply-To: <00bb01d5371d$453a8520$cfaf8f60$@nexbridge.com> (Randall
        S. Becker's message of "Wed, 10 Jul 2019 08:44:47 -0400")
Message-ID: <86h87sa3b6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:
> On July 9, 2019 5:51 PM, Peff wrote:
[...]
>> No, textconv only applies when generating a diff to output, and will nev=
er
>> impact what's stored in Git.
>>=20
>> It sounds like you might want a clean filter instead, to sanitize the fi=
le
>> contents as they come into Git (and perhaps a matching smudge filter to
>> convert back to the working-tree version if necessary).
>>=20
>> You're talking about "the diff engine" here, but note that git-add would=
 never
>> do a diff at all. It cares only about full sha1s (and optimizes out re-c=
omputing
>> the sha1 on each invocation by using stat data). So outside of clean/smu=
dge,
>> there's nothing else going on.
>
> Thanks. I can script this instead. Will do an external diff then
> --assume-unchanged when I detect an equivalence.

If you want to ignore changes, --assume-unchanged (i.e. lying to Git) is
a wrong solution, as it can lead to data loss.  It is meant as
performance optimization.

A better solution would be to use --skip-worktree, which though meant
for sparse checkout can be used for ignoring changes.  The only problem
is that it can prevent some safe operations, like git-stash, because git
thinks that it could lead to data loss.

Though I am not sure if they are needed with clean/smudge filter.

Best,
--=20
Jakub Nar=C4=99bski
