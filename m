Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D841F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 08:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbeFAIED (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 04:04:03 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38657 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeFAIEB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 04:04:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id x34-v6so17844310qtk.5
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LuMAv9LLv6YfOWDSSEOAZcsgWKxTj72wKJH6QNQTNwI=;
        b=psL3tfv0Aj1qMPCF2SQgVMPXVyIGOIJHX4x2KM9ZzPDe/cbQOF21z7w518ybolJwxX
         C8OX3jk8zdCSR8uba0Y6nMyPW28687/hz+Ivm/xTqJE8e1ujkDZACagDHYXDTTHtEKpu
         H993KnfYyvrHOQPRO6fYYuOvtJA0wgz+9K+a//v4IVd5i9jSKjOIEMeMB3v5jsUkA0mr
         Ei+TqssJOiJvs/mVt3lr5ePXS/6rMlu7i/U2rURMSizLDv8m0lBF72T0u+8EIs7SGr6x
         HUQ88mFd6dyKwlMSkzLyN7YA9+v0fw7m46uyqwcS5wA8CH4ZQMOX+EcBFjUHwM4roTRF
         rU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LuMAv9LLv6YfOWDSSEOAZcsgWKxTj72wKJH6QNQTNwI=;
        b=asa8gIkDNggF6CgCsOL/4DcXjDLAna4Mxj1ilviFkv1zvWoCIu0JoMgZRtUjf4gHEL
         cxwsqz+7G+vy8YX6tZTEQ7c2ry8FYJVW0p0q9fPQkBpUtzF1U2VpiQq5hRljCF4lwzmf
         gfHZjiJcdn0Gbt7P4RZaeBcL8u1mQlLT6xPWHt9zIz8tVf1+dfJDUaNzZF39jlfOd3QD
         0ePCEfibkfZNGHJhtfA9g0h3n0IaWmNR/3qzf166LZqE6begfWTrD2Sjhe2EgQfRgoKf
         mFjFlLwGRb4s8HhtuqfsLepUWvoy0+pTNU5H7/GbQq5WeqgEmTaej3LgiI6xbmnJbHGG
         9gmA==
X-Gm-Message-State: APt69E2SXNNiF4p9gOgfPeUW9PjLJpZm5LYC1j21YkUW+9YdPzHOMq4m
        826Dsii+P30yOh5cKUC56um5Fij22+im5vgTkErVOQ==
X-Google-Smtp-Source: ADUXVKIDeaWK7X04QgDAoS8zswlRO54jGLiqqr0zuZlw97EB+hxDcy3HGYGEf/h9eHbC1z+5k37ugYSsz8hiHRjQjGc=
X-Received: by 2002:ac8:3886:: with SMTP id f6-v6mr9359788qtc.165.1527840240672;
 Fri, 01 Jun 2018 01:04:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 01:04:00 -0700 (PDT)
In-Reply-To: <CAGZ79kZKaZq+bqFTwe+Y3FU-1DHPjzNrvMNU=DM10EyOXxZJVw@mail.gmail.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com> <20180531195252.29173-1-avarab@gmail.com>
 <20180531195252.29173-10-avarab@gmail.com> <CAGZ79kZKaZq+bqFTwe+Y3FU-1DHPjzNrvMNU=DM10EyOXxZJVw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Jun 2018 04:04:00 -0400
X-Google-Sender-Auth: glLv3cV9u9slXhhrsKLmfaQh3T0
Message-ID: <CAPig+cSk9Dt3ZLQRjWwpxqMyP3npu3KbEQxkNfjV5RxRtro82Q@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] checkout & worktree: introduce checkout.defaultRemote
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 5:49 PM, Stefan Beller <sbeller@google.com> wrote:
>> I considered splitting this into checkout.defaultRemote and
>> worktree.defaultRemote, but it's probably less confusing to break our
>> own rules that anything shared between config should live in core.*
>> than have two config settings, and I couldn't come up with a short
>> name under core.* that made sense (core.defaultRemoteForCheckout?).
>
>   core.dwimRemote ? It's a bit cryptic, though.

This option started out as 'core.dwimRemote' in the very first version
of this series[1], but someone argued against it for several reasons
and suggested 'defaultRemote' instead[2].

[1]: https://public-inbox.org/git/20180502105452.17583-1-avarab@gmail.com/
[2]: https://public-inbox.org/git/CAPig+cTZyYC-1_TxL2PrfOF6HAktUxxM+g5EXcByS5fCDMdCHg@mail.gmail.com/
