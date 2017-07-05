Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68FF1202B1
	for <e@80x24.org>; Wed,  5 Jul 2017 20:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbdGEUwB (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 16:52:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34321 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdGEUwA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 16:52:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so74739pge.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hSwvYkijCeFUj1A3fFn+79RDka0WGrKwMwZ6F11VyaE=;
        b=PnpHSEYhifQtPesPH6QkCP+l1jq3Fx8kgAhRJFygbH1CnoPVExCey0i3zXUBJmuC/L
         yVmvYAByXElfjvfNRAo9qMobkwnkJeQQiuawHcqqurB+LMOFVMOwKB2j+fRYI99NVJC4
         Evv1mDRYPXAj/puRoGoJSxZgFa0rHCN/0cvwiaqrq95rgSg7mHM9YmFsybqt9umzfUW6
         De/fQsaJB37sWr/+JHLAzNibbbvTkyDzsHo8ve7Z7Kq1Wmt5GWt2VkogruX3AVNu8jps
         Yatodw6AFksKcn7WznRpi4Oy8xuh5c+51ODawxJ1spFvBbqYgUTjv22RI873VL7WjGx9
         MtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hSwvYkijCeFUj1A3fFn+79RDka0WGrKwMwZ6F11VyaE=;
        b=sQzoPE4zdVRGg365XwBpKWa7we9+mFGONR7TBcx7mGBeFtPDgSu6CX2X77fAatTLHk
         dzz1dXWou3fCJD1OvRjLPyWgVEBZkar//jz84ofb98ccHXK1IP9MnLqYloXpxQC/x5P+
         wTKkDmPANrU3eEpSvL41P2BLzZhbFeP5qIfSRhVgLYMOs7gJ8dbaspDRQOf7aNgKYHzA
         ZYuCuCp/fcVYgjakLOnqy2xiuJijKvMKbAo106Fh4wSnJoCoQ/Pihn2IRWVXbMjWNbia
         Ak6fIbtYMZI6O1Fq86EbK/QklDs2EcCTyuH7mznCAiImiM3XkzDt6aO5ZGCFIECCtzWm
         UnXw==
X-Gm-Message-State: AIVw113pf8X9dKu8nAsus9ov2Rz/ozZbJB87mmwC35f/9uY5wy6L2Ylz
        HBbj6xTQuCja7w==
X-Received: by 10.99.115.85 with SMTP id d21mr22547065pgn.8.1499287919605;
        Wed, 05 Jul 2017 13:51:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id v17sm74635pgn.4.2017.07.05.13.51.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 13:51:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/10] Friday night special: hash map cleanup
References: <20170701002838.22785-1-sbeller@google.com>
Date:   Wed, 05 Jul 2017 13:51:56 -0700
In-Reply-To: <20170701002838.22785-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 30 Jun 2017 17:28:28 -0700")
Message-ID: <xmqqmv8ihaj7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This goes on top of sb/hashmap-customize-comparison.
> No functional impact but a pure cleanup series:
> No casts to hashmap_cmp_fn in the whole code base any more.
>
> This revealed another interesting thing, which is not a bug per se:
> The const correctness of hashmap_cmp_fn as it requires all its void
> pointers to be const!
>
> We violate this in patch-ids.c as we modify the `fndata` at some
> uncritical part (a part that doesn't change the equal-functionality
> AFAICT).

I am undecided, but perhaps we should loosen that, if some real-world
user has a legitimate need to take a mutable fndata?

I dunno.  The patches look good to me.

Thanks.
