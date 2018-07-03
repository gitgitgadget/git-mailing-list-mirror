Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30F601F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 18:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934440AbeGCSZX (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 14:25:23 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37713 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934309AbeGCSZW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 14:25:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so5738833oib.4
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t/jBfWFyLDF4iB134YGdUHoTzLDvq0+qgxED/hOIlDk=;
        b=SKc6AolpaV1W4GQVEH9KBcn7Jy8j6nqIdjxBo5jVBgCk6wcTDO8ddRZY6cjflHfUw1
         wLu2TuGZ13NlsN7wJI+HafZiVChaGYOOxfWLx36fG3lDZoKY87iWzCmHx2L+rgOOjbV6
         SwO8RiBIHyq3azXQKqTI4suSWs6hbjjphNsKI93MZ0Ws7l93EANtTlGOkDeEjRlwv2Js
         +sXUfMQowpe8QrLfNDA7yI72ERfS+++Am3fILs0ojRBe7GukRy0JxplYpqEtq0+Lyl1l
         UwBPHGbVh2XZFKuvSQRdwrAwWQxUrZmnllM7jt8ebFoD+ZYaL6K8g50sKcCyboU50rl/
         WIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t/jBfWFyLDF4iB134YGdUHoTzLDvq0+qgxED/hOIlDk=;
        b=XMY+VlL9iJdnI7TGEbOPGdjEZdpymgXDgQlLwIzYf6MdEo1BXy7zJIE7rnimY/rrmr
         2jNNAcAWlHeCv7SG5pzxw3/PvvIu9Ura7dfg9Hy79NGQjBgLRzKt7TAF6dpauYoA4Apq
         64aBR1/q8frKng+kpQXBQCcIj62BUnGUvqQAh3eL6rPFGIEWFoQG2f0Myeeoytj90oeF
         YMullM2xpFD69R6OnQz6gfn6JwQpH+etVlQBmiZb3S4jz7DWginuQNO2Hg/IPywg2zd6
         AvLTxI7rDzPSqyEuW4SBY9h7pObznF6mxds8hqcTAgkqsLhOC+j+wID9+VXTonVJCLBo
         nbLg==
X-Gm-Message-State: APt69E2GgBfHHPA8YIKfJH6YyWHCcVqkKgVOdWqX7gGsMe5Yd4QrIUjr
        Q69gofvpCYftEuuwbu4k+0TzCQ==
X-Google-Smtp-Source: AAOMgpfoKwo3C0DJxMK+6+RbkbqNf5Z3LizjmOiQR6fd1rr9sDydHIFCUe113+lPouKugzkF5ozytg==
X-Received: by 2002:aca:fdd5:: with SMTP id b204-v6mr6691987oii.30.1530642321373;
        Tue, 03 Jul 2018 11:25:21 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id r8-v6sm745583oif.25.2018.07.03.11.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 11:25:20 -0700 (PDT)
Date:   Tue, 3 Jul 2018 13:25:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] t5500: prettify non-commit tag tests
Message-ID: <20180703182518.GA89464@syl.attlocal.net>
References: <20180703165518.GA29295@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703165518.GA29295@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 03, 2018 at 12:55:19PM -0400, Jeff King wrote:
> We don't need to use backslash continuation, as the "&&"
> already provides continuation (and happily soaks up empty
> lines between commands).

OK. That seems correct according to my recollection.

> We can also expand the multi-line printf into a
> here-document, which lets us use line breaks more naturally
> (and avoids another continuation that required us to break
> the natural indentation).

The patch below seems obviously correct to me, for what my $.02 is worth
:-).

> Signed-off-by: Jeff King <peff@peff.net>

Thanks,
Taylor
