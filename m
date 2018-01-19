Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14F61F406
	for <e@80x24.org>; Fri, 19 Jan 2018 07:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbeASHy3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 02:54:29 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42395 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbeASHy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 02:54:27 -0500
Received: by mail-qt0-f194.google.com with SMTP id c2so1844772qtn.9
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 23:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yS/sGaOymMkfzGFnZmQskWUAKZDj9v8ivjOH8OXiWF4=;
        b=q2keqOZPgnMozKm+nJUyFwBj+cf5mtorb65aZ0cgmiYZDA4t3yMs+vUWf5husMnYkT
         X5UkJFEiK/19Jgb11huhrmWx6kVaDzZdO8tYaZQynjKJh61fAttixFbyCICn4AFn8PLR
         UkX4vMsPnNJkTyw12M3OUd0xtfc2yQgDYi2Hq2xQpOvj11qwV5JLQqKA1D5N6IP+ygOU
         +AbKK5d0nyZcdCBJ4Xdwb3rWfiMJwT5qyKAAs4/BeW6UjLgz3yZXOnkDR3pbsUqUK/S3
         tepcjQFKlO4uPHtkHy5fs5hv2NizwKweKoPg2JUbuJgzlqqA+CxeSW+FLTL9AEY7zxOu
         Xilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yS/sGaOymMkfzGFnZmQskWUAKZDj9v8ivjOH8OXiWF4=;
        b=QpgGcEp28bsliZiX2BktXS6JND3Y3UTR2dwogPB8cQ3++/Ow7Ozjiizz2g+qdrIlq/
         +bq4iFMw1ua1W+JUX9MoJ66xdJ7Mi2XVnquKDmXRMwiVtHhjC4DCPeRQ4V5SRnpFCur9
         rHdluMPEo4ZsvkUzgK7By2bAIUp2eoow4oKgaNbF8lP/y8L3EMMyowvHFk2wqERmTzD8
         QtsB7K1Gv+tBVxw8L+dp6NBLQ179a2GVDbURwOTVDSZgnjQmQTHA9FjHKDEfGGEckzcm
         KSMt5E8vJrVMo6sivsAVNLh2svBkenpcWqJDwHD3an9olaTPw+9/IB4PiOb6aXKmP1cs
         hBSw==
X-Gm-Message-State: AKwxytfkrEUtc538my44LJ45w0QkjNi5ZoDJZQh0TlDS9tGD+RJFfSdY
        J100ihK/4/ReAFGVIHSRzHTds1kAdTZl5Qg26hg=
X-Google-Smtp-Source: AH8x227CI6d5iHeB+ht6OhmuAjlw/Y3AptikaGq+do28HaIyNnbXwMOwq85JN4Ujg5eaYa5nyvr5LVs1voIbH69paOs=
X-Received: by 10.200.25.9 with SMTP id t9mr2016827qtj.75.1516348467166; Thu,
 18 Jan 2018 23:54:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Thu, 18 Jan 2018 23:54:26 -0800 (PST)
In-Reply-To: <20180119041825.727904-1-sandals@crustytoothpaste.net>
References: <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119041825.727904-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 02:54:26 -0500
X-Google-Sender-Auth: QlerXHECEkFvQNAkrj3yxAo7jr0
Message-ID: <CAPig+cTOw5NsSmLHYcBEidDzNyiidJ0Dw1dF227KWDL9JrASvw@mail.gmail.com>
Subject: Re: [PATCH] repository: pre-initialize hash algo pointer
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 11:18 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> There are various git subcommands (among them, clone) which don't set up
> the repository (that is, they lack RUN_SETUP or RUN_SETUP_GENTLY) but
> end up needing to have information about the hash algorithm in use.
> Because the hash algorithm is part of struct repository and it's only
> initialized in repository setup, we can end up dereferencing a NULL
> pointer in some cases if we call one of these subcommands and look up
> the empty blob or empty tree values.
>
> In the future, we can add a command line option for this or read it from
> the configuration, but until we're ready to expose that functionality to
> the user, simply initialize the repository structure to use the current
> hash algorithm, SHA-1.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I'm still quite mystified as to why this is working on Linux and not
> macOS, but I can only guess that compilers are just very advanced and
> have somehow concluded that we would clearly never dereference a NULL
> pointer, so they picked the only non-NULL value.

Now that we know (due to Duy's excellent detective work[1]) that the
trigger is files with names differing only in case on case-insensitive
filesystems, the commit message can be updated appropriately.

> I haven't included a test because I have no way to reproduce the issue.
> This patch is the first from a series I'm working on where I do expand
> the use of the hash struct and therefore caused a segfault on clone, so
> I can imagine what's going on without having a way to prove it affects
> this particular case.
>
> If someone with access to macOS can provide a test, I'd be very
> grateful.

Done. Find the test here[2]. It fails without your fix on MacOS and
(presumably) Windows, and succeeds with the fix.

> My apologies for the error and inconvenience.

[1]: https://public-inbox.org/git/CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com/
[2]: https://public-inbox.org/git/20180119074001.GA55929@flurp.local/
