Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77990211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 20:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeK3HQu (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 02:16:50 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34870 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3HQt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 02:16:49 -0500
Received: by mail-ed1-f42.google.com with SMTP id x30so2991774edx.2
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 12:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3Cxq5sdce6HQidU4eLNBbWpnbAW04jn5joQD07GAXHg=;
        b=G/ibMxqGkPlHBBZOaLX3hKwsVuikxUmlNuBesfj9fpvnlqc70FyvfzYvo0v5OdlYBa
         ZACS0FYN1C5m37X/bRjTfd9o47uncMrfH/hQ1XTSjbDtD02K+DU2JEz8Gn9lKgmdk0eU
         2kmIRFw9FXG85R/sNYYDly4ckLZPWta9ao6h1abN0MzqW0KeJslJWYnO0rTlANBxGFmM
         fLe7KmP6Vh08i3cvA19uALEyhNnC3YICeHF1S1PhKc9NsweAISZ9LfWitGKe3gFxW0NG
         Iu7y+TTFqC7nceunacJjcOpRR9jkApZ13lM4CjdtMNXlm+lrosgLUq839vMVMLoQmUDb
         8pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3Cxq5sdce6HQidU4eLNBbWpnbAW04jn5joQD07GAXHg=;
        b=e45W/Omv5kKLzUlkZz16XZUkS5TwCwmNtB517mDgwvmGXyPbahfnJ7NN3a0wQpz3Wq
         z3QkNLKWCNijNihacQUnxh9z9z/HZJIxWkegg9YYwAvHKkm0yftVzZUWsAYl1VuzdGwl
         MafGoHKy1cegzvqKHqfnJQNqtSay42ucUHeEK2mRfCUN6YAdOG25gy77imIWSk8F6L/w
         UkJfW/jaBz7sYNemGHAZzox8PYGcV+ZFYbrOrB4SdeyFggY27vqMQ4YL4KZAq69owq7q
         ZHnElTEHOHrc7gwR11ijaqrrA1djAMW6UTXKKIcOZg5wPexrTaZXBOUD8llbD/a+Zn6F
         uUCg==
X-Gm-Message-State: AA+aEWZGAowPn5a8qC+7EM1GFXbA7SowLs0vSDWIBjh4p2TnQTxDBus3
        RFlGOlaSzfTXUA3J2WuKeYUQuwre
X-Google-Smtp-Source: AFSGD/Xhho/ycZpNGJBiTxpK2FBOukKE1wMM5JV8VcQVXHxIvPfm+Rjkt3iSAucbctd7pMzbgyqa2Q==
X-Received: by 2002:a17:906:6085:: with SMTP id t5-v6mr2628979ejj.47.1543522211622;
        Thu, 29 Nov 2018 12:10:11 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id j8sm837657ede.55.2018.11.29.12.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 12:10:10 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, git-users@googlegroups.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: How de-duplicate similar repositories with alternates
References: <87zhtsx73l.fsf@evledraar.gmail.com> <CAGZ79ka1sjU+rHctRP4SVMP0GQsK2iZghkU46=f96ugqvX5Neg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAGZ79ka1sjU+rHctRP4SVMP0GQsK2iZghkU46=f96ugqvX5Neg@mail.gmail.com>
Date:   Thu, 29 Nov 2018 21:10:06 +0100
Message-ID: <87r2f3y7a9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 29 2018, Stefan Beller wrote:

> On Thu, Nov 29, 2018 at 7:00 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> A co-worker asked me today how space could be saved when you have
>> multiple checkouts of the same repository (at different revs) on the
>> same machine. I said since these won't block-level de-duplicate well[1]
>> one way to do this is with alternates.
>
> Another way is to use git-worktree, which would solve the gc issues
> mentioned below?
>
> I view alternates as a historic artefact as the deduping
> of objects client side can be done using worktrees, and on the
> serverside - I think - most of the git hosters use namespaces
> and put a fork network into the same repository and use pack islands.
>
> Can you elaborate on why worktrees would not solve the problem?
> (I initially was hesitant to use them as I liked going into .git and tempering
> with files such as the config directly. But now I cannot `cd .git` any more;
> it turns out the advantages outweigh this corner case that I was attached to)

This was discussed recently on-list & I chimed in with details about
that here:
https://public-inbox.org/git/87po1waqyc.fsf@evledraar.gmail.com/ &
https://public-inbox.org/git/87muwzc2kv.fsf@evledraar.gmail.com/

In particular the "multiple devs" use-case described in the latter
E-Mail is what I have in mind. Worktrees are inherently unsuitable for
that.
