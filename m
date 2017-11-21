Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8512036D
	for <e@80x24.org>; Tue, 21 Nov 2017 19:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbdKUTWO (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 14:22:14 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:41687 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdKUTWN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 14:22:13 -0500
Received: by mail-qk0-f177.google.com with SMTP id f63so13586682qke.8
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 11:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ChIM7Ly1XD72VW4GN/6uBt0y3sBovgJVLwYAXGiOA/M=;
        b=YLWRWDjvHf8pd8bFI0aibP7bGG2aHa8JTpI4VQKhAFoN3Ob2JlzeIf+FXNOgLCI8Bh
         C2kFVWWPPGE65SbI75bNxbXmWYOKdHzv6qKHYvz47Y6IssfvOkZMUsjfgJ/kEqnQX7Ux
         z6dbQXPds23pePU9n/NzZNQYPllVQYcTV8LKTIU0YW6Mpf2urnCZ/+EIorl1pz8wGntl
         dcFgFGXh56rxPkoDWW5TmjT78CGPNLiF6toqQhSIirIpYF0gqaUM+iS/ZZHrlqjHjJgh
         AlhKLC7mHe8Jpp6EOF4tlgzGHqBLrJfGK11o9HQIUAZI1/2zDcrlrbU+qQ4h4GMdEv1s
         Vejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ChIM7Ly1XD72VW4GN/6uBt0y3sBovgJVLwYAXGiOA/M=;
        b=nbhDBe6s7KswySVOoLmEjNvM/xPMmTyf09W38F4wEfe3xCdRcBwXFv5GZptxQI/tB2
         PatuD+48ez4d9CgpG9MXiahR+3w1FmF3kwhVWlRSqc/Vmn2juYv91slLdo9yT0/LJlrJ
         vWnwcYEPshbQazLu6mPC7ydZBSLmKnhS3xDib3X/4gajTCwYa9DZXth62uCRC53RjOr1
         ShLwq0x4edLLdD8YqueHJCbBXgF84+b4EwZuh5bIfTwZl6kAEY33UJ49vwT7L9p+Jrg5
         QRPRzWDhGbuYAACCzEZQgUIj0+nX1SHDbt4tSGdT8r2bWF0FxTL/47MbspxSGJMx8/W2
         jPuA==
X-Gm-Message-State: AJaThX7Y3JkL6lJgTA2qZO+rTt4IqoPBo49pLBPYi2lpOxv0gNn/mT/q
        LeX4uovtsB+t0DgfP93zbTKYehZrI7JLO+K7zOA=
X-Google-Smtp-Source: AGs4zMaCRqjxWjg9wTui1/LNjkHtk0mTmABMOr2TKPjWVR0h+IWd6qzG5W7Av+0oszQwrlhEjVsGmhavRmdH3IlpOm0=
X-Received: by 10.55.141.3 with SMTP id p3mr28398493qkd.210.1511292133041;
 Tue, 21 Nov 2017 11:22:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Tue, 21 Nov 2017 11:22:12 -0800 (PST)
In-Reply-To: <60caf5c8-4dc3-481a-80d6-37a697e31b52@gmail.com>
References: <20171121141852.551-1-kaartic.sivaraam@gmail.com>
 <CAPig+cSGu-+6Bw3YBzMwzxO8vKt7jdf9xgtr9FUdOAQpXzi2rQ@mail.gmail.com> <60caf5c8-4dc3-481a-80d6-37a697e31b52@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Nov 2017 14:22:12 -0500
X-Google-Sender-Auth: 9bEprf3F4vH4mv7DPoS9bQNr5q4
Message-ID: <CAPig+cRK8+pzf3EWuoG+36CRNaaGv6CQk27d4CrzTv=8beoQGg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] builtin/branch: strip refs/heads/ using skip_prefix
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 2:12 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Wednesday 22 November 2017 12:08 AM, Eric Sunshine wrote:
>> The original code unconditionally uses "+ 11", which says that the
>> prefix is _always_ present. This commit message muddies the waters [...]
>
> That muddiness of that statement is a consequence of my recent encounter[=
1]
> in which the assumption (that the prefix(refs/heads/ always exists) of th=
at
> code failed. I had a little suspicion, when I wrote that commit message,
> that there might be other cases in which assumption might fail. The issue
> has been resolved only in 3/4 of jc/branch-name-sanity but that was only
> after I wrote the commit message initially.  So, it does make sense to
> remove that muddiness now. Thanks for noting that.
>
> [1]: Note the 'warning: ' message in the following mail. That ugly '|=EF=
=BF=BD?' was
> a consequence of the assumption that the 'prefix' always existed!
> https://public-inbox.org/git/1509209933.2256.4.camel@gmail.com/

Thanks for the explanation and history reference.
