Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480F01F404
	for <e@80x24.org>; Wed, 28 Feb 2018 22:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935290AbeB1WW3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 17:22:29 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:41014 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935151AbeB1WW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 17:22:28 -0500
Received: by mail-qk0-f174.google.com with SMTP id w142so5108742qkb.8
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 14:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=teXYwu86uFpKY/thlegJp3QFkUmpMaiCd/flz11A89Q=;
        b=vRB5AfavNm5usZ3xH0VUgkCqUrf7RZj/dx5KWD/B6Nn2oT5oWLQIi8YvwKXOMxSWtP
         agywJ3Vllb2Onp6Lme/Xzp1iZHPgMVa+sIFl3ndyALjbSnK0rvjUzRkGFXXiy6khyjBS
         SIs+8SmLCmqxtnJI03/B3VZgP3bDsw3CGPQpaCFbwLULOZg3/J69F6HMsLVB8WzHPZD4
         3quIsJN806khy9L/nurMrs8cRjZPHwd/TsxkUj8GoDiJ6+nWJyJs52X876WZczpoAfRb
         TlI5sOFD/9P5zQbu5N24IcEJfQabsxeYspJtvCog3y8KVT8AM08OcL3kpbTJHTrqKSqf
         fcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=teXYwu86uFpKY/thlegJp3QFkUmpMaiCd/flz11A89Q=;
        b=nljD+HKfKChBzK3no9DvrOcDwN8+4Pcp8K484sX4yOYnyQqWGA0/2YfsAnKrDl3r3q
         feDu63aUIJLBmp/c2e+EYvdPxYGqrO7Rygp3H9hNSddAkA3ZJxkdGBUFynmPFt0hPMck
         6DMWTiCRNGIPHMl+hFzDadVvkmzkmc2nX51bvexOPAMSCxIdmiVcxaFImtj1I+3E9ivG
         3oY0Q7E5UjIis2p/lpaLn8RKxuOUkJAC3Ywbd6vo2CFs9G/CjUXjwrmoG6bTCeATpHi+
         tw+UqfJhQXfP2YmPh0WtCu/SRsKEp5oVOjDtQZS7bnLJAXGEjHeA/zeLjSWlkgT0mTKS
         PaxQ==
X-Gm-Message-State: APf1xPBdGtnDiDP6sNLNclxT66DzJiLnJ4pA+wBkNpnUOYZcGqwqQVRF
        SMFp/a3AIXB1l2tpp7F6z8/iWZarK1U+juPfDt0=
X-Google-Smtp-Source: AG47ELsYuGuDXHedSeskRwvWr+gnDQj9Vr+DIdecT4coCMI+d0qCpgBAtvqm4b3ukpcZzpMPkaRLFvVDbPy0kpAZMrM=
X-Received: by 10.55.32.2 with SMTP id g2mr21659905qkg.176.1519856547383; Wed,
 28 Feb 2018 14:22:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Wed, 28 Feb 2018 14:22:27 -0800 (PST)
In-Reply-To: <b9aa0939-8b20-0f35-84f4-5b519080ca34@gmail.com>
References: <20180228172906.30582-1-alban.gruin@gmail.com> <CAPig+cTOv+jAQHA8p76MHcbbvv4SAs4y_1BxeRpexWwTT4+8hA@mail.gmail.com>
 <763c5ee4-0bee-7f76-1e2a-4ad07a813e29@gmail.com> <CAPig+cQ6awH8KfX3C+=OwE3qJLJPQyAt_dmQvMw1NLNnCT73RQ@mail.gmail.com>
 <b9aa0939-8b20-0f35-84f4-5b519080ca34@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Feb 2018 17:22:27 -0500
X-Google-Sender-Auth: zjYLOaW7CyvcKWRyptPPRVZTFXM
Message-ID: <CAPig+cQ3MuFhMHKGyejE2o0WnVZGvLwcLVgVLpshU_j01MkcaA@mail.gmail.com>
Subject: Re: [GSoC][PATCH] userdiff: add built-in pattern for golang
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 5:17 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
> Yes, but I can split the line like that:
>
>     % cat >baz.go<<\EOF
>     package baz
>     func baz(arg1 int64,
>         arg2 int64) {
>     }
>     EOF
>     % go build baz.go
>
> This complies to the standard formatting (at least, gofmt doesn't change
> it), but making the regex strict about the brace would cause it to
> ignore those funcs, although I don't know how common they are.

Makes sense. Thanks for the clarifying example. I wouldn't be at all
surprised it such formatting exists in the wild, so keeping the regex
as-is seems a good idea.
