Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 482701FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 19:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbdFSTaa (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 15:30:30 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33654 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbdFSTa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 15:30:29 -0400
Received: by mail-pg0-f53.google.com with SMTP id f185so52371699pgc.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+kDevUSPuCgqLfdmncoVzxq4Jc4xa2cKzALYcPLEG6s=;
        b=dfN1hHm1OSeBYwp/39vHuqTBob/uZ4WJ2331eV2CpRLdcs1Xk/DUuFv1syMfVR+WSQ
         ZRslRLtgVcA33nFr8dqvNWizcjUvz3G3nk2XpUkS3VqvbH8iooQVFAw5BlJthOus4or3
         7mc+VH4buNfs33+39HhFjPWWSy52QR5zWMyzV1s5Ikci1q1m3KD6yozBQjUL2PatUJ1r
         4HVo6lyaT2nSw54HCmh1Dba4VkOOY9bsSDf/zEVC1087piZaphHHBs8IzdAXce6TYMJj
         a6RySNtXzzne4CBzvD8L5mGRHgOAjq4TiVdlxeeMC5GhV82EuJn/TJWa3hd75IeXUX1M
         NqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+kDevUSPuCgqLfdmncoVzxq4Jc4xa2cKzALYcPLEG6s=;
        b=eaBKcKck8ET14vLjbh8uLqMigzt7oa6LZu+1nZubTEHpofZS353pZMcjuX6KElmCy+
         yyIcng1kb1BWer8vzZt5PdZT9LMQBtgCA3G/9LNySy03K165+khVr7sQHXpmFimb1IrO
         EYcUXEzXmy3S7wfD6mlT0RZa0ygCl2tCrLiOhqcxUjOHWFA6ghjLHg9olB769ms6x9B3
         PCiVNA25LKsUngvqiBsR1otisDx2/f2S/sEWsUusJ24hH9uQC5oCtaCkYp4NuFwcwZz1
         z7DpJIgSGaoG8nxhqihnp6oOV+jjdccSNA13689pnBMyYXH6vzH9q6Ra+h/rNB2aNO0p
         oG4w==
X-Gm-Message-State: AKS2vOx8vTSPMuQYvhIw4yj0Ma/prar/llSNTKRXbi7WrX+OvS4/rK0x
        rtn6adrqYDPNFH4Euy+3DQx7h3HFLM/U
X-Received: by 10.98.69.76 with SMTP id s73mr22134352pfa.94.1497900628655;
 Mon, 19 Jun 2017 12:30:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 12:30:28 -0700 (PDT)
In-Reply-To: <20170619155924.7ra2vwvaelr2yj2v@hopa.kiewit.dartmouth.edu>
References: <20170619155924.7ra2vwvaelr2yj2v@hopa.kiewit.dartmouth.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 12:30:28 -0700
Message-ID: <CAGZ79kZhj31eBYnboyxDLuFp1ceeqk8kj0nrnQaCmpRJCVFU4w@mail.gmail.com>
Subject: Re: in case you want a use-case with lots of submodules
To:     Yaroslav Halchenko <yoh@onerussian.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 8:59 AM, Yaroslav Halchenko <yoh@onerussian.com> wrote:
> Hi All,
>
> On a recent trip I've listened to the git minutes podcast episode and
> got excited to hear  Stefan Beller (CCed just in case) describing
> ongoing work on submodules mechanism.  I got excited, since e.g.
> performance improvements would be of great benefit to us too.

If you're mostly interested in performance improvements of the status
quo (i.e. "make git-submodule fast"), then the work of Prathamesh
Chavan (cc'd) might be more interesting to you than what I do.
He is porting git-submodule (which is mostly a shell script nowadays)
to C, such that we can save a lot of process invocations and can do
processing within one process.

> In our project, http://datalad.org, git submodules is the basic
> mechanism to bring multiple "datasets" (mix of git and git-annex'ed
> repositories)  under the same roof so we could non-ambiguously
> version them all at any level.

Cool, glad to here submodules being useful. :)

> http://datasets.datalad.org ATM provides quite a sizeable (ATM 370
> repositories, up to 4 levels deep) hierarchy of git/git-annex
> repositories all tied together via git submodules mechanism.  And as the
> collection grows, interactions with it become slower, so additional
> options (such as --ignore-submodules=dirty  to status) become our
> friends.

I am not as much concerned about the 370 number than about the
4 layers of nesting. In my experience the nested submodule case
is a little bit error prone and the bug reports are not as frequent as
there are not as many users of nesting, yet(?)

In a neighboring thread on the mailing list we have a discussion
on the usefulness of being on branches than in detached HEAD
in the submodules.
https://public-inbox.org/git/0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de/

This would not break non-ambiguously, rather it would add
ease of use.

> So I thought to share this as a use-case happen you need more
> motivation or just a real-case test-bed for your work.  And thank
> you again for making Git even Greater.

Thanks for the motivation. :)

> P.S. Please CCme in your replies (if any), I am not on the list
>
> With best regards,

Cheers,
Stefan
