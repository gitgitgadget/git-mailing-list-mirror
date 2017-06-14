Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81571FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 01:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753448AbdFNBZN (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 21:25:13 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35701 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbdFNBZM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 21:25:12 -0400
Received: by mail-lf0-f44.google.com with SMTP id p189so82258870lfe.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 18:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CKCGt+8QK+51Ssh18OGm4Lsyvf8BsOgKm2XTwsOZmYo=;
        b=gjkUhUTlc3Il9Nu+Di+oP1BfTLkpgd1YR1qfpXgl24GS8AhqrXCXqzr8d7+vphiTnL
         sxLT99/ilIKboWK1ixhVWJyZ6gpUy5y62gVfRE5oNcmFjqKFM0AVtBXXs9KzuhjnNn+F
         tzeUEC14hgwNCtb/C7RPIe1aBFM0xDw45pU9nxaQ8w6AEOXfRI3gq3LSZZ+62lKGi7rE
         YNyZJJUL9Z4cd1a6tyUDRDY5ESob5kcXu278oknZ0QtsQ7LHhWWFBtjNljq5QsG72HlY
         PjzicUxmRemY59Nz0lQ1YafXDB3A1AWuWCvEIityIhkyFdFI+uHB01H2VVgxr+ET6KAJ
         JGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CKCGt+8QK+51Ssh18OGm4Lsyvf8BsOgKm2XTwsOZmYo=;
        b=UmUyAXJ3G05eExjdl8aBOgAPu3rp2zJzSp9wLcwmAHcLiZXUIzchD4oeLq2JDoKpB6
         W7sllW+OKyjv/CwGJP1croGlti6Z2zR/GEaCQ2pC2blqie0XtKuJ115TKbxTmAmf7Ylb
         FoeBqHYbqcNQsw239tU/fBCSjBIg3QRQQ6LhN9Lc+SdAIPJbQiTgsfpjInauohrj09Md
         XcXB+A889AO2yDvNmTzAR233+jVLiIKRSuz7aq9gRTESx0hD32SSblkw3BtX/xfUrqNh
         02qyUu3aTLZFg2PXw5CSVw3COoJ+1I86yxUF6prBKKx3YDYsF+vBbqZ/chwolFGC27ck
         kQeg==
X-Gm-Message-State: AKS2vOwzhY96zbf23CU9IBC4AImBmKnR2ejpgYtTvjWAi4mWgCf3o0Fr
        fEkBgNfNg3/Kg4YT9KOe/Vm2AAgL+TAp
X-Received: by 10.46.71.14 with SMTP id u14mr795014lja.107.1497403510861; Tue,
 13 Jun 2017 18:25:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.79.17 with HTTP; Tue, 13 Jun 2017 18:24:50 -0700 (PDT)
In-Reply-To: <010f8a1b-cab3-fada-0f38-1f0726283f5e@xiplink.com>
References: <CA+P7+xrMX+gxQrsB9kcy3RkDL=eDXb_TQ-V+2vH+ir0Sbef8Xg@mail.gmail.com>
 <48064f67-6d88-8c14-853e-fd9214d26647@xiplink.com> <010f8a1b-cab3-fada-0f38-1f0726283f5e@xiplink.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 13 Jun 2017 18:24:50 -0700
Message-ID: <CA+P7+xqeAxtNqKLXtYs6pW9eEZLK-jVwjfX25mtZVe51W+yH6Q@mail.gmail.com>
Subject: Re: proposal for how to share other refs as part of refs/tracking/*
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 8:55 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> On 2017-06-13 10:41 AM, Marc Branchaud wrote:
>>
>>
>> So I like your refs/tracking proposal, and hope that it aims for mirroring
>> a remote's refs, to eventually replace refs/remotes entirely.
>
>
> To be extra-clear:
>
> I think a refs/tracking hierarchy that starts with notes and maybe some
> other bits is a good first step.
>
> I *hope* such a first step can eventually mirror all of a remote's refs,
> including heads and tags.
>
> I in no way think that this effort should begin by tackling heads and tags.
>
>                 M.
>

As far as I understand it, mirroring all refs should be as simple as
adding something like

refs/*:refs/tracking/<name>/*

assuming that * begins working for multiple components..

Now actually making *use* of that feature would be different.

However, this was generally the direction I was thinking of heading.

Thanks,
Jake
