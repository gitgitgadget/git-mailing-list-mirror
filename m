Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B030B1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 20:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbdLKU1Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 15:27:25 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:38522 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdLKU1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 15:27:24 -0500
Received: by mail-qt0-f172.google.com with SMTP id d4so41923212qtj.5
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 12:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pIJthEwmb1+pOZW+0dwbMfKeD7jnz1NonQVqEj77Tis=;
        b=WTrLQntKBwtBWJRqrl7L7WW39Dh6aqQfJMguaFCIPFw6Zq4/SFXBPBaknDWWHiJjwP
         RqnYJgVlFDyjXDzNGUeDJaXJ6X6e0P4ikVsqTc5rEUg9rUhkZxUA4IUrLNCUsizeFPXU
         YfLwahg6QA7ibYLH0PsLF++bbVg+dIAv9JER8xekalxC1Hm4L4d/eaR3LqWmxFCVICqV
         ieqLFsgh4vrtRpm4d6Eaw0GkIyKuQNIzjEfmiILffB3PaWgeikD07lOe0WAUkN8g6MIB
         AwfBuaFAuiisDF2UplgchkkXfhnRp7JQBbr/zrPMukLFXTF7dwaeQkgSbV/FFIMYGaiw
         KTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pIJthEwmb1+pOZW+0dwbMfKeD7jnz1NonQVqEj77Tis=;
        b=NwMnSAy1wnggaERMb1b3nY7vX8cVQdqLutk/PGtH3/9jZELJbyM06rWe6SYCkpif0t
         alyGxkUfqSxnLTlcffz+BCrmOqkpGBYzeT0YS2nQXheP5a5qn3c3yjuQMEmoYcEdfh9u
         67Y3/Q9QYmfr30vSvJLMkyniX5BWQTCJsRn4hTweCZwyCek90OS4lb7mj+CyatEferY8
         Ho5yJ5peeksebH4XjosNp8dILFNRefoSpZoRkDbadncL5O1LDJIV/I2mzaoDKj+Xb/Aa
         JXSuwgA7YtQVrjV4JwAdh7kwB/K9zPajvQ7lBFPhYRG/KS47sOMI6P5yLEhiZ1P/zxsc
         n7NA==
X-Gm-Message-State: AKGB3mKVWb7252yenQWDdeeL6SY8l0Y9yl5RjGB1YVnuLmpJXRJ+FpHL
        TQbw+hfRmiuBoXu/Rx4OWGXSMejKv7iqIHKRWHc3yTJz
X-Google-Smtp-Source: ACJfBovuidq0WEaqvgYXr/p1ZkTC12kqoOaFvnzFURPRG4n6icPoQ5pmLQDKCxLid7UgzjJJH2yJ8IuA7DYPr8yfC2M=
X-Received: by 10.200.35.215 with SMTP id r23mr2298114qtr.174.1513024043492;
 Mon, 11 Dec 2017 12:27:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 11 Dec 2017 12:27:22 -0800 (PST)
In-Reply-To: <1512423580.9882.405.camel@novalis.org>
References: <1512423580.9882.405.camel@novalis.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Dec 2017 12:27:22 -0800
Message-ID: <CAGZ79kZVm7ZgnqBFnKd8L51Uy+5_7DOttUMAU=qofN3XXD94nQ@mail.gmail.com>
Subject: Re: submodule modify/delete wrong message
To:     David Turner <novalis@novalis.org>
Cc:     git <git@vger.kernel.org>, brock.peabody@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 4, 2017 at 1:39 PM, David Turner <novalis@novalis.org> wrote:
> When merging with a submodule modify/delete conflict (i.e. I've deleted
> the submodule, and I'm merging in a branch that modified it), git lies
> about what it is doing:
>
> "CONFLICT (modify/delete): submodule deleted in HEAD and modified in
> submodules.

Up to here the error message sounds correct, still?


> Version submodules of submodule left in tree at
> submodule~submodules.
> Automatic merge failed; fix conflicts and then commit the result."

This sounds as if the code assumed to handle only files.

> In fact, the working tree does not contain anything named
> 'submodule~submodules'.
>
> In addition, I would ordinarily resolve a conflict like this by using
> 'git rm'. Here, this gives a warning:
>
> $ git rm submodule
> submodule: needs merge

(Regarding submodule merges in general:)

Uh. We cannot add merge markers to a submodule or such.
More importantly we'd have to ask the question if the merge conflict
is on the superproject level (Choose one of the commits of the submodule)
or on the submodule level (perform a merge in the submodule between the
two commits) or some hybrid approach thereof.

> rm 'submodule'
> warning: Could not find section in .gitmodules where path=submodule

The deletion of the submodule removed the .gitmodules entry, and the
merge of the .gitmodules file presumably went fine. :/

I assume we need a special merge driver for the .gitmodules file to keep
the submodule around when it is in at least one side.

> Git's behavior here is significantly better than liggit2's (which tries
> to check out 'submodule' as if it were a blob, and fails to do so), but
> it's still confusing.
>
> It's not clear to me what the correct behavior is here.  Maybe it's
> sufficient to just fix the message?

I think the first step is to fix the message to reflect reality.

As alluded to above, I don't know what the correct merge
behavior is (and where to put 'conflict markers').

Stefan
