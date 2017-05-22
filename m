Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40E12023D
	for <e@80x24.org>; Mon, 22 May 2017 20:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761005AbdEVUEp (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 16:04:45 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32802 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757958AbdEVUEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 16:04:43 -0400
Received: by mail-pf0-f173.google.com with SMTP id e193so92123040pfh.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1AIjfIN5Whor6BFyqA7c6bFrSTlsDvqY3ku+cg8+brk=;
        b=UunBstGNkoWqg8CAC1G9RckZs6FZlISyOWkyc/kyuGha/DSiqKn4onkygP2wHzwWc0
         viSCybYKZ1x69SR9lPhQ90puOiM6Yfe2ebhGZobAtNzGG8TCJ/shrdXhP25IGfNcMI1y
         nEjvMsgA6b0kP87o3B0Wrv+5BOL0PLzXSXTWrbHfmmb1FMnHXUthcoBk4705WAXTR6bK
         25sRiAyGE782em3iuvjeqzRmPQUNyNY7peNhzYHghzG9i8j4DWAo5VZzkozZB4vHYlwH
         BxrQHykmKHQKmWq/r+YxLS9D+TBrdVmScBjx6xiQVMt2djEuMumOprIHjg9RY5PkINHY
         PjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1AIjfIN5Whor6BFyqA7c6bFrSTlsDvqY3ku+cg8+brk=;
        b=bv8HFXogTOcFfcS8m8UZRHCU5QSA+XqsY1in+PkrSwC33ukfnik/DdxbfgVVK0ptoG
         mkWFB6kczRXSTmUniY2rju+a0UDkkAC/fEKsca96Fn7q+NMKpZXMdk6DLZaonFPAlSbX
         EeebfdWbL9E1hot0F0xYzbOfsXByoq0ikzGeL7X/40Rf3k1jNojXk22iCSBRKdE75EVg
         qxa7b05u4gx7bXlONTLcQwG9l/Wgpf7nhlvUnEaK1Cv/axjm4PdjFWORLN0ozEWyZDwv
         y6NyG5zfeS4/lupQv6ej3700oRqOT3xgnHzhxUA4zdFKIs4jns3up6Hq9Y9Wl2z340nm
         0geg==
X-Gm-Message-State: AODbwcDUpLH9fvbucT2q/FCqW7Yt2nKjoNXqZdx2S29bKJkUnD7G7mK0
        IUkEZIFRygIoj3xOXVXKtA/gi44QQl3T
X-Received: by 10.98.236.150 with SMTP id e22mr27282638pfm.48.1495483483124;
 Mon, 22 May 2017 13:04:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 22 May 2017 13:04:42 -0700 (PDT)
In-Reply-To: <20170521125814.26255-2-pc44800@gmail.com>
References: <20170515183405.GA79147@google.com> <20170521125814.26255-1-pc44800@gmail.com>
 <20170521125814.26255-2-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 May 2017 13:04:42 -0700
Message-ID: <CAGZ79kbmQ5_Vb8BSoJkA74-+e0FoKwz=iJkSk4sdSnc46s+qUw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 2/2] submodule: port subcommand foreach from
 shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 21, 2017 at 5:58 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:

> I have also made some changes in git-submodule.sh for correcting
> the $path variable. And hence made the corresponding changes in
> the new test introduced in t7407-submodule-foreach as well.
> I have push this work at:
> https://github.com/pratham-pc/git/commits/foreach-bug-fixed

This one seems to pass the test suite by having the bug fixed.
(The patches posted here seems to be
https://github.com/pratham-pc/git/commits/foreach
which does not pass tests? These two series seem to only differ in
the bug fix commit, which I think is a good idea to include, as then we
have a bug fixed and the tests pass.)

> +static void for_each_submodule_list(const struct module_list list, submodule_list_func_t fn, void *cb_data)
..
> +       return;

no need for an explicit return in a void function.

> +struct cb_foreach {
> +       int argc;
> +       const char **argv;
> +       const char *prefix;
> +       unsigned int quiet: 1;
> +       unsigned int recursive: 1;
> +};
> +#define CB_FOREACH_INIT { 0, NULL, 0, 0 }

This static initializer doesn't quite match the struct,
(I would expect two NULLs as we have two const char pointers).

> +
> +       info.argc = argc;
> +       info.argv = argv;
> +       info.prefix = prefix;
> +       info.quiet = !!quiet;
> +       info.recursive = !!recursive;

as you assign all fields of the struct yourself, you could also omit the
static initialization via _INIT above.


Apart from these two minor nits the code looks good to me.
However we'd really want to have the bug fix patch as well.
(At the time of submission of a patch we should not be aware
of any tests failing, which we are without said bug fix patch)

Thanks,
Stefan
