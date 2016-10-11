Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A4651F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 15:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbcJKPUC (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 11:20:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35951 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbcJKPUA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 11:20:00 -0400
Received: by mail-lf0-f66.google.com with SMTP id b75so4276702lfg.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oun0iWB9QIU7PCV724+zG6PXCzMYB8y6x1xEpU+CfEY=;
        b=fJx7kLOy7kKw/Oyqh+mSmzTo8iMWjQccr0SZN4DrNTRg5ihggvNwOnR3emXjyF+eJu
         +s0Pzr4ZbldLqm+MUlORmTfY74RcQEmhYIiOzJYqIiyvUFVAGKBkPuvT8uJlzoe4+gdQ
         x1CUhfHNU7B5vUrrBhKaj141YwYFVOTmNuSq9RVu3ghW8qDOnZrQzLpUhF202fl1psD9
         UsXbmWIz+hRCUTuZd8XD6G17zYz3AWu1dfOUIBmG0ksmu0Nul5/EbeCzNu4Hic2xVdtm
         odsYFsCY9gCrJPbx8T+7bqE2J93UqHKgyZP11lMs4fhKt68ezldZqH09sXGOHZyzdCgH
         5RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oun0iWB9QIU7PCV724+zG6PXCzMYB8y6x1xEpU+CfEY=;
        b=dThec2q+TxDoJ93PNgyIxH6OtRpXcon3Rum0uwgCWKjk6KspKj23FvINwsCLhELZie
         XqhlXLZzaHBpxI+y1NXx8cKUOSxbifl/5gg0x6sHWJGaYdR/+aKo7XLZt1u0lZEcn972
         uPqFH1OUXft1SS4Y7M1JBjwSm7ffvyAXALJnafIU6sho264DTGuwYbqvZ64FBxj5jq1l
         yqdwc/GCNYe6UWQp1XrxK1JSFnAgsDeet2kbdb4MxleD+Q0edzZpkJloNkqCtzNfhcSs
         bdeyFLMkbidSbVRS3ID+5uSV+6AXO5WiWE4b5fzJXBsCA2KAe2aMRzlp2OHXRYDQfPsn
         YJUA==
X-Gm-Message-State: AA6/9Rn6I9W1psofm7rCjV8y7to0imxYCaKLpJ6/xFP9SEBEGz3PAdVESk3YU3EHyMHOMQ==
X-Received: by 10.194.89.71 with SMTP id bm7mr5426195wjb.207.1476198073354;
        Tue, 11 Oct 2016 08:01:13 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id qa7sm7020153wjc.39.2016.10.11.08.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Oct 2016 08:01:12 -0700 (PDT)
Message-ID: <1476198071.3876.7.camel@kaarsemaker.net>
Subject: Re: [PATCH] contrib: add credential helper for libsecret
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Jeff King <peff@peff.net>
Cc:     Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        git@vger.kernel.org
Date:   Tue, 11 Oct 2016 17:01:11 +0200
In-Reply-To: <20161010204654.krj44nk6xbjh4t2v@sigill.intra.peff.net>
References: <20161009123417.147239-1-grawity@gmail.com>
         <1476130850.7457.8.camel@kaarsemaker.net>
         <20161010204654.krj44nk6xbjh4t2v@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2016-10-10 at 16:46 -0400, Jeff King wrote:
> On Mon, Oct 10, 2016 at 10:20:50PM +0200, Dennis Kaarsemaker wrote:
> 
> > On Sun, 2016-10-09 at 15:34 +0300, Mantas Mikulėnas wrote:
> > > This is based on the existing gnome-keyring helper, but instead of
> > > libgnome-keyring (which was specific to GNOME and is deprecated), it
> > > uses libsecret which can support other implementations of XDG Secret
> > > Service API.
> > > 
> > > Passes t0303-credential-external.sh.
> > 
> > When setting credential.helper to this helper, I get the following output:
> > 
> > $ git clone https://private-repo-url-removed private
> > Cloning into 'private'...
> > /home/dennis/code/git/contrib/credential/libsecret/ get: 1: /home/dennis/code/git/contrib/credential/libsecret/ get: /home/dennis/code/git/contrib/credential/libsecret/: Permission denied
> > 
> > Looks suboptimal. Am I holding it wrong?
> 
> That looks like a directory name in your error message. How did you set
> up credential.helper?

Doh.

I had done git config --global credential.helper ~/code/git/contrib/credential/libsecret/

After doing it properly (actual path to the binary), it works just
fine. The error message above is slightly suboptimal, but there's no
solution for pebkac.

D.




