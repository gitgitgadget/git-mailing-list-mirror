Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0141A1F5FB
	for <e@80x24.org>; Sat, 25 Feb 2017 05:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdBYFj3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 00:39:29 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:32990 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdBYFj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 00:39:28 -0500
Received: by mail-ua0-f175.google.com with SMTP id h65so24100388uah.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 21:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=G1qmlbuma/MMeLrDq8ikMXcqp1mPVBeptOw+PpNx6bg=;
        b=fzZV33qjEpPDHH2mUdyngQ+mhj8zh2r62IIuO1rgFZWr/MA98u19Jtr506sSryYIwD
         RcFvkLN83Rf5QNRQjSMaMp7ivDfgy2G+6WTYgTdf8GOLdci6z/gULSsQvDKHdZcHAjFw
         m7kZ9+ZLKVzLJxiuHr3iidsePpbFwl7uftI/HqwpuB7xNBKwbLhqYbiP+UN9waKVm/tj
         GHAtZ2nElx1Cs2vBxSHJP3uvxz8niHwu8Qio9Cbwh3jFGQC+5wwrMOZiX8ylWKwFRx95
         tOZoumvWNpJ2VJPalIr5qG9bf+rwqaQDWcZwjBskWd0IYIKK+lmfNFdBEEMjer8Xjbdk
         irCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=G1qmlbuma/MMeLrDq8ikMXcqp1mPVBeptOw+PpNx6bg=;
        b=jNdX9Gk8/Mystac/LtL2FTZFVxlL1kxP30Fe1LjQB9BJdCFTZBvouc9Dps2k3g+6pA
         1JJz1jbrfx1ZoMoyio3AFxlqbEtaGsYRQbbALxsbi1dsaEE/7lBnZoQYFap1q9AfvbVO
         vwBsqdyd6tD40pktHQfSqmonBTjj+TkHwUv5fOhAO1IcO3R8xS7wkxNoSugtrxeQ5QD2
         Yas2ZkGHSzHu10StHJ1F1lUWUjASNIMamtbrz4kmsw+j9H+7s9z6V+m161KWgojjmU0N
         2hj2W+ytskAlKcbtNOnITb7pXZ4SXe2PtoQbaDzATRcGt2BpGrgd0LqwtDL6lKKf6JAb
         E7jA==
X-Gm-Message-State: AMke39nksa+PM0w2GlQ01SNHgsIhOEX60EddyspWABomO5odmgcCA+UlCeKFjBQFlgtj55qBVZgUxEiKGS+UQA==
X-Received: by 10.159.40.101 with SMTP id c92mr2550946uac.111.1488001154282;
 Fri, 24 Feb 2017 21:39:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.48.143 with HTTP; Fri, 24 Feb 2017 21:39:13 -0800 (PST)
In-Reply-To: <CA+P7+xqyaWHBxug0BPdCgDVJBLtsvUxbgfgy1uJcoGf3q6xMQg@mail.gmail.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <nycvar.QRO.7.75.62.1702241656010.6590@qynat-yncgbc> <20170225012100.ivfdlwspsqd7bkhf@sigill.intra.peff.net>
 <CA+P7+xqyaWHBxug0BPdCgDVJBLtsvUxbgfgy1uJcoGf3q6xMQg@mail.gmail.com>
From:   grarpamp <grarpamp@gmail.com>
Date:   Sat, 25 Feb 2017 00:39:13 -0500
Message-ID: <CAD2Ti29v9h5d9mqeQMd5YTi4fDmbAJ8LMT2oX_SagDkC-LBrMQ@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Repos should address keeping / 'fixing' broken sha-1 as needed.
They also really need to create new native modes so users can
initialize and use repos with (sha-3 / sha-256 / whatever) going forward.
Backward compatibility with sha-1 or 'fixed sha-1' will be fine. Clients
can 'taste' and 'test' repos for which hash mode to use, or add it to
their configs. Make things flexible, modular, configurable, updateable.
What little point is there in 'fixing / caveating' their use of broken sha-1,
without also doing strong (sha-3 / optionals) in the first place, defaulting
new init's to whichever strong hash looks good, and letting natural
migration to that happen on its own through the default process.
Introducing new hash modes also gives good oppurtunity to incorporate
other generally 'incompatabile with the old' changes to benefit the future.
One might argue against mixed mode, after all, export and import,
as with any other repo migration, is generally possible.  And mixed
mode tends to prolong the actual endeavour to move to something
better in the init itself. Native and new makes you update to follow.
A lot of question / wrong ramble here, but the point should be
consistant... move, natively, even if only for sake of death of old
broken hashes. And attacks only get worse. Thought food is all.
