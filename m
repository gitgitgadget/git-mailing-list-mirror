Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64A30201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 20:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbdBUUtD (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 15:49:03 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33293 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdBUUtB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 15:49:01 -0500
Received: by mail-lf0-f53.google.com with SMTP id l12so32953321lfe.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JWI4vxBSyETgS3Y2uZtFS3LxsgMT4DU5YgxGEr8SUAk=;
        b=frgnYgwWgGwl8xnnh1Bh+SCltcKybRvAYApqltXdGDGvRKITDl/gSIvfbY7hIp7lvB
         Xkg1TkL2P3nSBXrdEv4hUWUQImxjx7iAZosKDWFqUBnSGFY/kdwYKI+DnSP0UJAa9IJf
         ZiLDQzeX96nxJRHdoDZjJO0v0f/gVnbGLMEpvBaVt2xe6k+9mnerBk5z9Q6vBeBHuh4C
         pyXwqA+iRg/fz3Q/LDWHNq3l7xYNJcUETLb/wwBsYm2vUP5BgfCSQ+OuIiBl0rMTiThY
         5t7Wp9nq3hAYGYID4P+ZpoIon/kGBEbrG3qzv6T7fz7eIg/KpwhYIZ5kVZOPo62FSpXM
         3Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JWI4vxBSyETgS3Y2uZtFS3LxsgMT4DU5YgxGEr8SUAk=;
        b=IHFiT8hZhGM4xw6CzKIM0e/nPZjFxR/8a899Mqo9bGK6cZx0kU5oYrmKkepOeoaJJi
         AfB+fQnyKJVRR1xf/idrSxXJDY8NvuFh8q+WjyRg1DHxOniTGJhGpFYqmWOT8KuOBOs7
         JKPT41oNOdMYEUplIn69Jx84h5j59orCr13O2O8wENIikRnIUOlCtJ3DR8HUvD14vveQ
         fvTKC1wVgqGjSnNKztKpTBP1C1z3bBNExcABmOOyOzwHBHQCH2NU8z1kx9K5n5j4iH9C
         l7/W+Mqq72bvy8qo3PAr3WoV48jqLJxaoTqMB92hNfEXNpfYk8umtG8CdSo8Mh5obsuF
         eayQ==
X-Gm-Message-State: AMke39kcE8moRsZJhMI/CgH8W9r959RKKD1RIMSyjW8XBlBcsqymiquEmbqhApAe/PgzxRHab0CfDw0rfZkAOw==
X-Received: by 10.46.22.11 with SMTP id w11mr7524080ljd.108.1487710139698;
 Tue, 21 Feb 2017 12:48:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Tue, 21 Feb 2017 12:48:39 -0800 (PST)
In-Reply-To: <CAGZ79kZyFfC9Xx-p8dpoAFFpz48BqmftpMonuxeiKg1sV68iuQ@mail.gmail.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-7-sbeller@google.com> <CA+P7+xozip8TuvyUe9vAPYLAg=QFieExhOyR7a0pgGFhiuO3jw@mail.gmail.com>
 <CAGZ79kZyFfC9Xx-p8dpoAFFpz48BqmftpMonuxeiKg1sV68iuQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 21 Feb 2017 12:48:39 -0800
Message-ID: <CA+P7+xoVOxBgubfZP1uUnbXvbVNrCN_w2je7_tcxJ97pXzL1VQ@mail.gmail.com>
Subject: Re: [PATCH 06/15] update submodules: add submodule config parsing
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 11:42 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Feb 17, 2017 at 10:24 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>
>> Ok so this function here reads a recurse submodules parameter which is
>> a boolean or it can be set to the word "checkout"? Why does checkout
>> need its own value separate from true? Just so that we have a synonym?
>> or so that we can expand on it in the future?
>
> I think eventually we want all the commands that touch the worktree to
> be able to cope with submodules.
>
>   Now what should e.g. git-revert --recurse-submodules do?
>   yes == "checkout" means we'd revert the superproject commit and
>   if that commit changed any submodule pointers we'd just "checkout"
>   those states in the submodule.
>
>   For revert you could also imagine to have
>   git-revert --recurse-submodules=revert-in-subs
>   that would not repoint the submodule pointer to the old state, but
>   would try to revert $OLD..$NEW in the submodule and take the newly
>   reverted state as the new submodule pointer.
>
> As I want to focus on checkout first, I went with "yes == checkout"
> here (or rather the other way round).

Ok I understand, but this seems like the variable could eventually
start to included more and more complex things? For now, "checkout"
means "when changing submodules prefer to check out contents" right?

I guess that sort of makes some sense.

Thanks,
Jake
