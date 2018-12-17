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
	by dcvr.yhbt.net (Postfix) with ESMTP id 603C81F405
	for <e@80x24.org>; Mon, 17 Dec 2018 23:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeLQXhD (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 18:37:03 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:44857 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeLQXhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 18:37:02 -0500
Received: by mail-ed1-f47.google.com with SMTP id y56so12242039edd.11
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 15:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4VJ4/THk5WSfH+Gxc8wF2b9u7u53YM+GT/nfvMqSeNI=;
        b=Z87WtPufFzkzgDJJPdEpSxRvPMZ2bBIyYEbjILuvEUcFVVehLLxmjJY4cxvcBsiKWL
         DmtqE/r4i8FVbBSKJwh7CHx3PAlDIeFV3OOZWCx3wewUrNGL9eEvdgSAiieZH6JkD1gM
         7dpqYtoChEXrW16Dms6v3L8v7N4aTXWTPohUmHYRXhSvrP9AIZHq6jcCzuQ37H/4wTNb
         sCviuVxgWAbh9toCcJ+5UQSaCLNLocwvWoePL6JeTx8xHTyGsBTbVnRwEn0axITD0vAK
         nAv13rQKFBktfKqIYSLNrGPiVZwJPXH2qx6UXa2YZjLJcS4DnuLAFuJbn10Cm3rZAtq/
         bqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4VJ4/THk5WSfH+Gxc8wF2b9u7u53YM+GT/nfvMqSeNI=;
        b=QzB34UGrXNMB0u6NvFE/X1Szu/JMFqzgyqpcDK2jP6ZdhR3HGqHTCBBYeCuHeJ5YzN
         yYut6hQp8yEcQxaOEZoiI8dqvenl0kfd0DysJEgsAY9e4BkpfB176MsiNsASoyVpSNZH
         nCFvQ6qfavWDQgDRIj/ktnCTA70FjOzK4m+GX/fdTKIaBRZFUZOzJSTRZLwHs5BeFjne
         teyl29eU2ww0wVcOsANYYfGRUdnyDVReHTpx/56wfnd3aMg/CNpKLTtHVKhY+rgItUTJ
         26lFBCqyDlH6k+17m1KzE+LWpza1mvYkngS/Ea1qmKDlAlegoHIM9///M9200ODQX4oy
         zMFA==
X-Gm-Message-State: AA+aEWbX62cO5j3+7eapOTk4ZZItUNetkSKSM6o7P9Efxs8BEefR5cb5
        ULrex++J+h09eOPsmEtiEkA=
X-Google-Smtp-Source: AFSGD/XrBrX4qErH5osMiaIgCfU4yjivO51fjaUjsU56DLcW5GAYoPrGCKwtHl9mFsZqsf7dcrwb3g==
X-Received: by 2002:a50:8a03:: with SMTP id i3mr14659854edi.164.1545089820654;
        Mon, 17 Dec 2018 15:37:00 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id s3sm4036132edm.31.2018.12.17.15.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 15:36:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com> <20181213155817.27666-9-avarab@gmail.com> <87pnu51kac.fsf@evledraar.gmail.com> <20181214101232.GC13465@sigill.intra.peff.net> <87o99o1iot.fsf@evledraar.gmail.com> <20181217195713.GA10673@sigill.intra.peff.net> <20181217231452.GA13835@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181217231452.GA13835@google.com>
Date:   Tue, 18 Dec 2018 00:36:58 +0100
Message-ID: <874lbb209x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 17 2018, Jonathan Nieder wrote:

> Hi,
>
> Jeff King wrote:
>> On Fri, Dec 14, 2018 at 11:55:30AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>>> More importantly this bypasses the security guarantee we've had with the
>>> default of uploadpack.allowAnySHA1InWant=false.
>>
>> IMHO those security guarantees there are overrated (due to delta
>> guessing attacks, though things are not quite as bad if the attacker
>> can't actually push to the repo).
>
> Do you have a proof of concept for delta guessing?  My understanding
> was that without using a broken hash (e.g. uncorrected SHA-1), it is
> not feasible to carry out.
>
> JGit checks delta bases in received thin packs for reachability as
> well.
>
>> But I agree that people do assume it's the case. I was certainly
>> surprised by the v2 behavior, and I don't remember that aspect being
>> discussed.
>
> IMHO it's a plain bug (either in implementation or documentation).
>
> [...]
>>> I'm inclined to say that in the face of that "SECURITY" section we
>>> should just:
>>>
>>>  * Turn on uploadpack.allowReachableSHA1InWant for v0/v1 by
>>>    default. Make saying uploadpack.allowReachableSHA1InWant=false warn
>>>    with "this won't work, see SECURITY...".
>>>
>>>  * The uploadpack.allowTipSHA1InWant setting will also be turned on by
>>>    default, and will be much faster, since it'll just degrade to
>>>    uploadpack.allowReachableSHA1InWant=true and we won't need any
>>>    reachability check. We'll also warn saying that setting it is
>>>    useless.
>>
>> No real argument from me. I have always thought those security
>> guarantees were BS.
>
> This would make per-branch ACLs (as implemented both by Gerrit and
> gitolite) an essentially useless feature, so please no.

Doesn't Gerrit always use JGit?

The discussion upthread is about what we should do about git.git's
version of this feature since we document it doesn't do its job from a
security / ACL standpoint, but that doesn't preclude other server
implementations from having a working version of this.

But if gitolite is relying on this to hide refs, and if our security
docs are to be believed, then it's just providing security through
obscurity.

Like you I'm curious about a POC. The patch I submitted in
<20181217221625.1523-1-avarab@gmail.com> takes the "SECURITY" docs at
face value. I.e. I think it's dangerous to expose this as-is given the
scary non-promise they make, but perhaps we'll find that this actually
works well enough in some cases, or there's other non-security uses for
this (e.g. simply discouraging users from cloning certain things,
e.g. for cache performance purposes).

> I would be all for changing the default, but making turning off
> allowReachableSHA1InWant an unsupported deprecated thing is a step too
> far, in my opinion.
>
> Is there somewhere that we can document these kinds of invariants or
> goals so that we don't have to keep repeating the same discussions?
>
> Thanks,
> Jonathan
