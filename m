Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3D41F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKKVpR (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:45:17 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47683 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbfKKVpR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Nov 2019 16:45:17 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0B7445DE;
        Mon, 11 Nov 2019 16:45:15 -0500 (EST)
Received: from imap8 ([10.202.2.58])
  by compute1.internal (MEProxy); Mon, 11 Nov 2019 16:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lastninja.net;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=9gzasyQMaUw3UwvJjQveYK9QrSt0
        TLGHCp0whfAfgqM=; b=prD5U1ndypUVQhCNFpB7q6iEQjUdc65tzlVD0YjfBzaF
        52G5E2kHSZCyb6LpsRJvDxWZi4KjhwN4BeyP0gNpTKjrdImgIzoS3RIDSnPbBIGO
        muUriMgctpcvHT5ErLN0Gu2OOm5v9JDO/ZR6hXkQJmH1KZpSRM7MjiQZi0bvmusd
        rk4rHN24eGEM7VmUn0x7VEZ7jevGErIcBsBN3gIMuWnhOX0/kvF2wBOVPIRnBxf1
        J61PE8+BvbEjS47sjMj/RGiQJ+VbFJ16UMfU4PUseE/aT0UQfaPJ+DUIN6I9vX2+
        RQ4gXkmeKr/hmZVZk3fDuulH4luIZJYmHtGAU4HiCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9gzasy
        QMaUw3UwvJjQveYK9QrSt0TLGHCp0whfAfgqM=; b=Ffxu8jkY5E6sWdDF1rzyOM
        4OewfnAR1GIpsMw1Ckq/36UcKNNdb+5jri1QO5d+S1o0O/k4zTgQVQDqqr74RHd+
        78f+D0xa80H3wLbhibeG+LeuSCm/fD3eifYEq6qMaxUqaaOywMu5JIxJj00D5CAC
        7Bl0eEk1yLkHZRG+2mIzvNR38dHUJZdiP9GBoTJAJ65+4YOWtWIJDKQDnFFqtYJn
        P1DxA6l1sCBDmdlfJEoHCliHZd6egRbkT3rSwF+vKBIlKpDWBa8FYZLf+8OqG+T5
        3Dou/54r+Nk2+8yb9c7z2Dwrxt0mGEBLe6ab+Tm8/RwN2WlQC9/owSkcJG6rAbdA
        ==
X-ME-Sender: <xms:a9bJXchT-UkPMWZFN5m4rkB7UpxxzAXIXuj5WQo71aHSWe82rpVGtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddvjedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesth
    dtredtreertdenucfhrhhomhepfdfprghvvggvnhcupfgrthhhrghnfdcuoehnrghvvggv
    nheslhgrshhtnhhinhhjrgdrnhgvtheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnrg
    hvvggvnheslhgrshhtnhhinhhjrgdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:a9bJXcAc_Y8ZlPQ0P6c9PVJYRXNUnVoVPE7NSBwh888O-lkeUU2gLg>
    <xmx:a9bJXZHLgyUhONw2ZnYvkIQa2UCadCixu9cmVspEIN8n5Tu879qjgw>
    <xmx:a9bJXcIAzqLgg3He_0q2YxyPexq7IY1fA0AP3lkb9bdECL7jQ2y-7Q>
    <xmx:a9bJXQBbHxRVzJ89npNu15DinMB3HecDRZg6al8JiGkWQP_a3gYzOg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5FE76520093; Mon, 11 Nov 2019 16:45:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-509-ge3ec61c-fmstable-20191030v1
Mime-Version: 1.0
Message-Id: <556b38ff-a118-43b3-8024-cf6dd97253ff@www.fastmail.com>
In-Reply-To: <xmqqr22ehjbg.fsf@gitster-ct.c.googlers.com>
References: <20191110095942.GB6071@a.local>
 <xmqqr22ehjbg.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 12 Nov 2019 08:44:54 +1100
From:   "Naveen Nathan" <naveen@lastninja.net>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: improve readability of --rebase-merges in git-rebase
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think the original "to the deprecated `--preserve-merges`" is
> mildly easier to follow than "to `--preserve-merges` (deprecated)".
> 
> The later part of the sentence with this patch does read smoother
> and is a definite improvement.

Thanks Junio.

I've incorporated the suggestion and will submit a new patch shortly.

- Naveen
