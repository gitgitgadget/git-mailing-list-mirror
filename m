Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51EC51F404
	for <e@80x24.org>; Thu,  8 Feb 2018 19:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeBHTsg (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 14:48:36 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37074 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHTsf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 14:48:35 -0500
Received: by mail-wr0-f195.google.com with SMTP id a43so5956825wrc.4
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 11:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/bknX54RwGhCizYi0eb6nVIVG15+lbIujTttJ8Mdmfw=;
        b=N8JQK+2scEoknZaoy6SsCOqrND+/BvL5DjaAjE58IHahRNxSUKfP8ikyg57ixV3WJB
         02BZ96B89fRAvsSe9dazP9T8h7fyKJTH+DC1NdQnWK1bBcADiIwYa2X1qYQuFemCtkRQ
         N0vErXIzpn8HdHUv3tN94j4uczUFbVnW6fV0T3cpsAh4LJEHjW/pt0tL+otqDX1vGzct
         KdEYPheJNBTUxbl+UvfI+f6p1JlQ6spRl82jLToRC19VHavCsLGf0vMnzxOOzIRyvE5l
         crQMWMB0TIrSifkVZmjp5utrZIVNVCdQyG97ujouIunk+g0p2w3K73ZwsPXdyqRyL64w
         qKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/bknX54RwGhCizYi0eb6nVIVG15+lbIujTttJ8Mdmfw=;
        b=Mlai2bLn/6QDmncD+aXzrbWCayU5lyEEmW3TY1BX5YKWgCoct9hyfbW15TYhFO+gqG
         uph7Ut+K0GoHsmz+calz4XupP3JF/enw7LGlVFw7Lpy/8tiuHCyIJboCMEek1/VqN4fC
         GPtB8yzFeM9MzRVRkS2+kdzlciqz/QfjUssliLtGIbyLyySuI1lCaJMprNmvtDr6qJq9
         nkf5JZSm/JXcBNOQCHrfiPoVvUJrYNiz1B15DOhjthscx4vsKfXjv2wn8RiVfJ5S3oW1
         q6Vt54jnFOxt3SKoqXU/Mh2Tq+7sovWTbITreRMpkrNGA3uwvZpQvwdCrKQ1sS7Cn1hW
         FPMg==
X-Gm-Message-State: APf1xPB2IIRqP0jTBWadoJigcn8xvZd3eC6RuMFrUUxKpnNbE2qreJAv
        6njGHfzITb+sWzjkRBQ3dxjz7a7FMUw=
X-Google-Smtp-Source: AH8x227JL1p7GJomPYNIumfGx4Eo3A3FReOadbWPR2bWPnktTlNUE7Hq8D4QqI8GXeq/d56AUkJZXg==
X-Received: by 10.223.185.3 with SMTP id k3mr290323wrf.18.1518119313343;
        Thu, 08 Feb 2018 11:48:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 137sm682589wmm.46.2018.02.08.11.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 11:48:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 00/17] document & test fetch pruning & add fetch.pruneTags
References: <20180123221326.28495-1-avarab@gmail.com>
        <20180208161936.8196-1-avarab@gmail.com>
        <87d11fmjer.fsf@evledraar.gmail.com>
Date:   Thu, 08 Feb 2018 11:48:30 -0800
In-Reply-To: <87d11fmjer.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 08 Feb 2018 19:21:48 +0100")
Message-ID: <xmqqlgg3qn3l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 08 2018, Ævar Arnfjörð Bjarmason jotted:
>
>> As noted in my 87h8quytmq.fsf@evledraar.gmail.com there was a bug I
>> noticed in v3 where it would segfault on some git-fetch invocations,
>> but there were not tests anywhere that caught that.
>
> ...and of course this whole submission this time around should be v4,
> not v2, but I didn't notice that I didn't adjust the subject prefix
> before sending. Junio: Hopefully you can pick it up anyway without too
> much trouble, sorry.
>
> FWIW I've deployed this to production @ work to some tens of k of
> machines (low "k" of which have users using git) without any issues.

Will replace.  I found that the resolution of conflicts necessary
with the jh/partial-clone topic is a bit different from the previous
version due to addition of an extra parameter to fetch_one(), and I
think I didn't botch it, but please double check when I push the
results out in a few hours.

Thanks.
