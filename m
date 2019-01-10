Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454D91F803
	for <e@80x24.org>; Thu, 10 Jan 2019 00:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfAJAhk (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 19:37:40 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37522 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfAJAhj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 19:37:39 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so8813551edb.4
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 16:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6014htiyCj9eXMSt5zK1lN2t5NCDdzDXV8ia+j8WMtA=;
        b=ssbr2PYOVnMqD4+qTvL4qfAHiD3N6U1LEU927O3YHkxpyD8b09OhOOTkjn1dnugGZr
         ySUDnDAXKbfaeIfovy9liar5AsaNjN+VnuaMvPmievK3zm38IGwHy021Wy9GP9UBDZ69
         8XYR8g50sm8Q3H6HmwrjnGGX4vy2VO8wYSfzZkdUE888RwV1Nvuol8N/W6QOUTr4R8Wa
         mErXEulw9uQ5MXVJP/3jF6UOD7OtxYQfYXcCPS6aliQjFJr/9RazNEDGQf02JSqWA7XR
         RkcKZY/Qh8PMmGkRtz1GJaasOf/xrLgscPnW0kD+4La/lTjLHMYJWc1fUbWREAW6183K
         4ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6014htiyCj9eXMSt5zK1lN2t5NCDdzDXV8ia+j8WMtA=;
        b=IasK2eO29yG0cBI2hyQN3Z9oq/sqlgpXxkgBSSQvH9Burrhs1D+wSUOsXjvA9EUJim
         jqzVACKpXe0gWM6J1eg2n97Rw907NSgGPluzTYeJe4BpZQGefahScejKsO2wGuDpPVMS
         ZYW5eilDpc3f6obGfaHogHbRWs5E3cqXdeliPBueBeTVNd3RAqjdDtnlNCfv3pLGp8XZ
         Uk1WB3jrSxrLqBsZy6aSGFRRJxEZ4xfT2+rlkLyoP0Wrz4fkQMyAF/pGrfkMAjvmxVy7
         6aUU+ASh6qH2XLnfQvSc6/hdB/+/o3mgRM067xw54h48TluUyYIO/mCCK0fUQ36PMTu0
         VTEw==
X-Gm-Message-State: AJcUukcPiTRlQseTgeZ587lghCSy8ygVctfYx2q5hsvIwTYnr7c9Trby
        GDa51GmJtLTxYRCL9N70N8Xl+i4Aa6Mm+M483GbK2T8xzU4=
X-Google-Smtp-Source: ALg8bN7iaobeafmUYdrQvWRyyp5jB6ZjCH9WKr+V4MJS+SeBWI6GlNf68lecR/dmwPJq0MuQAMkJLCwHapKlZP2flA0=
X-Received: by 2002:a05:6402:1816:: with SMTP id g22mr7936564edy.191.1547080657877;
 Wed, 09 Jan 2019 16:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181123111658.30342-1-phillip.wood@talktalk.net> <402b9c01-cd7c-79f3-9fde-55907f03c406@talktalk.net>
 <xmqqh8ej57d1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8ej57d1.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Jan 2019 16:37:27 -0800
Message-ID: <CAGZ79kZBfkKc6L5o4rCJoSw63q49YZwn7QRedNmFr=-nd=GbMw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] diff --color-moved-ws fixes and enhancment
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 8, 2019 at 10:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood@talktalk.net> writes:
>
> > I just wanted to check that these patches are on your radar as they
> > haven't made it into pu yet.
>
> Sorry, but they were not on my radar.  I was waiting for comments to
> come in on them before doing anything, and now it is more than a
> month ago X-<.

I have reviewed the whole series again, and still have
no comment on them, i.e. the series as-is in v2 is
    Reviewed-by: Stefan Beller <sbeller@google.com>
if that helps.
