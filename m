Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE548205C9
	for <e@80x24.org>; Thu,  5 Jan 2017 17:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758706AbdAERbS (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 12:31:18 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34573 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753850AbdAERax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 12:30:53 -0500
Received: by mail-qk0-f178.google.com with SMTP id a20so50591753qkc.1
        for <git@vger.kernel.org>; Thu, 05 Jan 2017 09:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xMs5/1tZ8sVk+bFZ8ClEjOn+kC+jUsx2KqLeA+OKjIM=;
        b=QYObgEc/vEtfBluIqKbgMHyhG4A4K+MauKSYefi6HwTmNdmwcqv3bUQONfvpe+mFV1
         /TimzqgTvjhAfTYF943y9KMJjpF614BBVCbwpcsOyOuoMyt5JNQ11IWeBu0DeCKrhGph
         jIl7959yktxKcMOoBYdweWJYP8ZQjE+wgyK8Eum5DKUVIo6GO6M4oUhBbDHnRUrreBg4
         XGzu7WSsuWMjwG1nbO6hPHOjnrwZZ0hmm9h054hkPrAgr0MmzPNrQ+VgEh6F7iqP7/k6
         EX7Uj+z5LJUWhP8HTarRf3TOjVG4k907c6LZhEhj/6Sb62Wg6gVgej7iRFFFJ9UF9Hcd
         P0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xMs5/1tZ8sVk+bFZ8ClEjOn+kC+jUsx2KqLeA+OKjIM=;
        b=rN+pOW+7NZvhIz1TXpX2jQzXM5pDlaM2KAsrXni148GCOMVRVS5VKYDGG3LkF4tDyW
         Pj2etM7nuofah1dv85/OCXwOyxW0G8PW5mxyEIq6TcjcTboz0GZP+2TkNM5iNNrjsxnp
         26d/0yEMwwnoCkdJB7SmW7exhOa/jPKK9fRlVQjCscFrlEs5uz47XU4EXeSxG7P1awQA
         b0JtYXgWcYugjt/NfZ5TbFY9Mq+se2FFXBMl/93S9bYhnKgv9r9M5X+gUHfZMM8wH1TH
         Xa1WE7gvmAydn90uJB/SSyJrluGt0PY5HMKIv3s51ePQcCLKR27CI7owsTrWc4OG6lCM
         ocYQ==
X-Gm-Message-State: AIkVDXLamZPo3lWbImoSXN9n+DqtneYSWO0KBQ0SQwdnANDQHt8gIS5G3iXu4M8iZcL68Tee7MMvcNYcPPFVBQVl
X-Received: by 10.55.221.5 with SMTP id n5mr67901046qki.58.1483637452118; Thu,
 05 Jan 2017 09:30:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Thu, 5 Jan 2017 09:30:51 -0800 (PST)
In-Reply-To: <20170105170214.6fmsbj6ltbmpvcfb@sigill.intra.peff.net>
References: <17f2724d-7001-203e-f0b5-cf586703a41a@boxbox.org>
 <CAGZ79kb8TTaJBmVCWK3jnr4RvGjmfmsj3-ieT87wzyFLYi5frQ@mail.gmail.com> <20170105170214.6fmsbj6ltbmpvcfb@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Jan 2017 09:30:51 -0800
Message-ID: <CAGZ79kYPuqYTAFe9c0kQxrREfEPtuT_OT4ZsFAz-c1UPW3k9yQ@mail.gmail.com>
Subject: Re: core.sshCommand and url.*.insteadOf for submodules
To:     Jeff King <peff@peff.net>
Cc:     Stefan Schindler <stsch@boxbox.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 5, 2017 at 9:02 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 05, 2017 at 05:53:30AM -0800, Stefan Beller wrote:
>
>> > My scenario is as follows: I use 2 SSH keys for GitHub, for private and
>> > work-related repositories. My default key is my private key. So when I
>> > clone a work repository and try getting the submodules, `git submodule
>> > update --init` fails. This is also the case when setting
>> > `core.sshCommand` and `url.*.insteadOf` (useful for substituting
>> > "github.com" by some ~/.ssh/config'ured host).
>>
>> which is why e.g.
>> git config --global url.https://github.com/.insteadOf git://github.com/
>> is not your preferred way here.
>>
>> There was some discussion a couple of weeks ago, which settings
>> should be kept when recursing into submodules, Jacob and Jeff cc'd.
>
> The only discussion I recall was from last May. But that was about "-c"
> config on the command-line, and the end decision was that we pass it all
> down to submodules, per 89044baa8b (submodule: stop sanitizing config
> options, 2016-05-04).

Oh, yeah that was the difference.

>
> I think the problem here is more about propagating options from the
> superproject's repo-level config into the submodules. AFAIK we do not do
> that at all, but I may have missed some patches in that area.

AFAIK there were no such patches yet.

>
> Another approach would be conditional config includes based on the repo
> path. With the patches discussed in [1], you could do something like:
>
>   git config --global include./path/to/work/repos.path .gitconfig-work
>   git config -f ~/.gitconfig-work url.foo.insteadOf bar

Or maybe we could specialize these patches to allow
includes from specific other repos, i.e. superproject(s) or worktrees.

>
> -Peff
>
> [1] http://public-inbox.org/git/20160626070617.30211-1-pclouds@gmail.com/
