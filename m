Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B24520248
	for <e@80x24.org>; Fri, 22 Mar 2019 02:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCVCUh (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 22:20:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38664 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfCVCUh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 22:20:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id a188so639579wmf.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 19:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VLyYenL6SUVc/ejmds7TfMcyxQ4hFnsoiMzzSyOjoGc=;
        b=UvPjP47ZwdC1/FE74quy35Z3X9Dc1CiHjhKOsd85PWVLWy6wOgirp+5sSX69CnL+EO
         oElGI/1sIAJsnot72FUkmBjQi/cONeZwOCk/T+5v38oBAT7nhbjsDE4uAl3REtWsrtOV
         szrhNXU8ZkQM46lGLH/B7KwB/zazo5Ueno/0YVpfriF5mvLSAUeaI5H4f8GwYb1K886U
         Y0ylksk6WL2jHXfbxxQ3/0tqvOfetMstm0Kgj14f8LwVF018CXUZXNw4cfhu2coUV8F4
         vUdE35LQnBv1FlmT/8M6gsieT/iLY/fV5p3mOlbmVAJjxoGbi09YsXErqiLEnxdJmVcf
         fpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VLyYenL6SUVc/ejmds7TfMcyxQ4hFnsoiMzzSyOjoGc=;
        b=sASiqnxDHvaz8X8zAyOR/CF2T/xFoSrb/MExs2TTqlUbLkCovJ9WdA8Yrsw5OyI1RN
         4bDkmyYpCcKWi176wSFhpHF1HoOmW+e7zdFydTNOG4upD2ku/1epRZAjWgpttRNx+Am9
         jgI0byu3nR1F17knmfdcd6/zXGCavLagxSGrLcfMJaXBagPozqtFA89lDAUvL1X6p5kl
         fxaoJraglf32FkCxC4dQEK9IktsgSGf/J7DjfFZX/CjQULxqRUlePaNbCO8nrP3mh6go
         Cn6Ta/e2b3gvUWjR5Gp6/cEUTEIe/OD/qlTzjJDWT01VlMB/sQrgz7wxQ7ZTH7Jb2+S9
         Dknw==
X-Gm-Message-State: APjAAAWU9s0LUWJNiO3wFvs2IPYWDVjuSBlMcE9WGpdXWT1tUqzTTFHQ
        v4f4xuHVF1GYchvjrorB5kw=
X-Google-Smtp-Source: APXvYqwrH1IcQZZBN9HdQJ7ho4fxwxRwYIpDxms8vadUfTuH/F8nzrx6vHe3/ZPVYFK+CfgKNYxCSg==
X-Received: by 2002:a1c:b455:: with SMTP id d82mr1379682wmf.153.1553221235387;
        Thu, 21 Mar 2019 19:20:35 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 132sm11819338wmd.27.2019.03.21.19.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 19:20:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH] t5551: delete auth-for-pack-but-not-refs test
References: <20190321174719.151877-1-jonathantanmy@google.com>
Date:   Fri, 22 Mar 2019 11:20:34 +0900
In-Reply-To: <20190321174719.151877-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 21 Mar 2019 10:47:19 -0700")
Message-ID: <xmqq36nfsl8t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Because this configuration is not supported by all protocol versions,
> and because this configuration seems to be of limited usefulness (only
> useful for people who use manual credential entry and on servers that
> are OK with exposing refs but not objects, and even in this case, helps
> only in a no-op fetch), delete the test that verifies that this
> configuration works.

A possible and different conclusion that naturally follow your first
"because" could be "fix protocol versions whose support of this
configuration is broken", and your second "because" is with "seems
to be", that makes it quite weak.

Quite honestly, I hate to see a proposed log message that downplays
its potential negative effects without sufficient justification.

Isn't this feature primarily for those who want to poll from an
automated job (and naturally you want to assign as little privilege
as possible to such an automated job) with ls-remote and only run an
authenticated fetch, perhaps manually, with or without cred helper,
when the automated polling job finds there is something worthwhile
to fetch?  What this test is checking seems to be a quite effective
way to achieve that useful workflow, at least to me, and offhand I
do not think of other ways to easily achieve the same.

The "ls-remote" communication may not even touch any outside network
but may be happening all within a single organization, in which case
"are OK with exposing refs" is making a security mountain out of a
molehill.  If it were a truly problematic hole that makes it a
security issue, wouldn't we deleting this test and at the same time
plugging the hole for earlier protocol versions?

Having said all that, I do not care too deeply.  Would a much better
longer-term solution for those who want to poll and fetch only when
there is something new be to allow clients to subscribe to a feed
that hangs while there is nothing new, and lets the upstream side
continuously feed incremental updates to the receiving client, as
its refs are updated, or something?  As long as such a thing is in
our vision (it is OK if nobody is currently working on it) to become
replacement, I do not think it is a huge loss to lose the ability for
unauthenticated ls-remote with authenticated fetch.

Thanks.


