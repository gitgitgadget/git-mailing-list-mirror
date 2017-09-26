Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122A4202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 00:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966673AbdIZAHB (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:07:01 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:44741 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965296AbdIZAHA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:07:00 -0400
Received: by mail-qt0-f177.google.com with SMTP id o13so8736250qtf.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 17:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1XhXGXC4rX5w3dszUJmm2NhRcdZK3sJuuQnM+wjcvfE=;
        b=njlo5ypBmHu8pdti45Px3qlQkNYPm/HWbb2Y7qpBH6M2H8QvfotMVr9SC3tRaoO0J0
         k2iT850VAYJTQEE/zApzoYmIvaF1HMfy2kCO/YrN4AuKomQcukMgqXTgWc3vb/5rCgFr
         Xb0zCOt19g2Cq61BJTnv+NYjvEwiMP+F+Om6f1YenOJKswVhg/IUF85Br3e1BTzrHgdX
         0e3Id0RrGe6RMfol+4IVoSNcgfrLuA46I6XhKiS6pxVdsC/OhA0HPzCDuyumtHqgV2MP
         mPavGeUhCp/2dM9DKbL4k81mPbmPsY0BdwoMq+KmymtrL1AEwczZVR3iFv4+0KB+i+8d
         8YJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1XhXGXC4rX5w3dszUJmm2NhRcdZK3sJuuQnM+wjcvfE=;
        b=KL30DovZBhtBXIn+4dSJzhbgE4eIvXSL1yrt42ozyeogvc0JrNA+MIZp4gsuf4oPqB
         1+MBsAE15ORxoR5lC10ygilnlg1wOOGNb4dCD7bXSBVqxTf1BJByPhjklp9JSIlp+Plx
         bCWl8uVKBnFTeckUtDM2f4NgliTMWy434X78zKP1AD0l7YdTGB0tIKN3kFE/n/15zKo9
         ilWkzfIKnOO/SIoH0/KtnqfyipuLAnZBI760HMQnpjp8I5EQw0wIpCp54pF3gW89Ypgz
         8URQJGtBC7X1tCkAHqoU/6pZLlIBvPx6Y/eYn4q8a8PY/tpGlyhtoFnicSpkKEwJcoBI
         tfFg==
X-Gm-Message-State: AHPjjUgjpROdQyUxIV9mLBqFsWORdoc//5WTWcW6+8VPVNbBUJMyS+1l
        xdBZg+7fF7E0DN5mnkV6ygt6USMDEkr1OwlXtfJJlg==
X-Google-Smtp-Source: AOwi7QBV4L5BLtejR8Qq/XUdqzguNv+REqRs9jbIhAQY36O/Wk/RbLr7K5tM1XhHjCkABmD+a+sqOT8LSE4n8nPRO+0=
X-Received: by 10.200.27.226 with SMTP id m31mr13872236qtk.198.1506384419600;
 Mon, 25 Sep 2017 17:06:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Mon, 25 Sep 2017 17:06:58 -0700 (PDT)
In-Reply-To: <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net> <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net> <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net> <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com> <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 25 Sep 2017 17:06:58 -0700
Message-ID: <CAGZ79kZwc8bNWJfH_36soy75EpyHAMbJGhQd4rV5f-0RMjiwHQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 5:01 PM, Jeff King <peff@peff.net> wrote:

>
>> If you are okay with the too-long/too-short confusion in EOVERFLOW, then
>> there is EMSGSIZE:
>>
>>       Message too long
>
> I don't really like that one either.
>
> I actually prefer "0" of the all of the options discussed. At least it
> is immediately clear that it is not a syscall error.
>
> -Peff

After reading this discussion from the sideline, maybe

  ENODATA         No message is available on the STREAM head read
queue (POSIX.1)

is not too bad after all. Or

  ESPIPE          Invalid seek (POSIX.1)

Technically we do not seek, but one could imagine we'd seek there
to read?
