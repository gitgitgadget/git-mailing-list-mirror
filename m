Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660622095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758021AbdCUWhQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:37:16 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35671 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758038AbdCUWhO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:37:14 -0400
Received: by mail-pg0-f41.google.com with SMTP id t143so34129994pgb.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ymigIyeCreAluNeWUlY5Ki+RGq0ncVwTcmrXy27WsaM=;
        b=bRgE7U7OVcC9+9zXq6HTSJSEhF/qeI5Oe6KuacoQginbfaX9qbvrECZw5XtRfvtH4y
         /BuSnnMfFZGIRmVOGb06JVMqL/AFwxKsm/2cCWJjCfUuiQ7FQD8o+423GLDo1TmfJv19
         0mVCBlgo8P6i0bXHtGrn/C1+M4dF2Irjw6GMluGVbf/dhJLzqecg3S3gibLI0gCuyYME
         9AV0gSEut8SyCkMsiYPYcpYeXpvW2v2zBWDxKkIbaOwEx6hK7teoAXkM1/HsLIepIpNl
         F+fg2bdT6FSDeanRXLX4kVVmaoBJiKq3L3+4d462k3fx3VgKDkzNE2urvVVlSzq7ov+W
         fljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ymigIyeCreAluNeWUlY5Ki+RGq0ncVwTcmrXy27WsaM=;
        b=FnCTlzOgDA/H3Pt46n0m/3yOt2oN13ZPuI+w3+3L17tUtgSnI1U6ddFAoa7UhGYX/0
         MYwDB8ZFKgYTeKMsaalpzhDKIyynz+Jb//LHfjdQKudJvbA72pEuEjZOVPev8fFLxoGl
         o2OuwnmLwTEZ1S6havcey2lOPwzVS4VkclyyXZy7zYwxJk6V2NOjkHWbh9eUvt6TiS7P
         BJID0sprYi1lZJhGYX9yDoF11JtewLxjRUaKfVkoufoviqqqOvRTRaPVfpejGXs37i10
         c4dRpCTeMUOOy28MIUTYA1n05JDJvOvdpEFXv6mgK6FPopidmf2c1zukN8QAwgkm1VEA
         kxyA==
X-Gm-Message-State: AFeK/H0eKK8U6IjMp0pdEjIJsL2E9T5yrdmKPDjbXqpZpQgRzJtvh6OgO7mUGDnD7Q3S5Aa8krFaW/CTZy96uBMa
X-Received: by 10.98.48.196 with SMTP id w187mr15036753pfw.179.1490135277169;
 Tue, 21 Mar 2017 15:27:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Tue, 21 Mar 2017 15:27:56 -0700 (PDT)
In-Reply-To: <xmqq7f3invr6.fsf@gitster.mtv.corp.google.com>
References: <xmqq37e7t902.fsf@gitster.mtv.corp.google.com> <20170321185139.8300-1-sbeller@google.com>
 <xmqq7f3invr6.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Mar 2017 15:27:56 -0700
Message-ID: <CAGZ79kbjsm1p+Ag5Q8fii3ncbxSsVLYRwGP=Va=btx8Tfy3aOA@mail.gmail.com>
Subject: Re: [PATCH] builtin/describe: introduce --broken flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 2:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This patch helps to fix the root cause in [1], which tries to work around
>> this situation.
>
> I do not necessarily think it is reasonable to give $version-dirty
> and proceed when a repository corruption is detected; if there is a
> breakage in the repository, "git describe" is correct to die when a
> populated submodule is broken.  IOW, I do not agree that [1] below
> is working with a sensible expectation.

ok, so I won't quote it in the commit message

>
> This is a tangent, but how does the Gerrit repository get corrupted
> in the way described in [1] in the first place?  That might be what
> needs to be corrected, perhaps?

AFAICT, someone is (was?) using a version of Git that doesn't contain
f8eaa0ba98 (submodule--helper, module_clone: always operate
on absolute paths, 2016-03-31). So then the submodule paths were
made absolute paths on creation of the Gerrit repo.

And then someone moved the repo and the absolute paths broke.

Even after an upgrade of Git to its latest and greatest version, the underlying
issue of having broken submodule paths remains in that case.

So there are a couple of ways forward
0) as an immediate fix, manually fix the absolute path or make them relative

1A) have more error resilient tools in Git
1B) have a tool in git (e.g. "git submodule fsck-setup") that rewrites
    the .git file link and the core.worktree setting to be relative and correct.

I think we should do both A and B, I decided to go with A first, specifically
"git-describe" as that was reported to not work well in this situation with the
given broken data

> The wording for the "--dirty" is already awkward, but this one is
> even more so ("Describe the working tree. It means" conveys no
> useful information).  I however cannot come up with something much
> better.  This is the best I could come up with:
>
>         Describe the state of the working tree.  When the working
>         tree matches HEAD, the output is the same as "git describe
>         HEAD" and "-dirty" is appended to it if the working tree has
>         local modification.  When a repository is corrupt and Git
>         cannot determine if there is local modification, instead of
>         dying, append "-broken" instead.

ok, I'll reuse parts of it.

>> +static const char *append, *dirty, *broken;
>
> Perhaps call it "suffix" or something?

done


>> +                     argv_array_pushl(&args, "diff-index", "--quiet", "HEAD", "--", NULL);
..
>  Wouldn't argv_array_pushv() into these two different args
> array from the same template work better?

yes, looks much saner. Thanks
