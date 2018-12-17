Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B341F405
	for <e@80x24.org>; Mon, 17 Dec 2018 22:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeLQW5y (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 17:57:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38326 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbeLQW5y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 17:57:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so12208940ede.5
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 14:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=w7m3Vl//fghVEFWumR8SFg2Y2t/Gghj5B5YOj3n3Nmc=;
        b=lWjTgsoza2TdzVaOKb3HnFF9axtObk0AxD+wNrw0Grz06zjK3jyBHhjDJzJk64+b3L
         Ib6WjOMQ09ewpTAYyBHvc56m9+7XOJuwu/mKy8QoL54SwV/TpgQ9+fle0v4URKB3YjUl
         6CR/lNOOzQDoTNDVgcX1iC7rz0ZUJ3NKc+hZM/CanDgOs9iN0iCI8hSfFLTxts2dXKNx
         XctyA6Aq2qy9gwrs9iCwigxXACqaPkWIybmmkDs99nwPBXyJFPb3MCIKO/m3GEGn7IM/
         ny6ejlx+GyUI3OL5lGw4vO+0BwtSm7O4xo00UfXR36z3OFk/TjrwD7fPcmXZoUGb7qvu
         QV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=w7m3Vl//fghVEFWumR8SFg2Y2t/Gghj5B5YOj3n3Nmc=;
        b=rsB+VWCOBAXnG0Mbyo8sl0hGq0UH6fl/4TOYIp5JyJND4HKShNTMC5QYRWjyEh/opz
         xRaTDu/KPZtG8PxbCpIkaWr+MCoEDjGS1B1bMH9tmcPkXO6yLEZ5ZhiVUw3LiWVikRGL
         j6xTpAncjL3ex3AHPgP1ile5u0kSjCB611Pp6v4Qs1ouWvp5ZW2ioXTA0h8wWPCcBfae
         ZMJkEQijnpZio+H4sKoNPiG5Us098buqrDGQnYbOHxtmLQbaVE91tXCgkaw8Y8Nz1pd+
         n8vBAuvw0OpavClpILZLNvL+gLRDodxwGzhOFTuYu5ZyhC8K6o0hoj9CgGnqfbgeabu8
         puMg==
X-Gm-Message-State: AA+aEWbX/pzJ/Nan7M1ya+Vx8ee+2Hjk2UBguMsQuiZKqM7B5YZ+edA2
        pq/HHNAOh28F7N+FuNWWpM0=
X-Google-Smtp-Source: AFSGD/VhVk7L4XuLdyg94aA4N2UAuJo06lTdDlr1K6V3IOIbC5GFzjNEyH+fj5Awf3U64Sd0MNEnCw==
X-Received: by 2002:a17:906:2e4f:: with SMTP id r15-v6mr11275335eji.198.1545087472562;
        Mon, 17 Dec 2018 14:57:52 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id i14-v6sm2008751ejy.40.2018.12.17.14.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 14:57:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Fredrik Medley <fredrik.medley@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH] upload-pack: turn on uploadpack.allowAnySHA1InWant=true
References: <20181217195713.GA10673@sigill.intra.peff.net> <20181217221625.1523-1-avarab@gmail.com> <F368D768-7DC6-479C-8888-2A41360B0B6A@novalis.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <F368D768-7DC6-479C-8888-2A41360B0B6A@novalis.org>
Date:   Mon, 17 Dec 2018 23:57:50 +0100
Message-ID: <875zvr2235.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 17 2018, David Turner wrote:

> Overall, I like this. One nit:

Thanks for the review!

> On December 17, 2018 5:16:25 PM EST, "Ævar Arnfjörð Bjarmason" <avarab@gmail.com> wrote:
>>--- a/upload-pack.c
>>+++ b/upload-pack.c
>>@@ -54,7 +54,8 @@ static int no_progress, daemon_mode;
>> #define ALLOW_REACHABLE_SHA1	02
>>/* Allow request of any sha1. Implies ALLOW_TIP_SHA1 and
>>ALLOW_REACHABLE_SHA1. */
>> #define ALLOW_ANY_SHA1	07
>>-static unsigned int allow_unadvertised_object_request;
>>+static unsigned int allow_unadvertised_object_request = (
>>+	ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1 | ALLOW_ANY_SHA1);
>
> ALLOW_ANY_SHA1 already includes the other two.

FWIW (and maybe I made the wrong call, and have no preference realy) I
opted for this as part of "this change doesn't do any of the hard work
of extracting the now-dead ALLOW_[...]*.

I.e. the diff context I had doesn't show all the ALLOW_* values, and
with the context given it might be easier for reviewers to look no
further than "this is what you'd get before if all
uploadpack.allow.*SHA1InWant was true".
