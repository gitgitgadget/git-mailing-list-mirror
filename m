Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C721820954
	for <e@80x24.org>; Wed, 22 Nov 2017 17:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdKVRAq (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 12:00:46 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:45428 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdKVRAp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:00:45 -0500
Received: by mail-qk0-f173.google.com with SMTP id d125so17627555qkc.12
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 09:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VW8sbrs+FY/i4R9UR+pnLfYhvFYhFofGw30JkhkNnj8=;
        b=v6ieRMyyzYn0OL3CRy8iiJmktdNhTG5F514qRFDwROUxZyiAfYFC/ENRhza58HkyLc
         bIu8w6FtpKCwwleSyGymbrzYMh1DKmI4f5he4ny+DUQDYdlsLbrnyN6jm/AXp3EgIvBf
         RT423y+7LsgoQh1qiOddpdoBzHGgnm3Gd4DjYrNCkvkWY5PzAs9/8PHGm/ESKgVYCCUx
         ol9SOGRDWUrd7zsEYevvhd98WtTWwIz5N08e0fsDfcLoOrStVWl0ej9FAglUNfGh85H9
         9MRM74yxc1ZyGR/+bl3S5EDBUO3BNoTvRVyp5W50iWGqdbis99f8yCVDwzqCtzDq4W0j
         ZBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VW8sbrs+FY/i4R9UR+pnLfYhvFYhFofGw30JkhkNnj8=;
        b=Z7j7R6Ftgkfx0rro0S7SGHeN/EiY8AUbvqD0cgKaH8tPus6nvwf5Pejls+mfd5Ip1p
         vfYZDp1A5f9h4kZp1xUrNRBBS+b394Ivyfi+A9aC9vbVkLMAwRzKWdlleCRd8u6KNkBa
         lwohKPb5AZ9/uwZXoD47OYmW4VWjwNITO708jRte9yApzxdzO7aHk8bB0N7b+vISiikv
         pk4ppElJrix3tG5OJqNtYGp0k2aVLKLf4b1YR1muEET1L/qoiUEYBUKQx2SI3b0zPLpr
         cxw2276aY9O28QzoRdf5+dwkLfVkem51nvuhcieOWONkyy7yMizOrw0ep4BrM/04e4fg
         77Gw==
X-Gm-Message-State: AJaThX5Vj8dfnpdXES1EsVvmCXgX/NuB8n/MnrOJYwp3atDhaTSU/l+U
        o8SeMoGia7BiPRmFMjEioE+pYj3mmSiv2HhU+3YY8g==
X-Google-Smtp-Source: AGs4zMbReecEKhdCJzZEBY8SGEp1gfLOwSQomTGC07WVikJxBnXu2oVfUfBhMBnviCXskUTkNFQVIqn0aQ6Wyq40SBI=
X-Received: by 10.233.216.70 with SMTP id u67mr35473281qkf.133.1511370044805;
 Wed, 22 Nov 2017 09:00:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 22 Nov 2017 09:00:43 -0800 (PST)
In-Reply-To: <xmqq7euiu4r8.fsf@gitster.mtv.corp.google.com>
References: <20171116020039.17810-1-sbeller@google.com> <20171116020039.17810-8-sbeller@google.com>
 <xmqqwp2qx5w6.fsf@gitster.mtv.corp.google.com> <CAGZ79kaGGUJSGG6OdfaTepDrvGBGFd17paBNNYuQt7t8XnDfHw@mail.gmail.com>
 <xmqq7euiu4r8.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Nov 2017 09:00:43 -0800
Message-ID: <CAGZ79kZajrugviv60kQA6UepYrQGpJK447BK1fBFd3N5Wnn5rQ@mail.gmail.com>
Subject: Re: [PATCHv5 7/7] builtin/describe.c: describe a blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 11:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> ...
>> fixed.
>> ...
>> fixed the text...
>> ...
>> I am not fully convinced all descriptions are in recent history, but I
>> tend to agree that most are, so probably the trade off is a wash.
>
> So what do we want with this topic?  I think the "teach 'git log' to
> highlight commits whose changes involve the given blob" is a more or
> less an orthogonal thing,

Well, both of them solve our immediate needs, so I'd be fine with pursuing
just one of them, but I do not oppose taking both.

> and I suspect that it is something users
> may (although I personally do not) find valuable to have a related
> but different feature in "git describe".

agreed.
