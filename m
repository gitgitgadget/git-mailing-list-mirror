Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 517D01F461
	for <e@80x24.org>; Thu, 29 Aug 2019 13:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfH2NfC (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 09:35:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46569 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfH2NfB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 09:35:01 -0400
Received: by mail-qk1-f193.google.com with SMTP id p13so2865695qkg.13
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SxPIyIb8k0gRGNdNLfYG6wpxT5YQlJsGpOBpUtY5cZU=;
        b=NM+yzHMmkKau01MVzxozOQjqxsFFrIkQ09+RYhQeLiDdcB3gpSVfZ1WIaepZ/xaICa
         fczdSO8zfzT9ND7x+1eYtbSndNMhoaBQasqhSXe9OnH6B2IjLABhib0gPPW3aVBfKQ6R
         zttu7fxSSxYzGYxu9Lw6LnEXV82QmS1SXwnzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SxPIyIb8k0gRGNdNLfYG6wpxT5YQlJsGpOBpUtY5cZU=;
        b=V2i3Z+IHmfGiPCmPFnApeLfu50y44JaJxNjFpTvUj41QiOuYfYMSpeM71AWwPtzslb
         zEJlFIno/TsuWag7Qq/bmbMFxm7DOrsH7c0Ee41GmqEYSE5rls+9H24PNgrTzVIlMBPm
         lRpXiXN3Cs5N7SEzxOzl08zCbCJfRS22WLliA6xJevPnUZyI8la524WzEZArteFLxnfT
         tMkNxts4c4kFrj+uDk/7kiSL8Va3ZSnrmxXyiGU9arjPy4WIJvNk7oolot6CbrZLSYTu
         zU0ucOab2SRVgWW05xuZLoth46IcCuzahzLIzTCPWF0o6CqysR4IpFaHu0YN+UisE0ch
         +wlA==
X-Gm-Message-State: APjAAAWNXf5edZgLRIjOuNwl2S9OtXWw0uaFZCODLyk1N8F1qcRH/yA7
        L4k7VD/YsGnI5LC+6QExyGLzFw==
X-Google-Smtp-Source: APXvYqzWqUg2NK1Ln3LTcTgGD83qegIFAIOSOXarYzbUODxeBDpnPJDetYYPCSILHF0Q9K/6L2IXBA==
X-Received: by 2002:a37:e31a:: with SMTP id y26mr9413085qki.51.1567085699742;
        Thu, 29 Aug 2019 06:34:59 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id 22sm1147193qkc.90.2019.08.29.06.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 06:34:59 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:34:57 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Is git clone followed by git verify-tag meaningful?
Message-ID: <20190829133457.GA26173@chatter.i7.local>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190828203224.GE26001@chatter.i7.local>
 <20190828234706.GB25355@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190828234706.GB25355@sigill.intra.peff.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 07:47:06PM -0400, Jeff King wrote:
>On Wed, Aug 28, 2019 at 04:32:24PM -0400, Konstantin Ryabitsev wrote:
>
>> If I know that a project uses tag signing, would "git clone" followed by
>> "git verify-tag" be meaningful without a "git fsck" in-between? I.e. if an
>> attacker has control over the remote server, can they sneak in any badness
>> into any of the resulting files and still have the clone, checkout, and
>> verify-tag return success unless the repository is fsck'd before verify-tag?
>
>It depends on your definition of badness. :)

As you know, for the Linux kernel we provide both tag signatures and 
detached PGP signatures on tarballs (and the same is true for git). The 
argument I hear frequently is that providing detached tarball signatures 
is redundant[*] when tags are already PGP-signed, so I wanted to 
double-check that all checksums are computed and matched on the client 
in the process of "git checkout" and we're not just verifying a 
signature of a non-verified checksum.

In other words, I needed to double-check that what we get in the end is 
assurance that "all files in this repository are exactly the same as on 
the developer's system at the time when they ran 'git tag -s'."

>Generally, Git clients do not trust the server much at all (not only to
>be no malicious, but also not to accidentally introduce bit errors).
>
>Even without the fsck, we will compute the sha1 of each object (we must,
>because the other side doesn't send it at all), and that we have all
>objects reachable from the refs. So verifying the tag at that point
>demonstrates a signature on the tag object, which refers to probably
>some commit via sha1, which refers to actual trees and blobs by a chain
>of sha1s. If you believe in the integrity of sha1, then it has
>effectively signed all of that content.

So, the client will actually calculate those checksums during the 
checkout stage to make sure that all content in the repository matches 
the hash of the commit being checked out, correct? 

>If you want to analyze each object for such malformed bits before the
>checkout, you can do so with "git fsck". But consider instead setting
>transfer.fsckObjects to check the objects while they're being indexed by
>the initial clone (i.e., having their sha1's computed). It's effectively
>free to do it at that point, whereas a later fsck has to access each
>object again (this takes on the order of minutes of CPU for the kernel).
>
>I don't think there's any real safety in doing so for the case you've
>described (there's no bad pattern that fsck knows about that the actual
>checkout code does not).  But it does give you an early warning, and is
>especially help if you're not planning to check things out yourself, but
>want to avoid hosting malicious repos.

Right, but it's not something end-users are going to do if they just 
want to check out a repository and access code from it. The "git clone 
&& git verify-tag" workflow is now used by some distros that are 
packaging Github releases, and they aren't setting transfer.fsckObjects 
before "git clone" starts, pretty sure.

Thanks for your help!

-K

[*] Tarball signatures may be redundant in cryptographic sense, but for 
repositories like linux.git, which are now around 1.2 GB in size, it 
makes significant difference whether someone downloads the full git tree 
or just a highly compressed tarball that is only 100MB. I know that it's 
possible to clone with --depth 1 to reduce the amount of downloaded 
history, but that's hard on the servers and not something I really want 
to widely advertise as a mechanism for getting the kernel. :) In 
addition to that, distributing static content like tarballs is much 
easier logistically than git repositories, and it's much harder to 
introduce accidental corruption to a bunch of static files. Disk is 
cheap, but CPU and admin time aren't.
