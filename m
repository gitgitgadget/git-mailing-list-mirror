Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A42E20357
	for <e@80x24.org>; Fri,  7 Jul 2017 21:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbdGGV3T (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 17:29:19 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36517 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbdGGV3T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 17:29:19 -0400
Received: by mail-qt0-f173.google.com with SMTP id i2so37296587qta.3
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uc/gjj6p+44ftiOMdpfccIxa0BooE80yMRHNru5yYV8=;
        b=ik4Av3+Zt3y5Sib4++U/9QFClgV3W+EqBE0ik4wRKpUzXLFqjjq0ynvsqnBMMZ+10P
         dcCOM4HiPDe00KtM4DL0H6enN5dp2NFGBmKlnH1WNMV4l8Pxda1bhzDZG8k8igJn449b
         KI5Bhf3IGnhEoVR34NzJyGZHqYOZ6NpIWA6+G93nYYufEmkXqrJIgP530zmOSwcGhaF7
         yvx4rZy3UQgVSFlaLnl8kvmDxTfdOB6P7DlkVEb/fCgpoMxNMLKddEhQYVDLpIFx96ew
         jIZlo5Gke6oU+Tmb3RIbVL6qODo+634f8ksJQGfxlEVgLpAP6sPPyaxB7powrMU+ZMkl
         V9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uc/gjj6p+44ftiOMdpfccIxa0BooE80yMRHNru5yYV8=;
        b=CcXpn+NzBe4cnxfN3oSvTQy6V6xN9dfPV3dX9SYMCOwCS2Z7zKAEpIo5f9PkWAQc3i
         WW2fm/3W6WuVVbuwjwsU9v6B5vrakVJnaRLPd/xSmzg545Uf9PneYj3ARAz3/n1/8P+R
         +6HwLBUdiPPh2bDzwl4Dllsh6Gm/BrWyEan5qz3+1SKaCAzbFPwkj/pmBC5gYpUhdon/
         iRZdwVIy7QFvVAftJpaqOCtWkXRcFur1VRUAuPJRsm9PFvl+AmQKH26ZwWeID6dXviF9
         YLOJgIwqQvCUQSoVdcUJ5lQNoGaUVA1PrXQwiJc4UCnM2kUE+qPf6cMLC8GxYsTd/znq
         WhuA==
X-Gm-Message-State: AKS2vOyLfgdzNqmTaRKtPqYE8BhOfS2MD9+kJJXMhpNj36D52ahmanRP
        5JcsJltCijqWZ4jxErC19Mn7le27BA==
X-Received: by 10.200.4.140 with SMTP id s12mr69377605qtg.35.1499462958042;
 Fri, 07 Jul 2017 14:29:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.0.129 with HTTP; Fri, 7 Jul 2017 14:29:17 -0700 (PDT)
In-Reply-To: <xmqqshi89c3d.fsf@gitster.mtv.corp.google.com>
References: <20170707123727.dgd5rub2ycrg525y@ltop.local> <xmqqd19cckfw.fsf@gitster.mtv.corp.google.com>
 <20170707171300.kd5hqcujbvubw73q@ltop.local> <xmqqshi89c3d.fsf@gitster.mtv.corp.google.com>
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date:   Fri, 7 Jul 2017 23:29:17 +0200
Message-ID: <CAMHZB6Hwc=wiJ=R7fQZ+XB-i9_JP09qV9tm6jZRTUBgJgpvn=Q@mail.gmail.com>
Subject: Re: bug during checkout of remote branch and uncommited changes ?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 7, 2017 at 11:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:
>
>> At least here, the scenario I gave allow to fully reproduce the problem.
>>
>> Would you like any other information?
>
> Not really.  Here is what I locally ran and its output
>
> -- >8 -- cut here -- >8 --
>
> #!/bin/sh
>
> mkdir -p /var/tmp/x/lvo && cd /var/tmp/x/lvo || exit
>
> rm -fr src dst
>
> (
>         mkdir src &&
>         cd src &&
>         git init &&
>         >file &&
>         git add file &&
>         git commit -m 'initial' &&
>         git checkout -b abranch &&
>         echo abranch >file &&
>         git commit -a -m 'abranch'
> ) || exit
>
> mkdir dst &&
> cd dst &&
> git init &&
> git pull ../src master &&
> echo mine >file &&
> git status -suno &&
> git remote add aremote ../src &&
> git fetch aremote abranch || exit
>
> git checkout abranch
>
> git reset --hard
>
> git checkout abranch
>
> -- 8< -- cut here -- 8< --
>
> $ sh script
> Initialized empty Git repository in /var/tmp/x/lvo/src/.git/
> [master (root-commit) 8535bd5] initial
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 file
> Switched to a new branch 'abranch'
> [abranch 32814d9] abranch
>  1 file changed, 1 insertion(+)
> Initialized empty Git repository in /var/tmp/x/lvo/dst/.git/
> From ../src
>  * branch            master     -> FETCH_HEAD
>  M file
> From ../src
>  * branch            abranch    -> FETCH_HEAD
>  * [new branch]      abranch    -> aremote/abranch
> error: Your local changes to the following files would be overwritten by checkout:
>         file
> Please commit your changes or stash them before you switch branches.
> Aborting
> HEAD is now at 8535bd5 initial
> Switched to a new branch 'abranch'
> Branch abranch set up to track remote branch abranch from aremote.
>
> ----------------------------------------
>
> As far as I can see, everything is working as intended.  The first
> "git checkout abranch" stops due to the dirty local state before it
> even tries to DWIM to create abranch, and then after resetting to
> get rid of all the local modifications, the second "git checkout
> abranch" manages to create the branch just fine.
>
> Even with different variations (like making dst a clone of src to
> force the "checkout" to see an ambiguity), I do not seem to get your
> "the first one fails with an error message about Ambiguity, the
> second does not", which indeed is a curious symptom.
>
> Without knowing if this is an ancient Git, or what remote other than
> aremote this repository has, what remote-tracking branches from
> these remotes this repository has, if they share the same name
> abranch that points at the same or different objects, etc., I simply
> do not know what is causing you the symptom, and time I allocated to
> look into this for now just ran out.

Strange.
I forgot to say that I was using git 2.13.0

I have a few more remote but 'abranch' was just a new branch (with
name unique to the remote) with fresh objects.

I'll investigate things more here and report if anything new.
Thanks, for your time.

-- Luc
