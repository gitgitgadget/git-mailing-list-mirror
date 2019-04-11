Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F21BD20248
	for <e@80x24.org>; Thu, 11 Apr 2019 18:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDKSkg (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 14:40:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43117 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfDKSkg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 14:40:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id w3so6101438edu.10
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GxLGTYpQrNv88Vj8o0LftpBGfsb1ty6eAyxn4yXzJYE=;
        b=QXAXF3dycXSio7PUEF/wamRx2Szf7LKDHInda6IWuADYPiXnkDOO5wZmbU6/+8HUaz
         KTkOp5clge7OZagw+xXW1enOZpo4L+w4UP65oF50pE8oPcxJTLTLruYnbKAiOSZptUVt
         ArIF0ysgWal1qu52I2AC21djIRA1KVIOug8CbxwkZzbKnIa3Uj8YQWZu4vk5CsnDAnAZ
         /sLfARBsoFRGb6D+/CSsRxJmFK56FR47scruyUTvl5uOT8w7jeHCCqRqHIccwvD0DD2O
         e1tUZlfkPuIS3fo7DlzV8AFfxVAnEfCCCdEvZu9KoAN4MnWdKlCCYivq61qG/6ZDLoQV
         rQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GxLGTYpQrNv88Vj8o0LftpBGfsb1ty6eAyxn4yXzJYE=;
        b=DN4Qre/iyVeNVmnfwUX22LiPZddSxs81ibzPBfIVW/Ulc9OVdbwFsahzyNFGB45Ovk
         42fFC3PhPvOp58oUFTzwvYxXYWYq1jBYE8ixJ6bsPWQd1AJAP8aMWTzGaVmpCP0CYgzR
         vdKGL6mlzm/XBbGyREELnvHZCcwzcAgdAKuN+aj0MRrQb16VOfJRGgbHjVL5hRJm49+B
         x8rFMKxbt2dhe+jK5TiBQoKMEVZlRzEXiArgVaJf44v1Bgrf0ugZwZDILWN+fJfFaPYs
         8uc3vcVU5c0RTMnFZH5RtY0M4zyD4JZbUAJSgc7WfMkaSboNRyjB3BduCqojUmN+kauB
         VT4w==
X-Gm-Message-State: APjAAAV9NyNvw8t6ohJcc1D0t3yZnsnTOfaJd3E42RegZXzm02U4WFor
        n6tswGqRJRXVxdl05xEA64w=
X-Google-Smtp-Source: APXvYqz6/jBjruEMvtu5q/9naMuFEsgnEpkr36FgHkIHOvfV05dYZxJGGOuR12Dc9Ss+bOSBNxBH/A==
X-Received: by 2002:a50:a604:: with SMTP id d4mr26682927edc.26.1555008034406;
        Thu, 11 Apr 2019 11:40:34 -0700 (PDT)
Received: from esm (ipbcc038b1.dynamic.kabel-deutschland.de. [188.192.56.177])
        by smtp.gmail.com with ESMTPSA id g14sm3106202edv.90.2019.04.11.11.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:40:33 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Thu, 11 Apr 2019 20:40:31 +0200
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
Message-ID: <20190411184031.GA20265@esm>
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
 <20190402230345.GA5004@dev-l>
 <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
 <20190403213318.GA14137@dev-l>
 <20190404020226.GG4409@sigill.intra.peff.net>
 <xmqqftqyf76a.fsf@gitster-ct.c.googlers.com>
 <20190404122722.GA23024@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404122722.GA23024@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 08:27:22AM -0400, Jeff King wrote:
> IMHO the difference between those cases is that it is very easy to type
> something natural to get a tag of tag, like:
> 
>   git tag -m foo mytag
>   # oops, try again
>   git tag -m bar -f mytag mytag

Could it be that the semantics of `-f` are unintuitive and the real
culprit? The documentation talks about replacing the tag, which at least
naively to me has the sense of "well, the old tag object gets garbage
collected sometimes". But if the tag is still referenced, the old tag
hangs around. And this gets quite confusing. For example:

git tag -m 'Message' -a myTag
git tag -m 'Message' -a myOtherTag myTag
git tag -m 'Message' -f -a myTag otherBranch

Now a `git show myOtherTag` gives me the old myTag - and labels it as
myTag. Copy and pasting this directs me to somewhere completely else,
though. Wouldn't it be the more sane approach here to fail, when the old
tag is (or as in your example will) still be referenced? Or make some
effort with git show that it is clear that the referenced tag can no
longer be referenced with its original name?

Greetings,
Eckhard
