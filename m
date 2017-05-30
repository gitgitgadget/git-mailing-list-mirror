Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 061B52027C
	for <e@80x24.org>; Tue, 30 May 2017 13:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbdE3NX5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 09:23:57 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35139 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdE3NX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 09:23:57 -0400
Received: by mail-pf0-f173.google.com with SMTP id n23so72399512pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Cfv64sywzGEEOZc9Vw+LVQ8d1fnCGPybzix390a/lYM=;
        b=e3zgwhrKaXGDwgi6K5IQoSd/gZjj4+ICCfus1ugCH5J05F+CeA34Nucb9lK9E3aU9j
         nVYsmuy5BkllKrCkmDRwHjvEbSR/OZkxXdt9c3BC7n0Adc+OoS/lUjvYNJGBs3/1UG4L
         3SkQ3YTNxFfMgHBrylldPaqFISNBnfB4WmEmuRoPheAWsUk9aPoevPts15/tUfsUcaYg
         7dwz4kNKlowEtQP8tmO9zakPzhnXz4vR+YKYL300QMg+nfwBrAot7Dcf8zv8ECgOryhn
         CcM2cPUstCPDd25AKgYhXwbazZ9RqSpLBQ2aoqcWmHpB9eJMfJx4MTt/FGiYNjdFagbH
         p6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Cfv64sywzGEEOZc9Vw+LVQ8d1fnCGPybzix390a/lYM=;
        b=Czn/9V1i+QFzkXddeyD13HzsOSMoqaw0+sWnBmjCOy9vYiw7tSIjer2hTBSyyGQZVD
         8ZLXg9yfG03LA2d+LbLH1gtlqGDHeIF8xwM4H6Lmy5kCn2NgrrpVi1sjLDpnYFnHaGid
         Cb/qzLLvaiuJSTDm9W1Lkq958jILx3nMq8eogGtkeJs7rVBApWDCg46en1Xc14CtXT1n
         5F2p7d/+sAnPFCG43M4sVTkeJZTwBfoq97ZGfYHyok3ZAxZMv1HooHypkdGObzvZqf87
         MCgQwRPg/0P54H7rowZewLV8GeS2SHmX0jxzJ+kmxeCitpg5OrK3Q3D04/zq5S3UTve6
         vKIg==
X-Gm-Message-State: AODbwcDhYi58TXtywPd4X524IO/APIBwq4imszP+YmSiCZxqXG3a2VNr
        r+nJjzKUfqiOPofK+3c=
X-Received: by 10.98.141.199 with SMTP id p68mr23834847pfk.55.1496150636380;
        Tue, 30 May 2017 06:23:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id 6sm23249717pfo.132.2017.05.30.06.23.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 06:23:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
        <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
        <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
        <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
        <xmqqshjmc1wm.fsf@gitster.mtv.corp.google.com>
        <20170530061546.tdpuhvq7yk34rvlj@sigill.intra.peff.net>
Date:   Tue, 30 May 2017 22:23:54 +0900
In-Reply-To: <20170530061546.tdpuhvq7yk34rvlj@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 30 May 2017 02:15:46 -0400")
Message-ID: <xmqqo9uabhqt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Nope, I have those patches directly on your e83352ef23, and it passes. I
> wonder if there's something funny between our environments. What does
> the failure look like for you?

Travis seems to be seeing the same failure.  Curiously, the topic by
itself passes for me; iow, pu fails, pu^2 doesn't fail.

    git.git/pu$ ./git rev-list -h
    BUG: environment.c:173: setup_git_env called without repository
    Aborted (core dumped)

Hmph...
