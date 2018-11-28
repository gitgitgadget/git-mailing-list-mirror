Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E720D1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 19:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeK2Grs (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 01:47:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42996 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeK2Grs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 01:47:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so23114173edp.9
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 11:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ArkkYGL3H45Df17ZPUDeDZT6eejQx8S84L7YLC8Kzbs=;
        b=I46a5LD1ciLZrdxXXTnQV3mrSXdiSNsmajezzTWfA7XYaCq8wJ8cYfobOUQVQs/hKo
         sbZ8Ql3kzQ6rvjkWxrhC2lhD4Rddpa7PzfSFrPM5lcMjUSP3Y7BiEiEv9RKfW9Gwj6/I
         7Dl1OKxXrjnx86rHlULPAQO8uOk5iOi5hS3t0lURQHZIoILTwoHCgkDsQnjfK3AKVyih
         ThEg5n35mibAcb93uCwoWRR4s1UZWu6pM0n5aVYXRcjSHDabArTQeCy2Ghaszo1myBlE
         KGhBmw+g++y/LmuKsOW+r56OK6Ry6nzDte1j1268Lf8PzziUujTIP5QNQtUt8m1EqmYD
         k67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ArkkYGL3H45Df17ZPUDeDZT6eejQx8S84L7YLC8Kzbs=;
        b=YbH82kvkkWH8hUS6uiNfiXbtrkXYopnifxuphoaCS88cUxE5/hcw6XdAvvrkY4ckZT
         0iY8uScSstdc4AEmu21yrbqjNDvGeNHTR6TVS5YmTvIh+qIF2XohtwAFwaNnB6bPSUix
         5KpmqFd7OnmK27H3Z6/h3wJOhK0Xt90sTN9KykrbQx2tfjo5r3hCm0iGu/i6N0AHouwN
         cF1BakMn7pxx3H7ApRuI/+Us8ff26wRlpHWmeIwyKFY+/kdCEolfi17UdpGAexb7ad9V
         O3YCM6KHeYlJjqdNwvVa9AJJC+BtqlXe/pwOHniWEkMOHHxjumXf33Zzy2cNA2P7LcJY
         KdPw==
X-Gm-Message-State: AGRZ1gKFqq1rq067QwxKsiMT/mzOqHvohAVyr0PtrUWjxSCU+Dn8UABU
        qoq+TetxAWV0Li8Ytdm724m48cf2
X-Google-Smtp-Source: AJdET5eUb7Egm2ZLOXEHdm1giC1MJlvrk8s7ct71rIDl1lhmcg4Dmj5KgGYmGjCC/w0obKEYVZoGIg==
X-Received: by 2002:a17:906:2972:: with SMTP id x18-v6mr28305391ejd.28.1543434300525;
        Wed, 28 Nov 2018 11:45:00 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id w24-v6sm1208103eja.71.2018.11.28.11.44.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 11:44:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Pawe=C5=82?= Samoraj <samoraj.pawel@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-reset.txt: render tables correctly under Asciidoctor
References: <CAN0heSph-a08AzsihqqxfC=nqmUQLsqx-rKGULXQ-gmT4+c10w@mail.gmail.com> <cover.1543429054.git.martin.agren@gmail.com> <1596a9ff9fa6849f53590de1b15eb18ee6b41e4d.1543429054.git.martin.agren@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <1596a9ff9fa6849f53590de1b15eb18ee6b41e4d.1543429054.git.martin.agren@gmail.com>
Date:   Wed, 28 Nov 2018 20:44:58 +0100
Message-ID: <877egxyojp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 28 2018, Martin Ågren wrote:

> Asciidoctor removes the indentation of each line in these tables, so the
> last lines of each table have a completely broken alignment.
>
> Similar to 379805051d ("Documentation: render revisions correctly under
> Asciidoctor", 2018-05-06), use an explicit literal block to indicate
> that we want to keep the leading whitespace in the tables.
>
> Because this gives us some extra indentation, we can remove the one that
> we have been carrying explicitly. That is, drop the first six spaces of
> indentation on each line. With Asciidoc (8.6.10), this results in
> identical rendering before and after this commit, both for git-reset.1
> and git-reset.html.
>
> Reported-by: Paweł Samoraj <samoraj.pawel@gmail.com>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>

Earlier I was trying to get the Documentation/doc-diff script to diff
the asciidoc and asciidoctor docs without much success (hadn't used it
before, just hacking the Makefile to turn on asciidoctor yielded syntax
errors or something).

Is something like that a thing we could make into a regression test?
