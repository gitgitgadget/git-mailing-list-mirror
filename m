Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21AF20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 19:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754489AbdASTQy (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 14:16:54 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36557 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754415AbdASTQy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 14:16:54 -0500
Received: by mail-ot0-f195.google.com with SMTP id 36so5274652otx.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 11:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TEb3LpR4sG4gJLCNvdcygprQqgquqhMsct7aKtQggs0=;
        b=Kw+7srdoMUet49loU0H0Y5XFw9GbdcF7/diAV41HhtiAbGiLq1cfsYBWfGv4vL2HxZ
         l7H0CtBpVeXaXsEnkun2wyW/TLn0PJDg2BYObFd2QAGH0nmiwziB3xySDyBd0NLd5iGF
         ioOav+N2kODkEHhO5bIirxLhl+v1Cq+hpQvYFe2lYjxOGdgSPitWsfigEcBbxcVUzlHR
         q3DodJ3RF/29d87Vu20tKQbRld4pCdzRg7Ojj8fiveKX9r2hVmZcu8abksnxbDSohXzh
         StfFE15gmvobZVw6X+3kiT57jtdEtyJoi3QTMU+GU8VnuwOsnIkbgjjfiZJk3ecxDQb6
         a/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TEb3LpR4sG4gJLCNvdcygprQqgquqhMsct7aKtQggs0=;
        b=hPOBPoy/9Sb/Ahfup2sby5hRjzu4FFncukHwXb5hySqp76ID+8ANR8lkui+gXgKxaM
         im0eBchhrnfqwhmTeRKRrE8/YQhjj0bfuooGumTczw4jKwpgAXyR8b343zkWZsdhe/XO
         wtT5wNw1liF0rLQ52uKooUy+lW/g65sRybQd2VPwShIV6THWOpgqHg5D9dxQdPWNtM8h
         kZblpWTLE5BVL324yiy0F5uYI6fuG/+4FWWg33zo4BsC/G7aLGShi5iy3ECjbENBCtxY
         ySzDfJN8fNGqqym8MkLbP3u1qqbgiH4pYXbSs8PGZQ0tJQoamhGVVPlisAWmYqdclpvp
         PEzg==
X-Gm-Message-State: AIkVDXK9XmUYINyO/jAah4LWabb+X9zxmFfW9i7yyztoQoPt7FPjIrNRtQuTXf/RiYkNvRTRhJtTcaeXC6ahBQ==
X-Received: by 10.157.45.194 with SMTP id g60mr4782226otb.87.1484853408235;
 Thu, 19 Jan 2017 11:16:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Thu, 19 Jan 2017 11:16:47 -0800 (PST)
In-Reply-To: <991ef396-3fc3-27d6-283c-b8dffa10a7b7@synopsys.com>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
 <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com> <CA+55aFxAe8bH2xXkx1p5gYN+nc-D-vjNnfUeA_64Q3ttpbHq+w@mail.gmail.com>
 <991ef396-3fc3-27d6-283c-b8dffa10a7b7@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Jan 2017 11:16:47 -0800
X-Google-Sender-Auth: 7hf_8uoHpOm-yvosdua_89HV4tw
Message-ID: <CA+55aFzGaxhRRHXUcfnUDcgyaAKy4jXLcKMXH8T61x8sxEJT+g@mail.gmail.com>
Subject: Re: Git: new feature suggestion
To:     Joao Pinto <Joao.Pinto@synopsys.com>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git Mailing List <git@vger.kernel.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 10:54 AM, Joao Pinto <Joao.Pinto@synopsys.com> wrote:
>
> I am currently facing some challenges in one of Linux subsystems where a rename
> of a set of folders and files would be the perfect scenario for future
> development, but the suggestion is not accepted, not because it's not correct,
> but because it makes the maintainer life harder in backporting bug fixes and new
> features to older kernel versions and because it is not easy to follow the
> renamed file/folder history from the kernel.org history logs.

Honestly, that's less of a git issue, and more of a "patch will not
apply across versions" issue.

No amount of rename detection will ever fix that, simply because the
rename hadn't even _happened_ in the old versions that things get
backported to.

("git cherry-pick" can do a merge resolution and thus do "backwards"
renaming too, so tooling can definitely help, but it still ends up
meaning that even trivial patches are no longer the _same_ trivial
patch across versions).

So renaming things increases maintainer workloads in those situations
regardless of any tooling issues.

(You may also be referring to the mellanox mess, where this issue is
very much exacerbated by having different groups working on the same
thing, and maintainers having very much a "I will not take _anything_
from any of the groups that makes my life more complicated" model,
because those groups fucked up so much in the past).

In other words, quite often issues are about workflows rather than
tools. The networking layer probably has more of this, because David
actually does the backports himself, so he _really_ doesn't want to
complicate things.

               Linus
