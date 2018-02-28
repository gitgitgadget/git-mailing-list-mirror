Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840F61F404
	for <e@80x24.org>; Wed, 28 Feb 2018 21:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935230AbeB1V5q (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 16:57:46 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36485 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935108AbeB1V5p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 16:57:45 -0500
Received: by mail-wm0-f67.google.com with SMTP id 188so7876713wme.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 13:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Vg1vLYTTRYhfxYml3mBupZ/VV1yyrrK7ik1GrHs6+a8=;
        b=LQn0B7DTVhrP/BSmZMWaEOrwiScfYQWfFwGq+bDkpGFWmz66brlYz6N9AM+rMZ3UMa
         4hpY7NMTkDuhokVLIwtCymj8rTupB+rddVCf08ADrIMB5uqgQdswYLibcVdogFZWrM0h
         Mo1ZF6KgYEr7UyD0g2r/yPChqYLC3/IH1bOcRlN8lK8UAwG2mvAFVzLFNMtJs556ueT+
         Qm4VPo5UhyOSJf5DE6mAO5VdGbOMHlLCmlEcd5/10UyNaLI4PmIcd4pgkrKKj7etY02U
         q2xWJ2WgS2jPCKEUBBVjJfZiqlnxFRN/XYEYxWHxKnAkL3ZTZa+EybGoepxh+OZP5sJd
         MTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Vg1vLYTTRYhfxYml3mBupZ/VV1yyrrK7ik1GrHs6+a8=;
        b=pxsc/tTp5w87iiyNCpYvgpc7ABojARPJCEIz7tFaQhXjKVgxsOIPOKzh0obOXKujNk
         wFBIcJ83Q+PfVQ2AEY8TywRsAWamO5CtJw1iSbvIbQPg4Ttv+9cEWyvginqq8GfiXzxG
         e7cxk9dB9/zy/h1qefDLEwMc7UoczG33kl6tTLL967CNwDofPeOA+ypQQDwEdW7Q/G2D
         DB4qD5tQ/UFGpHCoPTHQSzQ9V6POWc6GZMN6f4GZxclmcEQbIg3tca0m+OLalgbR4Zcb
         DQuHGgF0G0Ho1i1SaaY35pA+p7JBnabQo1KkwQZjIv/WjuvxESUK/UZr8OSDCj3SbQIO
         LaKg==
X-Gm-Message-State: APf1xPDbt8SdJc9gcaDMDfQS940shMqaOd3pDW91P72AV3p/KTa0y9sq
        lFPvcjiYnbh+Zxbhw085LnA=
X-Google-Smtp-Source: AG47ELu2xJ8hVfRqaWXUCws5MQDhS5G8CQ4y9hSSqM1PoVtjI3G0Cvfzq4gQsSW3TbkncdBK4NNa0A==
X-Received: by 10.28.71.135 with SMTP id m7mr864wmi.115.1519855063642;
        Wed, 28 Feb 2018 13:57:43 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d27sm2978346wrd.60.2018.02.28.13.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 13:57:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     git@vger.kernel.org, Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH] hooks/pre-auto-gc-battery: allow gc to run on non-laptops
References: <20180228044807.1000-1-kilobyte@angband.pl>
        <xmqqpo4pkmiy.fsf@gitster-ct.c.googlers.com>
        <20180228214654.t4rcqmcb37q3grdh@angband.pl>
Date:   Wed, 28 Feb 2018 13:57:42 -0800
In-Reply-To: <20180228214654.t4rcqmcb37q3grdh@angband.pl> (Adam Borowski's
        message of "Wed, 28 Feb 2018 22:46:54 +0100")
Message-ID: <xmqq8tbckca1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Borowski <kilobyte@angband.pl> writes:

> 0 usually means a laptop on AC power, 255 is for a typical desktop.
> The current code can't return 2 or any other unexpected value, but if it
> ever does, an unknown error should probably be treated same as 255 unknown.
> Thus, gc should be avoided only if the return code is 1.

In short, your answer to my question is "What the code does is the
more correct version between the two---the log message was lying."

Then please do not talk about 255 but explain why "only if it is 1"
is the right thing in the log message.  That would make the result
consistent.

> As for the second paragraph,...

That paragraph reads just fine.
