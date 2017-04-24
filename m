Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2794207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 23:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979330AbdDXXnb (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 19:43:31 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35080 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979226AbdDXXn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 19:43:29 -0400
Received: by mail-pf0-f178.google.com with SMTP id v14so14976518pfd.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WWSTHkKYzkIoZxzi9Y7lPLNRkWdDF7G1FY+UJpqOB7Y=;
        b=lShIqsbVVT5TNZMD+INtomjetkRcwuFo4cScS4GCF4GS6N6tSbdmAT3Km59iBC8qoi
         /viNglMEkXh7Tjg+4yskeq+HIGXjIcV1UHF7fC6L4NpTqsYDeLnt1tPHJblaBCm82Bz3
         IpDhwE0C0m53jcZVcHdA7MEOO72iBmUF4DXuz5fvtdMAwaw1g864VkWvvc2iXSURQxVl
         RnfDa6b7YMeMkWBZO2hZMFnGc3PJoURGxeLB56kzBpjhYSK6mfcqykYlnLbMMerGMHM+
         0u768/Y46siZg3tkJL3jleBQn02Yjg1FshKTz90OzjGPUp4Yt5SA4wrDULBgyCFCrP4S
         udFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WWSTHkKYzkIoZxzi9Y7lPLNRkWdDF7G1FY+UJpqOB7Y=;
        b=a3eK3sdk8j2wFPCg3Z40hYO4SIm/s/PJxdM1Cd/1zkoSZCH9C1+gNJXU/3SNpeiNeF
         XEjXXYETGTZmsELYV7ZV7BmC46S5s2uogn9mROIUz07rf+JsEfguOYrlB5wiwSvmIS6l
         zb+J4f/UwAAzh0lMGYRLP03DusZpTzYavXCgJ0oEbhzdZveD/igzGV3XCRdaAeWuSGW1
         Ff40ldpNp9jo9sX1IrNJiaNl8GeIYpYQAclBAo3XEtBQ6ANKLR+p+WfQnskskPvTkR5f
         VVFmagBtFrgGqPVuHfY4PD/vcO/KZPpnjOc1U3hm86Gg+eV62rubFsVCRJ2Kt3UrK4EB
         bRZQ==
X-Gm-Message-State: AN3rC/7kVY43LmpWURAeTSNsEQD/nkcF3CgAHQBKAC/aUKxfVRvSWzEl
        JYy/2zRjiG+8ib9q94fNptN58suZ7/3p
X-Received: by 10.84.222.134 with SMTP id x6mr35520834pls.52.1493077409215;
 Mon, 24 Apr 2017 16:43:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 24 Apr 2017 16:43:28 -0700 (PDT)
In-Reply-To: <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley>
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
 <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com> <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Apr 2017 16:43:28 -0700
Message-ID: <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com>
Subject: Re: Submodule/contents conflict
To:     Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Cc:     Orgad Shaneh <orgads@gmail.com>,
        Dakota Hawkins <dakotahawkins@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 4:33 PM, Philip Oakley <philipoakley@iee.org> wrote:

> This is almost the same as just reported by 'vvs' [1]
> https://public-inbox.org/git/CAM1zWBtfgHT=pT0pidQo1HD=DfrXLG3gNaUvs0vZKvYfG1BHFw@mail.gmail.com/,
> originally on the 'git user' list
> https://groups.google.com/forum/?hl=en#!topic/git-users/9ziZ6yq-BfU

For this issue, +cc Jeff King due to this pointer:

>> On the main list thare is a similar "issue" [1] regarding the expectation for `git checkout`,
>> and importantly (for me) these collected views regarding the "Git Data Protection and
>> Management Principles" is not within the Git documentation.
>
> Yes, that's an interesting point. What concerns me is that the commit
> c5326bd62b7e168ba1339dacb7ee812d0fe98c7c which introduced this
> into checkout isn't consistent with reset. Seems that nobody noticed this before.

It seems as if we'd want to see the code from
c5326bd62b7e168ba1339dacb7ee812d0fe98c7c
to be part of any worktree touching command, specifically reset?

> It also has a similarity to
> https://public-inbox.org/git/1492287435.14812.2.camel@gmail.com/  regarding
> how checkout operates.

This seems to be orthogonal to the original topic (no submodules, nor checkout
bugs, just a doc update?)


> It does feel as if there are two slightly different optimisations that could
> be used when the desired file pre-exists in the worktree, but isn't
> immediately known to the index.
>
