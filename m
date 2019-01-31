Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980691F453
	for <e@80x24.org>; Thu, 31 Jan 2019 23:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfAaXjc (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 18:39:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35283 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfAaXjc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 18:39:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so5225133wrb.2
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 15:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=u/BXnlMb8g/ormaYaKFdW3U/7sWeHlS6UYmnvf5sw2E=;
        b=c184HJG6kqrZheRSx5NTQEOQ9V+UvNWAYWKItJScmhJgA9KXhnhoSN5X9z1kDDVrHM
         EKvnxwqSaOVXxPaCtBwA/h7vN4Wxh5c8JxSF8p7WSHSG3WLNjcKZ8iG7WL/fvYG8AZLW
         n41UkQtqAiPaHeZ2HFMSymChozPu9i+gX5AfnXORRLywIACMb4oyIpE9dJgX6hDAiyMa
         WcvhEuWHWLgrbnTO5PIVNGOqTpzt0AvyC2Ye+ZWy/9DThOmO0AtTgN3iXLc8NAvFmwz5
         iziyVtINKl6YSdKKW8J0CMlgpthyM4gpyrdnxL4ujUp1wEpkEfi8KQYuFXFe7TFn+050
         apHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=u/BXnlMb8g/ormaYaKFdW3U/7sWeHlS6UYmnvf5sw2E=;
        b=NwQYTBpW83uhoq0kT4xN369mtHxilfKbklH6+8ywWlXlnCpjOY6TDy5531FkC+D6Qz
         3efZB7taZjQaN7eo/XPaeQDthI8k7blSZV5T90QkYS3MZ7fQODekhbGFOWdpWo2bh6KH
         Pxz37cI6DGPL4t0YLmd6TKN3joZ3jh+Wy76+h7E9a1mSeqzIStrx4kUZLojIQ9PEumRJ
         OXdNnacx275kg8UOaGpvQKfDYZacKEbMU4Z7M/ygcFgvtV3/7xWi9ZtiwwP7uhIVKR7L
         FIbPRbpAM2fS5OGJpo0EaYVls8M6xBJEZfjDIcqCxLmSZEhyVp1lzisIue0V712Bui2E
         2gWA==
X-Gm-Message-State: AJcUukfxWwHesbTxi3MW51be1ckJAtx1SAfdtkCoE0EnFmBCyY3sK2ih
        aUsi3krcJVDvoHr7Ebq884M=
X-Google-Smtp-Source: ALg8bN5eimSVO5J9+59hRejsrV7sB1EheW51LN9ydkR6QoKm46PpnFkdCdNtxdd55t1uFriRfiAqGg==
X-Received: by 2002:adf:c452:: with SMTP id a18mr36951657wrg.145.1548977970404;
        Thu, 31 Jan 2019 15:39:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a132sm893707wmh.5.2019.01.31.15.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 15:39:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH v4 01/14] trace2: Documentation/technical/api-trace2.txt
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
        <60b56d6a8fe9c0e37563f66809cc12c98c9eb21d.1548881779.git.gitgitgadget@gmail.com>
        <20190131141127.GA10587@szeder.dev>
        <0384b5e0-e2e2-710f-2e37-1dff96aac143@jeffhostetler.com>
Date:   Thu, 31 Jan 2019 15:39:29 -0800
In-Reply-To: <0384b5e0-e2e2-710f-2e37-1dff96aac143@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 31 Jan 2019 17:33:29 -0500")
Message-ID: <xmqqy370z9am.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I'd rather not use the term "subcommand" because it already has mixed
> usage.
> [] See git_more_info_string[] in git.c and list_all_cmd_help()
>    in help.c where both "command" and "subcommand" are used
>    interchangeably.
> [] And yet another completely different usage in git-submodule
>    and bisect where "subcommand" is used to mean the 3rd token
>    on the command line after the "command".

To "git" the command, "submodule" would be its direct subcommand,
and to "git submodule", things like "update", "init", etc. are
subcommands that is one level down.  I am not sure if it bothers
me too much that hierarchical things are not always named from
the top-level, requiring the third-level things to be called always
subsubX.  In the context of describing "git submodule", I would say
calling "init" subsubcommand may be technically correct, but it
would be too pedantic to be practical, when it is clear from the
context that we are discussing "git submodule".

