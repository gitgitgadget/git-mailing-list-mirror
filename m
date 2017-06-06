Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0980E20D09
	for <e@80x24.org>; Tue,  6 Jun 2017 07:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdFFHjz (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 03:39:55 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35946 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdFFHjy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 03:39:54 -0400
Received: by mail-it0-f47.google.com with SMTP id m47so85911104iti.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TXxHxMM0w2qw//tc6Tjr74nVhPP9FuI7LDVSCAoB6k0=;
        b=vhAupkmpgoCN8fK+uxvI7XVSIGKpZs5MF/3gjmAuad65hRXt4BHf4RUL1PRkyoGnMj
         yXBOnteT2HDx3PR5m8qbOkPOVtd1xCLilfUEO0+h1Gm/FSnNH40BdafJOpLxTF2e4Tb/
         kiVlOjeCKI0WpG3u3lC4Or/K1UuuyihcZOp2H4fCfiJTqdnevWEVC2dYs2J+P0WKVSaS
         xvKvPXhZH2HVpW0tmb7ZIZjbLBms2Oz9cCjbMd+xNFFBSNN/ucXTGZkovOH7H7BAN8lJ
         uUdeKoxznEvUZIAkdaEdNuBAas60iSHxX8UUJsIjnDyOwHuc5YgUuPSUOlgQvSjifjKo
         r/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TXxHxMM0w2qw//tc6Tjr74nVhPP9FuI7LDVSCAoB6k0=;
        b=a1YUhdn/tArHn14Q87lpgWg2PAOr9H3kQrbH4S5/Pwz+vBjWd2IpIgzY+3nuFkkhn2
         nW9uT8HQVClJnEqB3tf1iZZRNzME9nM/wYgqDJ5OIZKP9wJg19Rp88Sh4PfphtUya+Cb
         wXamGubyZzETI0wptj2rva0upkLYOr8S602bQZn306vaI/quOponccSADfW/9S4XWg2z
         vS0jtwgHIUJ6gNPU1a7hcvD6WIbKZJtLuOVdgz4WhVAARGi97Qrk2y2h5VOokGCccNJs
         vx3rqdLjhmPoqoJrkZBF2SytQVX6ym/nARCpPpv6gWjPOk+WZ8CiCF00j7kOg8nj2POi
         YUIg==
X-Gm-Message-State: AODbwcCYt9WvlB48uy8WEEl/ZxwhUKRxMexkoyZKlBEzuJ/9D7ledT2q
        6xUpmXOwRdqkrLsocPmUS2JBcM4JlA==
X-Received: by 10.107.201.213 with SMTP id z204mr4760681iof.160.1496734793139;
 Tue, 06 Jun 2017 00:39:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Tue, 6 Jun 2017 00:39:32 -0700 (PDT)
In-Reply-To: <xmqqlgp69ds9.fsf@gitster.mtv.corp.google.com>
References: <0102015c79fcbda0-2779b4ff-54ad-46f4-bef0-14eeb58338d4-000000@eu-west-1.amazonses.com>
 <0102015c79fcbe99-7e18cee7-d82d-4ab2-9d6a-ad7376a5ac27-000000@eu-west-1.amazonses.com>
 <CALiud+=qoSSSg_p2MXZEaVTGMhFW_FtirDJ2-FnmNh+U0yf0Gw@mail.gmail.com> <xmqqlgp69ds9.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 6 Jun 2017 09:39:32 +0200
Message-ID: <CACBZZX5OS_cz_mo4rpd+=DGtyN4SfipGrOXwVHJisv3CywoFaw@mail.gmail.com>
Subject: Re: [PATCH/RFC v4 3/3] branch: add copy branch feature implementation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 2:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sahil Dua <sahildua2305@gmail.com> writes:
>
>> I want suggestions about one logical point raised by Evar.
>>
>> Let's consider a case that I'm on branch maint and then I do 'git
>> checkout master' followed by 'git branch -m feature', it will rename
>> master branch to feature. Now if I do 'git checkout -' to go to the
>> last branch, it will take me to maint since master branch doesn't
>> exist in this case.
>>
>> Now, for this copy operation - if I'm on branch maint and then I do
>> 'git checkout master' followed by 'git branch -c feature', it will
>> copy master branch to feature. Now if I do 'git checkout -' to go to
>> the last branch, it will again go to maint (according to the current
>> implementation). What do you think it should do? Is this the desired
>> behavior? Or should it go to master branch since that was the branch
>> checked out before copying.
>>
>> Also, in case this needs to be changed, can someone please point me to
>> how it's being handled so that I can change the behavior.
>
> When somebody says "I want to rename my current branch to X", it is
> clear that the person wants to end up being on a branch called X.
>
> To me, "I want to copy my current branch to Y" sounds more like "I
> want to create another Y that looks just like the current branch,
> but I want stay on my current branch".

This would be more useful to me if the semantics were copy & checkout
instead of just copy, since when I'd like to copy branches it's almost
always because I'm on some topic branch and want to create & work on a
new copy of that topic branch.

It would also be consistent with "git branch -m" and easier to
explain, i.e. "git branch -c just like -m except it doesn't delete the
branch name/config you moved away from".

Like with -m, you can still move around random other branches, e.g.:

    # While on master
    $ git branch -m some-other new-some-other

This will just move some-other to new-some-other without checkout out
new-some-other, it's only when the source name is the same as your
currently checked out branch that you checkout a new branch,

Now, of course the difference is that when you -m your current branch
it doesn't really have a choice of whether to move your checkout as
well (although I suppose it could leave you in a detached HEAD..) so
it *could* be done differently with -c, but the current behavior makes
more sense to me and matches the common case I'd use it for.

> If you think copy makes @{-1} problematic, perhaps your copy is
> doing more than it should (e.g. switching the current branch at the
> same time, or something).

I think what Sahil is getting at is asking where the @{-N} info is
stored and why this isn't equivalent to:

    $ git checkout -b one master
    $ git checkout -b two master
    $ git checkout master
    $ git checkout one
    $ git checkout two
    $ git checkout - # Goes to "one", not "master"

Which is in analogous flow without this feature that switches to the
last branch, but with "git branch -c" if you were on 'one' and copied
& checked out 'two' doing 'git checkout -' would bring you back to
'master', not 'one'.
