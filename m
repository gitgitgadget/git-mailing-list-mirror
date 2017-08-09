Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348A8208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 23:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbdHIXjo (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 19:39:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37002 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbdHIXjn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 19:39:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id t138so1128669wmt.4
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 16:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=07zJlZVOgIFTozePipSHfThbBbwlDkjmeev/Gy+PDCU=;
        b=DCne3f6w+LTOn5MbMfckJgWi41JqRjBzKGzNarrHsprn530MsVDGY6MU0cRHdgHVJ1
         MpJ/cgcXb1bq5smHQ2m2FD5RCJe+rdc7SmfqLX0rDnd6DBScJ5AUjdcKNPOS0UfAoNQJ
         cttfLVamyc8EPqd/OP0uToDRhwX8xj7cBg1ob47iQXVVfoFPx2VFebyQSXmcfun+ZnVD
         e1QVue4Q+pRhgssd5gSBmGqF+VZjlAI3o7J97cNPTVcrjz3txZd7PlrPRbkCBI9ZDW06
         Ude+RvmDEHcpI0iMkC/fOmht/LF2EYOCl/5PU7/RSjmULU8nOmfG5E/IBAPHPhH4BbjR
         4Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=07zJlZVOgIFTozePipSHfThbBbwlDkjmeev/Gy+PDCU=;
        b=kNYFsRSxoEVcelvdOq9dvAjg+PDwNvRtxhhLpeuKmEcS0cODI0S95u+lq9VMIK+S+5
         jXADzuCDunWiDsYKNVV9A3cSG/5m3QUPvYeFvHxg6GYrecC8Y4bEOS4j+//2uoYxWYq4
         6H8J9xytqh7B3mBHj9pBq1O6iaX9lrGZz+LPCiKsDmJ0H/H1MezcIiyvVOyFke6hx3PT
         XHNvgl0fxt9+Ix5uAvZLf99vFD4TK7+lmauH5TaT/jzkkXZm3LLF4fOT21e88ekd+woa
         aA6C2WpEq6lItq3IIDotGYrzTFr37XV9Uholg5dnAZFjybtca3c3Xkywl/hvXb1tWkjx
         A7Bg==
X-Gm-Message-State: AHYfb5jq5ddT3q+ttKuWONsL4ruspG8MarbQQJH57adAJn9eAeXeNuJd
        7D8Wf01/vecvIw==
X-Received: by 10.80.187.13 with SMTP id y13mr9847023ede.122.1502321982137;
        Wed, 09 Aug 2017 16:39:42 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id u10sm2465162eda.93.2017.08.09.16.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2017 16:39:40 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dfaZf-0002Sz-Mb; Thu, 10 Aug 2017 01:39:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] dropping support for older curl
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net> <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
User-agent: Debian GNU/Linux 8.9 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
Date:   Thu, 10 Aug 2017 01:39:39 +0200
Message-ID: <874ltg2tvo.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 09 2017, Johannes Schindelin jotted:

> Hi Peff,
>
> On Wed, 9 Aug 2017, Jeff King wrote:
>
>> This is a resurrection of the thread from April:
>>
>>   https://public-inbox.org/git/20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net/
>
> As before, I would like to point out that people running with older cURL
> are most likely not at liberty to change the system libraries.
>
> I know that I didn't when I was working on a very expensive microscope
> whose only certified control computer ran a very old version of CentOS,
> and I really needed to install Git on it.
>
> In such a case, it is often preferable to be able to build against an old
> cURL -- even if some of the fancier features might be broken, and even if
> some minor compile errors need to be fixed.
>
> I know I was happy to compile Git against an ancient cURL back then.
>
> Just so you understand where I come from when I would like to caution
> against dropping support for older cURL unless it *really* adds an
> *enormous* amount of maintenance burden.
>
> I mean, if we even go out of our way to support the completely outdated
> and obsolete .git/branches/ for what is likely a single user, it may not
> be the worst to keep those couple of #ifdef guards to keep at least
> nominal support for older cURLs?

I too compile against ancient CentOS crap often where I need a newer
library and upgrading the system library is not an option, and the
problem you're describing is easily solved.

You grab the source RPM for e.g. curl, search-replace both the package
name and the installation paths to something else, e.g. name it
avar-curl and install it in /usr/local/avar-curl/{lib,bin,include}, then
make your new git package {Requires,BuildRequires}: avar-curl{,-dev}.

You then get a brand new curl on your system without touching anything
that needed the ancient system-library curl, because your new custom
curl lives under other paths, you then compile the package you actually
wanted against those.

Is it painless? No, of course it would be easier for me if I could just
"yum upgrade" and every package tested all 10 year old versions of their
dependencies, but it's often not realistic that they do that.

It usually takes no more than 10 minutes to give a package this
treatment, since I can usually grab a SRPM that already works for that
OS version, I just need to change the name & installation paths.

At $WORK we have hundreds of RPMs that have been given this treatment
for one reason or another.

Some of those are because upstream has decided to support the stuff
found on our systems. In some cases it's trivial to fix and they're
willing to take a patch, but in other cases it's reasonable of them to
say "just upgrade". I think looking at the diffstat of this series that
this is such a case, especially given Jeff's argument in
20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net
