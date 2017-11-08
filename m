Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B9A1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 21:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbdKHVvU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 16:51:20 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:45531 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbdKHVvT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 16:51:19 -0500
Received: by mail-it0-f68.google.com with SMTP id u132so5156791ita.0
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jyAosAtiLeaZwgSPYtBigYBAX7EXzJl+qev8OUSYHxI=;
        b=ZlAwNYaXeQFpzwt48gaycUyJnexRLQ78eHmiE8vJoT1MMsXwYZyycDqniWCEFD4Q7A
         0f3dpDLkCFjS6TRayqhrVXRRbNFTvXKGfpL3Q75A/f1EWKGRqV91IFln3L0NOA6iNTOv
         qcYuQueqYlCkpRT4vcPh0CFHt0NXO99GqJlt+9uqqbTqaSuEk+oqexKQbMo3O+3g3Ef3
         1MnuyexVhi0++d273ZjcRO+Yios+XRHdQO21lRttOUBRcj58zvdhpa+WLvKmGE9Wya30
         R22k7OeNiZ1HK8w6HikfHNaaAWkkM9L80RZR/6tLqb7K+owp/LB7GQ95uWKXRNKJc1ex
         5s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyAosAtiLeaZwgSPYtBigYBAX7EXzJl+qev8OUSYHxI=;
        b=cSNNgjoEt0BVTfDW5cFUjn47advrpqHK84ubY2i/bk7HFAkww4P7tmC1Pmg1KOL4dk
         YzZaQZ8vRtMpvE2isdKcVMD+YQGQ3EVFuY6sm55ancXDMbnAdVGVQ+55wxxhBsKYxdLd
         mRVgFLZx/112PCCWo+sU4rLrdry0qL5gau3BEy4dC+dFi87xZCsTWEWID/ne0XON27Vq
         JFkqL9AnFlwljYpRtcWAnL7vcsI+9X/cqMJ3TQRbLn0s8Zne9cKjqbWQI2oh0TprBtpz
         ruoji9uoVZmqCKuSqgHBgEYQr9OOrT2HN+mX/2PP5R1kvNjdZ7PuDjSsmmMpGsEYSbHk
         eyXg==
X-Gm-Message-State: AJaThX6xvwTxWs029mQDdyDgd6FBiO+y19rtFiePB66yCfHyXBpjm7D5
        Z0/eujNX9dwzVCAFtlwVZ/fLqxvmoX8=
X-Google-Smtp-Source: ABhQp+RFenAv85lL9dwNFmrCydIwHFQt5/zPWZacuX13GWkgWmIUzPHM7SaCbw1bFzctacAmmR5h8Q==
X-Received: by 10.36.60.86 with SMTP id m83mr2627053ita.25.1510177878777;
        Wed, 08 Nov 2017 13:51:18 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:8df4:1665:e9bb:1ae7])
        by smtp.gmail.com with ESMTPSA id w139sm2723996itb.5.2017.11.08.13.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 13:51:17 -0800 (PST)
Date:   Wed, 8 Nov 2017 13:51:16 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/9] extension.partialclone: introduce partial clone
 extension
Message-Id: <20171108135116.f96c58500caa302583bb2810@google.com>
In-Reply-To: <515130bd-6fd8-2c53-e935-e811330f8512@jeffhostetler.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
        <20171102202052.58762-2-git@jeffhostetler.com>
        <20171102152427.32544b3d6149e7a7bfe840c8@google.com>
        <1db01a45-85c4-6243-c43f-9f5e50e9a6a8@jeffhostetler.com>
        <20171103113919.396807c82dbfdecff7f19c41@google.com>
        <99b7c61b-f8ab-43a0-0707-62ac1db4d080@jeffhostetler.com>
        <20171106111642.696a006e802cf0259098b44f@google.com>
        <515130bd-6fd8-2c53-e935-e811330f8512@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 8 Nov 2017 15:32:21 -0500
Jeff Hostetler <git@jeffhostetler.com> wrote:

> Thanks Jonathan.
> 
> I moved my version of part 2 on top of yesterday's part 1.
> There are a few changes between my version and yours. Could
> you take a quick look at them and see if they make sense?
> (I'll spare the mailing list another patch series until after
> I attend to the feed back on part 1.)
> 
> https://github.com/jeffhostetler/git/commits/core/pc3_p2

Thanks - the differences are quite minor, and they generally make sense.
The main one is that finish_object() in builtin/rev-list.c now returns
int instead of void, but that makes sense.

Other than that:

 - I think you accidentally squashed the rev-list commit into
   "sha1_file: support lazily fetching missing objects".
 - The documentation for --exclude-promisor-objects in
   git-pack-objects.txt should be "Omit objects that are known to be in
   the promisor remote". (This option has the purpose of operating only
   on locally created objects, so that when we repack, we still maintain
   a distinction between locally created objects [without .promisor] and
   objects from the promisor remote [with .promisor].)
 - The transport options in gitremote-helpers.txt could have the same
   documentation as in transport.h.
