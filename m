Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F89D1F406
	for <e@80x24.org>; Mon, 14 May 2018 22:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeENW6i (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 18:58:38 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53229 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeENW6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 18:58:37 -0400
Received: by mail-wm0-f45.google.com with SMTP id w194-v6so16146725wmf.2
        for <git@vger.kernel.org>; Mon, 14 May 2018 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=K8iJdo/L8t2FZhSkXtSlNjIj1/14OP6+vZI/nhjAzyA=;
        b=SdteAJo319pdUrA9yo19UUjl7b9qt2k0HPnhB2q/QqdwnDl8d28RmU7l1mgV2BPj8E
         EzvjutK08ogUgUKAthF2t34po+mJ+j9M+/iYkIeOTX7gjvr2O7iRFtuuxar3HY0AZ+GL
         L0k1q0GS2Lzyowt9MMnt+UTJ4U2ladbBaizVx4zRyL6p1fuEh6G9+3/sguyZvC0MNpsU
         aCF7gRUhCWgRssBQZMBAqLYx/lcyjU+RcSN2Bv238DiUaqaiYkYzPo9QxMpd3ztKbCgx
         Hwyb7G8t6V5l2BGL9AbRNadghZpex2b7wfvO8MtCEowEq1dtR2sBc6eBghLm1YGeQd9P
         eSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=K8iJdo/L8t2FZhSkXtSlNjIj1/14OP6+vZI/nhjAzyA=;
        b=USJ7NypVGpaneY9sLhtY6Ym07Y39EUCk+6ZdSZbP+CMyuM8fqGdE7AVp2G6J/pOpmr
         R36q0evULENfO05DV11yidsgxYptLeTyIkjUeNtGX6bZhrrph5HS6ZI9D2hcLtCyulmc
         njoa2jBVjGjzzk7URPUhPU+dLY7igCW00wFbstfmfDZ4TXAusQbODndHECj8ivoEBLcK
         hPmj1nboQS4bYdDS1XP8sckq/yTRnTy3d/2Nz1l/AaRZ7CpEu+eGukNDqLHypVks7vcm
         Ajv8aq/SX7eqDg8E8wp+rBUPoN6mO+7FOy1/qUplHfxrndsTk8MvlOQxi/ALJjBomj/5
         sREQ==
X-Gm-Message-State: ALKqPwdDM5UYtaU0NgbZ6kG1EAKEqo9AEuSWulSLfeDAxh/0R3Rf0qkv
        ppZpeAGXLNLLj/KXQ12TIpX7qVXG
X-Google-Smtp-Source: AB8JxZqPPYVE6/mtuElrDtglT+QrrtyK1Lu9+VJQSlHq+bVC8f0ht9B1Q2CyJpVgNWKZuu0LdTyXhQ==
X-Received: by 2002:a50:921c:: with SMTP id i28-v6mr14672501eda.27.1526338715960;
        Mon, 14 May 2018 15:58:35 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b43-v6sm5604117edc.34.2018.05.14.15.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 15:58:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: could `git merge --no-ff origin/master` be made more useful?
References: <CANgJU+VFCY0LNRLMSGtD7ScpcLaPFMzUOyw6Bjgk6q=Kx9DvCg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CANgJU+VFCY0LNRLMSGtD7ScpcLaPFMzUOyw6Bjgk6q=Kx9DvCg@mail.gmail.com>
Date:   Tue, 15 May 2018 00:58:34 +0200
Message-ID: <87lgcl3kv9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 14 2018, demerphq wrote:

> The first time I tried to use --no-ff I tried to do something like this:
>
>   git checkout master
>   git commit -a -m'whatever'
>   git commit -a -m'whatever2'
>   git merge --no-ff origin/master
>
> and was disappointed when "it didn't work" and git told me there was
> nothing to do as the branch was up to date. (Which I found a bit
> confusing.)
>
> I realize now my expectations were incorrect, and that the argument to
> merge needs to resolve to a commit that is ahead of the current
> commit, and in the above sequence it is the other way around. So to do
> what I want I can do:
>
>   git checkout master
>   git checkout -b topic
>   git commit -a -m'whatever'
>   git commit -a -m'whatever2'
>   git checkout master
>   git merge --no-ff topic
>
> and iiuir this works because 'master' would be behind 'topic' in this case.
>
> But I have a few questions, 1) is there is an argument to feed to git
> merge to make the first recipe work like the second? And 2) is this
> asymmetry necessary with --no-ff?

I've been bitten my this myself, but found that it's documented as the
very first thing in git-merge:

    Incorporates changes from the named commits (since the time their
    histories diverged from the current branch) into the current
    branch[...].

Since origin/master hasn't diverged from your current branch (unlike the
other way around), the merge with --no-ff is a noop.

> More specifically would something horrible break if --no-ff
> origin/trunk detected that the current branch was ahead of the named
> branch and "swapped"  the implicit order of the two so that the first
> recipe could behave like the second

If it worked like that then the user who sets merge.ff=false in his
config and issues a "git pull" after making a commit on his local master
would create a merge commit.

This old E-Mail of Junio's discusses that edge case & others in detail:
https://public-inbox.org/git/7vty1zfwmd.fsf@alter.siamese.dyndns.org/

> Anyway, even if the above makes no sense, would it be hard to make the
> message provided by git merge in the first recipe a bit more
> suggestive of what is going on? For instance if it had said "Cannot
> --no-ff merge, origin/master is behind master" it would have been much
> more clear what was going on.

I can't spot any reason for why we couldn't have something like this POC
(would be properly done through advice.c):

    diff --git a/builtin/merge.c b/builtin/merge.c
    index 9db5a2cf16..920f67d9f8 100644
    --- a/builtin/merge.c
    +++ b/builtin/merge.c
    @@ -1407,6 +1407,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
                     * but first the most common case of merging one remote.
                     */
                    finish_up_to_date(_("Already up to date."));
    +               if (fast_forward == FF_NO)
    +                       fprintf(stderr, "did you mean this the other way around?\n");
                    goto done;
            } else if (fast_forward != FF_NO && !remoteheads->next &&
                            !common->next &&

But that should probably be reworked to be smart about whether --no-ff
or merge.ff=false was specified, i.e. do we want to yell this at the
user who's just set that at his config default, or the user who's
specified --no-ff explicitly, or both? I don't know.
