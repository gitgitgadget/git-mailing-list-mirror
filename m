Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B62D1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 20:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbeGXV5i (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 17:57:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39654 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388690AbeGXV5i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 17:57:38 -0400
Received: by mail-pl0-f66.google.com with SMTP id m1-v6so2272298plt.6
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Msl4c/J5AmwGEi+FJX+gjGzIF8unXQb+jhh5UNdnKgk=;
        b=guMAnHH6ex10562BDNIs4tUw6Y6AONa327WlYdbVeq5Xa6GrweIuhZoMqIqk0lPhlo
         jjP/v7i/99hLLP3Lg1j06ah3CydlpSZrP8r5ernoCXHivJP14Dh84f5qyPGb/l007ZZk
         OaN7zkr9vy5Z4BOe0yc8v2ajCUrObpBgHgnYbAPLgAjjujkaLP99g0hLNpYDZEVtTIVk
         1WiFoyG99ZL4mT5d64sUp9TDIaqutklLkgiBZCWZAScxjcJ6aFdKZeASeR1tfTk9fiV1
         z5EalmnBN3wS6xNLFMh4B9f+ngnzWQT+9caWs4ZOELfy5n1Hojwy69nI6VxQehtU/jfe
         6Nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Msl4c/J5AmwGEi+FJX+gjGzIF8unXQb+jhh5UNdnKgk=;
        b=NyTxdlyTKiTaK9WlsZvpCpbx/nAtackW5MNeu4fqzghvcfIDYlcWpUta9mb6aygunD
         /+LGgUgt3236W8/OvSxOTg+qRw0Jud/wsazPxjFGKVt7QrOja2rHqwtBCRW0GP5U0U4M
         v03BeO3XxvZntP2b/mUokIA5xXvcd/fnfg0ldDMcb5sQKjTdqXoXxa/zZigmuNF7B7By
         YhQQ4vtyOPSlFbhcbC12IDMPZOkNc0gJGWhyzTLkJCOrT5KuFtbJ+SkJQ6Q5XhLzCSst
         AqzAgf82krGHmizoRi4AvRCKhIGc5KLMlwZswr6lLw/pS+gRtQXiEhF0LbRpXSv71Flc
         QC8Q==
X-Gm-Message-State: AOUpUlE51CNQQ2VRou83ovhMMU7hxb7EQh6ZQUTlkruBnxvE/6/vcu2N
        bsFfvHd+VS6lehSYQxZxcCg=
X-Google-Smtp-Source: AAOMgpdJBA8Z71HCAEyuM1I6DZpzLZ9vFCVxoacPirRq7j2wuqPmaqlovOnIFsSx4gLTnk5dkVz41w==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr18294860plb.108.1532465363136;
        Tue, 24 Jul 2018 13:49:23 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y27-v6sm30503120pff.181.2018.07.24.13.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 13:49:22 -0700 (PDT)
Date:   Tue, 24 Jul 2018 13:49:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Subject: Re: Hash algorithm analysis
Message-ID: <20180724204916.GA136514@aiede.svl.corp.google.com>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <20180724190136.GA5@0f3cdde9c159>
 <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Linus Torvalds wrote:
> On Tue, Jul 24, 2018 at 12:01 PM Edward Thomson
> <ethomson@edwardthomson.com> wrote:

>> Switching gears, if I look at this from the perspective of the libgit2
>> project, I would also prefer SHA-256 or SHA3 over blake2b.  To support
>> blake2b, we'd have to include - and support - that code ourselves.  But
>> to support SHA-256, we would simply use the system's crypto libraries
>> that we already take a dependecy on (OpenSSL, mbedTLS, CryptoNG, or
>> SecureTransport).

Just to be clear, OpenSSL has built-in blake2b support.

[...]
> So I'm not a huge fan of sha256, partly because of my disappointment
> in lack of hw acceleration in releant markets (sure, it's fairly
> common in ARM, but nobody sane uses ARM for development because of
> _other_ reasons). And partly because I don't like how the internal
> data size is the same as the final hash. But that second issue is an
> annoyance with it, not a real issue - in the absence of weaknesses
> it's a non-issue, and any future weaknesses might affect any other
> choice too.

Thanks for saying this.  With this in mind, I think we have a clear
way forward: we should use SHA-256.

My main complaint about it is that it is not a tree hash, but the
common availability in libraries trumps that (versus SHA-256x16, say).
I also was excited about K12, both because I like a world where Keccak
gets wide hardware accelaration (improving PRNGs and other
applications) and because of Keccak team's helpfulness throughout the
process of helping us evaluate this, and it's possible that some day
in the future we may want to switch to something like it.  But today,
as mentioned in [1] and [2], there is value in settling on one
standard and SHA2-256 is the obvious standard today.

Thanks,
Jonathan

[1] https://public-inbox.org/git/CAL9PXLyNVLCCqV1ftRa3r4kuoamDZOF29HJEhv2JXrbHj1nirA@mail.gmail.com/
[2] https://public-inbox.org/git/20180723183523.GB9285@aiede.svl.corp.google.com/
