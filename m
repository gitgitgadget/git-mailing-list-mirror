Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0481FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 23:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbcIBXsk (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 19:48:40 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:36663 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbcIBXsj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 19:48:39 -0400
Received: by mail-it0-f42.google.com with SMTP id i184so65146855itf.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 16:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y8XqrX0u8sSn+gYF2MVuts418qxTUzXxl4IR4R66nBs=;
        b=hTsAxCgzz1id/PG2Xbc7Bd6Mm6chWPtBP/nmhJ3hLXqk2wita213JpE5F8tuL/AOR4
         sz8XPMVZ2CcNZLnSoVohHagXbPnENR+T7DsgiYKbIYMarUwomDwgn8swfZiKkP56RFpM
         etQ5PZSksnl4AHupR07RzNrWAt9JJ6Z49/7+TQAZ/gleBt5X17QV9a1V5uJvlbpNcoLb
         hy1VquTvTdsjsvd6YV8p53l8s3IowXucPyIXH0P69wbPtIci04ACPs37ZhA1ur43dU8p
         hJaVAHAMkte4QdWVcqjUDpDEli6Wppr7nXfmYCiiL9SurzXLa87suAy1v/eBgbAXAXeQ
         2Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y8XqrX0u8sSn+gYF2MVuts418qxTUzXxl4IR4R66nBs=;
        b=D1ZPLRF6aonIRUyXDatdgtLbPdbLEgch8Is4SPg9KV8JJv8Bi27V2b75xEF7rfHDwl
         ArKID5hM/Q4as+1eSok0BxdBgubRGpJsottZHR96oai64PkMTiJw3P5vZnnBSiYkEQre
         QnQ44Qj7erPueMwJdWSKz8oyXiKfpkSZOhxyRRBBSXN+rfjsHSWqnzcPONqhCvgtm/u9
         JwMu6WQmhgxFX08yoAyM1q4GvNjjoCyRWgML6Dclei/4BfAVa6s3X+sywsmApxbxKGQd
         FT5iNYjRT6jNh0KX33UIZ7n869b7vctKxnXWIMrN2pxjAxw814xLS8UgtGCkTcog7Fdb
         O6HQ==
X-Gm-Message-State: AE9vXwMcQ5LHUS73ASs6gkrJNhqxC+VNs4YCWFyrQNKTiGfrFN5MBTvrY9VFLS3g5Upg3/X+Js63Y6YoblLdb/5f
X-Received: by 10.107.134.87 with SMTP id i84mr2029365iod.165.1472860118188;
 Fri, 02 Sep 2016 16:48:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 2 Sep 2016 16:48:37 -0700 (PDT)
In-Reply-To: <20160902233547.mzgluioc7hhabalw@sigill.intra.peff.net>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1472853827.git.jonathantanmy@google.com> <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
 <20160902233547.mzgluioc7hhabalw@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Sep 2016 16:48:37 -0700
Message-ID: <CAGZ79ka0VvXbkR+JYJwK9oyRzcsDXDoqKXyp4F+moDc4qDuv7w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] connect: advertized capability is not a ref
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Shawn Pearce <spearce@spearce.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2016 at 4:35 PM, Jeff King <peff@peff.net> wrote:
> I'd be more interested in the pain of this transition if there was a
> concrete use case for "hide literally all refs, but still allow
> fetches". Is that a thing that people do?
>

Not yet, I would think.

Not to derail the discussion to much, but let's talk about protocol v2
for a second:

    One of the ideas we floated around for protocol v2 would be exactly
    that: the server advertises only a small portion (could be just master
    or no branch eventually) with a capability "v2" and then the client
    selects that capability and after that there comes protocol 2.

    The advantage of this approach would be have a functional
    v1 server still running, but the meat is found only in v2: e.g. via
    v2 you can obtain all pull requests/changes or even wiki/meta
    information stuff that would be too large to advertise in v1.
