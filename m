Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C992520281
	for <e@80x24.org>; Sat,  4 Nov 2017 09:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756526AbdKDJ5p (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 05:57:45 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:52292 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756243AbdKDJ5o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 05:57:44 -0400
Received: by mail-wm0-f54.google.com with SMTP id t139so5747533wmt.1
        for <git@vger.kernel.org>; Sat, 04 Nov 2017 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nhypVrSmVHtPCbqqc3NjVmB2rPX1BCVU/N1VOsbv2tI=;
        b=Ws73EWkmoL6Y1iKvUy1gTrzXtNSbQCsXnWi4wQkCX7byq7QEJrB6PmADAMUAWBA0dY
         /rim0sC1PJPlVMuS5nfnAKibpygOwy1mXaaETfMTyTIhf1/ABcI1BPGsKKkq8rQ6Ek0Q
         ZDARaCipLLhk9brSZagysGyd6L5wCteRcPSExT8uk6xi3pgziVg22+MR9LFpmWmWQMxN
         rrQC4Z96Qmlj219AK1jemvsBdBq3oWMiQjcOBKW9epAmyfkw1tOFRq+jYS98Ozjgn7pz
         8aXDz39Cw/dHGNZUdr1vTDDV8YUKLBkeHTVtlX+G/9YhYxVNjd8Au4bZ87vwBAQCYIT2
         +3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nhypVrSmVHtPCbqqc3NjVmB2rPX1BCVU/N1VOsbv2tI=;
        b=NHiWAIdDLrGbDEytMbMpdIamzGHPh2PtYihYMkXh/Ojo7RAIo+XyMWqcNlkurICfwQ
         3P2Iie8BaTf0QzSVGuBN/HlLE+JxN4iQEfXBYPeF1n4ng5fgNgijDRxWKrZhJzvYsAcj
         tZ4EjB3w1JHdIEutkSzlAyFr3X5i2gQBiJbP4WuqpOZTFX3qkCCDMMv/wZYMqMAGbS6+
         hek1RkgU518ll4+vBvxa9WiqO5xc3RJ+DRHO1KnjwiuPcWVmjehdbJdPpgY4igzUO6hE
         oV4xqMJ9rWiLqBCVmEMgkZaqA9vsnGfQjbS8Kcy6WDNZyquHf1z1zAt7xSnJzKL1dqfL
         453A==
X-Gm-Message-State: AJaThX6yhIqYEEp6eFY4PbO7yGVvkLe9Y/G8Ish8OzYKYUR88adEJ2A9
        fVrt2dMtCRQvnNikKSwVR9Vb1KfD
X-Google-Smtp-Source: ABhQp+Rq3UjXr09bo9do0oNu0cfWKQrzvfuzbx5JsgKfKUK/M5Bw7bc51UWhPF5GrvfQ0YHvStyC/A==
X-Received: by 10.28.125.206 with SMTP id y197mr1268273wmc.85.1509789463021;
        Sat, 04 Nov 2017 02:57:43 -0700 (PDT)
Received: from laptop.local (host-78-145-151-122.as13285.net. [78.145.151.122])
        by smtp.gmail.com with ESMTPSA id 50sm6952225wry.84.2017.11.04.02.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Nov 2017 02:57:42 -0700 (PDT)
Date:   Sat, 4 Nov 2017 09:57:40 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     Antoine =?iso-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>
Cc:     Thomas Adam <thomas@xteddy.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] remote-mediawiki: show progress while fetching
 namespaces
Message-ID: <20171104095740.hhdgcqgtyjejmqjm@laptop.local>
References: <20171030025142.19421-1-anarcat@debian.org>
 <20171102212518.1601-1-anarcat@debian.org>
 <20171102212518.1601-8-anarcat@debian.org>
 <20171102221807.juon446b6zfw64cq@laptop.local>
 <87vais48rg.fsf@curie.anarc.at>
 <20171102223102.j3niifmupcs77p3r@laptop.local>
 <87o9ok46qu.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o9ok46qu.fsf@curie.anarc.at>
User-Agent: NeoMutt/20170714-87-e4144b (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 02, 2017 at 07:10:17PM -0400, Antoine Beaupré wrote:
> Actually, is there a standard way to do this in git with Perl
> extensions? I know about "option verbosity N" but how should I translate
> this into Perl? Carp? Warn? Log::Any? Log4perl?

No, not really.  From a quick glance at some of the existing perl code in git,
a lot of it continues to use "print STDERR" -- but then to be fair, a lot of
the perl code also reads like it has been written by C programmers...

While there's nothing wrong with using "print STDERR", it's probably wiser to
transition this to using Carp in the long run -- it would decrease the
round-trip time to debugging should there be a situation where that was
needed, and hence I would recommend using "warn" for less-severe
errors/debugging.

-- Thomas Adam
