Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41701F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 02:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfAPCvP (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 21:51:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45975 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbfAPCvO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 21:51:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so2269709pfd.12
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 18:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K5Qdb0x8o+xF2/6Jsmf4J/TohoUr7GSndhDw513dCPQ=;
        b=AsnkjWSCtzK3zGCbmwwPj5uPHIuw3K0SN1W+ScgfntRMO5AhaskzhCgsyLxm2nmql4
         UVdpyZImUdRYciWEcRrOq9s9VyXAGODD2M8tweQMPDhyswFB5TUrchUiX+q21A74LfU/
         +2/xOrVtl+oDa5q0oxpkDE0y8eP/JvH9K5owTXzILAm9lkolDWfPHHMxbbos3RKQ4o/W
         PBR8Z/Frpkotw8ZR/xaC0rcXup4VKkkcH1T3aNbVNtflS1P28Q1eEL8YzTurfXfS1PGb
         zsVHnnSjgWNZFGj6cWbblT1NK9t2HkC545oNmER4fto0ZKpdV3XKA7MHlXmy5bj71xT/
         zYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K5Qdb0x8o+xF2/6Jsmf4J/TohoUr7GSndhDw513dCPQ=;
        b=OPByaVxD4UpcxK4iHcTbahqdKJSUIYjTB/9DDVl4J28JBZm7dnJ/PaoMCPR4U4ZKTs
         Z7aUNQJped4al3gd4/z869Fn26ntkQUVEwcXCCX3blMKBsMLyrczLCQvrbCuxVxjY+ep
         HOtAnv0ax03ySXcxgSeahn8TEJ/cNB0txmXOA6El9mIYNGcWJN7ZvNLw3eCJsP7KNp/s
         bW4PRH/xZiZgbPFUULQLvl1Gq310lHJB916kjDRvr9M5CrajlOhFH6yP7KhqEjfpkG0X
         9o0FLpnoB46MjP231007T54dzBhWV8Ef29cyUVTvPBzUcDuviuC9bA0wZYxysE/WmXpm
         HMcg==
X-Gm-Message-State: AJcUukfLb5v8lP3MQtERssjbq741EiZHVE16l05lYFT5vpe4dontlCnm
        O5AG2lyf64AiJ2fdBa697Xw=
X-Google-Smtp-Source: ALg8bN44uBKEnhSoeqjf1LFsbW/4FrZkDpEJvYwqrt+/dUXseuDi/DYG2kZolZl6bRydpQ7FPfwN2w==
X-Received: by 2002:a65:4904:: with SMTP id p4mr6776564pgs.384.1547607073191;
        Tue, 15 Jan 2019 18:51:13 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 134sm4914866pgb.78.2019.01.15.18.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 18:51:12 -0800 (PST)
Date:   Tue, 15 Jan 2019 18:51:10 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Marketa Calabkova <mcalabkova@suse.cz>, git@vger.kernel.org
Subject: Re: Git bomb still present (at least in SUSE)?
Message-ID: <20190116025110.GD8864@google.com>
References: <a212bd07-8d3c-da5c-6387-4d70ed8edd65@suse.cz>
 <20190115180031.GA31834@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115180031.GA31834@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(moving conversation to the main Git list.  I hope that's okay.)
Hi,

Jeff King wrote:
> On Tue, Jan 15, 2019 at 02:35:29PM +0100, Marketa Calabkova wrote:

>> meggy@irbis:/tmp/test> /usr/bin/time git clone
>> https://github.com/Katee/git-bomb.git
>> Cloning into 'git-bomb'...
>> remote: Enumerating objects: 18, done.
>> remote: Total 18 (delta 0), reused 0 (delta 0), pack-reused 18
>> Unpacking objects: 100% (18/18), done.
>> ^Cwarning: Clone succeeded, but checkout failed.
[...]
>   git clone --bare https://github.com/Katee/git-bomb.git
>   cd git-bomb.git
>   git read-tree HEAD ;# yikes!
>
> So I don't think there's a bug per se. It is possible that Git could
> have better protections against maliciously gigantic repositories, but I
> don't think anybody is actively working on such a feature (and it would
> involve much more than this case; it's pretty easy to generate trees
> with pessimal diffs, etc).

One thing I think interested people could do is introduce some kind of
"limits" subsystem into Git, so that a person could configure Git to
refuse to even try when it notices that an operation is going to be
sufficiently expensive.  I.e. something similar to what rlimits (or
other limits e.g. enforced in cgroups) provide in an operating system.

That said, as alluded to in the last paragraph, there's also some
protection possible at the operating system level.

So my feeling is that there's some real potential for improvement
here, and I'm happy to help mentor anyone working on it if it is their
itch (because of the "can handle at another level" thing, it is not
mine).

Thanks,
Jonathan
