Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5E81F462
	for <e@80x24.org>; Thu, 23 May 2019 21:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbfEWVy0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 17:54:26 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37308 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbfEWVy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 17:54:26 -0400
Received: by mail-wr1-f49.google.com with SMTP id e15so7860988wrs.4
        for <git@vger.kernel.org>; Thu, 23 May 2019 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jRS2V6nXPWLQBZaCGIgHstvii953eaLilLU7XLQPrCo=;
        b=ZEMWDiZOlzZ1mcIbxa0TwwLQDumMc2T68pdEBL7kij1yik1Bm/hXpBXsD56kTPR39N
         olsJTZVORNc6iJDGP3zgfe+W3Fxcj6NuQzXO6/zUL9/YdlZmMvNXDy6oxnTMDmb1EZ74
         N8eSJcXfvzp9VewaZ8aBWcAidh4a8e4tGcBx2WfjFiH/wlF+fuh5GZRlrdEl9d8kFCtk
         s7ASXBUKotnsQ2AOsO07CODK92P+ItP2jBjjcXFwPE9mhkQdlUSkzpATyTGi9GYg313U
         7qUN/QU4yBrqo/J630wT/que1b8SlZD0vAaUUQSfIo5B975vf0g6PcbCHsVzPaKwtkvw
         WdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jRS2V6nXPWLQBZaCGIgHstvii953eaLilLU7XLQPrCo=;
        b=fVuWdxbffsX0uENRN+uJKfAkzwhwLj14FQbDCbppq2ondHW/J7eaEK7zrzZ5hMTS7S
         7dpK3CWjeswEQqVuJV3yqMtpZXiTGvamNBZeIEmBnaf9d+s+/g61b5KpUFnZ+DbG4nbp
         7kqfSdS69IXjQNKnMLNe4aeKxOwh6zc7A6GbiYvTnS1YFR3na6LfeyGYgs8wHBK7KOvy
         t0YRQ2t4XVHGhtAoAvskw4gFcuhhCTkAq0RypsGJLUIOpRvEuzFfDhGF6BL3JAD+D4dn
         OvdQtbsnY86sK4nGxQoK6hsX9w+MAhdHu5XZJNGPOF1YJK4/GlmSK99WeQU/7pbDietN
         CVhg==
X-Gm-Message-State: APjAAAVBAVBT7kzLZ54av9SZR5IDRC4ytYvA5CT4XeW5UvauvbzZ1woo
        04HNygffdOs1pOgEeGbWaEUjFefWeZg=
X-Google-Smtp-Source: APXvYqwAquui5oAQc+RoFBfB9yNTr5jEgQpozaJGa1qDaMlh7RA+O/XMy7hY+74MPTbdXB+jA7wvKw==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr5276289wrw.306.1558648464703;
        Thu, 23 May 2019 14:54:24 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id z5sm821047wmi.34.2019.05.23.14.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 14:54:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Karl Ostmo <kostmo@gmail.com>,
        git@vger.kernel.org
Subject: Re: standalone library/tool to query commit-graph?
References: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com> <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com> <86blztq8ap.fsf@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <86blztq8ap.fsf@gmail.com>
Date:   Thu, 23 May 2019 23:54:22 +0200
Message-ID: <87tvdkg7ld.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 23 2019, Jakub Narebski wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>> On 5/22/2019 2:49 PM, Karl Ostmo wrote:
>
>>> After producing the file ".git/objects/info/commit-graph" with the
>>> command "git commit-graph write", is there a way to answer queries
>>> like "git merge-base --is-ancestor" without having a .git directory?
>>> E.g. is there a library that will operate on the "commit-graph" file
>>> all by itself?
>>
>> You could certainly build such a tool, assuming your merge-base parameters are
>> full-length commit ids. If you try to start at ref names, you'll need the .git
>> directory.
>>
>> I would not expect such a tool to ever exist in the Git codebase. Instead, you
>> would need a new project, say "graph-analyzer --graph=<path> --is-ancestor <id1> <id2>"
>
> It would be nice if such tool could convert commit-graph into other
> commonly used augmented graph storage formats, like GEXF (Graph Exchange
> XML Format), GraphML, GML (Graph Modelling Language), Pajek format or
> Graphviz .dot format.

Wouldn't that make more sense as a hypothetical output format for "log
--graph" rather than something you'd want to emit from the commit-graph?
Presumably you'd want to export in such a format to see the shape of the
repo, and since the commit graph doesn't include any commits outside of
packs you'd miss any loose commits.
