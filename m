Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C257820209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdGASQT (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:16:19 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:36788 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdGASQT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 14:16:19 -0400
Received: by mail-ua0-f173.google.com with SMTP id g40so91400916uaa.3
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z06fOektcIlVBRxqgwO9JtxOblmRmmU6ihpicsZ2uWg=;
        b=XH8EbHPQCGe6fqOgytPG8f213SwGlRo/kei1VotgoNNjWmXQvgsbszEZ5GZ0kxn5d4
         dj2+Bv5clrg/BKtOoDh5aw+4dpgBcGc6WPwFD9GCSVtec1ebBgdRbO3vUUxIknELAn3u
         8e0iAjeA0pyRXiv0cCd5Z9/2HnlwFmsIQmORw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z06fOektcIlVBRxqgwO9JtxOblmRmmU6ihpicsZ2uWg=;
        b=rk1jF933w2KzylwsQ7poI0DwLk/VFIwKMcBeUxkbAx96pBnlAWWnMn5NG+YbMd1N+o
         44sncuajwH7cqcjxMcUQovBuPjsoDFvoZtCKLMxQU6UoOTIpCA2zbR9lL60khCJY7wvb
         SCUYrkgC8BZgYuaHdR0pDsZnsI9nukto6rQ6LnkGQ9LCRDZF1B9hEZz26z6FhW4P/DTb
         gaj03gKkeSA6Jp3wGXh3Wq7UMujgN+5qfoseG2xV/v6isixjHbJSn54meeH/uT6QjJmo
         NOEgS4VWbDsAgFBKc6JBIu8jESWD4P2gFOFCj/5NfzXoQH1qoLgrqP7+k6rU9YEGJyVO
         gRsg==
X-Gm-Message-State: AIVw110/qY3TqfWGu0r14wuJ+LhivL3TQmPz5JU436or1M/MCp4G1rR8
        +mKYQ3xV/N661cQhZNaXsF2pkS66J/SPC6ExmQ==
X-Received: by 10.176.24.80 with SMTP id j16mr1632616uag.120.1498932978161;
 Sat, 01 Jul 2017 11:16:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.69.194 with HTTP; Sat, 1 Jul 2017 11:15:57 -0700 (PDT)
In-Reply-To: <xmqqbmp4nj9u.fsf@gitster.mtv.corp.google.com>
References: <CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com>
 <xmqqbmp4nj9u.fsf@gitster.mtv.corp.google.com>
From:   Dan Kohn <dan@linuxfoundation.org>
Date:   Sat, 1 Jul 2017 14:15:57 -0400
Message-ID: <CAHv71zJZfG3AGNL_J5KqYiut6AyyNdUyBG-sZ9aZ-zoGVdOr+w@mail.gmail.com>
Subject: Re: Request for git merge --signoff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 1, 2017 at 1:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dan Kohn <dan@linuxfoundation.org> writes:

>> Could you please add a `--signoff` option to `git merge`?

> The reason why we changed the default for "git merge" to start an
> editor at around v1.7.10 was because we wanted to encourage people
> to write log message that more meaningfully documents the change,
> and adding sign-off is probably in line with that.

> I've done that "commit --amend" on a merge to tweak its message
> myself number of times, but I have to admit that I never did so for
> sign-off, but why not? ;-)

I'm not opposed to starting the editor, although in the case of our
workflow there's not much more to say beyond "Merged in master". I
would just like the Sign-Off line to appear by default in the commit
message if I do `git merge origin/master --signoff`. I know it seems
trivial, but many GitHub users aren't familiar with the exact header
syntax to use, as they're used to just doing `git commit -sam 'New
Feature'`.

Separately, I just came back from Beijing where Linus spoke at LC3
<https://www.lfasiallc.com/linuxcon-containercon-cloudopen-china>. He
was asked about git and explained that he had largely bowed out of any
development after the first few months and credited your stewardship.
Even if you turn down my request for a new flag here, thanks for the
amazing project!
--
Dan Kohn <mailto:dan@linuxfoundation.org>
Executive Director, Cloud Native Computing Foundation <https://cncf.io/>
tel:+1-415-233-1000
