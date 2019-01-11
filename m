Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143AB211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 17:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbfAKRrd (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 12:47:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34453 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfAKRrc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 12:47:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so2531157wmd.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V2pNPiy4wXCarciDhFQ08oOLxpgUgKei5u6NFlqN5Ug=;
        b=F0yMh0gj5mpfqpfxEyMhYexB7tKnLCYvrj90dgfK+vTMlklxX3JvgxQ68vgEu2jaSf
         Y8LACANsC3bhnminkKHtiqQSwt1qcp+91gXsl7KLoWx1WfKDbEyNLAsBU7mz7+zjbBld
         kPJNqKF+O/9X1zM3/JGa2Kd70c6V58VgnygC0Voq6EYwaYijjCmoqPukglDe7wvZK3qa
         SEw6l4PJwoWuZnZJncuGLHv0x4BaCtP+4ap9ySG/yu4D+sRUrRegyN/8rlesgBeJX7vi
         HFn/dMD2pux/I33Zr5Jc/vd08uadM896x3S4ig+q1Qp5TWVs1QdnNRGEAQh5QHIGMoPV
         w/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V2pNPiy4wXCarciDhFQ08oOLxpgUgKei5u6NFlqN5Ug=;
        b=KoYD+wiyVBaIHdCq8WUTIRgFMmMN+Z1JF4i/bjawjkytdYWqMngPiUfFm/4WjEK499
         o+93uBmRezlGACRaHpQJWF/+PKb2SdbjQI8/92mHgboJ7tmKF/Ygl/stgrFGChQDzzYu
         4pgsCa006bkcTeq4VAvB3YrGPaFwCKukcKf8N4jRa0NUkmhkk+5huS3YjAX3tZsGvZPU
         7/ms98tXrW10hlRqh+8WF7vFc2E4k2fEU07gJFhGVZ7em8iYG6Jop2UYrg911G554/bq
         V7jq+5BXpV4JOeGJUppfBqL2Eu9+Oo1f87HeDS19JAn9qvGH/xRZB20KfRfn3vavEYua
         vHXA==
X-Gm-Message-State: AJcUukcAwW0RGT4AWiYXznCb8DCy3xuKdpFOJ2LCBgiuekmdGc40NRZJ
        Osu/ukDlyE85CJiVUvpaRnE=
X-Google-Smtp-Source: ALg8bN7/7UMfqVjufN6VBjlAavIyB27VUFZ8ggaOxwymK5Zn2NTOk/zxwsABJEzBHVqu8nh6wbhwaw==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr3163618wma.24.1547228850517;
        Fri, 11 Jan 2019 09:47:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c65sm20792679wma.24.2019.01.11.09.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 09:47:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Issac Trotts <issac.trotts@gmail.com>
Cc:     git@vger.kernel.org, Noemi Mercado <noemi@sourcegraph.com>,
        Issac Trotts <issactrotts@google.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
References: <20190108132048.57142-1-issactrotts@google.com>
        <xmqqmuoa4wp7.fsf@gitster-ct.c.googlers.com>
        <CANdyxMzDevigyMTCixjV7bfa-UZ1vknwxt0X=RGc6LZz7F4UXQ@mail.gmail.com>
Date:   Fri, 11 Jan 2019 09:47:28 -0800
In-Reply-To: <CANdyxMzDevigyMTCixjV7bfa-UZ1vknwxt0X=RGc6LZz7F4UXQ@mail.gmail.com>
        (Issac Trotts's message of "Thu, 10 Jan 2019 22:28:41 -0800")
Message-ID: <xmqqd0p3ytlb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Issac Trotts <issac.trotts@gmail.com> writes:

> Sounds good. Btw, did you queue it yet? I didn't see it at the mirror:
> https://github.com/git/git/commits/master.

No patch goes to 'master' directly.  

Once we see that a patch is in reviewable shape during the mailing
list discussion, we wait for a few more days and unless there are
more issues to be addressed discovered during that period, it hits
the 'next' branch, and spends a week or so before graduating.

Before all of that happens, i.e. when a patch has not proven itself
'next'-worthy, I may pick it up to make trial merges in order to see
how it interacts with other proposed updates, which happens in the
'pu' (proposed updates) branch.  As there is only limited amount of
time in a day, this obviously cannot happen to all patches sent to
the list, but I try to cover as much as possible.

You'd find it as 5ca3af27 ("log: add %S option (like --source) to
log --format", 2019-01-09) on 'pu'.


