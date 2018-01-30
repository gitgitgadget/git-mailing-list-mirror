Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7281F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbeA3XiC (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:38:02 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36207 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752413AbeA3XiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 18:38:01 -0500
Received: by mail-lf0-f43.google.com with SMTP id t79so17960698lfe.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 15:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2P0DexEt234cNXveGnjjCRgVeab1ZhiB+dPI3PFw5E8=;
        b=gomRTL5F8x/Xur9Y/9GzKwd/yfsrKyYciyOFI3bfYSDCsxYr8vMVl3Noxr2eTy/tji
         F/ON36d8r86Deyu70qXLCEcIeLvk5/awmW0SOO9NYmUD7iG1X8VFm164HV0xOk7Ffqy7
         sdbx/GZQLTNSShdVT/nO37xy6P47QaiAvwSvVx9qX884BvyoUEpfRpMyt2gLiwJ/VkkR
         Hr6sKoN5yOzm5tVaOg2ZpGPp+brDUNJNwGb2nmPl2iimt6WJgKU5dV057kvkW7la2ir7
         RwX+EMgPrgbr44P4aXbi9LqGrYtGtzcuwUWTZEHUQmA8YmX2wn35RgWw5Qt4ptiCnzYO
         J8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2P0DexEt234cNXveGnjjCRgVeab1ZhiB+dPI3PFw5E8=;
        b=fEcMXyJcQgWK24ZBMPJy9GUeK1Wl8ghFwnOVpPdiPdtcAE11vt5deVagGWZfkn+VpG
         nNJQhJFCO37w5rp584KMACN+N4NQQA518Hc+jRTJE5LRBLCN0Y+5aEQWNjpfd2Fz0SRE
         xYxjeFcSfhveDEdlzk7PDdz/QAfm8kcJKI3dKA9t/zKtjIjLIU640bLNsn+2E7ltDura
         ZOn0BCHo8zYZq7mmoQFsakRkXAXS2X9r/vB8kZ/axKriimTfmOkNqv+Z98Qm63cW1IhT
         78pMIiVK1cOEifwJbTDXgWGjSn3aXAOoxNNT90AKYcY2SMkg2/bBrtDxVZHkFG4D0rbN
         O3bw==
X-Gm-Message-State: AKwxytcWai+yCtT3nuEL85a27mlid8li27tXu77QgJAVzYsttPDJj3+2
        L7dcI1RidAOmwFZvRo/EPMJARwMFJYRnMBNh5sQ=
X-Google-Smtp-Source: AH8x227qndugIi2iGwv4VgMfx9tTXakrtxrhJlsbWK4iG48sMw0ULQodyoB3w1ROG8eqiW3n6eQSqzLHafynvjwlXrk=
X-Received: by 10.46.21.15 with SMTP id s15mr18639738ljd.58.1517355479874;
 Tue, 30 Jan 2018 15:37:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.67.153 with HTTP; Tue, 30 Jan 2018 15:37:39 -0800 (PST)
In-Reply-To: <xmqqy3kfq6a9.fsf@gitster-ct.c.googlers.com>
References: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
 <CADfK3RU4WJLV9EtieWYQzzRBoJkpyE+w178WQk+wj6soFwKW7g@mail.gmail.com>
 <CADfK3RVJdk3zK7+eE45-PSkb=_v86wrC0TzY+hUmAkfO0Dea=w@mail.gmail.com>
 <CAGZ79kafgyOujDM4BsXdDUnP+iFk5mp2bYnX-Q65khW-weEhUg@mail.gmail.com> <xmqqy3kfq6a9.fsf@gitster-ct.c.googlers.com>
From:   Avery Pennarun <apenwarr@gmail.com>
Date:   Tue, 30 Jan 2018 18:37:39 -0500
Message-ID: <CAHqTa-0kdkDUjH1nw=4JPAivtyL84zfZ5t8Dj1UYXPrMd7Poqw@mail.gmail.com>
Subject: Re: Bug Report: Subtrees and GPG Signed Commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>> There has not been feedback for a while on this thread.
>> I think that is because subtrees are not in anyone's hot
>> interest area currently.
>>
>> This is definitely the right place to submit&discuss bugs.
>> Looking through "git log --format="%ae %s" -S subtree",
>> it seems as if Avery (apenwarr@gmail.com) was mostly
>> interested in developing subtrees, though I think he has
>> moved on. Originally it was invented by Junio, who is
>> the active maintainer of the project in 68faf68938
>> (A new merge stragety 'subtree'., 2007-02-15)
>
> Thanks for trying to help, but I have *NOTHING* to do with the "git
> subtree" subcommand (and I personally have no interest in it).  What
> I did was a subtree merge strategy (i.e. "git merge -s subtree"),
> which is totally a different thing.
>
> David Greene offered to take it over in 2015, and then we saw some
> activity by David Aguilar in 2016, but otherwise the subcommand from
> contrib/ has pretty much been dormant these days.

Strictly speaking, the 'git subtree' command does in fact use 'git
merge -s subtree' under the covers, so Junio is at least partly
responsible for giving me the idea :)

I actually have never looked into how signed commits work and although
I still use git-subtree occasionally (it hasn't needed any
maintenance, for my simple use cases), I have never used it with
signed commits.

git-subtree maintains a cache that maps commit ids in the "original
project" with their equivalents in the "merged project."  If there's
something magic about how commit ids work with signed commits, I could
imagine that causing the "no a valid object name" problems.  Or,
git-subtree in --squash mode actually generates new commit objects
using some magic of its own.  If it were to accidentally copy a
signature into a commit that no longer matches the original, I imagine
that new object might get rejected.

Unfortunately I don't have time to look into it.  The git-subtree code
is pretty straightforward, though, so if Stephen has an hour or two to
look deeper it's probably possible to fix it up.  The tool is not
actually as magical and difficult as it might seem at first glance :)

Sorry I can't help more.

Good luck,

Avery
