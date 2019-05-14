Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE5B1F461
	for <e@80x24.org>; Tue, 14 May 2019 00:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfENAvG (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:51:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40557 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfENAvF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 20:51:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so7313901plr.7
        for <git@vger.kernel.org>; Mon, 13 May 2019 17:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yLeAm4eNjdqVKEJZ99miKRV4Krm+ENqwpK6nDzIjfs4=;
        b=pPW2DIAdL9ilJ3FgVhjvTiAlMpqZGFEADQaBXlRNCoWJMAuSI0mJ8V+ei9MBUQP+Nm
         6QxMNG03eieq72VitjncXdj6ttuL3s9C/mvVg17B7OkkQf2t8kurH3cDaYTHgDJJY5+L
         8rYOs3+CLzGgBN2SsxHSqPKUdXbW2kIZ6+oNuUHmtjxqFhiGgyeFpfVRlOvHyn6ni2/k
         HzFQ4oDkHLPvncwsIbS3lAZZugo91wtnEcVljjy0lV9qDjB45V6hek4uKfOCM74CuVR8
         y8F+OPhl/1ciPr0kbIY0tAYdoVGLhW24YkkPHMKZy2hrFi0KGNC9LjV7QqS4RRzz5U0b
         abrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yLeAm4eNjdqVKEJZ99miKRV4Krm+ENqwpK6nDzIjfs4=;
        b=JnIFERDEzXq++RdTwd4im2R7q/OVBXEHZ2+yUCcJJOEsWYbOKlyiN4p5XPTp4ZF/0D
         tx2qNSTtFDZfEWcOtgeovpQuChN+frLKoJjr2UfqTNXJr1JU58Q8yvSEg5sa/dgJ5CuM
         HfCmahP+lK2DAPGUYy8owumaFoMnftqJ3ovBn4gDKh+3VGdS+pZHos+wnYuBRiEIEftB
         96jheGJz6eoM85ZWPPTrQ1w2sRFzjxz3flyT2P1rBzvlK6sKIy434AzA4dKLsTMl5P/A
         ZuRvBw2mlD0LSAsjgrNizswL+YJDVXk726UU77JTXRM26tqwGQ7cTBYu5TeS3I5orh16
         hzKA==
X-Gm-Message-State: APjAAAXX9LE6snIiNqGtXaCGThM/WC0ozeUpAlASTSfbl6qqVu066Q7M
        wV9SHIXgPvRiDurG1Tp5tl4=
X-Google-Smtp-Source: APXvYqxhRiYm5x6nGcyUC974puTPjMGw2sUbz/wAw7vTQfOy6V96xyQLuoTmNDgz2cxJHzg59KoLdw==
X-Received: by 2002:a17:902:e407:: with SMTP id ci7mr34341527plb.219.1557795063984;
        Mon, 13 May 2019 17:51:03 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id s6sm19306357pfb.128.2019.05.13.17.51.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 17:51:03 -0700 (PDT)
Date:   Mon, 13 May 2019 17:51:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/7] Multiple hook support
Message-ID: <20190514004920.GB136746@google.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514002332.121089-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:

> I've thought a lot about the discussion over whether this series should
> use the configuration as the source for multiple hooks. Ultimately, I've
> come to the decision that it's not a good idea. Even adopting the empty
> entry as a reset marker, the fact that inheritance in the configuration
> is in-order and can't be easily modified means that it's not likely to
> be very useful, but it is likely to be quite surprising for the average
> user.

Can we discuss this some more?  What would it take to make it likely
to be useful in your view?

> I think a solution that sticks with the existing model and builds
> off a design used by other systems people are familiar with, like cron
> and run-parts, is going to be a better choice. Moreover, this is the
> design that people have already built with outside tooling, which is a
> further argument in favor of it.

To be clear, the main advantage I see for config versus the .git/hooks
model is that with the config model, a user doesn't have to search
throughout the filesystem for .git/hooks directories to update when a
hook is broken.

There are other models that similarly fix that --- e.g. putting hooks
in /etc.  But as long as they're in .git/hooks, I think we're digging
ourselves deeper into the same hole.

Thanks,
Jonathan
