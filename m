Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB2931F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeBYTBW (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:01:22 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52892 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbeBYTBV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:01:21 -0500
Received: by mail-wm0-f50.google.com with SMTP id t3so13532457wmc.2
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7NdnCHH9XuWRWmXXDA5PpQqnfOq6dyyHxMG1tV5XR30=;
        b=ZAbwLzxR9xkSIdzMJiOJZWf0D2R1QFoEDUROYwEL9QPwCrq2wDSFXiYRpCBYEcHcNW
         h8YmK0B9Mo7F8Qp8Rz/wKeBVShKFH4tSvVZhLcm2WrPwfDfQ9d1lnAtswtS18lgDB7ae
         GnTSK+/LQYyV1CHBb2ugXsA+QN6MHaJplGS/T3lfsbnPxXAbNTVWjW/xG8KaP690Pvra
         6cojJbGpyBR4rZ4ZRqsjxnWLNFsUGmiy1DkIPMI8leRtvjHSmE2fLn+a+QYsD5BaFZQA
         g/lfAn3IpsyBFuRsTsd9gM80aK69IBQru6JlzifkGSDGCzdi9hzmXdOraoIXXhfvyiha
         Ikgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7NdnCHH9XuWRWmXXDA5PpQqnfOq6dyyHxMG1tV5XR30=;
        b=fxuaFyFIdfShpQZ8sJHPRiC0mqfNROfv5eAJyv/ub/1TGc4lJsRTxKXE6QFQHkhy9H
         U2wpQkuxtVhOZ2BQqsApk/2dTwF9hzlodZEsTiXWmDE2xeB1plgNDfZEsSxm7gXp/3vr
         e/wU/RIh1+R0ziNV9fGnxUyVJV57CG/20qkRysHVDMVSwK6pjT18rnZBCkv7Tfbwm+Uw
         CvJYBjCqXTWxaVDYQIHnozh0koblM+FdWzmTtN5yAB2dGoMId+bSWIa9KvdziTXvTrjR
         Y6SjDN/3/JTOLA/f0DJT3HTdfmIERTzEIoaNjTLgyy9Jw4OWrX4JWZemHb54Mj7Ay5kl
         UYMQ==
X-Gm-Message-State: APf1xPDSHBWDm6+YmzAP46n7SK0ub/kSvF/zsCxDkrMrWcZscMxe8C1/
        ftO9KUcTOWl+GsYn0f8MfyUYqRsn
X-Google-Smtp-Source: AH8x226u53Es3nfsxPROrik2XAq9c9b9MbaCRQhY86A0Di7rI1+CNJHj60dzfqTC9kXXcqHO8DZcgA==
X-Received: by 10.80.182.73 with SMTP id c9mr11057840ede.55.1519585280137;
        Sun, 25 Feb 2018 11:01:20 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 8sm5415189edw.72.2018.02.25.11.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Feb 2018 11:01:18 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 1/8] perl: *.pm files should not have the executable bit
References: <20180214222146.10655-1-avarab@gmail.com> <20180214222146.10655-2-avarab@gmail.com> <20180214224137.GA136185@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180214224137.GA136185@aiede.svl.corp.google.com>
Date:   Sun, 25 Feb 2018 20:01:18 +0100
Message-ID: <87r2p8evwh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 14 2018, Jonathan Nieder jotted:

> Hi,
>
> Ævar Arnfjörð Bjarmason wrote:
>
>> The Git::Mail::Address file added in bd869f67b9 ("send-email: add and
>> use a local copy of Mail::Address", 2018-01-05) had the executable bit
>> set, this should not be the case with *.pm files, it breaks nothing,
>> but is redundant and confusing as none of the other files have it, and
>> it's never executed as a stand-alone program.
>
> Needs a period somewhere to break up the long sentence with comma
> splices.  How about:
>
> 	The Git::Mail::Address file added in bd869f67b9 ("send-email: add and
> 	use a local copy of Mail::Address", 2018-01-05) had the executable bit
> 	set. That bit should not be set for *.pm files. It breaks nothing but
> 	but it is redundant and confusing as none of the other files have it
> 	and these files are never executed as stand-alone programs.

Thanks, used this with s/but but/but/

>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>
> With or without such a tweak,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks.

