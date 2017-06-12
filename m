Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9658F20C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 19:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbdFLTLB (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 15:11:01 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36176 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbdFLTLA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 15:11:00 -0400
Received: by mail-pf0-f172.google.com with SMTP id x63so55235490pff.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6iCmf9VsYaz94wQR6aTHqJQHxhEi06gYGo8B7dfKBMw=;
        b=lVuTjcdJbdqRnTa/wmOkqMC4yCcE0LjG8IGxSQd9BVu3EQ8UP+vCxSXcx0oYP2FUij
         V70o9YKjw63oTqrzeUn2zCrgZDoN9T1dAUhfUEVyBST4I7QqeDGO+iHOTU4oXUGarrLO
         8Ajkqmefqo/7XKEfuAB0up6XFtd0B7M8s+nQ6vwfGi0WhREw9HSOERILfXf/XIszZ4aH
         uzfSsCyIOnx97U8u75x4XHuAvCWZDwRrQ1iB1jKITZfR50Gwhf2A5z/Dwftoq+jLPXab
         rnnV4z9FVRzFVWwnmMeQPrvppOLS2pB7u15zGqgFVarV6dnfAOb33fnL6bAXnXkHgbM4
         wVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iCmf9VsYaz94wQR6aTHqJQHxhEi06gYGo8B7dfKBMw=;
        b=Si+2dV09OAW+OpNfrtJMBd70hjOn669mz6atVTQLS3tRmjTIY7BIBKktUnpZWVnVlc
         H9HN4RUQbpt+C9CV3f+atT+Pq2EMZCmPagTzNDxxUwfrCGQRS7Zf5nr9MXNlBEedSIOQ
         YIy2CmnkPNDRf/xppG6ZSibVSJ/fN6H561Onl6X8fg0NIS/60878I59aRw44dWknKTxS
         k6hF7MBs+ipHBCCrycPkdX4DIVP/TonDh4ubLelzK8wQXmgQvUzjqv3r8GXrnk7/Z7Xg
         23ZeiD52UrF6D2gHxeWn61YAyPNaczaq3mY15XILDmVzUp20pyMglEEFZJSSEb2jYWI9
         OFow==
X-Gm-Message-State: AODbwcAvHa8Zo0V5wIYNQHKPfiBkf5a6TrQxxGa0zlgLjaS2v0k8mFkO
        48lvDlboLipB8s7eeH6ctqBK
X-Received: by 10.98.11.196 with SMTP id 65mr57207523pfl.110.1497294659366;
        Mon, 12 Jun 2017 12:10:59 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a1c6:b49e:dc41:58c])
        by smtp.gmail.com with ESMTPSA id 84sm18700438pfq.125.2017.06.12.12.10.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 12:10:59 -0700 (PDT)
Date:   Mon, 12 Jun 2017 12:10:54 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, sbeller@google.com,
        jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/32] repository object
Message-ID: <20170612121054.72618ac9@twelve2.svl.corp.google.com>
In-Reply-To: <20170611004329.GE81269@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
        <20170608234100.188529-1-bmwill@google.com>
        <20170609174034.61889ae8@twelve2.svl.corp.google.com>
        <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
        <20170610061326.2dkdnvpjdq5d7223@sigill.intra.peff.net>
        <20170611004329.GE81269@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 10 Jun 2017 17:43:29 -0700
Brandon Williams <bmwill@google.com> wrote:

> I disagree with a few points of what jonathan said (mostly about
> removing the config from the repo object, as I like the idea of nothing
> knowing about a 'config_set' object) and I think this problem could be
> solved in a couple ways.

Ah...is the plan to eventually delete the git_configset_.* functions and
only have repo_config_get_.* functions? If yes, I would prefer the
in-between state to be "git_config_set_get_int(repo->configset, ...)"
instead of "repo_config_get_int(repo, ...)" to avoid the parallel set of
functions (which will make it more troublesome, for example, to add
support for a new data type) but I can see the benefits of having the
repo_config_get_.* functions too (conciseness and not having to make one
final find-and-replace when we finally complete the migration, at least)
so I don't feel too strongly about this.

> I don't think that the in-memory global variable 'quotepath' (or
> whatever its called) should live in the repository object (I mean it's
> already contained in the config) but rather 'quotepath' is specific to
> how ls-files handles its output.  So really what should happen is you
> pass a pair of objects to the ls-files machinery (or any other command's
> machinery) (1) the repository object being operated on and (2) an
> options struct which can be configured based on the repository.  So when
> recursing you can do something like the following:
> 
>   repo_init(submodule, path_to_submodule);
>   configure_opts(sub_opts, submodule, super_opts)
>   ls_files(submodule, sub_opts);
> 
> This eliminates bloating 'struct repository' and would allow you to have
> things configured differently in submodules (which is crazy if you ask
> me, but people do crazy things).

This does sound good to me.
